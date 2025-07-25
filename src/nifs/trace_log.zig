const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

const stdlib = @cImport({
    @cInclude("stdlib.h");
});

const build_config = @import("config");

var log_type_level = rl.LOG_INFO;

pub const exported_nifs = [_]e.ErlNifFunc{
    // TraceLog
    .{ .name = "trace_log", .arity = 2, .fptr = core.nif_wrapper(nif_trace_log), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_trace_log_level", .arity = 1, .fptr = core.nif_wrapper(nif_set_trace_log_level), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_trace_log_callback", .arity = 0, .fptr = core.nif_wrapper(nif_set_trace_log_callback), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

////////////////
//  TraceLog  //
////////////////

pub fn trace_log(log_level: c_int, text: []const u8) void {
    if (build_config.trace_log) {
        if (log_level >= log_type_level) {
            const writer = std.io.getStdErr().writer();

            switch (log_level) {
                rl.LOG_TRACE => writer.writeAll("TRACE:   ") catch return,
                rl.LOG_DEBUG => writer.writeAll("DEBUG:   ") catch return,
                rl.LOG_INFO => writer.writeAll("INFO:    ") catch return,
                rl.LOG_WARNING => writer.writeAll("WARNING: ") catch return,
                rl.LOG_ERROR => writer.writeAll("ERROR:   ") catch return,
                rl.LOG_FATAL => writer.writeAll("FATAL:   ") catch return,
                else => return,
            }

            writer.writeAll(text) catch return;
            writer.writeAll("\n\r") catch return;

            if (log_level == rl.LOG_FATAL) {
                stdlib.exit(stdlib.EXIT_FAILURE);
            }
        }
    }
}

pub fn traceLog(log_level: c_int, text: [*c]const u8, args: *anyopaque) callconv(.C) void {
    const buf_len = rl.MAX_TRACELOG_MSG_LENGTH * 4;
    var buf: [buf_len]u8 = std.mem.zeroes([buf_len]u8);

    const len: usize = @intCast(rl.vsnprintf(&buf, buf_len, text, @ptrCast(@alignCast(args))));

    trace_log(log_level, buf[0..len]);
}

/// Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
///
/// raylib.h
/// RLAPI void TraceLog(int logLevel, const char *text, ...);
fn nif_trace_log(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const log_level: c_int = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_log_level;
    };

    const arg_text = core.ArgumentBinary(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    // Function

    trace_log(log_level, text);

    // Return

    return core.Atom.make(env, "ok");
}

/// Set the current threshold (minimum) log level
///
/// raylib.h
/// RLAPI void SetTraceLogLevel(int logLevel);
fn nif_set_trace_log_level(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const log_level: c_int = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_log_level;
    };

    // Function

    rl.SetTraceLogLevel(log_level);
    log_type_level = log_level;

    // Return

    return core.Atom.make(env, "ok");
}

/// Set custom trace log
///
/// raylib.h
/// RLAPI void SetTraceLogCallback(TraceLogCallback callback);
fn nif_set_trace_log_callback(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.SetTraceLogCallback(@ptrCast(&traceLog));

    // Return

    return core.Atom.make(env, "ok");
}
