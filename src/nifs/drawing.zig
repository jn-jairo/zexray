const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Drawing
    .{ .name = "clear_background", .arity = 1, .fptr = core.nif_wrapper(nif_clear_background), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "begin_drawing", .arity = 0, .fptr = core.nif_wrapper(nif_begin_drawing), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "end_drawing", .arity = 0, .fptr = core.nif_wrapper(nif_end_drawing), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "begin_mode_2d", .arity = 1, .fptr = core.nif_wrapper(nif_begin_mode_2d), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "end_mode_2d", .arity = 0, .fptr = core.nif_wrapper(nif_end_mode_2d), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "begin_mode_3d", .arity = 1, .fptr = core.nif_wrapper(nif_begin_mode_3d), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "end_mode_3d", .arity = 0, .fptr = core.nif_wrapper(nif_end_mode_3d), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "begin_texture_mode", .arity = 1, .fptr = core.nif_wrapper(nif_begin_texture_mode), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "end_texture_mode", .arity = 0, .fptr = core.nif_wrapper(nif_end_texture_mode), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "begin_shader_mode", .arity = 1, .fptr = core.nif_wrapper(nif_begin_shader_mode), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "end_shader_mode", .arity = 0, .fptr = core.nif_wrapper(nif_end_shader_mode), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "begin_blend_mode", .arity = 1, .fptr = core.nif_wrapper(nif_begin_blend_mode), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "end_blend_mode", .arity = 0, .fptr = core.nif_wrapper(nif_end_blend_mode), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "begin_scissor_mode", .arity = 1, .fptr = core.nif_wrapper(nif_begin_scissor_mode), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "begin_scissor_mode", .arity = 4, .fptr = core.nif_wrapper(nif_begin_scissor_mode), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "end_scissor_mode", .arity = 0, .fptr = core.nif_wrapper(nif_end_scissor_mode), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "begin_vr_stereo_mode", .arity = 1, .fptr = core.nif_wrapper(nif_begin_vr_stereo_mode), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "end_vr_stereo_mode", .arity = 0, .fptr = core.nif_wrapper(nif_end_vr_stereo_mode), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

///////////////
//  Drawing  //
///////////////

/// Set background color (framebuffer clear color)
///
/// raylib.h
/// RLAPI void ClearBackground(Color color);
fn nif_clear_background(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_color = core.Argument(core.Color).get(env, argv[0]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ClearBackground(color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Setup canvas (framebuffer) to start drawing
///
/// raylib.h
/// RLAPI void BeginDrawing(void);
fn nif_begin_drawing(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.BeginDrawing();

    // Return

    return core.Atom.make(env, "ok");
}

/// End canvas drawing and swap buffers (double buffering)
///
/// raylib.h
/// RLAPI void EndDrawing(void);
fn nif_end_drawing(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.EndDrawing();

    // Return

    return core.Atom.make(env, "ok");
}

/// Begin 2D mode with custom camera (2D)
///
/// raylib.h
/// RLAPI void BeginMode2D(Camera2D camera);
fn nif_begin_mode_2d(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_camera = core.Argument(core.Camera2D).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer arg_camera.free();
    const camera = arg_camera.data;

    // Function

    rl.BeginMode2D(camera);

    // Return

    return core.Atom.make(env, "ok");
}

/// Ends 2D mode with custom camera
///
/// raylib.h
/// RLAPI void EndMode2D(void);
fn nif_end_mode_2d(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.EndMode2D();

    // Return

    return core.Atom.make(env, "ok");
}

/// Begin 3D mode with custom camera (3D)
///
/// raylib.h
/// RLAPI void BeginMode3D(Camera3D camera);
fn nif_begin_mode_3d(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_camera = core.Argument(core.Camera3D).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer arg_camera.free();
    const camera = arg_camera.data;

    // Function

    rl.BeginMode3D(camera);

    // Return

    return core.Atom.make(env, "ok");
}

/// Ends 3D mode and returns to default 2D orthographic mode
///
/// raylib.h
/// RLAPI void EndMode3D(void);
fn nif_end_mode_3d(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.EndMode3D();

    // Return

    return core.Atom.make(env, "ok");
}

/// Begin drawing to render texture
///
/// raylib.h
/// RLAPI void BeginTextureMode(RenderTexture2D target);
fn nif_begin_texture_mode(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_target = core.Argument(core.RenderTexture2D).get(env, argv[0]) catch {
        return error.invalid_argument_target;
    };
    defer arg_target.free();
    const target = arg_target.data;

    // Function

    rl.BeginTextureMode(target);

    // Return

    return core.Atom.make(env, "ok");
}

/// Ends drawing to render texture
///
/// raylib.h
/// RLAPI void EndTextureMode(void);
fn nif_end_texture_mode(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.EndTextureMode();

    // Return

    return core.Atom.make(env, "ok");
}

/// Begin custom shader drawing
///
/// raylib.h
/// RLAPI void BeginShaderMode(Shader shader);
fn nif_begin_shader_mode(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_shader = core.Argument(core.Shader).get(env, argv[0]) catch {
        return error.invalid_argument_shader;
    };
    defer arg_shader.free();
    const shader = arg_shader.data;

    // Function

    rl.BeginShaderMode(shader);

    // Return

    return core.Atom.make(env, "ok");
}

/// End custom shader drawing (use default shader)
///
/// raylib.h
/// RLAPI void EndShaderMode(void);
fn nif_end_shader_mode(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.EndShaderMode();

    // Return

    return core.Atom.make(env, "ok");
}

/// Begin blending mode (alpha, additive, multiplied, subtract, custom)
///
/// raylib.h
/// RLAPI void BeginBlendMode(int mode);
fn nif_begin_blend_mode(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const mode = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_mode;
    };

    // Function

    rl.BeginBlendMode(mode);

    // Return

    return core.Atom.make(env, "ok");
}

/// End blending mode (reset to default: alpha blending)
///
/// raylib.h
/// RLAPI void EndBlendMode(void);
fn nif_end_blend_mode(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.EndBlendMode();

    // Return

    return core.Atom.make(env, "ok");
}

/// Begin scissor mode (define screen area for following drawing)
///
/// raylib.h
/// RLAPI void BeginScissorMode(int x, int y, int width, int height);
fn nif_begin_scissor_mode(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 4);

    // Arguments

    var x: c_int = undefined;
    var y: c_int = undefined;
    var width: c_int = undefined;
    var height: c_int = undefined;

    if (argc == 1) {
        const arg_rec = core.Argument(core.Rectangle).get(env, argv[0]) catch {
            return error.invalid_argument_rec;
        };
        defer arg_rec.free();
        const rec = arg_rec.data;

        x = @intFromFloat(rec.x);
        y = @intFromFloat(rec.y);
        width = @intFromFloat(rec.width);
        height = @intFromFloat(rec.height);
    } else {
        x = core.Int.get(env, argv[0]) catch {
            return error.invalid_argument_x;
        };

        y = core.Int.get(env, argv[1]) catch {
            return error.invalid_argument_y;
        };

        width = core.Int.get(env, argv[2]) catch {
            return error.invalid_argument_width;
        };

        height = core.Int.get(env, argv[3]) catch {
            return error.invalid_argument_height;
        };
    }

    // Function

    rl.BeginScissorMode(x, y, width, height);

    // Return

    return core.Atom.make(env, "ok");
}

/// End scissor mode
///
/// raylib.h
/// RLAPI void EndScissorMode(void);
fn nif_end_scissor_mode(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.EndScissorMode();

    // Return

    return core.Atom.make(env, "ok");
}

/// Begin stereo rendering (requires VR simulator)
///
/// raylib.h
/// RLAPI void BeginVrStereoMode(VrStereoConfig config);
fn nif_begin_vr_stereo_mode(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_config = core.Argument(core.VrStereoConfig).get(env, argv[0]) catch {
        return error.invalid_argument_config;
    };
    defer arg_config.free();
    const config = arg_config.data;

    // Function

    rl.BeginVrStereoMode(config);

    // Return

    return core.Atom.make(env, "ok");
}

/// End stereo rendering (requires VR simulator)
///
/// raylib.h
/// RLAPI void EndVrStereoMode(void);
fn nif_end_vr_stereo_mode(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.EndVrStereoMode();

    // Return

    return core.Atom.make(env, "ok");
}
