const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Screen space
    .{ .name = "get_screen_to_world_ray", .arity = 2, .fptr = core.nif_wrapper(nif_get_screen_to_world_ray), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_screen_to_world_ray", .arity = 3, .fptr = core.nif_wrapper(nif_get_screen_to_world_ray), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_screen_to_world_ray_ex", .arity = 4, .fptr = core.nif_wrapper(nif_get_screen_to_world_ray_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_screen_to_world_ray_ex", .arity = 5, .fptr = core.nif_wrapper(nif_get_screen_to_world_ray_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_world_to_screen", .arity = 2, .fptr = core.nif_wrapper(nif_get_world_to_screen), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_world_to_screen", .arity = 3, .fptr = core.nif_wrapper(nif_get_world_to_screen), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_world_to_screen_ex", .arity = 4, .fptr = core.nif_wrapper(nif_get_world_to_screen_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_world_to_screen_ex", .arity = 5, .fptr = core.nif_wrapper(nif_get_world_to_screen_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_world_to_screen_2d", .arity = 2, .fptr = core.nif_wrapper(nif_get_world_to_screen_2d), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_world_to_screen_2d", .arity = 3, .fptr = core.nif_wrapper(nif_get_world_to_screen_2d), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_screen_to_world_2d", .arity = 2, .fptr = core.nif_wrapper(nif_get_screen_to_world_2d), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_screen_to_world_2d", .arity = 3, .fptr = core.nif_wrapper(nif_get_screen_to_world_2d), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_camera_matrix", .arity = 1, .fptr = core.nif_wrapper(nif_get_camera_matrix), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_camera_matrix", .arity = 2, .fptr = core.nif_wrapper(nif_get_camera_matrix), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_camera_matrix_2d", .arity = 1, .fptr = core.nif_wrapper(nif_get_camera_matrix_2d), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_camera_matrix_2d", .arity = 2, .fptr = core.nif_wrapper(nif_get_camera_matrix_2d), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

////////////////////
//  Screen space  //
////////////////////

/// Get a ray trace from screen position (i.e mouse)
///
/// raylib.h
/// RLAPI Ray GetScreenToWorldRay(Vector2 position, Camera camera);
fn nif_get_screen_to_world_ray(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_position = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_camera = core.Argument(core.Camera).get(env, argv[1]) catch {
        return error.invalid_argument_camera;
    };
    defer arg_camera.free();
    const camera = arg_camera.data;

    // Function

    const screen_to_world_ray = rl.GetScreenToWorldRay(position, camera);
    defer if (!return_resource) core.Ray.free(screen_to_world_ray);
    errdefer if (return_resource) core.Ray.free(screen_to_world_ray);

    // Return

    return core.maybe_make_struct_as_resource(core.Ray, env, screen_to_world_ray, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get a ray trace from screen position (i.e mouse) in a viewport
///
/// raylib.h
/// RLAPI Ray GetScreenToWorldRayEx(Vector2 position, Camera camera, int width, int height);
fn nif_get_screen_to_world_ray_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4 or argc == 5);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 4);

    // Arguments

    const arg_position = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_camera = core.Argument(core.Camera).get(env, argv[1]) catch {
        return error.invalid_argument_camera;
    };
    defer arg_camera.free();
    const camera = arg_camera.data;

    const width = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_height;
    };

    // Function

    const screen_to_world_ray_ex = rl.GetScreenToWorldRayEx(position, camera, width, height);
    defer if (!return_resource) core.Ray.free(screen_to_world_ray_ex);
    errdefer if (return_resource) core.Ray.free(screen_to_world_ray_ex);

    // Return

    return core.maybe_make_struct_as_resource(core.Ray, env, screen_to_world_ray_ex, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get the screen space position for a 3d world space position
///
/// raylib.h
/// RLAPI Vector2 GetWorldToScreen(Vector3 position, Camera camera);
fn nif_get_world_to_screen(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_position = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_camera = core.Argument(core.Camera).get(env, argv[1]) catch {
        return error.invalid_argument_camera;
    };
    defer arg_camera.free();
    const camera = arg_camera.data;

    // Function

    const world_to_screen = rl.GetWorldToScreen(position, camera);
    defer if (!return_resource) core.Vector2.free(world_to_screen);
    errdefer if (return_resource) core.Vector2.free(world_to_screen);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector2, env, world_to_screen, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get size position for a 3d world space position
///
/// raylib.h
/// RLAPI Vector2 GetWorldToScreenEx(Vector3 position, Camera camera, int width, int height);
fn nif_get_world_to_screen_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4 or argc == 5);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 4);

    // Arguments

    const arg_position = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_camera = core.Argument(core.Camera).get(env, argv[1]) catch {
        return error.invalid_argument_camera;
    };
    defer arg_camera.free();
    const camera = arg_camera.data;

    const width = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_height;
    };

    // Function

    const world_to_screen_ex = rl.GetWorldToScreenEx(position, camera, width, height);
    defer if (!return_resource) core.Vector2.free(world_to_screen_ex);
    errdefer if (return_resource) core.Vector2.free(world_to_screen_ex);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector2, env, world_to_screen_ex, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get the screen space position for a 2d camera world space position
///
/// raylib.h
/// RLAPI Vector2 GetWorldToScreen2D(Vector2 position, Camera2D camera);
fn nif_get_world_to_screen_2d(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_position = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_camera = core.Argument(core.Camera2D).get(env, argv[1]) catch {
        return error.invalid_argument_camera;
    };
    defer arg_camera.free();
    const camera = arg_camera.data;

    // Function

    const world_to_screen_2d = rl.GetWorldToScreen2D(position, camera);
    defer if (!return_resource) core.Vector2.free(world_to_screen_2d);
    errdefer if (return_resource) core.Vector2.free(world_to_screen_2d);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector2, env, world_to_screen_2d, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get the world space position for a 2d camera screen space position
///
/// raylib.h
/// RLAPI Vector2 GetScreenToWorld2D(Vector2 position, Camera2D camera);
fn nif_get_screen_to_world_2d(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_position = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_camera = core.Argument(core.Camera2D).get(env, argv[1]) catch {
        return error.invalid_argument_camera;
    };
    defer arg_camera.free();
    const camera = arg_camera.data;

    // Function

    const screen_to_world_2d = rl.GetScreenToWorld2D(position, camera);
    defer if (!return_resource) core.Vector2.free(screen_to_world_2d);
    errdefer if (return_resource) core.Vector2.free(screen_to_world_2d);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector2, env, screen_to_world_2d, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get camera transform matrix (view matrix)
///
/// raylib.h
/// RLAPI Matrix GetCameraMatrix(Camera camera);
fn nif_get_camera_matrix(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_camera = core.Argument(core.Camera).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer arg_camera.free();
    const camera = arg_camera.data;

    // Function

    const camera_matrix = rl.GetCameraMatrix(camera);
    defer if (!return_resource) core.Matrix.free(camera_matrix);
    errdefer if (return_resource) core.Matrix.free(camera_matrix);

    // Return

    return core.maybe_make_struct_as_resource(core.Matrix, env, camera_matrix, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get camera 2d transform matrix
///
/// raylib.h
/// RLAPI Matrix GetCameraMatrix2D(Camera2D camera);
fn nif_get_camera_matrix_2d(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_camera = core.Argument(core.Camera2D).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer arg_camera.free();
    const camera = arg_camera.data;

    // Function

    const camera_matrix_2d = rl.GetCameraMatrix2D(camera);
    defer if (!return_resource) core.Matrix.free(camera_matrix_2d);
    errdefer if (return_resource) core.Matrix.free(camera_matrix_2d);

    // Return

    return core.maybe_make_struct_as_resource(core.Matrix, env, camera_matrix_2d, return_resource) catch {
        return error.invalid_return;
    };
}
