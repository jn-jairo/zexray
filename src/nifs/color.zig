const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Color
    .{ .name = "color_is_equal", .arity = 2, .fptr = core.nif_wrapper(nif_color_is_equal), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "fade", .arity = 2, .fptr = core.nif_wrapper(nif_fade), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "fade", .arity = 3, .fptr = core.nif_wrapper(nif_fade), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_to_int", .arity = 1, .fptr = core.nif_wrapper(nif_color_to_int), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_normalize", .arity = 1, .fptr = core.nif_wrapper(nif_color_normalize), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_normalize", .arity = 2, .fptr = core.nif_wrapper(nif_color_normalize), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_from_normalized", .arity = 1, .fptr = core.nif_wrapper(nif_color_from_normalized), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_from_normalized", .arity = 2, .fptr = core.nif_wrapper(nif_color_from_normalized), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_to_hsv", .arity = 1, .fptr = core.nif_wrapper(nif_color_to_hsv), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_to_hsv", .arity = 2, .fptr = core.nif_wrapper(nif_color_to_hsv), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_from_hsv", .arity = 3, .fptr = core.nif_wrapper(nif_color_from_hsv), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_from_hsv", .arity = 4, .fptr = core.nif_wrapper(nif_color_from_hsv), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_tint", .arity = 2, .fptr = core.nif_wrapper(nif_color_tint), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_tint", .arity = 3, .fptr = core.nif_wrapper(nif_color_tint), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_brightness", .arity = 2, .fptr = core.nif_wrapper(nif_color_brightness), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_brightness", .arity = 3, .fptr = core.nif_wrapper(nif_color_brightness), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_contrast", .arity = 2, .fptr = core.nif_wrapper(nif_color_contrast), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_contrast", .arity = 3, .fptr = core.nif_wrapper(nif_color_contrast), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_alpha", .arity = 2, .fptr = core.nif_wrapper(nif_color_alpha), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_alpha", .arity = 3, .fptr = core.nif_wrapper(nif_color_alpha), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_alpha_blend", .arity = 3, .fptr = core.nif_wrapper(nif_color_alpha_blend), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_alpha_blend", .arity = 4, .fptr = core.nif_wrapper(nif_color_alpha_blend), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_lerp", .arity = 3, .fptr = core.nif_wrapper(nif_color_lerp), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_lerp", .arity = 4, .fptr = core.nif_wrapper(nif_color_lerp), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_color", .arity = 1, .fptr = core.nif_wrapper(nif_get_color), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_color", .arity = 2, .fptr = core.nif_wrapper(nif_get_color), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_pixel_color", .arity = 2, .fptr = core.nif_wrapper(nif_get_pixel_color), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_pixel_color", .arity = 3, .fptr = core.nif_wrapper(nif_get_pixel_color), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_pixel_color", .arity = 2, .fptr = core.nif_wrapper(nif_set_pixel_color), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_pixel_data_size", .arity = 3, .fptr = core.nif_wrapper(nif_get_pixel_data_size), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

/////////////
//  Color  //
/////////////

/// Check if two colors are equal
///
/// raylib.h
/// RLAPI bool ColorIsEqual(Color col1, Color col2);
fn nif_color_is_equal(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_col1 = core.Argument(core.Color).get(env, argv[0]) catch {
        return error.invalid_argument_col1;
    };
    defer arg_col1.free();
    const col1 = arg_col1.data;

    const arg_col2 = core.Argument(core.Color).get(env, argv[1]) catch {
        return error.invalid_argument_col2;
    };
    defer arg_col2.free();
    const col2 = arg_col2.data;

    // Function

    const color_is_equal = rl.ColorIsEqual(col1, col2);

    // Return

    return core.Boolean.make(env, color_is_equal);
}

/// Get color with alpha applied, alpha goes from 0.0f to 1.0f
///
/// raylib.h
/// RLAPI Color Fade(Color color, float alpha);
fn nif_fade(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_color = core.Argument(core.Color).get(env, argv[0]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    const alpha = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_alpha;
    };

    // Function

    const new_color = rl.Fade(color, @floatCast(alpha));
    defer if (!return_resource) core.Color.free(new_color);
    errdefer if (return_resource) core.Color.free(new_color);

    // Return

    return core.maybe_make_struct_as_resource(core.Color, env, new_color, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get hexadecimal value for a Color (0xRRGGBBAA)
///
/// raylib.h
/// RLAPI int ColorToInt(Color color);
fn nif_color_to_int(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_color = core.Argument(core.Color).get(env, argv[0]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    const color_int = rl.ColorToInt(color);

    // Return

    return core.UInt.make(env, @bitCast(color_int));
}

/// Get Color normalized as float [0..1]
///
/// raylib.h
/// RLAPI Vector4 ColorNormalize(Color color);
fn nif_color_normalize(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_color = core.Argument(core.Color).get(env, argv[0]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    const normalized = rl.ColorNormalize(color);
    defer if (!return_resource) core.Vector4.free(normalized);
    errdefer if (return_resource) core.Vector4.free(normalized);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector4, env, normalized, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get Color from normalized values [0..1]
///
/// raylib.h
/// RLAPI Color ColorFromNormalized(Vector4 normalized);
fn nif_color_from_normalized(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_normalized = core.Argument(core.Vector4).get(env, argv[0]) catch {
        return error.invalid_argument_normalized;
    };
    defer arg_normalized.free();
    const normalized = arg_normalized.data;

    // Function

    const color = rl.ColorFromNormalized(normalized);
    defer if (!return_resource) core.Color.free(color);
    errdefer if (return_resource) core.Color.free(color);

    // Return

    return core.maybe_make_struct_as_resource(core.Color, env, color, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get HSV values for a Color, hue [0..360], saturation/value [0..1]
///
/// raylib.h
/// RLAPI Vector3 ColorToHSV(Color color);
fn nif_color_to_hsv(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_color = core.Argument(core.Color).get(env, argv[0]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    const hsv = rl.ColorToHSV(color);
    defer if (!return_resource) core.Vector3.free(hsv);
    errdefer if (return_resource) core.Vector3.free(hsv);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector3, env, hsv, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get a Color from HSV values, hue [0..360], saturation/value [0..1]
///
/// raylib.h
/// RLAPI Color ColorFromHSV(float hue, float saturation, float value);
fn nif_color_from_hsv(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const hue = core.Double.get(env, argv[0]) catch {
        return error.invalid_argument_hue;
    };

    const saturation = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_saturation;
    };

    const value = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_value;
    };

    // Function

    const color = rl.ColorFromHSV(@floatCast(hue), @floatCast(saturation), @floatCast(value));
    defer if (!return_resource) core.Color.free(color);
    errdefer if (return_resource) core.Color.free(color);

    // Return

    return core.maybe_make_struct_as_resource(core.Color, env, color, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get color multiplied with another color
///
/// raylib.h
/// RLAPI Color ColorTint(Color color, Color tint);
fn nif_color_tint(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_color = core.Argument(core.Color).get(env, argv[0]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    const arg_tint = core.Argument(core.Color).get(env, argv[1]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    const new_color = rl.ColorTint(color, tint);
    defer if (!return_resource) core.Color.free(new_color);
    errdefer if (return_resource) core.Color.free(new_color);

    // Return

    return core.maybe_make_struct_as_resource(core.Color, env, new_color, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get color with brightness correction, brightness factor goes from -1.0f to 1.0f
///
/// raylib.h
/// RLAPI Color ColorBrightness(Color color, float factor);
fn nif_color_brightness(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_color = core.Argument(core.Color).get(env, argv[0]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    const factor = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_factor;
    };

    // Function

    const new_color = rl.ColorBrightness(color, @floatCast(factor));
    defer if (!return_resource) core.Color.free(new_color);
    errdefer if (return_resource) core.Color.free(new_color);

    // Return

    return core.maybe_make_struct_as_resource(core.Color, env, new_color, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get color with contrast correction, contrast values between -1.0f and 1.0f
///
/// raylib.h
/// RLAPI Color ColorContrast(Color color, float contrast);
fn nif_color_contrast(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_color = core.Argument(core.Color).get(env, argv[0]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    const contrast = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_contrast;
    };

    // Function

    const new_color = rl.ColorContrast(color, @floatCast(contrast));
    defer if (!return_resource) core.Color.free(new_color);
    errdefer if (return_resource) core.Color.free(new_color);

    // Return

    return core.maybe_make_struct_as_resource(core.Color, env, new_color, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get color with alpha applied, alpha goes from 0.0f to 1.0f
///
/// raylib.h
/// RLAPI Color ColorAlpha(Color color, float alpha);
fn nif_color_alpha(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_color = core.Argument(core.Color).get(env, argv[0]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    const alpha = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_alpha;
    };

    // Function

    const new_color = rl.ColorAlpha(color, @floatCast(alpha));
    defer if (!return_resource) core.Color.free(new_color);
    errdefer if (return_resource) core.Color.free(new_color);

    // Return

    return core.maybe_make_struct_as_resource(core.Color, env, new_color, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get src alpha-blended into dst color with tint
///
/// raylib.h
/// RLAPI Color ColorAlphaBlend(Color dst, Color src, Color tint);
fn nif_color_alpha_blend(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const arg_dst = core.Argument(core.Color).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer arg_dst.free();
    const dst = arg_dst.data;

    const arg_src = core.Argument(core.Color).get(env, argv[1]) catch {
        return error.invalid_argument_src;
    };
    defer arg_src.free();
    const src = arg_src.data;

    const arg_tint = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    const new_color = rl.ColorAlphaBlend(dst, src, tint);
    defer if (!return_resource) core.Color.free(new_color);
    errdefer if (return_resource) core.Color.free(new_color);

    // Return

    return core.maybe_make_struct_as_resource(core.Color, env, new_color, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get color lerp interpolation between two colors, factor [0.0f..1.0f]
///
/// raylib.h
/// RLAPI Color ColorLerp(Color color1, Color color2, float factor);
fn nif_color_lerp(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const arg_color1 = core.Argument(core.Color).get(env, argv[0]) catch {
        return error.invalid_argument_color1;
    };
    defer arg_color1.free();
    const color1 = arg_color1.data;

    const arg_color2 = core.Argument(core.Color).get(env, argv[1]) catch {
        return error.invalid_argument_color2;
    };
    defer arg_color2.free();
    const color2 = arg_color2.data;

    const factor = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_factor;
    };

    // Function

    const new_color = rl.ColorLerp(color1, color2, @floatCast(factor));
    defer if (!return_resource) core.Color.free(new_color);
    errdefer if (return_resource) core.Color.free(new_color);

    // Return

    return core.maybe_make_struct_as_resource(core.Color, env, new_color, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get Color structure from hexadecimal value
///
/// raylib.h
/// RLAPI Color GetColor(unsigned int hexValue);
fn nif_get_color(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const hex_value = core.UInt.get(env, argv[0]) catch {
        return error.invalid_argument_hex_value;
    };

    // Function

    const color = rl.GetColor(hex_value);
    defer if (!return_resource) core.Color.free(color);
    errdefer if (return_resource) core.Color.free(color);

    // Return

    return core.maybe_make_struct_as_resource(core.Color, env, color, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get Color from a source pixel pointer of certain format
///
/// raylib.h
/// RLAPI Color GetPixelColor(void *srcPtr, int format);
fn nif_get_pixel_color(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_data = core.ArgumentBinary(core.Binary, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_data;
    };
    defer arg_data.free();
    const data = arg_data.data;

    const format = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_format;
    };

    const data_size: usize = @intCast(rl.GetPixelDataSize(1, 1, format));

    if (data.len != data_size) {
        return error.invalid_argument_data;
    }

    // Function

    const color = rl.GetPixelColor(@ptrCast(data), format);
    defer if (!return_resource) core.Color.free(color);
    errdefer if (return_resource) core.Color.free(color);

    // Return

    return core.maybe_make_struct_as_resource(core.Color, env, color, return_resource) catch {
        return error.invalid_return;
    };
}

/// Set color formatted into destination pixel pointer
///
/// raylib.h
/// RLAPI void SetPixelColor(void *dstPtr, Color color, int format);
fn nif_set_pixel_color(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_color = core.Argument(core.Color).get(env, argv[0]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    const format = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_format;
    };

    const data_size: usize = @intCast(rl.GetPixelDataSize(1, 1, format));

    const data = try rl.allocator.alloc(u8, data_size);
    defer rl.allocator.free(data);

    // Function

    rl.SetPixelColor(@ptrCast(data), color, format);

    // Return

    return core.Binary.make(env, data);
}

/// Get pixel data size in bytes for certain format
///
/// raylib.h
/// RLAPI int GetPixelDataSize(int width, int height, int format);
fn nif_get_pixel_data_size(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const width = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_height;
    };

    const format = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_format;
    };

    // Function

    const pixel_data_size = rl.GetPixelDataSize(width, height, format);

    // Return

    return core.UInt.make(env, @intCast(pixel_data_size));
}
