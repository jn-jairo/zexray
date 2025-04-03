const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Monitor
    .{ .name = "set_window_monitor", .arity = 1, .fptr = nif_set_window_monitor, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_monitor_count", .arity = 0, .fptr = nif_get_monitor_count, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_current_monitor", .arity = 0, .fptr = nif_get_current_monitor, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_monitor_position", .arity = 1, .fptr = nif_get_monitor_position, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_monitor_position", .arity = 2, .fptr = nif_get_monitor_position, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_monitor_width", .arity = 1, .fptr = nif_get_monitor_width, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_monitor_height", .arity = 1, .fptr = nif_get_monitor_height, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_monitor_physical_width", .arity = 1, .fptr = nif_get_monitor_physical_width, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_monitor_physical_height", .arity = 1, .fptr = nif_get_monitor_physical_height, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_monitor_refresh_rate", .arity = 1, .fptr = nif_get_monitor_refresh_rate, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_monitor_name", .arity = 1, .fptr = nif_get_monitor_name, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

///////////////
//  Monitor  //
///////////////

/// Set monitor for the current window
///
/// raylib.h
/// RLAPI void SetWindowMonitor(int monitor);
fn nif_set_window_monitor(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const monitor = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'monitor'.");
    };

    // Function

    rl.SetWindowMonitor(monitor);

    // Return

    return core.Atom.make(env, "ok");
}

/// Get number of connected monitors
///
/// raylib.h
/// RLAPI int GetMonitorCount(void);
fn nif_get_monitor_count(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const monitor_count = rl.GetMonitorCount();

    // Return

    return core.Int.make(env, monitor_count);
}

/// Get current monitor where window is placed
///
/// raylib.h
/// RLAPI int GetCurrentMonitor(void);
fn nif_get_current_monitor(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const current_monitor = rl.GetCurrentMonitor();

    // Return

    return core.Int.make(env, current_monitor);
}

/// Get specified monitor position
///
/// raylib.h
/// RLAPI Vector2 GetMonitorPosition(int monitor);
fn nif_get_monitor_position(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const monitor = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'monitor'.");
    };

    // Function

    const position = rl.GetMonitorPosition(monitor);
    defer if (!return_resource) core.Vector2.free(position);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector2, env, position, return_resource) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to get return value.");
    };
}

/// Get specified monitor width (current video mode used by monitor)
///
/// raylib.h
/// RLAPI int GetMonitorWidth(int monitor);
fn nif_get_monitor_width(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const monitor = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'monitor'.");
    };

    // Function

    const monitor_width = rl.GetMonitorWidth(monitor);

    // Return

    return core.Int.make(env, monitor_width);
}

/// Get specified monitor height (current video mode used by monitor)
///
/// raylib.h
/// RLAPI int GetMonitorHeight(int monitor);
fn nif_get_monitor_height(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const monitor = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'monitor'.");
    };

    // Function

    const monitor_height = rl.GetMonitorHeight(monitor);

    // Return

    return core.Int.make(env, monitor_height);
}

/// Get specified monitor physical width in millimetres
///
/// raylib.h
/// RLAPI int GetMonitorPhysicalWidth(int monitor);
fn nif_get_monitor_physical_width(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const monitor = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'monitor'.");
    };

    // Function

    const monitor_width = rl.GetMonitorPhysicalWidth(monitor);

    // Return

    return core.Int.make(env, monitor_width);
}

/// Get specified monitor physical height in millimetres
///
/// raylib.h
/// RLAPI int GetMonitorPhysicalHeight(int monitor);
fn nif_get_monitor_physical_height(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const monitor = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'monitor'.");
    };

    // Function

    const monitor_height = rl.GetMonitorPhysicalHeight(monitor);

    // Return

    return core.Int.make(env, monitor_height);
}

/// Get specified monitor refresh rate
///
/// raylib.h
/// RLAPI int GetMonitorRefreshRate(int monitor);
fn nif_get_monitor_refresh_rate(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const monitor = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'monitor'.");
    };

    // Function

    const monitor_refresh_rate = rl.GetMonitorRefreshRate(monitor);

    // Return

    return core.Int.make(env, monitor_refresh_rate);
}

/// Get the human-readable, UTF-8 encoded name of the specified monitor
///
/// raylib.h
/// RLAPI const char *GetMonitorName(int monitor);
fn nif_get_monitor_name(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const monitor = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'monitor'.");
    };

    // Function

    const monitor_name = rl.GetMonitorName(monitor);
    // Do NOT free monitor_name

    // Return

    return core.CString.make_c_unknown(env, monitor_name);
}
