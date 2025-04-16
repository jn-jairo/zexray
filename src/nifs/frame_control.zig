const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Frame control
    .{ .name = "swap_screen_buffer", .arity = 0, .fptr = core.nif_wrapper(nif_swap_screen_buffer), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "poll_input_events", .arity = 0, .fptr = core.nif_wrapper(nif_poll_input_events), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "wait_time", .arity = 1, .fptr = core.nif_wrapper(nif_wait_time), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

/////////////////////
//  Frame control  //
/////////////////////

/// Swap back buffer with front buffer (screen drawing)
///
/// raylib.h
/// RLAPI void SwapScreenBuffer(void);
fn nif_swap_screen_buffer(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.SwapScreenBuffer();

    // Return

    return core.Atom.make(env, "ok");
}

/// Register all input events
///
/// raylib.h
/// RLAPI void PollInputEvents(void);
fn nif_poll_input_events(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.PollInputEvents();

    // Return

    return core.Atom.make(env, "ok");
}

/// Wait for some time (halt program execution)
///
/// raylib.h
/// RLAPI void WaitTime(double seconds);
fn nif_wait_time(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const seconds: f64 = core.Double.get(env, argv[0]) catch {
        return error.invalid_argument_seconds;
    };

    // Function

    rl.WaitTime(seconds);

    // Return

    return core.Atom.make(env, "ok");
}
