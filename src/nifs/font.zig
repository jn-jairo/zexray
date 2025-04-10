const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Font loading
    .{ .name = "get_font_default", .arity = 0, .fptr = nif_get_font_default, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_font_default", .arity = 1, .fptr = nif_get_font_default, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_font", .arity = 1, .fptr = nif_load_font, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_font", .arity = 2, .fptr = nif_load_font, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_font_ex", .arity = 4, .fptr = nif_load_font_ex, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_font_ex", .arity = 5, .fptr = nif_load_font_ex, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_font_from_image", .arity = 3, .fptr = nif_load_font_from_image, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_font_from_image", .arity = 4, .fptr = nif_load_font_from_image, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_font_from_memory", .arity = 5, .fptr = nif_load_font_from_memory, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_font_from_memory", .arity = 6, .fptr = nif_load_font_from_memory, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_font_valid", .arity = 1, .fptr = nif_is_font_valid, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

////////////////////
//  Font loading  //
////////////////////

/// Get the default Font
///
/// raylib.h
/// RLAPI Font GetFontDefault(void);
fn nif_get_font_default(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0 or argc == 1);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 0);

    // Function

    const font = rl.GetFontDefault();
    defer if (!return_resource) core.Font.free(font);

    // Return

    return core.maybe_make_struct_as_resource(core.Font, env, font, return_resource) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to get return value.");
    };
}

/// Load font from file into GPU memory (VRAM)
///
/// raylib.h
/// RLAPI Font LoadFont(const char *fileName);
fn nif_load_font(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_file_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'file_name'.");
    };
    defer arg_file_name.free();
    const file_name = arg_file_name.data;

    // Function

    const font = rl.LoadFont(file_name);
    defer if (!return_resource) core.Font.free(font);

    // Return

    return core.maybe_make_struct_as_resource(core.Font, env, font, return_resource) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to get return value.");
    };
}

/// Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set, font size is provided in pixels height
///
/// raylib.h
/// RLAPI Font LoadFontEx(const char *fileName, int fontSize, int *codepoints, int codepointCount);
fn nif_load_font_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 4 or argc == 5);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 4);

    // Arguments

    const arg_file_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'file_name'.");
    };
    defer arg_file_name.free();
    const file_name = arg_file_name.data;

    const font_size = core.Int.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font_size'.");
    };

    var arg_codepoints = core.ArgumentArray(core.Int, core.Int.data_type, rl.allocator).get(env, argv[2]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'codepoint'.");
    };
    defer arg_codepoints.free();
    const codepoints = arg_codepoints.data;
    const codepoints_count = if (arg_codepoints.length > 0) arg_codepoints.length else rl.FONT_TTF_DEFAULT_NUMCHARS;

    const font_type = core.Int.get(env, argv[3]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font_type'.");
    };

    // Function

    const font = rl.LoadFontEx2(file_name, font_size, @ptrCast(codepoints), @intCast(codepoints_count), font_type);
    defer if (!return_resource) core.Font.free(font);

    // Return

    return core.maybe_make_struct_as_resource(core.Font, env, font, return_resource) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to get return value.");
    };
}

/// Load font from Image (XNA style)
///
/// raylib.h
/// RLAPI Font LoadFontFromImage(Image image, Color key, int firstChar);
fn nif_load_font_from_image(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const arg_image = core.Argument(core.Image).get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'image'.");
    };
    defer arg_image.free();
    const image = arg_image.data;

    const arg_key = core.Argument(core.Color).get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'key'.");
    };
    defer arg_key.free();
    const key = arg_key.data;

    const first_char = core.Int.get(env, argv[2]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'first_char'.");
    };

    // Function

    const font = rl.LoadFontFromImage(image, key, first_char);
    defer if (!return_resource) core.Font.free(font);

    // Return

    return core.maybe_make_struct_as_resource(core.Font, env, font, return_resource) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to get return value.");
    };
}

/// Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
///
/// raylib.h
/// RLAPI Font LoadFontFromMemory(const char *fileType, const unsigned char *fileData, int dataSize, int fontSize, int *codepoints, int codepointCount);
fn nif_load_font_from_memory(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 5);

    // Arguments

    const arg_file_type = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'file_type'.");
    };
    defer arg_file_type.free();
    const file_type = arg_file_type.data;

    const arg_file_data = core.ArgumentBinary(core.Binary, rl.allocator).get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'file_data'.");
    };
    defer arg_file_data.free();
    const file_data = arg_file_data.data;
    const data_size = arg_file_data.length;

    const font_size = core.Int.get(env, argv[2]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font_size'.");
    };

    var arg_codepoints = core.ArgumentArray(core.Int, core.Int.data_type, rl.allocator).get(env, argv[3]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'codepoint'.");
    };
    defer arg_codepoints.free();
    const codepoints = arg_codepoints.data;
    const codepoints_count = if (arg_codepoints.length > 0) arg_codepoints.length else rl.FONT_TTF_DEFAULT_NUMCHARS;

    const font_type = core.Int.get(env, argv[4]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font_type'.");
    };

    // Function

    const font = rl.LoadFontFromMemoryEx(file_type, @ptrCast(file_data), @intCast(data_size), font_size, @ptrCast(codepoints), @intCast(codepoints_count), font_type);
    defer if (!return_resource) core.Font.free(font);

    // Return

    return core.maybe_make_struct_as_resource(core.Font, env, font, return_resource) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to get return value.");
    };
}

/// Check if a font is valid (font data loaded, WARNING: GPU texture not checked)
///
/// raylib.h
/// RLAPI bool IsFontValid(Font font);
fn nif_is_font_valid(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_font = core.Argument(core.Font).get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'font'.");
    };
    defer arg_font.free();
    const font = arg_font.data;

    // Function

    const is_font_valid = rl.IsFontValid(font);

    // Return

    return core.Boolean.make(env, is_font_valid);
}
