const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Touch
    .{ .name = "get_touch_x", .arity = 0, .fptr = nif_get_touch_x, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_touch_y", .arity = 0, .fptr = nif_get_touch_y, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_touch_position", .arity = 1, .fptr = nif_get_touch_position, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_touch_position", .arity = 2, .fptr = nif_get_touch_position, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_touch_point_id", .arity = 1, .fptr = nif_get_touch_point_id, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_touch_point_count", .arity = 0, .fptr = nif_get_touch_point_count, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

/////////////
//  Touch  //
/////////////

/// Get touch position X for touch point 0 (relative to screen size)
///
/// raylib.h
/// RLAPI int GetTouchX(void);
fn nif_get_touch_x(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const touch_x = rl.GetTouchX();

    // Return

    return core.Int.make(env, touch_x);
}

/// Get touch position Y for touch point 0 (relative to screen size)
///
/// raylib.h
/// RLAPI int GetTouchY(void);
fn nif_get_touch_y(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const touch_y = rl.GetTouchY();

    // Return

    return core.Int.make(env, touch_y);
}

/// Get touch position XY for a touch point index (relative to screen size)
///
/// raylib.h
/// RLAPI Vector2 GetTouchPosition(int index);
fn nif_get_touch_position(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const index = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'index'.");
    };

    // Function

    const position = rl.GetTouchPosition(index);
    defer if (!return_resource) core.Vector2.free(position);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector2, env, position, return_resource) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to get return value.");
    };
}

/// Get touch point identifier for given index
///
/// raylib.h
/// RLAPI int GetTouchPointId(int index);
fn nif_get_touch_point_id(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const index = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'index'.");
    };

    // Function

    const touch_point_id = rl.GetTouchPointId(index);

    // Return

    return core.Int.make(env, touch_point_id);
}

/// Get number of touch points
///
/// raylib.h
/// RLAPI int GetTouchPointCount(void);
fn nif_get_touch_point_count(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const touch_point_count = rl.GetTouchPointCount();

    // Return

    return core.Int.make(env, touch_point_count);
}
