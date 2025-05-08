const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Basic 3D shapes drawing
    .{ .name = "draw_line_3d", .arity = 3, .fptr = core.nif_wrapper(nif_draw_line_3d), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_point_3d", .arity = 2, .fptr = core.nif_wrapper(nif_draw_point_3d), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_circle_3d", .arity = 5, .fptr = core.nif_wrapper(nif_draw_circle_3d), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_triangle_3d", .arity = 4, .fptr = core.nif_wrapper(nif_draw_triangle_3d), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_triangle_strip_3d", .arity = 2, .fptr = core.nif_wrapper(nif_draw_triangle_strip_3d), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_cube", .arity = 5, .fptr = core.nif_wrapper(nif_draw_cube), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_cube_v", .arity = 3, .fptr = core.nif_wrapper(nif_draw_cube_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_cube_wires", .arity = 5, .fptr = core.nif_wrapper(nif_draw_cube_wires), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_cube_wires_v", .arity = 3, .fptr = core.nif_wrapper(nif_draw_cube_wires_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_sphere", .arity = 3, .fptr = core.nif_wrapper(nif_draw_sphere), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_sphere_ex", .arity = 5, .fptr = core.nif_wrapper(nif_draw_sphere_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_sphere_wires", .arity = 5, .fptr = core.nif_wrapper(nif_draw_sphere_wires), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_cylinder", .arity = 6, .fptr = core.nif_wrapper(nif_draw_cylinder), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_cylinder_ex", .arity = 6, .fptr = core.nif_wrapper(nif_draw_cylinder_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_cylinder_wires", .arity = 6, .fptr = core.nif_wrapper(nif_draw_cylinder_wires), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_cylinder_wires_ex", .arity = 6, .fptr = core.nif_wrapper(nif_draw_cylinder_wires_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_capsule", .arity = 6, .fptr = core.nif_wrapper(nif_draw_capsule), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_capsule_wires", .arity = 6, .fptr = core.nif_wrapper(nif_draw_capsule_wires), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_plane", .arity = 3, .fptr = core.nif_wrapper(nif_draw_plane), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_ray", .arity = 2, .fptr = core.nif_wrapper(nif_draw_ray), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_grid", .arity = 2, .fptr = core.nif_wrapper(nif_draw_grid), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Model management
    .{ .name = "load_model", .arity = 1, .fptr = core.nif_wrapper(nif_load_model), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_model", .arity = 2, .fptr = core.nif_wrapper(nif_load_model), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_model_from_mesh", .arity = 1, .fptr = core.nif_wrapper(nif_load_model_from_mesh), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_model_from_mesh", .arity = 2, .fptr = core.nif_wrapper(nif_load_model_from_mesh), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_model_valid", .arity = 1, .fptr = core.nif_wrapper(nif_is_model_valid), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_model_bounding_box", .arity = 1, .fptr = core.nif_wrapper(nif_get_model_bounding_box), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_model_bounding_box", .arity = 2, .fptr = core.nif_wrapper(nif_get_model_bounding_box), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Model drawing
    .{ .name = "draw_model", .arity = 4, .fptr = core.nif_wrapper(nif_draw_model), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_model_ex", .arity = 6, .fptr = core.nif_wrapper(nif_draw_model_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_model_wires", .arity = 4, .fptr = core.nif_wrapper(nif_draw_model_wires), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_model_wires_ex", .arity = 6, .fptr = core.nif_wrapper(nif_draw_model_wires_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_model_points", .arity = 4, .fptr = core.nif_wrapper(nif_draw_model_points), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_model_points_ex", .arity = 6, .fptr = core.nif_wrapper(nif_draw_model_points_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_bounding_box", .arity = 2, .fptr = core.nif_wrapper(nif_draw_bounding_box), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_billboard", .arity = 5, .fptr = core.nif_wrapper(nif_draw_billboard), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_billboard_rec", .arity = 6, .fptr = core.nif_wrapper(nif_draw_billboard_rec), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_billboard_pro", .arity = 9, .fptr = core.nif_wrapper(nif_draw_billboard_pro), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Mesh management
    .{ .name = "upload_mesh", .arity = 2, .fptr = core.nif_wrapper(nif_upload_mesh), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "upload_mesh", .arity = 3, .fptr = core.nif_wrapper(nif_upload_mesh), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "update_mesh_buffer", .arity = 4, .fptr = core.nif_wrapper(nif_update_mesh_buffer), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_mesh", .arity = 3, .fptr = core.nif_wrapper(nif_draw_mesh), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_mesh_instanced", .arity = 3, .fptr = core.nif_wrapper(nif_draw_mesh_instanced), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_mesh_bounding_box", .arity = 1, .fptr = core.nif_wrapper(nif_get_mesh_bounding_box), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_mesh_bounding_box", .arity = 2, .fptr = core.nif_wrapper(nif_get_mesh_bounding_box), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_tangents", .arity = 1, .fptr = core.nif_wrapper(nif_gen_mesh_tangents), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_tangents", .arity = 2, .fptr = core.nif_wrapper(nif_gen_mesh_tangents), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "export_mesh", .arity = 2, .fptr = core.nif_wrapper(nif_export_mesh), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Mesh generation
    .{ .name = "gen_mesh_poly", .arity = 2, .fptr = core.nif_wrapper(nif_gen_mesh_poly), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_poly", .arity = 3, .fptr = core.nif_wrapper(nif_gen_mesh_poly), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_plane", .arity = 4, .fptr = core.nif_wrapper(nif_gen_mesh_plane), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_plane", .arity = 5, .fptr = core.nif_wrapper(nif_gen_mesh_plane), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_cube", .arity = 3, .fptr = core.nif_wrapper(nif_gen_mesh_cube), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_cube", .arity = 4, .fptr = core.nif_wrapper(nif_gen_mesh_cube), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_sphere", .arity = 3, .fptr = core.nif_wrapper(nif_gen_mesh_sphere), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_sphere", .arity = 4, .fptr = core.nif_wrapper(nif_gen_mesh_sphere), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_hemi_sphere", .arity = 3, .fptr = core.nif_wrapper(nif_gen_mesh_hemi_sphere), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_hemi_sphere", .arity = 4, .fptr = core.nif_wrapper(nif_gen_mesh_hemi_sphere), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_cylinder", .arity = 3, .fptr = core.nif_wrapper(nif_gen_mesh_cylinder), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_cylinder", .arity = 4, .fptr = core.nif_wrapper(nif_gen_mesh_cylinder), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_cone", .arity = 3, .fptr = core.nif_wrapper(nif_gen_mesh_cone), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_cone", .arity = 4, .fptr = core.nif_wrapper(nif_gen_mesh_cone), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_torus", .arity = 4, .fptr = core.nif_wrapper(nif_gen_mesh_torus), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_torus", .arity = 5, .fptr = core.nif_wrapper(nif_gen_mesh_torus), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_knot", .arity = 4, .fptr = core.nif_wrapper(nif_gen_mesh_knot), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_knot", .arity = 5, .fptr = core.nif_wrapper(nif_gen_mesh_knot), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_heightmap", .arity = 2, .fptr = core.nif_wrapper(nif_gen_mesh_heightmap), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_heightmap", .arity = 3, .fptr = core.nif_wrapper(nif_gen_mesh_heightmap), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_cubicmap", .arity = 2, .fptr = core.nif_wrapper(nif_gen_mesh_cubicmap), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_mesh_cubicmap", .arity = 3, .fptr = core.nif_wrapper(nif_gen_mesh_cubicmap), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Material management
    .{ .name = "load_materials", .arity = 1, .fptr = core.nif_wrapper(nif_load_materials), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_materials", .arity = 2, .fptr = core.nif_wrapper(nif_load_materials), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_material_default", .arity = 0, .fptr = core.nif_wrapper(nif_load_material_default), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_material_default", .arity = 1, .fptr = core.nif_wrapper(nif_load_material_default), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_material_valid", .arity = 1, .fptr = core.nif_wrapper(nif_is_material_valid), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_material_texture", .arity = 3, .fptr = core.nif_wrapper(nif_set_material_texture), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_material_texture", .arity = 4, .fptr = core.nif_wrapper(nif_set_material_texture), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_model_mesh_material", .arity = 3, .fptr = core.nif_wrapper(nif_set_model_mesh_material), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_model_mesh_material", .arity = 4, .fptr = core.nif_wrapper(nif_set_model_mesh_material), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Model animation
    .{ .name = "load_model_animations", .arity = 1, .fptr = core.nif_wrapper(nif_load_model_animations), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_model_animations", .arity = 2, .fptr = core.nif_wrapper(nif_load_model_animations), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "update_model_animation", .arity = 3, .fptr = core.nif_wrapper(nif_update_model_animation), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "update_model_animation", .arity = 4, .fptr = core.nif_wrapper(nif_update_model_animation), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "update_model_animation_bones", .arity = 3, .fptr = core.nif_wrapper(nif_update_model_animation_bones), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "update_model_animation_bones", .arity = 4, .fptr = core.nif_wrapper(nif_update_model_animation_bones), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_model_animation_valid", .arity = 2, .fptr = core.nif_wrapper(nif_is_model_animation_valid), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Collision detection
    .{ .name = "check_collision_spheres", .arity = 4, .fptr = core.nif_wrapper(nif_check_collision_spheres), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "check_collision_boxes", .arity = 2, .fptr = core.nif_wrapper(nif_check_collision_boxes), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "check_collision_box_sphere", .arity = 3, .fptr = core.nif_wrapper(nif_check_collision_box_sphere), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_ray_collision_sphere", .arity = 3, .fptr = core.nif_wrapper(nif_get_ray_collision_sphere), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_ray_collision_sphere", .arity = 4, .fptr = core.nif_wrapper(nif_get_ray_collision_sphere), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_ray_collision_box", .arity = 2, .fptr = core.nif_wrapper(nif_get_ray_collision_box), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_ray_collision_box", .arity = 3, .fptr = core.nif_wrapper(nif_get_ray_collision_box), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_ray_collision_mesh", .arity = 3, .fptr = core.nif_wrapper(nif_get_ray_collision_mesh), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_ray_collision_mesh", .arity = 4, .fptr = core.nif_wrapper(nif_get_ray_collision_mesh), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_ray_collision_triangle", .arity = 4, .fptr = core.nif_wrapper(nif_get_ray_collision_triangle), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_ray_collision_triangle", .arity = 5, .fptr = core.nif_wrapper(nif_get_ray_collision_triangle), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_ray_collision_quad", .arity = 5, .fptr = core.nif_wrapper(nif_get_ray_collision_quad), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_ray_collision_quad", .arity = 6, .fptr = core.nif_wrapper(nif_get_ray_collision_quad), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

///////////////////////////////
//  Basic 3D shapes drawing  //
///////////////////////////////

/// Draw a line in 3D world space
///
/// raylib.h
/// RLAPI void DrawLine3D(Vector3 startPos, Vector3 endPos, Color color);
fn nif_draw_line_3d(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_start_pos = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_start_pos;
    };
    defer arg_start_pos.free();
    const start_pos = arg_start_pos.data;

    const arg_end_pos = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_end_pos;
    };
    defer arg_end_pos.free();
    const end_pos = arg_end_pos.data;

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawLine3D(start_pos, end_pos, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a point in 3D space, actually a small line
///
/// raylib.h
/// RLAPI void DrawPoint3D(Vector3 position, Color color);
fn nif_draw_point_3d(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_position = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_color = core.Argument(core.Color).get(env, argv[1]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawPoint3D(position, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a circle in 3D world space
///
/// raylib.h
/// RLAPI void DrawCircle3D(Vector3 center, float radius, Vector3 rotationAxis, float rotationAngle, Color color);
fn nif_draw_circle_3d(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const arg_center = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_center;
    };
    defer arg_center.free();
    const center = arg_center.data;

    const radius = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_radius;
    };

    const arg_rotation_axis = core.Argument(core.Vector3).get(env, argv[2]) catch {
        return error.invalid_argument_rotation_axis;
    };
    defer arg_rotation_axis.free();
    const rotation_axis = arg_rotation_axis.data;

    const rotation_angle = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_rotation_angle;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawCircle3D(center, @floatCast(radius), rotation_axis, @floatCast(rotation_angle), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a color-filled triangle (vertex in counter-clockwise order!)
///
/// raylib.h
/// RLAPI void DrawTriangle3D(Vector3 v1, Vector3 v2, Vector3 v3, Color color);
fn nif_draw_triangle_3d(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_v1 = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_v1;
    };
    defer arg_v1.free();
    const v1 = arg_v1.data;

    const arg_v2 = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_v2;
    };
    defer arg_v2.free();
    const v2 = arg_v2.data;

    const arg_v3 = core.Argument(core.Vector3).get(env, argv[2]) catch {
        return error.invalid_argument_v3;
    };
    defer arg_v3.free();
    const v3 = arg_v3.data;

    const arg_color = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawTriangle3D(v1, v2, v3, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a triangle strip defined by points
///
/// raylib.h
/// RLAPI void DrawTriangleStrip3D(const Vector3 *points, int pointCount, Color color);
fn nif_draw_triangle_strip_3d(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    var arg_points = core.ArgumentArray(core.Vector3, core.Vector3.data_type, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_points.free();
    const points = arg_points.data;
    const point_count = arg_points.length;

    const arg_color = core.Argument(core.Color).get(env, argv[1]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawTriangleStrip3D(@ptrCast(points), @intCast(point_count), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw cube
///
/// raylib.h
/// RLAPI void DrawCube(Vector3 position, float width, float height, float length, Color color);
fn nif_draw_cube(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const arg_position = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const width = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_height;
    };

    const length = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_length;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawCube(position, @floatCast(width), @floatCast(height), @floatCast(length), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw cube (Vector version)
///
/// raylib.h
/// RLAPI void DrawCubeV(Vector3 position, Vector3 size, Color color);
fn nif_draw_cube_v(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_position = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_size = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_size;
    };
    defer arg_size.free();
    const size = arg_size.data;

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawCubeV(position, size, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw cube wires
///
/// raylib.h
/// RLAPI void DrawCubeWires(Vector3 position, float width, float height, float length, Color color);
fn nif_draw_cube_wires(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const arg_position = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const width = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_height;
    };

    const length = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_length;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawCubeWires(position, @floatCast(width), @floatCast(height), @floatCast(length), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw cube wires (Vector version)
///
/// raylib.h
/// RLAPI void DrawCubeWiresV(Vector3 position, Vector3 size, Color color);
fn nif_draw_cube_wires_v(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_position = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_size = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_size;
    };
    defer arg_size.free();
    const size = arg_size.data;

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawCubeWiresV(position, size, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw sphere
///
/// raylib.h
/// RLAPI void DrawSphere(Vector3 centerPos, float radius, Color color);
fn nif_draw_sphere(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_center_pos = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_center_pos;
    };
    defer arg_center_pos.free();
    const center_pos = arg_center_pos.data;

    const radius = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_radius;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawSphere(center_pos, @floatCast(radius), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw sphere with extended parameters
///
/// raylib.h
/// RLAPI void DrawSphereEx(Vector3 centerPos, float radius, int rings, int slices, Color color);
fn nif_draw_sphere_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const arg_center_pos = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_center_pos;
    };
    defer arg_center_pos.free();
    const center_pos = arg_center_pos.data;

    const radius = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_radius;
    };

    const rings = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_rings;
    };

    const slices = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_slices;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawSphereEx(center_pos, @floatCast(radius), rings, slices, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw sphere wires
///
/// raylib.h
/// RLAPI void DrawSphereWires(Vector3 centerPos, float radius, int rings, int slices, Color color);
fn nif_draw_sphere_wires(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const arg_center_pos = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_center_pos;
    };
    defer arg_center_pos.free();
    const center_pos = arg_center_pos.data;

    const radius = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_radius;
    };

    const rings = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_rings;
    };

    const slices = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_slices;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawSphereWires(center_pos, @floatCast(radius), rings, slices, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a cylinder/cone
///
/// raylib.h
/// RLAPI void DrawCylinder(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color);
fn nif_draw_cylinder(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_position = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const radius_top = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_radius_top;
    };

    const radius_bottom = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_radius_bottom;
    };

    const height = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_height;
    };

    const slices = core.Int.get(env, argv[4]) catch {
        return error.invalid_argument_slices;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawCylinder(position, @floatCast(radius_top), @floatCast(radius_bottom), @floatCast(height), slices, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a cylinder with base at startPos and top at endPos
///
/// raylib.h
/// RLAPI void DrawCylinderEx(Vector3 startPos, Vector3 endPos, float startRadius, float endRadius, int sides, Color color);
fn nif_draw_cylinder_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_start_pos = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_start_pos;
    };
    defer arg_start_pos.free();
    const start_pos = arg_start_pos.data;

    const arg_end_pos = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_end_pos;
    };
    defer arg_end_pos.free();
    const end_pos = arg_end_pos.data;

    const start_radius = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_start_radius;
    };

    const end_radius = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_end_radius;
    };

    const sides = core.Int.get(env, argv[4]) catch {
        return error.invalid_argument_sides;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawCylinderEx(start_pos, end_pos, @floatCast(start_radius), @floatCast(end_radius), sides, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a cylinder/cone wires
///
/// raylib.h
/// RLAPI void DrawCylinderWires(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color);
fn nif_draw_cylinder_wires(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_position = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const radius_top = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_radius_top;
    };

    const radius_bottom = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_radius_bottom;
    };

    const height = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_height;
    };

    const slices = core.Int.get(env, argv[4]) catch {
        return error.invalid_argument_slices;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawCylinderWires(position, @floatCast(radius_top), @floatCast(radius_bottom), @floatCast(height), slices, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a cylinder wires with base at startPos and top at endPos
///
/// raylib.h
/// RLAPI void DrawCylinderWiresEx(Vector3 startPos, Vector3 endPos, float startRadius, float endRadius, int sides, Color color);
fn nif_draw_cylinder_wires_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_start_pos = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_start_pos;
    };
    defer arg_start_pos.free();
    const start_pos = arg_start_pos.data;

    const arg_end_pos = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_end_pos;
    };
    defer arg_end_pos.free();
    const end_pos = arg_end_pos.data;

    const start_radius = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_start_radius;
    };

    const end_radius = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_end_radius;
    };

    const sides = core.Int.get(env, argv[4]) catch {
        return error.invalid_argument_sides;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawCylinderWiresEx(start_pos, end_pos, @floatCast(start_radius), @floatCast(end_radius), sides, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a capsule with the center of its sphere caps at startPos and endPos
///
/// raylib.h
/// RLAPI void DrawCapsule(Vector3 startPos, Vector3 endPos, float radius, int slices, int rings, Color color);
fn nif_draw_capsule(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_start_pos = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_start_pos;
    };
    defer arg_start_pos.free();
    const start_pos = arg_start_pos.data;

    const arg_end_pos = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_end_pos;
    };
    defer arg_end_pos.free();
    const end_pos = arg_end_pos.data;

    const radius = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_radius;
    };

    const slices = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_slices;
    };

    const rings = core.Int.get(env, argv[4]) catch {
        return error.invalid_argument_rings;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawCapsule(start_pos, end_pos, @floatCast(radius), slices, rings, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw capsule wireframe with the center of its sphere caps at startPos and endPos
///
/// raylib.h
/// RLAPI void DrawCapsuleWires(Vector3 startPos, Vector3 endPos, float radius, int slices, int rings, Color color);
fn nif_draw_capsule_wires(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_start_pos = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_start_pos;
    };
    defer arg_start_pos.free();
    const start_pos = arg_start_pos.data;

    const arg_end_pos = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_end_pos;
    };
    defer arg_end_pos.free();
    const end_pos = arg_end_pos.data;

    const radius = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_radius;
    };

    const slices = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_slices;
    };

    const rings = core.Int.get(env, argv[4]) catch {
        return error.invalid_argument_rings;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawCapsuleWires(start_pos, end_pos, @floatCast(radius), slices, rings, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a plane XZ
///
/// raylib.h
/// RLAPI void DrawPlane(Vector3 centerPos, Vector2 size, Color color);
fn nif_draw_plane(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_center_pos = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_center_pos;
    };
    defer arg_center_pos.free();
    const center_pos = arg_center_pos.data;

    const arg_size = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_size;
    };
    defer arg_size.free();
    const size = arg_size.data;

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawPlane(center_pos, size, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a ray line
///
/// raylib.h
/// RLAPI void DrawRay(Ray ray, Color color);
fn nif_draw_ray(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_ray = core.Argument(core.Ray).get(env, argv[0]) catch {
        return error.invalid_argument_ray;
    };
    defer arg_ray.free();
    const ray = arg_ray.data;

    const arg_color = core.Argument(core.Color).get(env, argv[1]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawRay(ray, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a grid (centered at (0, 0, 0))
///
/// raylib.h
/// RLAPI void DrawGrid(int slices, float spacing);
fn nif_draw_grid(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const slices = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_slices;
    };

    const spacing = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_spacing;
    };

    // Function

    rl.DrawGrid(slices, @floatCast(spacing));

    // Return

    return core.Atom.make(env, "ok");
}

////////////////////////
//  Model management  //
////////////////////////

/// Load model from files (meshes and materials)
///
/// raylib.h
/// RLAPI Model LoadModel(const char *fileName);
fn nif_load_model(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_file_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_file_name;
    };
    defer arg_file_name.free();
    const file_name = arg_file_name.data;

    // Function

    const model = rl.LoadModel(file_name);
    defer if (!return_resource) core.Model.free(model);
    errdefer if (return_resource) core.Model.free(model);

    // Return

    return core.maybe_make_struct_as_resource(core.Model, env, model, return_resource) catch {
        return error.invalid_return;
    };
}

/// Load model from generated mesh (default material)
///
/// raylib.h
/// RLAPI Model LoadModelFromMesh(Mesh mesh);
fn nif_load_model_from_mesh(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_mesh = core.Argument(core.Mesh).get(env, argv[0]) catch {
        return error.invalid_argument_mesh;
    };
    defer arg_mesh.free();
    const mesh = arg_mesh.data;

    // Function

    const model = rl.LoadModelFromMesh(mesh);
    defer if (!return_resource) core.Model.free(model);
    errdefer if (return_resource) core.Model.free(model);

    // Return

    return core.maybe_make_struct_as_resource(core.Model, env, model, return_resource) catch {
        return error.invalid_return;
    };
}

/// Check if a model is valid (loaded in GPU, VAO/VBOs)
///
/// raylib.h
/// RLAPI bool IsModelValid(Model model);
fn nif_is_model_valid(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_model = core.Argument(core.Model).get(env, argv[0]) catch {
        return error.invalid_argument_model;
    };
    defer arg_model.free();
    const model = arg_model.data;

    // Function

    const is_model_valid = rl.IsModelValid(model);

    // Return

    return core.Boolean.make(env, is_model_valid);
}

/// Compute model bounding box limits (considers all meshes)
///
/// raylib.h
/// RLAPI BoundingBox GetModelBoundingBox(Model model);
fn nif_get_model_bounding_box(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_model = core.Argument(core.Model).get(env, argv[0]) catch {
        return error.invalid_argument_model;
    };
    defer arg_model.free();
    const model = arg_model.data;

    // Function

    const bounding_box = rl.GetModelBoundingBox(model);
    defer if (!return_resource) core.BoundingBox.free(bounding_box);
    errdefer if (return_resource) core.BoundingBox.free(bounding_box);

    // Return

    return core.maybe_make_struct_as_resource(core.BoundingBox, env, bounding_box, return_resource) catch {
        return error.invalid_return;
    };
}

/////////////////////
//  Model drawing  //
/////////////////////

/// Draw a model (with texture if set)
///
/// raylib.h
/// RLAPI void DrawModel(Model model, Vector3 position, float scale, Color tint);
fn nif_draw_model(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_model = core.Argument(core.Model).get(env, argv[0]) catch {
        return error.invalid_argument_model;
    };
    defer arg_model.free();
    const model = arg_model.data;

    const arg_position = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const scale = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_scale;
    };

    const arg_tint = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.DrawModel(model, position, @floatCast(scale), tint);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a model with extended parameters
///
/// raylib.h
/// RLAPI void DrawModelEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint);
fn nif_draw_model_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_model = core.Argument(core.Model).get(env, argv[0]) catch {
        return error.invalid_argument_model;
    };
    defer arg_model.free();
    const model = arg_model.data;

    const arg_position = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_rotation_axis = core.Argument(core.Vector3).get(env, argv[2]) catch {
        return error.invalid_argument_rotation_axis;
    };
    defer arg_rotation_axis.free();
    const rotation_axis = arg_rotation_axis.data;

    const rotation_angle = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_rotation_angle;
    };

    const arg_scale = core.Argument(core.Vector3).get(env, argv[4]) catch {
        return error.invalid_argument_scale;
    };
    defer arg_scale.free();
    const scale = arg_scale.data;

    const arg_tint = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.DrawModelEx(model, position, rotation_axis, @floatCast(rotation_angle), scale, tint);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a model wires (with texture if set)
///
/// raylib.h
/// RLAPI void DrawModelWires(Model model, Vector3 position, float scale, Color tint);
fn nif_draw_model_wires(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_model = core.Argument(core.Model).get(env, argv[0]) catch {
        return error.invalid_argument_model;
    };
    defer arg_model.free();
    const model = arg_model.data;

    const arg_position = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const scale = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_scale;
    };

    const arg_tint = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.DrawModelWires(model, position, @floatCast(scale), tint);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a model wires (with texture if set) with extended parameters
///
/// raylib.h
/// RLAPI void DrawModelWiresEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint);
fn nif_draw_model_wires_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_model = core.Argument(core.Model).get(env, argv[0]) catch {
        return error.invalid_argument_model;
    };
    defer arg_model.free();
    const model = arg_model.data;

    const arg_position = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_rotation_axis = core.Argument(core.Vector3).get(env, argv[2]) catch {
        return error.invalid_argument_rotation_axis;
    };
    defer arg_rotation_axis.free();
    const rotation_axis = arg_rotation_axis.data;

    const rotation_angle = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_rotation_angle;
    };

    const arg_scale = core.Argument(core.Vector3).get(env, argv[4]) catch {
        return error.invalid_argument_scale;
    };
    defer arg_scale.free();
    const scale = arg_scale.data;

    const arg_tint = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.DrawModelWiresEx(model, position, rotation_axis, @floatCast(rotation_angle), scale, tint);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a model as points
///
/// raylib.h
/// RLAPI void DrawModelPoints(Model model, Vector3 position, float scale, Color tint);
fn nif_draw_model_points(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_model = core.Argument(core.Model).get(env, argv[0]) catch {
        return error.invalid_argument_model;
    };
    defer arg_model.free();
    const model = arg_model.data;

    const arg_position = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const scale = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_scale;
    };

    const arg_tint = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.DrawModelPoints(model, position, @floatCast(scale), tint);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a model as points with extended parameters
///
/// raylib.h
/// RLAPI void DrawModelPointsEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint);
fn nif_draw_model_points_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_model = core.Argument(core.Model).get(env, argv[0]) catch {
        return error.invalid_argument_model;
    };
    defer arg_model.free();
    const model = arg_model.data;

    const arg_position = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_rotation_axis = core.Argument(core.Vector3).get(env, argv[2]) catch {
        return error.invalid_argument_rotation_axis;
    };
    defer arg_rotation_axis.free();
    const rotation_axis = arg_rotation_axis.data;

    const rotation_angle = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_rotation_angle;
    };

    const arg_scale = core.Argument(core.Vector3).get(env, argv[4]) catch {
        return error.invalid_argument_scale;
    };
    defer arg_scale.free();
    const scale = arg_scale.data;

    const arg_tint = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.DrawModelPointsEx(model, position, rotation_axis, @floatCast(rotation_angle), scale, tint);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw bounding box (wires)
///
/// raylib.h
/// RLAPI void DrawBoundingBox(BoundingBox box, Color color);
fn nif_draw_bounding_box(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_box = core.Argument(core.BoundingBox).get(env, argv[0]) catch {
        return error.invalid_argument_box;
    };
    defer arg_box.free();
    const box = arg_box.data;

    const arg_color = core.Argument(core.Color).get(env, argv[1]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawBoundingBox(box, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a billboard texture
///
/// raylib.h
/// RLAPI void DrawBillboard(Camera camera, Texture2D texture, Vector3 position, float scale, Color tint);
fn nif_draw_billboard(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const arg_camera = core.Argument(core.Camera).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer arg_camera.free();
    const camera = arg_camera.data;

    const arg_texture = core.Argument(core.Texture2D).get(env, argv[1]) catch {
        return error.invalid_argument_texture;
    };
    defer arg_texture.free();
    const texture = arg_texture.data;

    const arg_position = core.Argument(core.Vector3).get(env, argv[2]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const scale = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_scale;
    };

    const arg_tint = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.DrawBillboard(camera, texture, position, @floatCast(scale), tint);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a billboard texture defined by source
///
/// raylib.h
/// RLAPI void DrawBillboardRec(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector2 size, Color tint);
fn nif_draw_billboard_rec(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_camera = core.Argument(core.Camera).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer arg_camera.free();
    const camera = arg_camera.data;

    const arg_texture = core.Argument(core.Texture2D).get(env, argv[1]) catch {
        return error.invalid_argument_texture;
    };
    defer arg_texture.free();
    const texture = arg_texture.data;

    const arg_source = core.Argument(core.Rectangle).get(env, argv[2]) catch {
        return error.invalid_argument_source;
    };
    defer arg_source.free();
    const source = arg_source.data;

    const arg_position = core.Argument(core.Vector3).get(env, argv[3]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_size = core.Argument(core.Vector2).get(env, argv[4]) catch {
        return error.invalid_argument_size;
    };
    defer arg_size.free();
    const size = arg_size.data;

    const arg_tint = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.DrawBillboardRec(camera, texture, source, position, size, tint);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a billboard texture defined by source and rotation
///
/// raylib.h
/// RLAPI void DrawBillboardPro(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector3 up, Vector2 size, Vector2 origin, float rotation, Color tint);
fn nif_draw_billboard_pro(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 9);

    // Arguments

    const arg_camera = core.Argument(core.Camera).get(env, argv[0]) catch {
        return error.invalid_argument_camera;
    };
    defer arg_camera.free();
    const camera = arg_camera.data;

    const arg_texture = core.Argument(core.Texture2D).get(env, argv[1]) catch {
        return error.invalid_argument_texture;
    };
    defer arg_texture.free();
    const texture = arg_texture.data;

    const arg_source = core.Argument(core.Rectangle).get(env, argv[2]) catch {
        return error.invalid_argument_source;
    };
    defer arg_source.free();
    const source = arg_source.data;

    const arg_position = core.Argument(core.Vector3).get(env, argv[3]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_up = core.Argument(core.Vector3).get(env, argv[4]) catch {
        return error.invalid_argument_up;
    };
    defer arg_up.free();
    const up = arg_up.data;

    const arg_size = core.Argument(core.Vector2).get(env, argv[5]) catch {
        return error.invalid_argument_size;
    };
    defer arg_size.free();
    const size = arg_size.data;

    const arg_origin = core.Argument(core.Vector2).get(env, argv[6]) catch {
        return error.invalid_argument_origin;
    };
    defer arg_origin.free();
    const origin = arg_origin.data;

    const rotation = core.Double.get(env, argv[7]) catch {
        return error.invalid_argument_rotation;
    };

    const arg_tint = core.Argument(core.Color).get(env, argv[8]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.DrawBillboardPro(camera, texture, source, position, up, size, origin, @floatCast(rotation), tint);

    // Return

    return core.Atom.make(env, "ok");
}

///////////////////////
//  Mesh management  //
///////////////////////

/// Upload mesh vertex data in GPU and provide VAO/VBO ids
///
/// raylib.h
/// RLAPI void UploadMesh(Mesh *mesh, bool dynamic);
fn nif_upload_mesh(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    var arg_mesh = core.Argument(core.Mesh).get(env, argv[0]) catch {
        return error.invalid_argument_mesh;
    };
    defer if (!return_resource) arg_mesh.free();
    errdefer if (return_resource) arg_mesh.free();
    const mesh = &arg_mesh.data;

    const dynamic = core.Boolean.get(env, argv[1]) catch {
        return error.invalid_argument_dynamic;
    };

    // Function

    rl.UploadMesh(@ptrCast(mesh), dynamic);

    // Return

    return core.maybe_make_struct_or_resource(core.Mesh, env, argv[0], mesh.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Update mesh vertex data in GPU for a specific buffer index
///
/// raylib.h
/// RLAPI void UpdateMeshBuffer(Mesh mesh, int index, const void *data, int dataSize, int offset);
fn nif_update_mesh_buffer(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_mesh = core.Argument(core.Mesh).get(env, argv[0]) catch {
        return error.invalid_argument_mesh;
    };
    defer arg_mesh.free();
    const mesh = arg_mesh.data;

    const index = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_index;
    };

    const offset = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_offset;
    };

    // Function

    const is_data_nil = e.enif_is_identical(core.Atom.make(env, "nil"), argv[2]) != 0;

    switch (index) {
        rl.RL_DEFAULT_SHADER_ATTRIB_LOCATION_POSITION => {
            if (is_data_nil) {
                const data = if (mesh.animVertices != null) mesh.animVertices else mesh.vertices;
                const data_size = mesh.vertexCount * 3;
                rl.UpdateMeshBuffer(mesh, index, @ptrCast(data), @intCast(data_size * @sizeOf(f32)), offset * @sizeOf(f32));
            } else {
                var arg_data = core.ArgumentArray(core.Double, f32, rl.allocator).get(env, argv[2]) catch {
                    return error.invalid_argument_data;
                };
                defer arg_data.free();
                const data = arg_data.data;
                const data_size = arg_data.length;
                rl.UpdateMeshBuffer(mesh, index, @ptrCast(data), @intCast(data_size * @sizeOf(f32)), offset * @sizeOf(f32));
            }
        },
        rl.RL_DEFAULT_SHADER_ATTRIB_LOCATION_TEXCOORD => {
            if (is_data_nil) {
                const data = mesh.texcoords;
                const data_size = mesh.vertexCount * 2;
                rl.UpdateMeshBuffer(mesh, index, @ptrCast(data), @intCast(data_size * @sizeOf(f32)), offset * @sizeOf(f32));
            } else {
                var arg_data = core.ArgumentArray(core.Double, f32, rl.allocator).get(env, argv[2]) catch {
                    return error.invalid_argument_data;
                };
                defer arg_data.free();
                const data = arg_data.data;
                const data_size = arg_data.length;
                rl.UpdateMeshBuffer(mesh, index, @ptrCast(data), @intCast(data_size * @sizeOf(f32)), offset * @sizeOf(f32));
            }
        },
        rl.RL_DEFAULT_SHADER_ATTRIB_LOCATION_NORMAL => {
            if (is_data_nil) {
                const data = if (mesh.animNormals != null) mesh.animNormals else mesh.normals;
                const data_size = mesh.vertexCount * 3;
                rl.UpdateMeshBuffer(mesh, index, @ptrCast(data), @intCast(data_size * @sizeOf(f32)), offset * @sizeOf(f32));
            } else {
                var arg_data = core.ArgumentArray(core.Double, f32, rl.allocator).get(env, argv[2]) catch {
                    return error.invalid_argument_data;
                };
                defer arg_data.free();
                const data = arg_data.data;
                const data_size = arg_data.length;
                rl.UpdateMeshBuffer(mesh, index, @ptrCast(data), @intCast(data_size * @sizeOf(f32)), offset * @sizeOf(f32));
            }
        },
        rl.RL_DEFAULT_SHADER_ATTRIB_LOCATION_COLOR => {
            if (is_data_nil) {
                const data = mesh.colors;
                const data_size = mesh.vertexCount * 4;
                rl.UpdateMeshBuffer(mesh, index, @ptrCast(data), @intCast(data_size * @sizeOf(u8)), offset * @sizeOf(u8));
            } else {
                var arg_data = core.ArgumentArray(core.UInt, u8, rl.allocator).get(env, argv[2]) catch {
                    return error.invalid_argument_data;
                };
                defer arg_data.free();
                const data = arg_data.data;
                const data_size = arg_data.length;
                rl.UpdateMeshBuffer(mesh, index, @ptrCast(data), @intCast(data_size * @sizeOf(u8)), offset * @sizeOf(u8));
            }
        },
        rl.RL_DEFAULT_SHADER_ATTRIB_LOCATION_TANGENT => {
            if (is_data_nil) {
                const data = mesh.tangents;
                const data_size = mesh.vertexCount * 4;
                rl.UpdateMeshBuffer(mesh, index, @ptrCast(data), @intCast(data_size * @sizeOf(f32)), offset * @sizeOf(f32));
            } else {
                var arg_data = core.ArgumentArray(core.Double, f32, rl.allocator).get(env, argv[2]) catch {
                    return error.invalid_argument_data;
                };
                defer arg_data.free();
                const data = arg_data.data;
                const data_size = arg_data.length;
                rl.UpdateMeshBuffer(mesh, index, @ptrCast(data), @intCast(data_size * @sizeOf(f32)), offset * @sizeOf(f32));
            }
        },
        rl.RL_DEFAULT_SHADER_ATTRIB_LOCATION_TEXCOORD2 => {
            if (is_data_nil) {
                const data = mesh.texcoords2;
                const data_size = mesh.vertexCount * 2;
                rl.UpdateMeshBuffer(mesh, index, @ptrCast(data), @intCast(data_size * @sizeOf(f32)), offset * @sizeOf(f32));
            } else {
                var arg_data = core.ArgumentArray(core.Double, f32, rl.allocator).get(env, argv[2]) catch {
                    return error.invalid_argument_data;
                };
                defer arg_data.free();
                const data = arg_data.data;
                const data_size = arg_data.length;
                rl.UpdateMeshBuffer(mesh, index, @ptrCast(data), @intCast(data_size * @sizeOf(f32)), offset * @sizeOf(f32));
            }
        },
        rl.RL_DEFAULT_SHADER_ATTRIB_LOCATION_INDICES => {
            if (is_data_nil) {
                const data = mesh.indices;
                const data_size = mesh.triangleCount * 3;
                rl.UpdateMeshBuffer(mesh, index, @ptrCast(data), @intCast(data_size * @sizeOf(c_ushort)), offset * @sizeOf(c_ushort));
            } else {
                var arg_data = core.ArgumentArray(core.UInt, c_ushort, rl.allocator).get(env, argv[2]) catch {
                    return error.invalid_argument_data;
                };
                defer arg_data.free();
                const data = arg_data.data;
                const data_size = arg_data.length;
                rl.UpdateMeshBuffer(mesh, index, @ptrCast(data), @intCast(data_size * @sizeOf(c_ushort)), offset * @sizeOf(c_ushort));
            }
        },
        rl.RL_DEFAULT_SHADER_ATTRIB_LOCATION_BONEIDS => {
            if (is_data_nil) {
                const data = mesh.boneIds;
                const data_size = mesh.vertexCount * 4;
                rl.UpdateMeshBuffer(mesh, index, @ptrCast(data), @intCast(data_size * @sizeOf(u8)), offset * @sizeOf(u8));
            } else {
                var arg_data = core.ArgumentArray(core.UInt, u8, rl.allocator).get(env, argv[2]) catch {
                    return error.invalid_argument_data;
                };
                defer arg_data.free();
                const data = arg_data.data;
                const data_size = arg_data.length;
                rl.UpdateMeshBuffer(mesh, index, @ptrCast(data), @intCast(data_size * @sizeOf(u8)), offset * @sizeOf(u8));
            }
        },
        rl.RL_DEFAULT_SHADER_ATTRIB_LOCATION_BONEWEIGHTS => {
            if (is_data_nil) {
                const data = mesh.boneWeights;
                const data_size = mesh.vertexCount * 4;
                rl.UpdateMeshBuffer(mesh, index, @ptrCast(data), @intCast(data_size * @sizeOf(f32)), offset * @sizeOf(f32));
            } else {
                var arg_data = core.ArgumentArray(core.Double, f32, rl.allocator).get(env, argv[2]) catch {
                    return error.invalid_argument_data;
                };
                defer arg_data.free();
                const data = arg_data.data;
                const data_size = arg_data.length;
                rl.UpdateMeshBuffer(mesh, index, @ptrCast(data), @intCast(data_size * @sizeOf(f32)), offset * @sizeOf(f32));
            }
        },
        rl.RL_DEFAULT_SHADER_ATTRIB_LOCATION_INSTANCE_TX => {
            var arg_data = core.ArgumentArray(core.Matrix, core.Matrix.data_type, rl.allocator).get(env, argv[2]) catch {
                return error.invalid_argument_data;
            };
            defer arg_data.free();
            const data = arg_data.data;
            const data_size = arg_data.length;
            rl.UpdateMeshBuffer(mesh, index, @ptrCast(data), @intCast(data_size * @sizeOf(core.Matrix.data_type)), offset * @sizeOf(core.Matrix.data_type));
        },
        else => {
            return error.invalid_argument_index;
        },
    }

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a 3d mesh with material and transform
///
/// raylib.h
/// RLAPI void DrawMesh(Mesh mesh, Material material, Matrix transform);
fn nif_draw_mesh(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_mesh = core.Argument(core.Mesh).get(env, argv[0]) catch {
        return error.invalid_argument_mesh;
    };
    defer arg_mesh.free();
    const mesh = arg_mesh.data;

    const arg_material = core.Argument(core.Material).get(env, argv[1]) catch {
        return error.invalid_argument_material;
    };
    defer arg_material.free();
    const material = arg_material.data;

    const arg_transform = core.Argument(core.Matrix).get(env, argv[2]) catch {
        return error.invalid_argument_transform;
    };
    defer arg_transform.free();
    const transform = arg_transform.data;

    // Function

    rl.DrawMesh(mesh, material, transform);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw multiple mesh instances with material and different transforms
///
/// raylib.h
/// RLAPI void DrawMeshInstanced(Mesh mesh, Material material, const Matrix *transforms, int instances);
fn nif_draw_mesh_instanced(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_mesh = core.Argument(core.Mesh).get(env, argv[0]) catch {
        return error.invalid_argument_mesh;
    };
    defer arg_mesh.free();
    const mesh = arg_mesh.data;

    const arg_material = core.Argument(core.Material).get(env, argv[1]) catch {
        return error.invalid_argument_material;
    };
    defer arg_material.free();
    const material = arg_material.data;

    var arg_transforms = core.ArgumentArray(core.Matrix, core.Matrix.data_type, rl.allocator).get(env, argv[2]) catch {
        return error.invalid_argument_image;
    };
    defer arg_transforms.free();
    const transforms = arg_transforms.data;
    const transform_count = arg_transforms.length;

    // Function

    rl.DrawMeshInstanced(mesh, material, @ptrCast(transforms), @intCast(transform_count));

    // Return

    return core.Atom.make(env, "ok");
}

/// Compute mesh bounding box limits
///
/// raylib.h
/// RLAPI BoundingBox GetMeshBoundingBox(Mesh mesh);
fn nif_get_mesh_bounding_box(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_mesh = core.Argument(core.Mesh).get(env, argv[0]) catch {
        return error.invalid_argument_mesh;
    };
    defer arg_mesh.free();
    const mesh = arg_mesh.data;

    // Function

    const bounding_box = rl.GetMeshBoundingBox(mesh);
    defer if (!return_resource) core.BoundingBox.free(bounding_box);
    errdefer if (return_resource) core.BoundingBox.free(bounding_box);

    // Return

    return core.maybe_make_struct_as_resource(core.BoundingBox, env, bounding_box, return_resource) catch {
        return error.invalid_return;
    };
}

/// Compute mesh tangents
///
/// raylib.h
/// RLAPI void GenMeshTangents(Mesh *mesh);
fn nif_gen_mesh_tangents(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    var arg_mesh = core.Argument(core.Mesh).get(env, argv[0]) catch {
        return error.invalid_argument_mesh;
    };
    defer if (!return_resource) arg_mesh.free();
    errdefer if (return_resource) arg_mesh.free();
    const mesh = &arg_mesh.data;

    // Function

    rl.GenMeshTangents(@ptrCast(mesh));

    // Return

    return core.maybe_make_struct_or_resource(core.Mesh, env, argv[0], mesh.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Export mesh data to file, returns true on success
///
/// raylib.h
/// RLAPI bool ExportMesh(Mesh mesh, const char *fileName);
fn nif_export_mesh(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_mesh = core.Argument(core.Mesh).get(env, argv[0]) catch {
        return error.invalid_argument_mesh;
    };
    defer arg_mesh.free();
    const mesh = arg_mesh.data;

    const arg_file_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_file_name;
    };
    defer arg_file_name.free();
    const file_name = arg_file_name.data;

    // Function

    const ok = rl.ExportMesh(mesh, file_name);

    // Return

    return core.Boolean.make(env, ok);
}

///////////////////////
//  Mesh generation  //
///////////////////////

/// Generate polygonal mesh
///
/// raylib.h
/// RLAPI Mesh GenMeshPoly(int sides, float radius);
fn nif_gen_mesh_poly(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const sides = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_sides;
    };

    const radius = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_radius;
    };

    // Function

    const mesh = rl.GenMeshPoly(sides, @floatCast(radius));
    defer if (!return_resource) core.Mesh.free(mesh);
    errdefer if (return_resource) core.Mesh.free(mesh);

    // Return

    return core.maybe_make_struct_as_resource(core.Mesh, env, mesh, return_resource) catch {
        return error.invalid_return;
    };
}

/// Generate plane mesh (with subdivisions)
///
/// raylib.h
/// RLAPI Mesh GenMeshPlane(float width, float length, int resX, int resZ);
fn nif_gen_mesh_plane(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4 or argc == 5);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 4);

    // Arguments

    const width = core.Double.get(env, argv[0]) catch {
        return error.invalid_argument_width;
    };

    const length = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_length;
    };

    const res_x = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_res_x;
    };

    const res_z = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_res_z;
    };

    // Function

    const mesh = rl.GenMeshPlane(@floatCast(width), @floatCast(length), res_x, res_z);
    defer if (!return_resource) core.Mesh.free(mesh);
    errdefer if (return_resource) core.Mesh.free(mesh);

    // Return

    return core.maybe_make_struct_as_resource(core.Mesh, env, mesh, return_resource) catch {
        return error.invalid_return;
    };
}

/// Generate cuboid mesh
///
/// raylib.h
/// RLAPI Mesh GenMeshCube(float width, float height, float length);
fn nif_gen_mesh_cube(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const width = core.Double.get(env, argv[0]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_height;
    };

    const length = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_length;
    };

    // Function

    const mesh = rl.GenMeshCube(@floatCast(width), @floatCast(height), @floatCast(length));
    defer if (!return_resource) core.Mesh.free(mesh);
    errdefer if (return_resource) core.Mesh.free(mesh);

    // Return

    return core.maybe_make_struct_as_resource(core.Mesh, env, mesh, return_resource) catch {
        return error.invalid_return;
    };
}

/// Generate sphere mesh (standard sphere)
///
/// raylib.h
/// RLAPI Mesh GenMeshSphere(float radius, int rings, int slices);
fn nif_gen_mesh_sphere(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const radius = core.Double.get(env, argv[0]) catch {
        return error.invalid_argument_radius;
    };

    const rings = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_rings;
    };

    const slices = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_slices;
    };

    // Function

    const mesh = rl.GenMeshSphere(@floatCast(radius), rings, slices);
    defer if (!return_resource) core.Mesh.free(mesh);
    errdefer if (return_resource) core.Mesh.free(mesh);

    // Return

    return core.maybe_make_struct_as_resource(core.Mesh, env, mesh, return_resource) catch {
        return error.invalid_return;
    };
}

/// Generate half-sphere mesh (no bottom cap)
///
/// raylib.h
/// RLAPI Mesh GenMeshHemiSphere(float radius, int rings, int slices);
fn nif_gen_mesh_hemi_sphere(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const radius = core.Double.get(env, argv[0]) catch {
        return error.invalid_argument_radius;
    };

    const rings = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_rings;
    };

    const slices = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_slices;
    };

    // Function

    const mesh = rl.GenMeshHemiSphere(@floatCast(radius), rings, slices);
    defer if (!return_resource) core.Mesh.free(mesh);
    errdefer if (return_resource) core.Mesh.free(mesh);

    // Return

    return core.maybe_make_struct_as_resource(core.Mesh, env, mesh, return_resource) catch {
        return error.invalid_return;
    };
}

/// Generate cylinder mesh
///
/// raylib.h
/// RLAPI Mesh GenMeshCylinder(float radius, float height, int slices);
fn nif_gen_mesh_cylinder(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const radius = core.Double.get(env, argv[0]) catch {
        return error.invalid_argument_radius;
    };

    const height = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_height;
    };

    const slices = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_slices;
    };

    // Function

    const mesh = rl.GenMeshCylinder(@floatCast(radius), @floatCast(height), slices);
    defer if (!return_resource) core.Mesh.free(mesh);
    errdefer if (return_resource) core.Mesh.free(mesh);

    // Return

    return core.maybe_make_struct_as_resource(core.Mesh, env, mesh, return_resource) catch {
        return error.invalid_return;
    };
}

/// Generate cone/pyramid mesh
///
/// raylib.h
/// RLAPI Mesh GenMeshCone(float radius, float height, int slices);
fn nif_gen_mesh_cone(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const radius = core.Double.get(env, argv[0]) catch {
        return error.invalid_argument_radius;
    };

    const height = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_height;
    };

    const slices = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_slices;
    };

    // Function

    const mesh = rl.GenMeshCone(@floatCast(radius), @floatCast(height), slices);
    defer if (!return_resource) core.Mesh.free(mesh);
    errdefer if (return_resource) core.Mesh.free(mesh);

    // Return

    return core.maybe_make_struct_as_resource(core.Mesh, env, mesh, return_resource) catch {
        return error.invalid_return;
    };
}

/// Generate torus mesh
///
/// raylib.h
/// RLAPI Mesh GenMeshTorus(float radius, float size, int radSeg, int sides);
fn nif_gen_mesh_torus(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4 or argc == 5);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 4);

    // Arguments

    const radius = core.Double.get(env, argv[0]) catch {
        return error.invalid_argument_radius;
    };

    const size = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_size;
    };

    const rad_seg = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_rad_seg;
    };

    const sides = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_sides;
    };

    // Function

    const mesh = rl.GenMeshTorus(@floatCast(radius), @floatCast(size), rad_seg, sides);
    defer if (!return_resource) core.Mesh.free(mesh);
    errdefer if (return_resource) core.Mesh.free(mesh);

    // Return

    return core.maybe_make_struct_as_resource(core.Mesh, env, mesh, return_resource) catch {
        return error.invalid_return;
    };
}

/// Generate trefoil knot mesh
///
/// raylib.h
/// RLAPI Mesh GenMeshKnot(float radius, float size, int radSeg, int sides);
fn nif_gen_mesh_knot(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4 or argc == 5);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 4);

    // Arguments

    const radius = core.Double.get(env, argv[0]) catch {
        return error.invalid_argument_radius;
    };

    const size = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_size;
    };

    const rad_seg = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_rad_seg;
    };

    const sides = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_sides;
    };

    // Function

    const mesh = rl.GenMeshKnot(@floatCast(radius), @floatCast(size), rad_seg, sides);
    defer if (!return_resource) core.Mesh.free(mesh);
    errdefer if (return_resource) core.Mesh.free(mesh);

    // Return

    return core.maybe_make_struct_as_resource(core.Mesh, env, mesh, return_resource) catch {
        return error.invalid_return;
    };
}

/// Generate heightmap mesh from image data
///
/// raylib.h
/// RLAPI Mesh GenMeshHeightmap(Image heightmap, Vector3 size);
fn nif_gen_mesh_heightmap(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_heightmap = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_heightmap;
    };
    defer arg_heightmap.free();
    const heightmap = arg_heightmap.data;

    const arg_size = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_size;
    };
    defer arg_size.free();
    const size = arg_size.data;

    // Function

    const mesh = rl.GenMeshHeightmap(heightmap, size);
    defer if (!return_resource) core.Mesh.free(mesh);
    errdefer if (return_resource) core.Mesh.free(mesh);

    // Return

    return core.maybe_make_struct_as_resource(core.Mesh, env, mesh, return_resource) catch {
        return error.invalid_return;
    };
}

/// Generate cubes-based map mesh from image data
///
/// raylib.h
/// RLAPI Mesh GenMeshCubicmap(Image cubicmap, Vector3 cubeSize);
fn nif_gen_mesh_cubicmap(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_cubicmap = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_cubicmap;
    };
    defer arg_cubicmap.free();
    const cubicmap = arg_cubicmap.data;

    const arg_cube_size = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_cube_size;
    };
    defer arg_cube_size.free();
    const cube_size = arg_cube_size.data;

    // Function

    const mesh = rl.GenMeshCubicmap(cubicmap, cube_size);
    defer if (!return_resource) core.Mesh.free(mesh);
    errdefer if (return_resource) core.Mesh.free(mesh);

    // Return

    return core.maybe_make_struct_as_resource(core.Mesh, env, mesh, return_resource) catch {
        return error.invalid_return;
    };
}

///////////////////////////
//  Material management  //
///////////////////////////

/// Load materials from model file
///
/// raylib.h
/// RLAPI Material *LoadMaterials(const char *fileName, int *materialCount);
fn nif_load_materials(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_file_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_file_name;
    };
    defer arg_file_name.free();
    const file_name = arg_file_name.data;

    // Function

    var material_count: c_int = undefined;
    const materials_c = rl.LoadMaterials(file_name, &material_count);

    const materials_size: usize = @intCast(material_count);
    const materials = @as([*]rl.Material, @ptrCast(materials_c))[0..materials_size];

    defer {
        rl.MemFree(materials_c); // always free

        if (!return_resource) {
            for (0..materials_size) |i| {
                core.Material.free(materials[i]);
            }
        }
    }
    errdefer {
        if (return_resource) {
            for (0..materials_size) |i| {
                core.Material.free(materials[i]);
            }
        }
    }

    // Return

    var term_materials = e.enif_make_list_from_array(env, null, 0);

    for (0..materials_size) |i| {
        const term = core.maybe_make_struct_as_resource(core.Material, env, materials[materials.len - 1 - i], return_resource) catch {
            return error.invalid_return;
        };
        term_materials = e.enif_make_list_cell(env, term, term_materials);
    }

    return term_materials;
}

/// Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
///
/// raylib.h
/// RLAPI Material LoadMaterialDefault(void);
fn nif_load_material_default(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0 or argc == 1);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 0);

    // Function

    const material = rl.LoadMaterialDefault();
    defer if (!return_resource) core.Material.free(material);
    errdefer if (return_resource) core.Material.free(material);

    // Return

    return core.maybe_make_struct_as_resource(core.Material, env, material, return_resource) catch {
        return error.invalid_return;
    };
}

/// Check if a material is valid (shader assigned, map textures loaded in GPU)
///
/// raylib.h
/// RLAPI bool IsMaterialValid(Material material);
fn nif_is_material_valid(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_material = core.Argument(core.Material).get(env, argv[0]) catch {
        return error.invalid_argument_material;
    };
    defer arg_material.free();
    const material = arg_material.data;

    // Function

    const is_material_valid = rl.IsMaterialValid(material);

    // Return

    return core.Boolean.make(env, is_material_valid);
}

/// Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
///
/// raylib.h
/// RLAPI void SetMaterialTexture(Material *material, int mapType, Texture2D texture);
fn nif_set_material_texture(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    var arg_material = core.Argument(core.Material).get(env, argv[0]) catch {
        return error.invalid_argument_material;
    };
    defer if (!return_resource) arg_material.free();
    errdefer if (return_resource) arg_material.free();
    const material = &arg_material.data;

    const map_type = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_map_type;
    };

    const arg_texture = core.Argument(core.Texture2D).get(env, argv[2]) catch {
        return error.invalid_argument_texture;
    };
    defer arg_texture.free();
    const texture = arg_texture.data;

    // Function

    rl.SetMaterialTexture(@ptrCast(material), map_type, texture);

    // Return

    return core.maybe_make_struct_or_resource(core.Material, env, argv[0], material.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Set material for a mesh
///
/// raylib.h
/// RLAPI void SetModelMeshMaterial(Model *model, int meshId, int materialId);
fn nif_set_model_mesh_material(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    var arg_model = core.Argument(core.Model).get(env, argv[0]) catch {
        return error.invalid_argument_model;
    };
    defer if (!return_resource) arg_model.free();
    errdefer if (return_resource) arg_model.free();
    const model = &arg_model.data;

    const mesh_id = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_mesh_id;
    };

    const material_id = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_material_id;
    };

    // Function

    rl.SetModelMeshMaterial(@ptrCast(model), mesh_id, material_id);

    // Return

    return core.maybe_make_struct_or_resource(core.Model, env, argv[0], model.*, return_resource) catch {
        return error.invalid_return;
    };
}

///////////////////////
//  Model animation  //
///////////////////////

/// Load model animations from file
///
/// raylib.h
/// RLAPI ModelAnimation *LoadModelAnimations(const char *fileName, int *animCount);
fn nif_load_model_animations(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_file_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_file_name;
    };
    defer arg_file_name.free();
    const file_name = arg_file_name.data;

    // Function

    var model_animation_count: c_int = undefined;
    const model_animations_c = rl.LoadModelAnimations(file_name, &model_animation_count);

    const model_animations_size: usize = @intCast(model_animation_count);
    const model_animations = @as([*]rl.ModelAnimation, @ptrCast(model_animations_c))[0..model_animations_size];

    defer {
        rl.MemFree(model_animations_c); // always free

        if (!return_resource) {
            for (0..model_animations_size) |i| {
                core.ModelAnimation.free(model_animations[i]);
            }
        }
    }
    errdefer {
        if (return_resource) {
            for (0..model_animations_size) |i| {
                core.ModelAnimation.free(model_animations[i]);
            }
        }
    }

    // Return

    var term_model_animations = e.enif_make_list_from_array(env, null, 0);

    for (0..model_animations_size) |i| {
        const term = core.maybe_make_struct_as_resource(core.ModelAnimation, env, model_animations[model_animations.len - 1 - i], return_resource) catch {
            return error.invalid_return;
        };
        term_model_animations = e.enif_make_list_cell(env, term, term_model_animations);
    }

    return term_model_animations;
}

/// Update model animation pose (CPU)
///
/// raylib.h
/// RLAPI void UpdateModelAnimation(Model model, ModelAnimation anim, int frame);
fn nif_update_model_animation(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    var arg_model = core.Argument(core.Model).get(env, argv[0]) catch {
        return error.invalid_argument_model;
    };
    defer if (!return_resource) arg_model.free();
    errdefer if (return_resource) arg_model.free();
    const model = &arg_model.data;

    const arg_anim = core.Argument(core.ModelAnimation).get(env, argv[1]) catch {
        return error.invalid_argument_anim;
    };
    defer arg_anim.free();
    const anim = arg_anim.data;

    const frame = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_frame;
    };

    // Function

    rl.UpdateModelAnimation(model.*, anim, frame);

    // Return

    return core.maybe_make_struct_or_resource(core.Model, env, argv[0], model.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Update model animation mesh bone matrices (GPU skinning)
///
/// raylib.h
/// RLAPI void UpdateModelAnimationBones(Model model, ModelAnimation anim, int frame);
fn nif_update_model_animation_bones(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    var arg_model = core.Argument(core.Model).get(env, argv[0]) catch {
        return error.invalid_argument_model;
    };
    defer if (!return_resource) arg_model.free();
    errdefer if (return_resource) arg_model.free();
    const model = &arg_model.data;

    const arg_anim = core.Argument(core.ModelAnimation).get(env, argv[1]) catch {
        return error.invalid_argument_anim;
    };
    defer arg_anim.free();
    const anim = arg_anim.data;

    const frame = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_frame;
    };

    // Function

    rl.UpdateModelAnimationBones(model.*, anim, frame);

    // Return

    return core.maybe_make_struct_or_resource(core.Model, env, argv[0], model.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Check model animation skeleton match
///
/// raylib.h
/// RLAPI bool IsModelAnimationValid(Model model, ModelAnimation anim);
fn nif_is_model_animation_valid(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_model = core.Argument(core.Model).get(env, argv[0]) catch {
        return error.invalid_argument_model;
    };
    defer arg_model.free();
    const model = arg_model.data;

    const arg_anim = core.Argument(core.ModelAnimation).get(env, argv[1]) catch {
        return error.invalid_argument_anim;
    };
    defer arg_anim.free();
    const anim = arg_anim.data;

    // Function

    const is_model_animation_valid = rl.IsModelAnimationValid(model, anim);

    // Return

    return core.Boolean.make(env, is_model_animation_valid);
}

///////////////////////////
//  Collision detection  //
///////////////////////////

/// Check collision between two spheres
///
/// raylib.h
/// RLAPI bool CheckCollisionSpheres(Vector3 center1, float radius1, Vector3 center2, float radius2);
fn nif_check_collision_spheres(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_center1 = core.Argument(core.Vector3).get(env, argv[0]) catch {
        return error.invalid_argument_center1;
    };
    defer arg_center1.free();
    const center1 = arg_center1.data;

    const radius1 = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_radius1;
    };

    const arg_center2 = core.Argument(core.Vector3).get(env, argv[2]) catch {
        return error.invalid_argument_center2;
    };
    defer arg_center2.free();
    const center2 = arg_center2.data;

    const radius2 = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_radius2;
    };

    // Function

    const collision = rl.CheckCollisionSpheres(center1, @floatCast(radius1), center2, @floatCast(radius2));

    // Return

    return core.Boolean.make(env, collision);
}

/// Check collision between two bounding boxes
///
/// raylib.h
/// RLAPI bool CheckCollisionBoxes(BoundingBox box1, BoundingBox box2);
fn nif_check_collision_boxes(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_box1 = core.Argument(core.BoundingBox).get(env, argv[0]) catch {
        return error.invalid_argument_box1;
    };
    defer arg_box1.free();
    const box1 = arg_box1.data;

    const arg_box2 = core.Argument(core.BoundingBox).get(env, argv[1]) catch {
        return error.invalid_argument_box2;
    };
    defer arg_box2.free();
    const box2 = arg_box2.data;

    // Function

    const collision = rl.CheckCollisionBoxes(box1, box2);

    // Return

    return core.Boolean.make(env, collision);
}

/// Check collision between box and sphere
///
/// raylib.h
/// RLAPI bool CheckCollisionBoxSphere(BoundingBox box, Vector3 center, float radius);
fn nif_check_collision_box_sphere(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_box = core.Argument(core.BoundingBox).get(env, argv[0]) catch {
        return error.invalid_argument_box;
    };
    defer arg_box.free();
    const box = arg_box.data;

    const arg_center = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_center;
    };
    defer arg_center.free();
    const center = arg_center.data;

    const radius = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_radius;
    };

    // Function

    const collision = rl.CheckCollisionBoxSphere(box, center, @floatCast(radius));

    // Return

    return core.Boolean.make(env, collision);
}

/// Get collision info between ray and sphere
///
/// raylib.h
/// RLAPI RayCollision GetRayCollisionSphere(Ray ray, Vector3 center, float radius);
fn nif_get_ray_collision_sphere(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const arg_ray = core.Argument(core.Ray).get(env, argv[0]) catch {
        return error.invalid_argument_ray;
    };
    defer arg_ray.free();
    const ray = arg_ray.data;

    const arg_center = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_center;
    };
    defer arg_center.free();
    const center = arg_center.data;

    const radius = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_radius;
    };

    // Function

    const ray_collision = rl.GetRayCollisionSphere(ray, center, @floatCast(radius));
    defer if (!return_resource) core.RayCollision.free(ray_collision);
    errdefer if (return_resource) core.RayCollision.free(ray_collision);

    // Return

    return core.maybe_make_struct_as_resource(core.RayCollision, env, ray_collision, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get collision info between ray and box
///
/// raylib.h
/// RLAPI RayCollision GetRayCollisionBox(Ray ray, BoundingBox box);
fn nif_get_ray_collision_box(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_ray = core.Argument(core.Ray).get(env, argv[0]) catch {
        return error.invalid_argument_ray;
    };
    defer arg_ray.free();
    const ray = arg_ray.data;

    const arg_box = core.Argument(core.BoundingBox).get(env, argv[1]) catch {
        return error.invalid_argument_box;
    };
    defer arg_box.free();
    const box = arg_box.data;

    // Function

    const ray_collision = rl.GetRayCollisionBox(ray, box);
    defer if (!return_resource) core.RayCollision.free(ray_collision);
    errdefer if (return_resource) core.RayCollision.free(ray_collision);

    // Return

    return core.maybe_make_struct_as_resource(core.RayCollision, env, ray_collision, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get collision info between ray and mesh
///
/// raylib.h
/// RLAPI RayCollision GetRayCollisionMesh(Ray ray, Mesh mesh, Matrix transform);
fn nif_get_ray_collision_mesh(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const arg_ray = core.Argument(core.Ray).get(env, argv[0]) catch {
        return error.invalid_argument_ray;
    };
    defer arg_ray.free();
    const ray = arg_ray.data;

    const arg_mesh = core.Argument(core.Mesh).get(env, argv[1]) catch {
        return error.invalid_argument_mesh;
    };
    defer arg_mesh.free();
    const mesh = arg_mesh.data;

    const arg_transform = core.Argument(core.Matrix).get(env, argv[2]) catch {
        return error.invalid_argument_transform;
    };
    defer arg_transform.free();
    const transform = arg_transform.data;

    // Function

    const ray_collision = rl.GetRayCollisionMesh(ray, mesh, transform);
    defer if (!return_resource) core.RayCollision.free(ray_collision);
    errdefer if (return_resource) core.RayCollision.free(ray_collision);

    // Return

    return core.maybe_make_struct_as_resource(core.RayCollision, env, ray_collision, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get collision info between ray and triangle
///
/// raylib.h
/// RLAPI RayCollision GetRayCollisionTriangle(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3);
fn nif_get_ray_collision_triangle(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4 or argc == 5);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 4);

    // Arguments

    const arg_ray = core.Argument(core.Ray).get(env, argv[0]) catch {
        return error.invalid_argument_ray;
    };
    defer arg_ray.free();
    const ray = arg_ray.data;

    const arg_p1 = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_p1;
    };
    defer arg_p1.free();
    const p1 = arg_p1.data;

    const arg_p2 = core.Argument(core.Vector3).get(env, argv[2]) catch {
        return error.invalid_argument_p2;
    };
    defer arg_p2.free();
    const p2 = arg_p2.data;

    const arg_p3 = core.Argument(core.Vector3).get(env, argv[3]) catch {
        return error.invalid_argument_p3;
    };
    defer arg_p3.free();
    const p3 = arg_p3.data;

    // Function

    const ray_collision = rl.GetRayCollisionTriangle(ray, p1, p2, p3);
    defer if (!return_resource) core.RayCollision.free(ray_collision);
    errdefer if (return_resource) core.RayCollision.free(ray_collision);

    // Return

    return core.maybe_make_struct_as_resource(core.RayCollision, env, ray_collision, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get collision info between ray and quad
///
/// raylib.h
/// RLAPI RayCollision GetRayCollisionQuad(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4);
fn nif_get_ray_collision_quad(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 5);

    // Arguments

    const arg_ray = core.Argument(core.Ray).get(env, argv[0]) catch {
        return error.invalid_argument_ray;
    };
    defer arg_ray.free();
    const ray = arg_ray.data;

    const arg_p1 = core.Argument(core.Vector3).get(env, argv[1]) catch {
        return error.invalid_argument_p1;
    };
    defer arg_p1.free();
    const p1 = arg_p1.data;

    const arg_p2 = core.Argument(core.Vector3).get(env, argv[2]) catch {
        return error.invalid_argument_p2;
    };
    defer arg_p2.free();
    const p2 = arg_p2.data;

    const arg_p3 = core.Argument(core.Vector3).get(env, argv[3]) catch {
        return error.invalid_argument_p3;
    };
    defer arg_p3.free();
    const p3 = arg_p3.data;

    const arg_p4 = core.Argument(core.Vector3).get(env, argv[4]) catch {
        return error.invalid_argument_p4;
    };
    defer arg_p4.free();
    const p4 = arg_p4.data;

    // Function

    const ray_collision = rl.GetRayCollisionQuad(ray, p1, p2, p3, p4);
    defer if (!return_resource) core.RayCollision.free(ray_collision);
    errdefer if (return_resource) core.RayCollision.free(ray_collision);

    // Return

    return core.maybe_make_struct_as_resource(core.RayCollision, env, ray_collision, return_resource) catch {
        return error.invalid_return;
    };
}
