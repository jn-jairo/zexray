const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Camera
    .{ .name = "update_camera", .arity = 2, .fptr = core.nif_wrapper(nif_update_camera), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "update_camera", .arity = 3, .fptr = core.nif_wrapper(nif_update_camera), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "update_camera_pro", .arity = 4, .fptr = core.nif_wrapper(nif_update_camera_pro), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "update_camera_pro", .arity = 5, .fptr = core.nif_wrapper(nif_update_camera_pro), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_camera_forward", .arity = 1, .fptr = core.nif_wrapper(nif_get_camera_forward), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_camera_forward", .arity = 2, .fptr = core.nif_wrapper(nif_get_camera_forward), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_camera_up", .arity = 1, .fptr = core.nif_wrapper(nif_get_camera_up), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_camera_up", .arity = 2, .fptr = core.nif_wrapper(nif_get_camera_up), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_camera_right", .arity = 1, .fptr = core.nif_wrapper(nif_get_camera_right), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_camera_right", .arity = 2, .fptr = core.nif_wrapper(nif_get_camera_right), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_move_forward", .arity = 3, .fptr = core.nif_wrapper(nif_camera_move_forward), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_move_forward", .arity = 4, .fptr = core.nif_wrapper(nif_camera_move_forward), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_move_up", .arity = 2, .fptr = core.nif_wrapper(nif_camera_move_up), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_move_up", .arity = 3, .fptr = core.nif_wrapper(nif_camera_move_up), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_move_right", .arity = 3, .fptr = core.nif_wrapper(nif_camera_move_right), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_move_right", .arity = 4, .fptr = core.nif_wrapper(nif_camera_move_right), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_move_to_target", .arity = 2, .fptr = core.nif_wrapper(nif_camera_move_to_target), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_move_to_target", .arity = 3, .fptr = core.nif_wrapper(nif_camera_move_to_target), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_yaw", .arity = 3, .fptr = core.nif_wrapper(nif_camera_yaw), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_yaw", .arity = 4, .fptr = core.nif_wrapper(nif_camera_yaw), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_pitch", .arity = 5, .fptr = core.nif_wrapper(nif_camera_pitch), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_pitch", .arity = 6, .fptr = core.nif_wrapper(nif_camera_pitch), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_roll", .arity = 2, .fptr = core.nif_wrapper(nif_camera_roll), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_roll", .arity = 3, .fptr = core.nif_wrapper(nif_camera_roll), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_camera_view_matrix", .arity = 1, .fptr = core.nif_wrapper(nif_get_camera_view_matrix), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_camera_view_matrix", .arity = 2, .fptr = core.nif_wrapper(nif_get_camera_view_matrix), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_camera_projection_matrix", .arity = 2, .fptr = core.nif_wrapper(nif_get_camera_projection_matrix), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_camera_projection_matrix", .arity = 3, .fptr = core.nif_wrapper(nif_get_camera_projection_matrix), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

//////////////
//  Camera  //
//////////////

/// Update camera position for selected mode
///
/// raylib.h
/// RLAPI void UpdateCamera(Camera *camera, int mode);
fn nif_update_camera(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_camera = core.Argument(core.Camera).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer if (!return_resource) arg_camera.free();
    errdefer if (return_resource) arg_camera.free();
    var camera = arg_camera.data;

    const mode = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_mode;
    };

    // Function

    rl.UpdateCamera(&camera, mode);

    // Return

    return core.maybe_make_struct_or_resource(core.Camera, env, argv[0], camera, return_resource) catch {
        return error.invalid_return;
    };
}

/// Update camera movement/rotation
///
/// raylib.h
/// RLAPI void UpdateCameraPro(Camera *camera, Vector3 movement, Vector3 rotation, float zoom);
fn nif_update_camera_pro(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4 or argc == 5);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 4);

    // Arguments

    const arg_camera = core.Argument(core.Camera).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer if (!return_resource) arg_camera.free();
    errdefer if (return_resource) arg_camera.free();
    var camera = arg_camera.data;

    const arg_movement = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_movement;
    };
    defer arg_movement.free();
    const movement = arg_movement.data;

    const arg_rotation = core.Argument(core.Vector3).get(env, argv[2]) catch {
        return error.invalid_argument_rotation;
    };
    defer arg_rotation.free();
    const rotation = arg_rotation.data;

    const zoom = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_zoom;
    };

    // Function

    rl.UpdateCameraPro(&camera, movement, rotation, @floatCast(zoom));

    // Return

    return core.maybe_make_struct_or_resource(core.Camera, env, argv[0], camera, return_resource) catch {
        return error.invalid_return;
    };
}

/// Returns the cameras forward vector (normalized)
///
/// rcamera.h
/// RLAPI Vector3 GetCameraForward(Camera *camera);
fn nif_get_camera_forward(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_camera = core.Argument(core.Camera).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer arg_camera.free();
    var camera = arg_camera.data;

    // Function

    const camera_forward = rl.GetCameraForward(&camera);
    defer if (!return_resource) core.Vector3.free(camera_forward);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector3, env, camera_forward, return_resource) catch {
        return error.invalid_return;
    };
}

/// Returns the cameras up vector (normalized)
/// NOTE: The up vector might not be perpendicular to the forward vector
///
/// rcamera.h
/// RLAPI Vector3 GetCameraUp(Camera *camera);
fn nif_get_camera_up(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_camera = core.Argument(core.Camera).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer arg_camera.free();
    var camera = arg_camera.data;

    // Function

    const camera_up = rl.GetCameraUp(&camera);
    defer if (!return_resource) core.Vector3.free(camera_up);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector3, env, camera_up, return_resource) catch {
        return error.invalid_return;
    };
}

/// Returns the cameras right vector (normalized)
///
/// rcamera.h
/// RLAPI Vector3 GetCameraRight(Camera *camera);
fn nif_get_camera_right(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_camera = core.Argument(core.Camera).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer arg_camera.free();
    var camera = arg_camera.data;

    // Function

    const camera_right = rl.GetCameraRight(&camera);
    defer if (!return_resource) core.Vector3.free(camera_right);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector3, env, camera_right, return_resource) catch {
        return error.invalid_return;
    };
}

/// Moves the camera in its forward direction
///
/// rcamera.h
/// RLAPI void CameraMoveForward(Camera *camera, float distance, bool moveInWorldPlane);
fn nif_camera_move_forward(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const arg_camera = core.Argument(core.Camera).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer if (!return_resource) arg_camera.free();
    errdefer if (return_resource) arg_camera.free();
    var camera = arg_camera.data;

    const distance = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_distance;
    };

    const move_in_world_plane = core.Boolean.get(env, argv[2]) catch {
        return error.invalid_argument_move_in_world_plane;
    };

    // Function

    rl.CameraMoveForward(&camera, @floatCast(distance), move_in_world_plane);

    // Return

    return core.maybe_make_struct_or_resource(core.Camera, env, argv[0], camera, return_resource) catch {
        return error.invalid_return;
    };
}

/// Moves the camera in its up direction
///
/// rcamera.h
/// RLAPI void CameraMoveUp(Camera *camera, float distance);
fn nif_camera_move_up(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_camera = core.Argument(core.Camera).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer if (!return_resource) arg_camera.free();
    errdefer if (return_resource) arg_camera.free();
    var camera = arg_camera.data;

    const distance = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_distance;
    };

    // Function

    rl.CameraMoveUp(&camera, @floatCast(distance));

    // Return

    return core.maybe_make_struct_or_resource(core.Camera, env, argv[0], camera, return_resource) catch {
        return error.invalid_return;
    };
}

/// Moves the camera target in its current right direction
///
/// rcamera.h
/// RLAPI void CameraMoveRight(Camera *camera, float distance, bool moveInWorldPlane);
fn nif_camera_move_right(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const arg_camera = core.Argument(core.Camera).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer if (!return_resource) arg_camera.free();
    errdefer if (return_resource) arg_camera.free();
    var camera = arg_camera.data;

    const distance = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_distance;
    };

    const move_in_world_plane = core.Boolean.get(env, argv[2]) catch {
        return error.invalid_argument_move_in_world_plane;
    };

    // Function

    rl.CameraMoveRight(&camera, @floatCast(distance), move_in_world_plane);

    // Return

    return core.maybe_make_struct_or_resource(core.Camera, env, argv[0], camera, return_resource) catch {
        return error.invalid_return;
    };
}

/// Moves the camera position closer/farther to/from the camera target
///
/// rcamera.h
/// RLAPI void CameraMoveToTarget(Camera *camera, float delta);
fn nif_camera_move_to_target(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_camera = core.Argument(core.Camera).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer if (!return_resource) arg_camera.free();
    errdefer if (return_resource) arg_camera.free();
    var camera = arg_camera.data;

    const delta = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_delta;
    };

    // Function

    rl.CameraMoveToTarget(&camera, @floatCast(delta));

    // Return

    return core.maybe_make_struct_or_resource(core.Camera, env, argv[0], camera, return_resource) catch {
        return error.invalid_return;
    };
}

/// Rotates the camera around its up vector
/// Yaw is "looking left and right"
/// If rotateAroundTarget is false, the camera rotates around its position
/// NOTE: angle must be provided in radians
///
/// rcamera.h
/// RLAPI void CameraYaw(Camera *camera, float angle, bool rotateAroundTarget);
fn nif_camera_yaw(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const arg_camera = core.Argument(core.Camera).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer if (!return_resource) arg_camera.free();
    errdefer if (return_resource) arg_camera.free();
    var camera = arg_camera.data;

    const angle = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_angle;
    };

    const rotate_around_target = core.Boolean.get(env, argv[2]) catch {
        return error.invalid_argument_rotate_around_target;
    };

    // Function

    rl.CameraYaw(&camera, @floatCast(angle), rotate_around_target);

    // Return

    return core.maybe_make_struct_or_resource(core.Camera, env, argv[0], camera, return_resource) catch {
        return error.invalid_return;
    };
}

/// Rotates the camera around its right vector, pitch is "looking up and down"
///  - lockView prevents camera overrotation (aka "somersaults")
///  - rotateAroundTarget defines if rotation is around target or around its position
///  - rotateUp rotates the up direction as well (typically only usefull in CAMERA_FREE)
/// NOTE: angle must be provided in radians
///
/// rcamera.h
/// RLAPI void CameraPitch(Camera *camera, float angle, bool lockView, bool rotateAroundTarget, bool rotateUp);
fn nif_camera_pitch(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 5);

    // Arguments

    const arg_camera = core.Argument(core.Camera).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer if (!return_resource) arg_camera.free();
    errdefer if (return_resource) arg_camera.free();
    var camera = arg_camera.data;

    const angle = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_angle;
    };

    const lock_view = core.Boolean.get(env, argv[2]) catch {
        return error.invalid_argument_lock_view;
    };

    const rotate_around_target = core.Boolean.get(env, argv[3]) catch {
        return error.invalid_argument_rotate_around_target;
    };

    const rotate_up = core.Boolean.get(env, argv[4]) catch {
        return error.invalid_argument_rotate_up;
    };

    // Function

    rl.CameraPitch(&camera, @floatCast(angle), lock_view, rotate_around_target, rotate_up);

    // Return

    return core.maybe_make_struct_or_resource(core.Camera, env, argv[0], camera, return_resource) catch {
        return error.invalid_return;
    };
}

/// Rotates the camera around its forward vector
/// Roll is "turning your head sideways to the left or right"
/// NOTE: angle must be provided in radians
///
/// rcamera.h
/// RLAPI void CameraRoll(Camera *camera, float angle);
fn nif_camera_roll(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_camera = core.Argument(core.Camera).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer if (!return_resource) arg_camera.free();
    errdefer if (return_resource) arg_camera.free();
    var camera = arg_camera.data;

    const angle = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_angle;
    };

    // Function

    rl.CameraRoll(&camera, @floatCast(angle));

    // Return

    return core.maybe_make_struct_or_resource(core.Camera, env, argv[0], camera, return_resource) catch {
        return error.invalid_return;
    };
}

/// Returns the camera view matrix
///
/// rcamera.h
/// RLAPI Matrix GetCameraViewMatrix(Camera *camera);
fn nif_get_camera_view_matrix(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_camera = core.Argument(core.Camera).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer arg_camera.free();
    var camera = arg_camera.data;

    // Function

    const camera_view_matrix = rl.GetCameraViewMatrix(&camera);
    defer if (!return_resource) core.Matrix.free(camera_view_matrix);

    // Return

    return core.maybe_make_struct_as_resource(core.Matrix, env, camera_view_matrix, return_resource) catch {
        return error.invalid_return;
    };
}

/// Returns the camera projection matrix
///
/// rcamera.h
/// RLAPI Matrix GetCameraProjectionMatrix(Camera *camera, float aspect);
fn nif_get_camera_projection_matrix(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_camera = core.Argument(core.Camera).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer arg_camera.free();
    var camera = arg_camera.data;

    const aspect = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_aspect;
    };

    // Function

    const camera_projection_matrix = rl.GetCameraProjectionMatrix(&camera, @floatCast(aspect));
    defer if (!return_resource) core.Matrix.free(camera_projection_matrix);

    // Return

    return core.maybe_make_struct_as_resource(core.Matrix, env, camera_projection_matrix, return_resource) catch {
        return error.invalid_return;
    };
}
