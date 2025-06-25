const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Texture loading
    .{ .name = "load_texture", .arity = 1, .fptr = core.nif_wrapper(nif_load_texture), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_texture", .arity = 2, .fptr = core.nif_wrapper(nif_load_texture), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_texture_from_image", .arity = 1, .fptr = core.nif_wrapper(nif_load_texture_from_image), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_texture_from_image", .arity = 2, .fptr = core.nif_wrapper(nif_load_texture_from_image), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_texture_cubemap", .arity = 2, .fptr = core.nif_wrapper(nif_load_texture_cubemap), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_texture_cubemap", .arity = 3, .fptr = core.nif_wrapper(nif_load_texture_cubemap), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_render_texture", .arity = 2, .fptr = core.nif_wrapper(nif_load_render_texture), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_render_texture", .arity = 3, .fptr = core.nif_wrapper(nif_load_render_texture), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_texture_valid", .arity = 1, .fptr = core.nif_wrapper(nif_is_texture_valid), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_render_texture_valid", .arity = 1, .fptr = core.nif_wrapper(nif_is_render_texture_valid), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "update_texture", .arity = 2, .fptr = core.nif_wrapper(nif_update_texture), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "update_texture_rec", .arity = 3, .fptr = core.nif_wrapper(nif_update_texture_rec), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Texture configuration
    .{ .name = "gen_texture_mipmaps", .arity = 1, .fptr = core.nif_wrapper(nif_gen_texture_mipmaps), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_texture_mipmaps", .arity = 2, .fptr = core.nif_wrapper(nif_gen_texture_mipmaps), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_texture_filter", .arity = 2, .fptr = core.nif_wrapper(nif_set_texture_filter), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_texture_wrap", .arity = 2, .fptr = core.nif_wrapper(nif_set_texture_wrap), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Texture drawing
    .{ .name = "draw_texture", .arity = 4, .fptr = core.nif_wrapper(nif_draw_texture), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_texture_v", .arity = 3, .fptr = core.nif_wrapper(nif_draw_texture_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_texture_ex", .arity = 5, .fptr = core.nif_wrapper(nif_draw_texture_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_texture_rec", .arity = 4, .fptr = core.nif_wrapper(nif_draw_texture_rec), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_texture_pro", .arity = 6, .fptr = core.nif_wrapper(nif_draw_texture_pro), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_texture_n_patch", .arity = 6, .fptr = core.nif_wrapper(nif_draw_texture_n_patch), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

///////////////////////
//  Texture loading  //
///////////////////////

/// Load texture from file into GPU memory (VRAM)
///
/// raylib.h
/// RLAPI Texture2D LoadTexture(const char *fileName);
fn nif_load_texture(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_file_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_file_name;
    };
    defer arg_file_name.free();
    const file_name = arg_file_name.data;

    // Function

    const texture = rl.LoadTexture(file_name);
    defer if (!return_resource) core.Texture2D.unload(texture);
    errdefer if (return_resource) core.Texture2D.unload(texture);

    // Return

    return core.maybe_make_struct_as_resource(core.Texture2D, env, texture, return_resource) catch {
        return error.invalid_return;
    };
}

/// Load texture from image data
///
/// raylib.h
/// RLAPI Texture2D LoadTextureFromImage(Image image);
fn nif_load_texture_from_image(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_image.free();
    const image = arg_image.data;

    // Function

    const texture = rl.LoadTextureFromImage(image);
    defer if (!return_resource) core.Texture2D.unload(texture);
    errdefer if (return_resource) core.Texture2D.unload(texture);

    // Return

    return core.maybe_make_struct_as_resource(core.Texture2D, env, texture, return_resource) catch {
        return error.invalid_return;
    };
}

/// Load cubemap from image, multiple image cubemap layouts supported
///
/// raylib.h
/// RLAPI TextureCubemap LoadTextureCubemap(Image image, int layout);
fn nif_load_texture_cubemap(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_image.free();
    const image = arg_image.data;

    const layout = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_layout;
    };

    // Function

    const texture = rl.LoadTextureCubemap(image, layout);
    defer if (!return_resource) core.TextureCubemap.unload(texture);
    errdefer if (return_resource) core.TextureCubemap.unload(texture);

    // Return

    return core.maybe_make_struct_as_resource(core.TextureCubemap, env, texture, return_resource) catch {
        return error.invalid_return;
    };
}

/// Load texture for rendering (framebuffer)
///
/// raylib.h
/// RLAPI RenderTexture2D LoadRenderTexture(int width, int height);
fn nif_load_render_texture(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const width = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_height;
    };

    // Function

    const texture = rl.LoadRenderTexture(width, height);
    defer if (!return_resource) core.RenderTexture2D.unload(texture);
    errdefer if (return_resource) core.RenderTexture2D.unload(texture);

    // Return

    return core.maybe_make_struct_as_resource(core.RenderTexture2D, env, texture, return_resource) catch {
        return error.invalid_return;
    };
}

/// Check if a texture is valid (loaded in GPU)
///
/// raylib.h
/// RLAPI bool IsTextureValid(Texture2D texture);
fn nif_is_texture_valid(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_texture = core.Argument(core.Texture2D).get(env, argv[0]) catch {
        return error.invalid_argument_texture;
    };
    defer arg_texture.free();
    const texture = arg_texture.data;

    // Function

    const is_texture_valid = rl.IsTextureValid(texture);

    // Return

    return core.Boolean.make(env, is_texture_valid);
}

/// Check if a render texture is valid (loaded in GPU)
///
/// raylib.h
/// RLAPI bool IsRenderTextureValid(RenderTexture2D target);
fn nif_is_render_texture_valid(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_target = core.Argument(core.RenderTexture2D).get(env, argv[0]) catch {
        return error.invalid_argument_target;
    };
    defer arg_target.free();
    const target = arg_target.data;

    // Function

    const is_render_texture_valid = rl.IsRenderTextureValid(target);

    // Return

    return core.Boolean.make(env, is_render_texture_valid);
}

/// Update GPU texture with new data
///
/// raylib.h
/// RLAPI void UpdateTexture(Texture2D texture, const void *pixels);
fn nif_update_texture(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_texture = core.Argument(core.Texture2D).get(env, argv[0]) catch {
        return error.invalid_argument_texture;
    };
    defer arg_texture.free();
    const texture = arg_texture.data;

    const arg_pixels = core.ArgumentBinary(core.Binary, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_pixels;
    };
    defer arg_pixels.free();
    const pixels = arg_pixels.data;

    // Function

    rl.UpdateTexture(texture, @ptrCast(pixels));

    // Return

    return core.Atom.make(env, "ok");
}

/// Update GPU texture rectangle with new data
///
/// raylib.h
/// RLAPI void UpdateTextureRec(Texture2D texture, Rectangle rec, const void *pixels);
fn nif_update_texture_rec(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_texture = core.Argument(core.Texture2D).get(env, argv[0]) catch {
        return error.invalid_argument_texture;
    };
    defer arg_texture.free();
    const texture = arg_texture.data;

    const arg_rec = core.Argument(core.Rectangle).get(env, argv[1]) catch {
        return error.invalid_argument_rec;
    };
    defer arg_rec.free();
    const rec = arg_rec.data;

    const arg_pixels = core.ArgumentBinary(core.Binary, rl.allocator).get(env, argv[2]) catch {
        return error.invalid_argument_pixels;
    };
    defer arg_pixels.free();
    const pixels = arg_pixels.data;

    // Function

    rl.UpdateTextureRec(texture, rec, @ptrCast(pixels));

    // Return

    return core.Atom.make(env, "ok");
}

/////////////////////////////
//  Texture configuration  //
/////////////////////////////

/// Generate GPU mipmaps for a texture
///
/// raylib.h
/// RLAPI void GenTextureMipmaps(Texture2D *texture);
fn nif_gen_texture_mipmaps(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 1, argv[0]);

    // Arguments

    var arg_texture = core.Argument(core.Texture2D).get(env, argv[0]) catch {
        return error.invalid_argument_texture;
    };
    defer if (!return_resource) arg_texture.free();
    errdefer if (return_resource) arg_texture.free();
    const texture = &arg_texture.data;

    // Function

    rl.GenTextureMipmaps(@ptrCast(texture));

    // Return

    return core.maybe_make_struct_or_resource(core.Texture2D, env, argv[0], texture.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Set texture scaling filter mode
///
/// raylib.h
/// RLAPI void SetTextureFilter(Texture2D texture, int filter);
fn nif_set_texture_filter(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_texture = core.Argument(core.Texture2D).get(env, argv[0]) catch {
        return error.invalid_argument_texture;
    };
    defer arg_texture.free();
    const texture = arg_texture.data;

    const filter = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_filter;
    };

    // Function

    rl.SetTextureFilter(texture, filter);

    // Return

    return core.Atom.make(env, "ok");
}

/// Set texture wrapping mode
///
/// raylib.h
/// RLAPI void SetTextureWrap(Texture2D texture, int wrap);
fn nif_set_texture_wrap(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_texture = core.Argument(core.Texture2D).get(env, argv[0]) catch {
        return error.invalid_argument_texture;
    };
    defer arg_texture.free();
    const texture = arg_texture.data;

    const wrap = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_wrap;
    };

    // Function

    rl.SetTextureWrap(texture, wrap);

    // Return

    return core.Atom.make(env, "ok");
}

///////////////////////
//  Texture drawing  //
///////////////////////

/// Draw a Texture2D
///
/// raylib.h
/// RLAPI void DrawTexture(Texture2D texture, int posX, int posY, Color tint);
fn nif_draw_texture(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_texture = core.Argument(core.Texture2D).get(env, argv[0]) catch {
        return error.invalid_argument_texture;
    };
    defer arg_texture.free();
    const texture = arg_texture.data;

    const pos_x = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_pos_x;
    };

    const pos_y = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_pos_y;
    };

    const arg_tint = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.DrawTexture(texture, pos_x, pos_y, tint);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a Texture2D with position defined as Vector2
///
/// raylib.h
/// RLAPI void DrawTextureV(Texture2D texture, Vector2 position, Color tint);
fn nif_draw_texture_v(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_texture = core.Argument(core.Texture2D).get(env, argv[0]) catch {
        return error.invalid_argument_texture;
    };
    defer arg_texture.free();
    const texture = arg_texture.data;

    const arg_position = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_tint = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.DrawTextureV(texture, position, tint);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a Texture2D with extended parameters
///
/// raylib.h
/// RLAPI void DrawTextureEx(Texture2D texture, Vector2 position, float rotation, float scale, Color tint);
fn nif_draw_texture_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const arg_texture = core.Argument(core.Texture2D).get(env, argv[0]) catch {
        return error.invalid_argument_texture;
    };
    defer arg_texture.free();
    const texture = arg_texture.data;

    const arg_position = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const rotation = core.Float.get(env, argv[2]) catch {
        return error.invalid_argument_rotation;
    };

    const scale = core.Float.get(env, argv[3]) catch {
        return error.invalid_argument_scale;
    };

    const arg_tint = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.DrawTextureEx(texture, position, rotation, scale, tint);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a part of a texture defined by a rectangle
///
/// raylib.h
/// RLAPI void DrawTextureRec(Texture2D texture, Rectangle source, Vector2 position, Color tint);
fn nif_draw_texture_rec(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_texture = core.Argument(core.Texture2D).get(env, argv[0]) catch {
        return error.invalid_argument_texture;
    };
    defer arg_texture.free();
    const texture = arg_texture.data;

    const arg_source = core.Argument(core.Rectangle).get(env, argv[1]) catch {
        return error.invalid_argument_source;
    };
    defer arg_source.free();
    const source = arg_source.data;

    const arg_position = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_tint = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.DrawTextureRec(texture, source, position, tint);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a part of a texture defined by a rectangle with 'pro' parameters
///
/// raylib.h
/// RLAPI void DrawTexturePro(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint);
fn nif_draw_texture_pro(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_texture = core.Argument(core.Texture2D).get(env, argv[0]) catch {
        return error.invalid_argument_texture;
    };
    defer arg_texture.free();
    const texture = arg_texture.data;

    const arg_source = core.Argument(core.Rectangle).get(env, argv[1]) catch {
        return error.invalid_argument_source;
    };
    defer arg_source.free();
    const source = arg_source.data;

    const arg_dest = core.Argument(core.Rectangle).get(env, argv[2]) catch {
        return error.invalid_argument_dest;
    };
    defer arg_dest.free();
    const dest = arg_dest.data;

    const arg_origin = core.Argument(core.Vector2).get(env, argv[3]) catch {
        return error.invalid_argument_origin;
    };
    defer arg_origin.free();
    const origin = arg_origin.data;

    const rotation = core.Float.get(env, argv[4]) catch {
        return error.invalid_argument_rotation;
    };

    const arg_tint = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.DrawTexturePro(texture, source, dest, origin, rotation, tint);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draws a texture (or part of it) that stretches or shrinks nicely
///
/// raylib.h
/// RLAPI void DrawTextureNPatch(Texture2D texture, NPatchInfo nPatchInfo, Rectangle dest, Vector2 origin, float rotation, Color tint);
fn nif_draw_texture_n_patch(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_texture = core.Argument(core.Texture2D).get(env, argv[0]) catch {
        return error.invalid_argument_texture;
    };
    defer arg_texture.free();
    const texture = arg_texture.data;

    const arg_n_patch_info = core.Argument(core.NPatchInfo).get(env, argv[1]) catch {
        return error.invalid_argument_n_patch_info;
    };
    defer arg_n_patch_info.free();
    const n_patch_info = arg_n_patch_info.data;

    const arg_dest = core.Argument(core.Rectangle).get(env, argv[2]) catch {
        return error.invalid_argument_dest;
    };
    defer arg_dest.free();
    const dest = arg_dest.data;

    const arg_origin = core.Argument(core.Vector2).get(env, argv[3]) catch {
        return error.invalid_argument_origin;
    };
    defer arg_origin.free();
    const origin = arg_origin.data;

    const rotation = core.Float.get(env, argv[4]) catch {
        return error.invalid_argument_rotation;
    };

    const arg_tint = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.DrawTextureNPatch(texture, n_patch_info, dest, origin, rotation, tint);

    // Return

    return core.Atom.make(env, "ok");
}
