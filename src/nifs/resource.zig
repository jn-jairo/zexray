const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Vector2
    .{ .name = "vector2_to_resource", .arity = 1, .fptr = nif_vector2_to_resource, .flags = 0 },
    .{ .name = "vector2_from_resource", .arity = 1, .fptr = nif_vector2_from_resource, .flags = 0 },
    .{ .name = "vector2_free_resource", .arity = 1, .fptr = nif_vector2_free_resource, .flags = 0 },

    // Vector3
    .{ .name = "vector3_to_resource", .arity = 1, .fptr = nif_vector3_to_resource, .flags = 0 },
    .{ .name = "vector3_from_resource", .arity = 1, .fptr = nif_vector3_from_resource, .flags = 0 },
    .{ .name = "vector3_free_resource", .arity = 1, .fptr = nif_vector3_free_resource, .flags = 0 },

    // Vector4
    .{ .name = "vector4_to_resource", .arity = 1, .fptr = nif_vector4_to_resource, .flags = 0 },
    .{ .name = "vector4_from_resource", .arity = 1, .fptr = nif_vector4_from_resource, .flags = 0 },
    .{ .name = "vector4_free_resource", .arity = 1, .fptr = nif_vector4_free_resource, .flags = 0 },

    // Quaternion
    .{ .name = "quaternion_to_resource", .arity = 1, .fptr = nif_quaternion_to_resource, .flags = 0 },
    .{ .name = "quaternion_from_resource", .arity = 1, .fptr = nif_quaternion_from_resource, .flags = 0 },
    .{ .name = "quaternion_free_resource", .arity = 1, .fptr = nif_quaternion_free_resource, .flags = 0 },

    // Matrix
    .{ .name = "matrix_to_resource", .arity = 1, .fptr = nif_matrix_to_resource, .flags = 0 },
    .{ .name = "matrix_from_resource", .arity = 1, .fptr = nif_matrix_from_resource, .flags = 0 },
    .{ .name = "matrix_free_resource", .arity = 1, .fptr = nif_matrix_free_resource, .flags = 0 },

    // Color
    .{ .name = "color_to_resource", .arity = 1, .fptr = nif_color_to_resource, .flags = 0 },
    .{ .name = "color_from_resource", .arity = 1, .fptr = nif_color_from_resource, .flags = 0 },
    .{ .name = "color_free_resource", .arity = 1, .fptr = nif_color_free_resource, .flags = 0 },

    // Rectangle
    .{ .name = "rectangle_to_resource", .arity = 1, .fptr = nif_rectangle_to_resource, .flags = 0 },
    .{ .name = "rectangle_from_resource", .arity = 1, .fptr = nif_rectangle_from_resource, .flags = 0 },
    .{ .name = "rectangle_free_resource", .arity = 1, .fptr = nif_rectangle_free_resource, .flags = 0 },

    // Image
    .{ .name = "image_to_resource", .arity = 1, .fptr = nif_image_to_resource, .flags = 0 },
    .{ .name = "image_from_resource", .arity = 1, .fptr = nif_image_from_resource, .flags = 0 },
    .{ .name = "image_free_resource", .arity = 1, .fptr = nif_image_free_resource, .flags = 0 },

    // Texture
    .{ .name = "texture_to_resource", .arity = 1, .fptr = nif_texture_to_resource, .flags = 0 },
    .{ .name = "texture_from_resource", .arity = 1, .fptr = nif_texture_from_resource, .flags = 0 },
    .{ .name = "texture_free_resource", .arity = 1, .fptr = nif_texture_free_resource, .flags = 0 },

    // Texture2D
    .{ .name = "texture_2d_to_resource", .arity = 1, .fptr = nif_texture_2d_to_resource, .flags = 0 },
    .{ .name = "texture_2d_from_resource", .arity = 1, .fptr = nif_texture_2d_from_resource, .flags = 0 },
    .{ .name = "texture_2d_free_resource", .arity = 1, .fptr = nif_texture_2d_free_resource, .flags = 0 },

    // TextureCubemap
    .{ .name = "texture_cubemap_to_resource", .arity = 1, .fptr = nif_texture_cubemap_to_resource, .flags = 0 },
    .{ .name = "texture_cubemap_from_resource", .arity = 1, .fptr = nif_texture_cubemap_from_resource, .flags = 0 },
    .{ .name = "texture_cubemap_free_resource", .arity = 1, .fptr = nif_texture_cubemap_free_resource, .flags = 0 },

    // RenderTexture
    .{ .name = "render_texture_to_resource", .arity = 1, .fptr = nif_render_texture_to_resource, .flags = 0 },
    .{ .name = "render_texture_from_resource", .arity = 1, .fptr = nif_render_texture_from_resource, .flags = 0 },
    .{ .name = "render_texture_free_resource", .arity = 1, .fptr = nif_render_texture_free_resource, .flags = 0 },

    // RenderTexture2D
    .{ .name = "render_texture_2d_to_resource", .arity = 1, .fptr = nif_render_texture_2d_to_resource, .flags = 0 },
    .{ .name = "render_texture_2d_from_resource", .arity = 1, .fptr = nif_render_texture_2d_from_resource, .flags = 0 },
    .{ .name = "render_texture_2d_free_resource", .arity = 1, .fptr = nif_render_texture_2d_free_resource, .flags = 0 },

    // NPatchInfo
    .{ .name = "n_patch_info_to_resource", .arity = 1, .fptr = nif_n_patch_info_to_resource, .flags = 0 },
    .{ .name = "n_patch_info_from_resource", .arity = 1, .fptr = nif_n_patch_info_from_resource, .flags = 0 },
    .{ .name = "n_patch_info_free_resource", .arity = 1, .fptr = nif_n_patch_info_free_resource, .flags = 0 },

    // GlyphInfo
    .{ .name = "glyph_info_to_resource", .arity = 1, .fptr = nif_glyph_info_to_resource, .flags = 0 },
    .{ .name = "glyph_info_from_resource", .arity = 1, .fptr = nif_glyph_info_from_resource, .flags = 0 },
    .{ .name = "glyph_info_free_resource", .arity = 1, .fptr = nif_glyph_info_free_resource, .flags = 0 },

    // Font
    .{ .name = "font_to_resource", .arity = 1, .fptr = nif_font_to_resource, .flags = 0 },
    .{ .name = "font_from_resource", .arity = 1, .fptr = nif_font_from_resource, .flags = 0 },
    .{ .name = "font_free_resource", .arity = 1, .fptr = nif_font_free_resource, .flags = 0 },

    // Camera3D
    .{ .name = "camera_3d_to_resource", .arity = 1, .fptr = nif_camera_3d_to_resource, .flags = 0 },
    .{ .name = "camera_3d_from_resource", .arity = 1, .fptr = nif_camera_3d_from_resource, .flags = 0 },
    .{ .name = "camera_3d_free_resource", .arity = 1, .fptr = nif_camera_3d_free_resource, .flags = 0 },

    // Camera
    .{ .name = "camera_to_resource", .arity = 1, .fptr = nif_camera_to_resource, .flags = 0 },
    .{ .name = "camera_from_resource", .arity = 1, .fptr = nif_camera_from_resource, .flags = 0 },
    .{ .name = "camera_free_resource", .arity = 1, .fptr = nif_camera_free_resource, .flags = 0 },

    // Camera2D
    .{ .name = "camera_2d_to_resource", .arity = 1, .fptr = nif_camera_2d_to_resource, .flags = 0 },
    .{ .name = "camera_2d_from_resource", .arity = 1, .fptr = nif_camera_2d_from_resource, .flags = 0 },
    .{ .name = "camera_2d_free_resource", .arity = 1, .fptr = nif_camera_2d_free_resource, .flags = 0 },

    // Mesh
    .{ .name = "mesh_to_resource", .arity = 1, .fptr = nif_mesh_to_resource, .flags = 0 },
    .{ .name = "mesh_from_resource", .arity = 1, .fptr = nif_mesh_from_resource, .flags = 0 },
    .{ .name = "mesh_free_resource", .arity = 1, .fptr = nif_mesh_free_resource, .flags = 0 },

    // Shader
    .{ .name = "shader_to_resource", .arity = 1, .fptr = nif_shader_to_resource, .flags = 0 },
    .{ .name = "shader_from_resource", .arity = 1, .fptr = nif_shader_from_resource, .flags = 0 },
    .{ .name = "shader_free_resource", .arity = 1, .fptr = nif_shader_free_resource, .flags = 0 },

    // MaterialMap
    .{ .name = "material_map_to_resource", .arity = 1, .fptr = nif_material_map_to_resource, .flags = 0 },
    .{ .name = "material_map_from_resource", .arity = 1, .fptr = nif_material_map_from_resource, .flags = 0 },
    .{ .name = "material_map_free_resource", .arity = 1, .fptr = nif_material_map_free_resource, .flags = 0 },

    // Material
    .{ .name = "material_to_resource", .arity = 1, .fptr = nif_material_to_resource, .flags = 0 },
    .{ .name = "material_from_resource", .arity = 1, .fptr = nif_material_from_resource, .flags = 0 },
    .{ .name = "material_free_resource", .arity = 1, .fptr = nif_material_free_resource, .flags = 0 },

    // Transform
    .{ .name = "transform_to_resource", .arity = 1, .fptr = nif_transform_to_resource, .flags = 0 },
    .{ .name = "transform_from_resource", .arity = 1, .fptr = nif_transform_from_resource, .flags = 0 },
    .{ .name = "transform_free_resource", .arity = 1, .fptr = nif_transform_free_resource, .flags = 0 },

    // BoneInfo
    .{ .name = "bone_info_to_resource", .arity = 1, .fptr = nif_bone_info_to_resource, .flags = 0 },
    .{ .name = "bone_info_from_resource", .arity = 1, .fptr = nif_bone_info_from_resource, .flags = 0 },
    .{ .name = "bone_info_free_resource", .arity = 1, .fptr = nif_bone_info_free_resource, .flags = 0 },

    // Model
    .{ .name = "model_to_resource", .arity = 1, .fptr = nif_model_to_resource, .flags = 0 },
    .{ .name = "model_from_resource", .arity = 1, .fptr = nif_model_from_resource, .flags = 0 },
    .{ .name = "model_free_resource", .arity = 1, .fptr = nif_model_free_resource, .flags = 0 },

    // ModelAnimation
    .{ .name = "model_animation_to_resource", .arity = 1, .fptr = nif_model_animation_to_resource, .flags = 0 },
    .{ .name = "model_animation_from_resource", .arity = 1, .fptr = nif_model_animation_from_resource, .flags = 0 },
    .{ .name = "model_animation_free_resource", .arity = 1, .fptr = nif_model_animation_free_resource, .flags = 0 },

    // Ray
    .{ .name = "ray_to_resource", .arity = 1, .fptr = nif_ray_to_resource, .flags = 0 },
    .{ .name = "ray_from_resource", .arity = 1, .fptr = nif_ray_from_resource, .flags = 0 },
    .{ .name = "ray_free_resource", .arity = 1, .fptr = nif_ray_free_resource, .flags = 0 },

    // RayCollision
    .{ .name = "ray_collision_to_resource", .arity = 1, .fptr = nif_ray_collision_to_resource, .flags = 0 },
    .{ .name = "ray_collision_from_resource", .arity = 1, .fptr = nif_ray_collision_from_resource, .flags = 0 },
    .{ .name = "ray_collision_free_resource", .arity = 1, .fptr = nif_ray_collision_free_resource, .flags = 0 },
};

///////////////
//  Vector2  //
///////////////

fn nif_vector2_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Vector2.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Vector2.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Vector2.Resource.release(resource);

    return core.Vector2.Resource.make(env, resource);
}

fn nif_vector2_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Vector2.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Vector2.make(env, resource.*.*);
}

fn nif_vector2_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Vector2.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Vector2.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

///////////////
//  Vector3  //
///////////////

fn nif_vector3_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Vector3.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Vector3.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Vector3.Resource.release(resource);

    return core.Vector3.Resource.make(env, resource);
}

fn nif_vector3_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Vector3.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Vector3.make(env, resource.*.*);
}

fn nif_vector3_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Vector3.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Vector3.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

///////////////
//  Vector4  //
///////////////

fn nif_vector4_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Vector4.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Vector4.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Vector4.Resource.release(resource);

    return core.Vector4.Resource.make(env, resource);
}

fn nif_vector4_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Vector4.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Vector4.make(env, resource.*.*);
}

fn nif_vector4_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Vector4.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Vector4.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

//////////////////
//  Quaternion  //
//////////////////

fn nif_quaternion_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Quaternion.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Quaternion.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Quaternion.Resource.release(resource);

    return core.Quaternion.Resource.make(env, resource);
}

fn nif_quaternion_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Quaternion.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Quaternion.make(env, resource.*.*);
}

fn nif_quaternion_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Quaternion.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Quaternion.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

//////////////
//  Matrix  //
//////////////

fn nif_matrix_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Matrix.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Matrix.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Matrix.Resource.release(resource);

    return core.Matrix.Resource.make(env, resource);
}

fn nif_matrix_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Matrix.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Matrix.make(env, resource.*.*);
}

fn nif_matrix_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Matrix.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Matrix.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////
//  Color  //
/////////////

fn nif_color_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Color.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Color.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Color.Resource.release(resource);

    return core.Color.Resource.make(env, resource);
}

fn nif_color_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Color.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Color.make(env, resource.*.*);
}

fn nif_color_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Color.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Color.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////////
//  Rectangle  //
/////////////////

fn nif_rectangle_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Rectangle.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Rectangle.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Rectangle.Resource.release(resource);

    return core.Rectangle.Resource.make(env, resource);
}

fn nif_rectangle_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Rectangle.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Rectangle.make(env, resource.*.*);
}

fn nif_rectangle_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Rectangle.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Rectangle.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////
//  Image  //
/////////////

fn nif_image_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Image.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Image.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Image.Resource.release(resource);

    return core.Image.Resource.make(env, resource);
}

fn nif_image_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Image.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Image.make(env, resource.*.*);
}

fn nif_image_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Image.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Image.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

///////////////
//  Texture  //
///////////////

fn nif_texture_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Texture.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Texture.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Texture.Resource.release(resource);

    return core.Texture.Resource.make(env, resource);
}

fn nif_texture_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Texture.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Texture.make(env, resource.*.*);
}

fn nif_texture_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Texture.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Texture.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////////
//  Texture2D  //
/////////////////

fn nif_texture_2d_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Texture2D.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Texture2D.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Texture2D.Resource.release(resource);

    return core.Texture2D.Resource.make(env, resource);
}

fn nif_texture_2d_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Texture2D.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Texture2D.make(env, resource.*.*);
}

fn nif_texture_2d_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Texture2D.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Texture2D.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

//////////////////////
//  TextureCubemap  //
//////////////////////

fn nif_texture_cubemap_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.TextureCubemap.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.TextureCubemap.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.TextureCubemap.Resource.release(resource);

    return core.TextureCubemap.Resource.make(env, resource);
}

fn nif_texture_cubemap_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.TextureCubemap.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.TextureCubemap.make(env, resource.*.*);
}

fn nif_texture_cubemap_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.TextureCubemap.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.TextureCubemap.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////////////
//  RenderTexture  //
/////////////////////

fn nif_render_texture_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.RenderTexture.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.RenderTexture.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.RenderTexture.Resource.release(resource);

    return core.RenderTexture.Resource.make(env, resource);
}

fn nif_render_texture_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.RenderTexture.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.RenderTexture.make(env, resource.*.*);
}

fn nif_render_texture_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.RenderTexture.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.RenderTexture.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

///////////////////////
//  RenderTexture2D  //
///////////////////////

fn nif_render_texture_2d_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.RenderTexture2D.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.RenderTexture2D.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.RenderTexture2D.Resource.release(resource);

    return core.RenderTexture2D.Resource.make(env, resource);
}

fn nif_render_texture_2d_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.RenderTexture2D.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.RenderTexture2D.make(env, resource.*.*);
}

fn nif_render_texture_2d_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.RenderTexture2D.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.RenderTexture2D.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

//////////////////
//  NPatchInfo  //
//////////////////

fn nif_n_patch_info_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.NPatchInfo.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.NPatchInfo.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.NPatchInfo.Resource.release(resource);

    return core.NPatchInfo.Resource.make(env, resource);
}

fn nif_n_patch_info_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.NPatchInfo.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.NPatchInfo.make(env, resource.*.*);
}

fn nif_n_patch_info_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.NPatchInfo.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.NPatchInfo.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////////
//  GlyphInfo  //
/////////////////

fn nif_glyph_info_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.GlyphInfo.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.GlyphInfo.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.GlyphInfo.Resource.release(resource);

    return core.GlyphInfo.Resource.make(env, resource);
}

fn nif_glyph_info_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.GlyphInfo.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.GlyphInfo.make(env, resource.*.*);
}

fn nif_glyph_info_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.GlyphInfo.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.GlyphInfo.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////
//  Font  //
////////////

fn nif_font_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Font.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Font.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Font.Resource.release(resource);

    return core.Font.Resource.make(env, resource);
}

fn nif_font_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Font.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Font.make(env, resource.*.*);
}

fn nif_font_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Font.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Font.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////////
//  Camera3D  //
////////////////

fn nif_camera_3d_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Camera3D.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Camera3D.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Camera3D.Resource.release(resource);

    return core.Camera3D.Resource.make(env, resource);
}

fn nif_camera_3d_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Camera3D.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Camera3D.make(env, resource.*.*);
}

fn nif_camera_3d_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Camera3D.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Camera3D.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

//////////////
//  Camera  //
//////////////

fn nif_camera_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Camera.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Camera.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Camera.Resource.release(resource);

    return core.Camera.Resource.make(env, resource);
}

fn nif_camera_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Camera.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Camera.make(env, resource.*.*);
}

fn nif_camera_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Camera.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Camera.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////////
//  Camera2D  //
////////////////

fn nif_camera_2d_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Camera2D.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Camera2D.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Camera2D.Resource.release(resource);

    return core.Camera2D.Resource.make(env, resource);
}

fn nif_camera_2d_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Camera2D.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Camera2D.make(env, resource.*.*);
}

fn nif_camera_2d_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Camera2D.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Camera2D.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////
//  Mesh  //
////////////

fn nif_mesh_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Mesh.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Mesh.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Mesh.Resource.release(resource);

    return core.Mesh.Resource.make(env, resource);
}

fn nif_mesh_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Mesh.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Mesh.make(env, resource.*.*);
}

fn nif_mesh_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Mesh.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Mesh.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

//////////////
//  Shader  //
//////////////

fn nif_shader_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Shader.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Shader.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Shader.Resource.release(resource);

    return core.Shader.Resource.make(env, resource);
}

fn nif_shader_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Shader.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Shader.make(env, resource.*.*);
}

fn nif_shader_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Shader.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Shader.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

///////////////////
//  MaterialMap  //
///////////////////

fn nif_material_map_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.MaterialMap.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.MaterialMap.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.MaterialMap.Resource.release(resource);

    return core.MaterialMap.Resource.make(env, resource);
}

fn nif_material_map_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.MaterialMap.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.MaterialMap.make(env, resource.*.*);
}

fn nif_material_map_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.MaterialMap.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.MaterialMap.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////////
//  Material  //
////////////////

fn nif_material_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Material.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Material.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Material.Resource.release(resource);

    return core.Material.Resource.make(env, resource);
}

fn nif_material_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Material.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Material.make(env, resource.*.*);
}

fn nif_material_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Material.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Material.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////////
//  Transform  //
/////////////////

fn nif_transform_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Transform.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Transform.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Transform.Resource.release(resource);

    return core.Transform.Resource.make(env, resource);
}

fn nif_transform_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Transform.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Transform.make(env, resource.*.*);
}

fn nif_transform_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Transform.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Transform.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////////
//  BoneInfo  //
////////////////

fn nif_bone_info_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.BoneInfo.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.BoneInfo.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.BoneInfo.Resource.release(resource);

    return core.BoneInfo.Resource.make(env, resource);
}

fn nif_bone_info_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.BoneInfo.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.BoneInfo.make(env, resource.*.*);
}

fn nif_bone_info_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.BoneInfo.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.BoneInfo.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////
//  Model  //
/////////////

fn nif_model_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Model.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Model.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Model.Resource.release(resource);

    return core.Model.Resource.make(env, resource);
}

fn nif_model_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Model.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Model.make(env, resource.*.*);
}

fn nif_model_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Model.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Model.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

//////////////////////
//  ModelAnimation  //
//////////////////////

fn nif_model_animation_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.ModelAnimation.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.ModelAnimation.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.ModelAnimation.Resource.release(resource);

    return core.ModelAnimation.Resource.make(env, resource);
}

fn nif_model_animation_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.ModelAnimation.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.ModelAnimation.make(env, resource.*.*);
}

fn nif_model_animation_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.ModelAnimation.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.ModelAnimation.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

///////////
//  Ray  //
///////////

fn nif_ray_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Ray.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.Ray.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.Ray.Resource.release(resource);

    return core.Ray.Resource.make(env, resource);
}

fn nif_ray_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Ray.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.Ray.make(env, resource.*.*);
}

fn nif_ray_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Ray.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.Ray.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////////////
//  RayCollision  //
////////////////////

fn nif_ray_collision_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const value = core.RayCollision.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'value'.");
    };

    const resource = core.RayCollision.Resource.create(value) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource.");
    };
    defer core.RayCollision.Resource.release(resource);

    return core.RayCollision.Resource.make(env, resource);
}

fn nif_ray_collision_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.RayCollision.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    return core.RayCollision.make(env, resource.*.*);
}

fn nif_ray_collision_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.RayCollision.Resource.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'resource'.");
    };

    core.RayCollision.Resource.free(resource);

    return core.Atom.make(env, "ok");
}
