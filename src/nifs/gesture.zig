const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Gesture
    .{ .name = "set_gestures_enabled", .arity = 1, .fptr = nif_set_gestures_enabled, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_gesture_detected", .arity = 1, .fptr = nif_is_gesture_detected, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_gesture_detected", .arity = 0, .fptr = nif_get_gesture_detected, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_gesture_hold_duration", .arity = 0, .fptr = nif_get_gesture_hold_duration, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_gesture_drag_vector", .arity = 0, .fptr = nif_get_gesture_drag_vector, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_gesture_drag_vector", .arity = 1, .fptr = nif_get_gesture_drag_vector, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_gesture_drag_angle", .arity = 0, .fptr = nif_get_gesture_drag_angle, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_gesture_pinch_vector", .arity = 0, .fptr = nif_get_gesture_pinch_vector, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_gesture_pinch_vector", .arity = 1, .fptr = nif_get_gesture_pinch_vector, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_gesture_pinch_angle", .arity = 0, .fptr = nif_get_gesture_pinch_angle, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

///////////////
//  Gesture  //
///////////////

/// Enable a set of gestures using flags
///
/// raylib.h
/// RLAPI void SetGesturesEnabled(unsigned int flags);
fn nif_set_gestures_enabled(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const flags = core.UInt.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'flags'.");
    };

    // Function

    rl.SetGesturesEnabled(flags);

    // Return

    return core.Atom.make(env, "ok");
}

/// Check if a gesture have been detected
///
/// raylib.h
/// RLAPI bool IsGestureDetected(unsigned int gesture);
fn nif_is_gesture_detected(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const gesture = core.UInt.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'gesture'.");
    };

    // Function

    const is_gesture_detected = rl.IsGestureDetected(gesture);

    // Return

    return core.Boolean.make(env, is_gesture_detected);
}

/// Get latest detected gesture
///
/// raylib.h
/// RLAPI int GetGestureDetected(void);
fn nif_get_gesture_detected(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const gesture_detected = rl.GetGestureDetected();

    // Return

    return core.Int.make(env, gesture_detected);
}

/// Get gesture hold time in seconds
///
/// raylib.h
/// RLAPI float GetGestureHoldDuration(void);
fn nif_get_gesture_hold_duration(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const gesture_hold_duration = rl.GetGestureHoldDuration();

    // Return

    return core.Double.make(env, @floatCast(gesture_hold_duration));
}

/// Get gesture drag vector
///
/// raylib.h
/// RLAPI Vector2 GetGestureDragVector(void);
fn nif_get_gesture_drag_vector(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0 or argc == 1);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 0);

    // Function

    const gesture_drag_vector = rl.GetGestureDragVector();
    defer if (!return_resource) core.Vector2.free(gesture_drag_vector);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector2, env, gesture_drag_vector, return_resource) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to get return value.");
    };
}

/// Get gesture drag angle
///
/// raylib.h
/// RLAPI float GetGestureDragAngle(void);
fn nif_get_gesture_drag_angle(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const gesture_drag_angle = rl.GetGestureDragAngle();

    // Return

    return core.Double.make(env, @floatCast(gesture_drag_angle));
}

/// Get gesture pinch delta
///
/// raylib.h
/// RLAPI Vector2 GetGesturePinchVector(void);
fn nif_get_gesture_pinch_vector(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0 or argc == 1);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 0);

    // Function

    const gesture_pinch_vector = rl.GetGesturePinchVector();
    defer if (!return_resource) core.Vector2.free(gesture_pinch_vector);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector2, env, gesture_pinch_vector, return_resource) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to get return value.");
    };
}

/// Get gesture pinch angle
///
/// raylib.h
/// RLAPI float GetGesturePinchAngle(void);
fn nif_get_gesture_pinch_angle(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const gesture_pinch_angle = rl.GetGesturePinchAngle();

    // Return

    return core.Double.make(env, @floatCast(gesture_pinch_angle));
}
