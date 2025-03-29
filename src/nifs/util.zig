const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // TraceLog
    .{ .name = "trace_log", .arity = 2, .fptr = nif_trace_log, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_trace_log_level", .arity = 1, .fptr = nif_set_trace_log_level, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_trace_log_callback", .arity = 0, .fptr = nif_set_trace_log_callback, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

////////////////
//  TraceLog  //
////////////////

/// Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
///
/// raylib.h
/// RLAPI void TraceLog(int logLevel, const char *text, ...);
fn nif_trace_log(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const log_level: c_int = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'log_level'.");
    };

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'text'.");
    };
    defer arg_text.free();
    const text = arg_text.data;

    // Function

    rl.TraceLog(log_level, text);

    // Return

    return core.Atom.make(env, "ok");
}

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

pub fn traceLog(logLevel: c_int, text: [*c]const u8, args: [*c]rl.struct___va_list_tag_1) callconv(.C) void {
    const buf_len = rl.MAX_TRACELOG_MSG_LENGTH * 4;
    var buf: [buf_len]u8 = std.mem.zeroes([buf_len]u8);

    const writer = std.io.getStdErr().writer();

    const len: usize = @intCast(rl.vsnprintf(&buf, buf_len, text, args));

    switch (logLevel) {
        rl.LOG_TRACE => writer.writeAll("TRACE:   ") catch return,
        rl.LOG_DEBUG => writer.writeAll("DEBUG:   ") catch return,
        rl.LOG_INFO => writer.writeAll("INFO:    ") catch return,
        rl.LOG_WARNING => writer.writeAll("WARNING: ") catch return,
        rl.LOG_ERROR => writer.writeAll("ERROR:   ") catch return,
        rl.LOG_FATAL => writer.writeAll("FATAL:   ") catch return,
        else => return,
    }

    writer.writeAll(buf[0..len]) catch return;
    writer.writeAll("\n\r") catch return;
}

/// Set custom trace log
///
/// raylib.h
/// RLAPI void SetTraceLogCallback(TraceLogCallback callback);
fn nif_set_trace_log_callback(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.SetTraceLogCallback(@ptrCast(&traceLog));

    // Return

    return core.Atom.make(env, "ok");
}
