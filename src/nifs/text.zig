const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Text Drawing
    .{ .name = "draw_fps", .arity = 2, .fptr = nif_draw_fps, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_text", .arity = 5, .fptr = nif_draw_text, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
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
