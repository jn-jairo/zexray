const rl = @import("raylib.zig");
const build_config = @import("config");

/// Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
pub fn TRACELOG(logLevel: c_int, text: [*c]const u8, args: anytype) void {
    if (build_config.trace_log) {
        @call(.auto, rl.TraceLog, .{ logLevel, text } ++ args);
    }
}

/// Show trace log messages (LOG_DEBUG)
pub fn TRACELOGD(text: [*c]const u8, args: anytype) void {
    if (build_config.trace_log and build_config.trace_log_debug) {
        @call(.auto, rl.TraceLog, .{ rl.LOG_DEBUG, text } ++ args);
    }
}
