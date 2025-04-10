const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Text drawing
    .{ .name = "draw_fps", .arity = 2, .fptr = nif_draw_fps, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_text", .arity = 5, .fptr = nif_draw_text, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_text_ex", .arity = 6, .fptr = nif_draw_text_ex, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_text_pro", .arity = 8, .fptr = nif_draw_text_pro, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_text_codepoint", .arity = 5, .fptr = nif_draw_text_codepoint, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_text_codepoints", .arity = 6, .fptr = nif_draw_text_codepoints, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Text font info
    .{ .name = "set_text_line_spacing", .arity = 1, .fptr = nif_set_text_line_spacing, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "measure_text", .arity = 2, .fptr = nif_measure_text, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "measure_text_ex", .arity = 4, .fptr = nif_measure_text_ex, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "measure_text_ex", .arity = 5, .fptr = nif_measure_text_ex, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_glyph_index", .arity = 2, .fptr = nif_get_glyph_index, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_glyph_info", .arity = 2, .fptr = nif_get_glyph_info, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_glyph_info", .arity = 3, .fptr = nif_get_glyph_info, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_glyph_atlas_rec", .arity = 2, .fptr = nif_get_glyph_atlas_rec, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_glyph_atlas_rec", .arity = 3, .fptr = nif_get_glyph_atlas_rec, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

////////////////////
//  Text Drawing  //
////////////////////

/// Draw current FPS
///
/// raylib.h
/// RLAPI void DrawFPS(int posX, int posY);
fn nif_draw_fps(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const pos_x = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'pos_x'.");
    };

    const pos_y = core.Int.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'pos_y'.");
    };

    // Function

    rl.DrawFPS(pos_x, pos_y);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw text (using default font)
///
/// raylib.h
/// RLAPI void DrawText(const char *text, int posX, int posY, int fontSize, Color color);
fn nif_draw_text(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'text'.");
    };
    defer arg_text.free();
    const text = arg_text.data;

    const pos_x = core.Int.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'pos_x'.");
    };

    const pos_y = core.Int.get(env, argv[2]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'pos_y'.");
    };

    const font_size = core.Int.get(env, argv[3]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font_size'.");
    };

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'color'.");
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawText(text, pos_x, pos_y, font_size, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw text using font and additional parameters
///
/// raylib.h
/// RLAPI void DrawTextEx(Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint);
fn nif_draw_text_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_font = core.Argument(core.Font).get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font'.");
    };
    defer arg_font.free();
    const font = arg_font.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'text'.");
    };
    defer arg_text.free();
    const text = arg_text.data;

    const arg_position = core.Argument(core.Vector2).get(env, argv[2]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'position'.");
    };
    defer arg_position.free();
    const position = arg_position.data;

    const font_size = core.Double.get(env, argv[3]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font_size'.");
    };

    const spacing = core.Double.get(env, argv[4]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'spacing'.");
    };

    const arg_tint = core.Argument(core.Color).get(env, argv[5]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'tint'.");
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.DrawTextEx(font, text, position, @floatCast(font_size), @floatCast(spacing), tint);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw text using Font and pro parameters (rotation)
///
/// raylib.h
/// RLAPI void DrawTextPro(Font font, const char *text, Vector2 position, Vector2 origin, float rotation, float fontSize, float spacing, Color tint);
fn nif_draw_text_pro(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 8);

    // Arguments

    const arg_font = core.Argument(core.Font).get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font'.");
    };
    defer arg_font.free();
    const font = arg_font.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'text'.");
    };
    defer arg_text.free();
    const text = arg_text.data;

    const arg_position = core.Argument(core.Vector2).get(env, argv[2]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'position'.");
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_origin = core.Argument(core.Vector2).get(env, argv[3]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'origin'.");
    };
    defer arg_origin.free();
    const origin = arg_origin.data;

    const rotation = core.Double.get(env, argv[4]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'rotation'.");
    };

    const font_size = core.Double.get(env, argv[5]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font_size'.");
    };

    const spacing = core.Double.get(env, argv[6]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'spacing'.");
    };

    const arg_tint = core.Argument(core.Color).get(env, argv[7]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'tint'.");
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.DrawTextPro(font, text, position, origin, @floatCast(rotation), @floatCast(font_size), @floatCast(spacing), tint);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw one character (codepoint)
///
/// raylib.h
/// RLAPI void DrawTextCodepoint(Font font, int codepoint, Vector2 position, float fontSize, Color tint);
fn nif_draw_text_codepoint(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const arg_font = core.Argument(core.Font).get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font'.");
    };
    defer arg_font.free();
    const font = arg_font.data;

    const codepoint = core.Int.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'codepoint'.");
    };

    const arg_position = core.Argument(core.Vector2).get(env, argv[2]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'position'.");
    };
    defer arg_position.free();
    const position = arg_position.data;

    const font_size = core.Double.get(env, argv[3]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font_size'.");
    };

    const arg_tint = core.Argument(core.Color).get(env, argv[4]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'tint'.");
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.DrawTextCodepoint(font, codepoint, position, @floatCast(font_size), tint);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw multiple character (codepoint)
///
/// raylib.h
/// RLAPI void DrawTextCodepoints(Font font, const int *codepoints, int codepointCount, Vector2 position, float fontSize, float spacing, Color tint);
fn nif_draw_text_codepoints(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_font = core.Argument(core.Font).get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font'.");
    };
    defer arg_font.free();
    const font = arg_font.data;

    var arg_codepoints = core.ArgumentArray(core.Int, core.Int.data_type, rl.allocator).get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'codepoint'.");
    };
    defer arg_codepoints.free();
    const codepoints = arg_codepoints.data;
    const codepoints_count = arg_codepoints.length;

    const arg_position = core.Argument(core.Vector2).get(env, argv[2]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'position'.");
    };
    defer arg_position.free();
    const position = arg_position.data;

    const font_size = core.Double.get(env, argv[3]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font_size'.");
    };

    const spacing = core.Double.get(env, argv[4]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'spacing'.");
    };

    const arg_tint = core.Argument(core.Color).get(env, argv[5]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'tint'.");
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.DrawTextCodepoints(font, @ptrCast(codepoints), @intCast(codepoints_count), position, @floatCast(font_size), @floatCast(spacing), tint);

    // Return

    return core.Atom.make(env, "ok");
}

//////////////////////
//  Text Font Info  //
//////////////////////

/// Set vertical line spacing when drawing with line-breaks
///
/// raylib.h
/// RLAPI void SetTextLineSpacing(int spacing);
fn nif_set_text_line_spacing(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const spacing = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'spacing'.");
    };

    // Function

    rl.SetTextLineSpacing(spacing);

    // Return

    return core.Atom.make(env, "ok");
}

/// Measure string width for default font
///
/// raylib.h
/// RLAPI int MeasureText(const char *text, int fontSize);
fn nif_measure_text(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'text'.");
    };
    defer arg_text.free();
    const text = arg_text.data;

    const font_size = core.Int.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font_size'.");
    };

    // Function

    const width = rl.MeasureText(text, font_size);

    // Return

    return core.Int.make(env, width);
}

/// Measure string size for Font
///
/// raylib.h
/// RLAPI Vector2 MeasureTextEx(Font font, const char *text, float fontSize, float spacing);
fn nif_measure_text_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 4 or argc == 5);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 4);

    // Arguments

    const arg_font = core.Argument(core.Font).get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font'.");
    };
    defer arg_font.free();
    const font = arg_font.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'text'.");
    };
    defer arg_text.free();
    const text = arg_text.data;

    const font_size = core.Double.get(env, argv[2]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font_size'.");
    };

    const spacing = core.Double.get(env, argv[3]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'spacing'.");
    };

    // Function

    const size = rl.MeasureTextEx(font, text, @floatCast(font_size), @floatCast(spacing));
    defer if (!return_resource) core.Vector2.free(size);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector2, env, size, return_resource) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to get return value.");
    };
}

/// Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
///
/// raylib.h
/// RLAPI int GetGlyphIndex(Font font, int codepoint);
fn nif_get_glyph_index(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_font = core.Argument(core.Font).get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font'.");
    };
    defer arg_font.free();
    const font = arg_font.data;

    const codepoint = core.Int.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'codepoint'.");
    };

    // Function

    const glyph_index = rl.GetGlyphIndex(font, codepoint);

    // Return

    return core.Int.make(env, glyph_index);
}

/// Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
///
/// raylib.h
/// RLAPI GlyphInfo GetGlyphInfo(Font font, int codepoint);
fn nif_get_glyph_info(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_font = core.Argument(core.Font).get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font'.");
    };
    defer arg_font.free();
    const font = arg_font.data;

    const codepoint = core.Int.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'codepoint'.");
    };

    // Function

    const glyph_info = rl.GetGlyphInfo(font, codepoint);
    // Do NOT free glyph_info

    // Return

    return core.maybe_make_struct_as_resource(core.GlyphInfo, env, glyph_info, return_resource) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to get return value.");
    };
}

/// Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
///
/// raylib.h
/// RLAPI Rectangle GetGlyphAtlasRec(Font font, int codepoint);
fn nif_get_glyph_atlas_rec(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_font = core.Argument(core.Font).get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font'.");
    };
    defer arg_font.free();
    const font = arg_font.data;

    const codepoint = core.Int.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'codepoint'.");
    };

    // Function

    const glyph_atlas_rec = rl.GetGlyphAtlasRec(font, codepoint);
    // Do NOT free glyph_atlas_rec

    // Return

    return core.maybe_make_struct_as_resource(core.Rectangle, env, glyph_atlas_rec, return_resource) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to get return value.");
    };
}
