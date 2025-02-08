const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // TraceLog
    .{ .name = "set_trace_log_level", .arity = 1, .fptr = nif_set_trace_log_level, .flags = 0 },
};

////////////////
//  TraceLog  //
////////////////

/// Set the current threshold (minimum) log level
///
/// raylib.h
/// RLAPI void SetTraceLogLevel(int logLevel);
fn nif_set_trace_log_level(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const log_level: c_int = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'log_level'.");
    };

    // Function

    rl.SetTraceLogLevel(log_level);

    // Return

    return core.Atom.make(env, "ok");
}
