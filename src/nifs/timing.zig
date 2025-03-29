const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Timing
    .{ .name = "set_target_fps", .arity = 1, .fptr = nif_set_target_fps, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_frame_time", .arity = 0, .fptr = nif_get_frame_time, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_time", .arity = 0, .fptr = nif_get_time, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_fps", .arity = 0, .fptr = nif_get_fps, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

//////////////
//  Timing  //
//////////////

/// Set target FPS (maximum)
///
/// raylib.h
/// RLAPI void SetTargetFPS(int fps);
fn nif_set_target_fps(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const fps = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'fps'.");
    };

    // Function

    rl.SetTargetFPS(fps);

    // Return

    return core.Atom.make(env, "ok");
}

/// Get time in seconds for last frame drawn (delta time)
///
/// raylib.h
/// RLAPI float GetFrameTime(void);
fn nif_get_frame_time(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const frame_time = rl.GetFrameTime();

    // Return

    return core.Double.make(env, @floatCast(frame_time));
}

/// Get elapsed time in seconds since InitWindow()
///
/// raylib.h
/// RLAPI double GetTime(void);
fn nif_get_time(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const time = rl.GetTime();

    // Return

    return core.Double.make(env, @floatCast(time));
}

/// Get current FPS
///
/// raylib.h
/// RLAPI int GetFPS(void);
fn nif_get_fps(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const fps = rl.GetFPS();

    // Return

    return core.Int.make(env, fps);
}
