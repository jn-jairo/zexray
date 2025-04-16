const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Vector2
    .{ .name = "vector2_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_vector2_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "vector2_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_vector2_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "vector2_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_vector2_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // IVector2
    .{ .name = "ivector2_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_ivector2_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "ivector2_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_ivector2_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "ivector2_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_ivector2_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // UIVector2
    .{ .name = "uivector2_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_uivector2_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "uivector2_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_uivector2_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "uivector2_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_uivector2_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Vector3
    .{ .name = "vector3_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_vector3_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "vector3_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_vector3_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "vector3_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_vector3_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // IVector3
    .{ .name = "ivector3_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_ivector3_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "ivector3_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_ivector3_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "ivector3_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_ivector3_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // UIVector3
    .{ .name = "uivector3_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_uivector3_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "uivector3_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_uivector3_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "uivector3_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_uivector3_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Vector4
    .{ .name = "vector4_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_vector4_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "vector4_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_vector4_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "vector4_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_vector4_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // IVector4
    .{ .name = "ivector4_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_ivector4_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "ivector4_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_ivector4_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "ivector4_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_ivector4_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // UIVector4
    .{ .name = "uivector4_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_uivector4_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "uivector4_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_uivector4_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "uivector4_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_uivector4_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Quaternion
    .{ .name = "quaternion_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_quaternion_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "quaternion_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_quaternion_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "quaternion_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_quaternion_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Matrix
    .{ .name = "matrix_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_matrix_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "matrix_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_matrix_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "matrix_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_matrix_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Color
    .{ .name = "color_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_color_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_color_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "color_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_color_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Rectangle
    .{ .name = "rectangle_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_rectangle_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rectangle_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_rectangle_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rectangle_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_rectangle_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Image
    .{ .name = "image_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_image_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_image_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_image_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Texture
    .{ .name = "texture_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_texture_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "texture_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_texture_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "texture_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_texture_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Texture2D
    .{ .name = "texture_2d_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_texture_2d_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "texture_2d_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_texture_2d_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "texture_2d_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_texture_2d_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // TextureCubemap
    .{ .name = "texture_cubemap_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_texture_cubemap_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "texture_cubemap_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_texture_cubemap_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "texture_cubemap_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_texture_cubemap_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // RenderTexture
    .{ .name = "render_texture_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_render_texture_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "render_texture_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_render_texture_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "render_texture_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_render_texture_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // RenderTexture2D
    .{ .name = "render_texture_2d_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_render_texture_2d_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "render_texture_2d_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_render_texture_2d_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "render_texture_2d_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_render_texture_2d_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // NPatchInfo
    .{ .name = "n_patch_info_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_n_patch_info_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "n_patch_info_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_n_patch_info_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "n_patch_info_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_n_patch_info_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // GlyphInfo
    .{ .name = "glyph_info_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_glyph_info_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "glyph_info_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_glyph_info_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "glyph_info_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_glyph_info_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Font
    .{ .name = "font_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_font_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "font_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_font_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "font_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_font_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Camera3D
    .{ .name = "camera_3d_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_camera_3d_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_3d_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_camera_3d_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_3d_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_camera_3d_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Camera
    .{ .name = "camera_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_camera_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_camera_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_camera_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Camera2D
    .{ .name = "camera_2d_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_camera_2d_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_2d_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_camera_2d_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "camera_2d_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_camera_2d_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Mesh
    .{ .name = "mesh_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_mesh_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "mesh_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_mesh_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "mesh_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_mesh_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Shader
    .{ .name = "shader_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_shader_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "shader_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_shader_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "shader_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_shader_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // MaterialMap
    .{ .name = "material_map_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_material_map_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "material_map_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_material_map_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "material_map_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_material_map_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Material
    .{ .name = "material_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_material_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "material_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_material_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "material_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_material_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Transform
    .{ .name = "transform_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_transform_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "transform_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_transform_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "transform_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_transform_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // BoneInfo
    .{ .name = "bone_info_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_bone_info_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "bone_info_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_bone_info_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "bone_info_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_bone_info_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Model
    .{ .name = "model_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_model_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "model_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_model_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "model_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_model_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // ModelAnimation
    .{ .name = "model_animation_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_model_animation_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "model_animation_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_model_animation_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "model_animation_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_model_animation_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Ray
    .{ .name = "ray_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_ray_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "ray_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_ray_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "ray_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_ray_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // RayCollision
    .{ .name = "ray_collision_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_ray_collision_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "ray_collision_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_ray_collision_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "ray_collision_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_ray_collision_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // BoundingBox
    .{ .name = "bounding_box_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_bounding_box_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "bounding_box_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_bounding_box_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "bounding_box_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_bounding_box_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Wave
    .{ .name = "wave_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_wave_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "wave_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_wave_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "wave_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_wave_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // AudioStream
    .{ .name = "audio_stream_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_audio_stream_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "audio_stream_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_audio_stream_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "audio_stream_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_audio_stream_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Sound
    .{ .name = "sound_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_sound_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "sound_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_sound_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "sound_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_sound_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Music
    .{ .name = "music_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_music_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "music_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_music_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "music_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_music_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // VrDeviceInfo
    .{ .name = "vr_device_info_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_vr_device_info_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "vr_device_info_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_vr_device_info_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "vr_device_info_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_vr_device_info_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // VrStereoConfig
    .{ .name = "vr_stereo_config_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_vr_stereo_config_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "vr_stereo_config_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_vr_stereo_config_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "vr_stereo_config_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_vr_stereo_config_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // FilePathList
    .{ .name = "file_path_list_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_file_path_list_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "file_path_list_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_file_path_list_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "file_path_list_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_file_path_list_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // AutomationEvent
    .{ .name = "automation_event_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_automation_event_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "automation_event_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_automation_event_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "automation_event_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_automation_event_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // AutomationEventList
    .{ .name = "automation_event_list_to_resource", .arity = 1, .fptr = core.nif_wrapper(nif_automation_event_list_to_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "automation_event_list_from_resource", .arity = 1, .fptr = core.nif_wrapper(nif_automation_event_list_from_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "automation_event_list_free_resource", .arity = 1, .fptr = core.nif_wrapper(nif_automation_event_list_free_resource), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

///////////////
//  Vector2  //
///////////////

fn nif_vector2_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Vector2.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Vector2.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Vector2.Resource.release(resource);

    return core.Vector2.Resource.make(env, resource);
}

fn nif_vector2_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Vector2.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Vector2.make(env, resource.*.*);
}

fn nif_vector2_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Vector2.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Vector2.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////////
//  IVector2  //
////////////////

fn nif_ivector2_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.IVector2.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.IVector2.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.IVector2.Resource.release(resource);

    return core.IVector2.Resource.make(env, resource);
}

fn nif_ivector2_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.IVector2.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.IVector2.make(env, resource.*.*);
}

fn nif_ivector2_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.IVector2.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.IVector2.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////////
//  UIVector2  //
/////////////////

fn nif_uivector2_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.UIVector2.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.UIVector2.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.UIVector2.Resource.release(resource);

    return core.UIVector2.Resource.make(env, resource);
}

fn nif_uivector2_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.UIVector2.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.UIVector2.make(env, resource.*.*);
}

fn nif_uivector2_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.UIVector2.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.UIVector2.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

///////////////
//  Vector3  //
///////////////

fn nif_vector3_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Vector3.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Vector3.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Vector3.Resource.release(resource);

    return core.Vector3.Resource.make(env, resource);
}

fn nif_vector3_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Vector3.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Vector3.make(env, resource.*.*);
}

fn nif_vector3_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Vector3.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Vector3.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////////
//  IVector3  //
////////////////

fn nif_ivector3_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.IVector3.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.IVector3.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.IVector3.Resource.release(resource);

    return core.IVector3.Resource.make(env, resource);
}

fn nif_ivector3_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.IVector3.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.IVector3.make(env, resource.*.*);
}

fn nif_ivector3_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.IVector3.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.IVector3.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////////
//  UIVector3  //
/////////////////

fn nif_uivector3_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.UIVector3.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.UIVector3.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.UIVector3.Resource.release(resource);

    return core.UIVector3.Resource.make(env, resource);
}

fn nif_uivector3_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.UIVector3.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.UIVector3.make(env, resource.*.*);
}

fn nif_uivector3_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.UIVector3.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.UIVector3.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

///////////////
//  Vector4  //
///////////////

fn nif_vector4_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Vector4.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Vector4.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Vector4.Resource.release(resource);

    return core.Vector4.Resource.make(env, resource);
}

fn nif_vector4_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Vector4.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Vector4.make(env, resource.*.*);
}

fn nif_vector4_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Vector4.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Vector4.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////////
//  IVector4  //
////////////////

fn nif_ivector4_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.IVector4.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.IVector4.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.IVector4.Resource.release(resource);

    return core.IVector4.Resource.make(env, resource);
}

fn nif_ivector4_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.IVector4.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.IVector4.make(env, resource.*.*);
}

fn nif_ivector4_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.IVector4.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.IVector4.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////////
//  UIVector4  //
/////////////////

fn nif_uivector4_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.UIVector4.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.UIVector4.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.UIVector4.Resource.release(resource);

    return core.UIVector4.Resource.make(env, resource);
}

fn nif_uivector4_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.UIVector4.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.UIVector4.make(env, resource.*.*);
}

fn nif_uivector4_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.UIVector4.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.UIVector4.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

//////////////////
//  Quaternion  //
//////////////////

fn nif_quaternion_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Quaternion.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Quaternion.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Quaternion.Resource.release(resource);

    return core.Quaternion.Resource.make(env, resource);
}

fn nif_quaternion_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Quaternion.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Quaternion.make(env, resource.*.*);
}

fn nif_quaternion_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Quaternion.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Quaternion.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

//////////////
//  Matrix  //
//////////////

fn nif_matrix_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Matrix.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Matrix.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Matrix.Resource.release(resource);

    return core.Matrix.Resource.make(env, resource);
}

fn nif_matrix_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Matrix.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Matrix.make(env, resource.*.*);
}

fn nif_matrix_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Matrix.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Matrix.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////
//  Color  //
/////////////

fn nif_color_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Color.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Color.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Color.Resource.release(resource);

    return core.Color.Resource.make(env, resource);
}

fn nif_color_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Color.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Color.make(env, resource.*.*);
}

fn nif_color_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Color.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Color.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////////
//  Rectangle  //
/////////////////

fn nif_rectangle_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Rectangle.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Rectangle.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Rectangle.Resource.release(resource);

    return core.Rectangle.Resource.make(env, resource);
}

fn nif_rectangle_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Rectangle.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Rectangle.make(env, resource.*.*);
}

fn nif_rectangle_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Rectangle.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Rectangle.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////
//  Image  //
/////////////

fn nif_image_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Image.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Image.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Image.Resource.release(resource);

    return core.Image.Resource.make(env, resource);
}

fn nif_image_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Image.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Image.make(env, resource.*.*);
}

fn nif_image_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Image.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Image.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

///////////////
//  Texture  //
///////////////

fn nif_texture_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Texture.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Texture.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Texture.Resource.release(resource);

    return core.Texture.Resource.make(env, resource);
}

fn nif_texture_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Texture.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Texture.make(env, resource.*.*);
}

fn nif_texture_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Texture.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Texture.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////////
//  Texture2D  //
/////////////////

fn nif_texture_2d_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Texture2D.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Texture2D.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Texture2D.Resource.release(resource);

    return core.Texture2D.Resource.make(env, resource);
}

fn nif_texture_2d_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Texture2D.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Texture2D.make(env, resource.*.*);
}

fn nif_texture_2d_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Texture2D.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Texture2D.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

//////////////////////
//  TextureCubemap  //
//////////////////////

fn nif_texture_cubemap_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.TextureCubemap.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.TextureCubemap.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.TextureCubemap.Resource.release(resource);

    return core.TextureCubemap.Resource.make(env, resource);
}

fn nif_texture_cubemap_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.TextureCubemap.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.TextureCubemap.make(env, resource.*.*);
}

fn nif_texture_cubemap_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.TextureCubemap.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.TextureCubemap.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////////////
//  RenderTexture  //
/////////////////////

fn nif_render_texture_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.RenderTexture.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.RenderTexture.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.RenderTexture.Resource.release(resource);

    return core.RenderTexture.Resource.make(env, resource);
}

fn nif_render_texture_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.RenderTexture.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.RenderTexture.make(env, resource.*.*);
}

fn nif_render_texture_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.RenderTexture.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.RenderTexture.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

///////////////////////
//  RenderTexture2D  //
///////////////////////

fn nif_render_texture_2d_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.RenderTexture2D.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.RenderTexture2D.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.RenderTexture2D.Resource.release(resource);

    return core.RenderTexture2D.Resource.make(env, resource);
}

fn nif_render_texture_2d_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.RenderTexture2D.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.RenderTexture2D.make(env, resource.*.*);
}

fn nif_render_texture_2d_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.RenderTexture2D.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.RenderTexture2D.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

//////////////////
//  NPatchInfo  //
//////////////////

fn nif_n_patch_info_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.NPatchInfo.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.NPatchInfo.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.NPatchInfo.Resource.release(resource);

    return core.NPatchInfo.Resource.make(env, resource);
}

fn nif_n_patch_info_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.NPatchInfo.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.NPatchInfo.make(env, resource.*.*);
}

fn nif_n_patch_info_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.NPatchInfo.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.NPatchInfo.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////////
//  GlyphInfo  //
/////////////////

fn nif_glyph_info_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.GlyphInfo.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.GlyphInfo.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.GlyphInfo.Resource.release(resource);

    return core.GlyphInfo.Resource.make(env, resource);
}

fn nif_glyph_info_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.GlyphInfo.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.GlyphInfo.make(env, resource.*.*);
}

fn nif_glyph_info_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.GlyphInfo.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.GlyphInfo.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////
//  Font  //
////////////

fn nif_font_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Font.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Font.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Font.Resource.release(resource);

    return core.Font.Resource.make(env, resource);
}

fn nif_font_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Font.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Font.make(env, resource.*.*);
}

fn nif_font_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Font.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Font.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////////
//  Camera3D  //
////////////////

fn nif_camera_3d_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Camera3D.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Camera3D.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Camera3D.Resource.release(resource);

    return core.Camera3D.Resource.make(env, resource);
}

fn nif_camera_3d_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Camera3D.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Camera3D.make(env, resource.*.*);
}

fn nif_camera_3d_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Camera3D.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Camera3D.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

//////////////
//  Camera  //
//////////////

fn nif_camera_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Camera.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Camera.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Camera.Resource.release(resource);

    return core.Camera.Resource.make(env, resource);
}

fn nif_camera_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Camera.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Camera.make(env, resource.*.*);
}

fn nif_camera_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Camera.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Camera.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////////
//  Camera2D  //
////////////////

fn nif_camera_2d_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Camera2D.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Camera2D.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Camera2D.Resource.release(resource);

    return core.Camera2D.Resource.make(env, resource);
}

fn nif_camera_2d_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Camera2D.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Camera2D.make(env, resource.*.*);
}

fn nif_camera_2d_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Camera2D.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Camera2D.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////
//  Mesh  //
////////////

fn nif_mesh_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Mesh.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Mesh.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Mesh.Resource.release(resource);

    return core.Mesh.Resource.make(env, resource);
}

fn nif_mesh_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Mesh.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Mesh.make(env, resource.*.*);
}

fn nif_mesh_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Mesh.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Mesh.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

//////////////
//  Shader  //
//////////////

fn nif_shader_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Shader.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Shader.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Shader.Resource.release(resource);

    return core.Shader.Resource.make(env, resource);
}

fn nif_shader_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Shader.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Shader.make(env, resource.*.*);
}

fn nif_shader_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Shader.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Shader.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

///////////////////
//  MaterialMap  //
///////////////////

fn nif_material_map_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.MaterialMap.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.MaterialMap.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.MaterialMap.Resource.release(resource);

    return core.MaterialMap.Resource.make(env, resource);
}

fn nif_material_map_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.MaterialMap.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.MaterialMap.make(env, resource.*.*);
}

fn nif_material_map_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.MaterialMap.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.MaterialMap.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////////
//  Material  //
////////////////

fn nif_material_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Material.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Material.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Material.Resource.release(resource);

    return core.Material.Resource.make(env, resource);
}

fn nif_material_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Material.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Material.make(env, resource.*.*);
}

fn nif_material_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Material.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Material.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////////
//  Transform  //
/////////////////

fn nif_transform_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Transform.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Transform.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Transform.Resource.release(resource);

    return core.Transform.Resource.make(env, resource);
}

fn nif_transform_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Transform.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Transform.make(env, resource.*.*);
}

fn nif_transform_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Transform.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Transform.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////////
//  BoneInfo  //
////////////////

fn nif_bone_info_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.BoneInfo.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.BoneInfo.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.BoneInfo.Resource.release(resource);

    return core.BoneInfo.Resource.make(env, resource);
}

fn nif_bone_info_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.BoneInfo.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.BoneInfo.make(env, resource.*.*);
}

fn nif_bone_info_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.BoneInfo.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.BoneInfo.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////
//  Model  //
/////////////

fn nif_model_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Model.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Model.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Model.Resource.release(resource);

    return core.Model.Resource.make(env, resource);
}

fn nif_model_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Model.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Model.make(env, resource.*.*);
}

fn nif_model_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Model.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Model.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

//////////////////////
//  ModelAnimation  //
//////////////////////

fn nif_model_animation_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.ModelAnimation.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.ModelAnimation.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.ModelAnimation.Resource.release(resource);

    return core.ModelAnimation.Resource.make(env, resource);
}

fn nif_model_animation_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.ModelAnimation.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.ModelAnimation.make(env, resource.*.*);
}

fn nif_model_animation_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.ModelAnimation.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.ModelAnimation.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

///////////
//  Ray  //
///////////

fn nif_ray_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Ray.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Ray.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Ray.Resource.release(resource);

    return core.Ray.Resource.make(env, resource);
}

fn nif_ray_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Ray.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Ray.make(env, resource.*.*);
}

fn nif_ray_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Ray.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Ray.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////////////
//  RayCollision  //
////////////////////

fn nif_ray_collision_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.RayCollision.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.RayCollision.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.RayCollision.Resource.release(resource);

    return core.RayCollision.Resource.make(env, resource);
}

fn nif_ray_collision_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.RayCollision.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.RayCollision.make(env, resource.*.*);
}

fn nif_ray_collision_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.RayCollision.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.RayCollision.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

///////////////////
//  BoundingBox  //
///////////////////

fn nif_bounding_box_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.BoundingBox.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.BoundingBox.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.BoundingBox.Resource.release(resource);

    return core.BoundingBox.Resource.make(env, resource);
}

fn nif_bounding_box_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.BoundingBox.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.BoundingBox.make(env, resource.*.*);
}

fn nif_bounding_box_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.BoundingBox.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.BoundingBox.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////
//  Wave  //
////////////

fn nif_wave_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Wave.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Wave.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Wave.Resource.release(resource);

    return core.Wave.Resource.make(env, resource);
}

fn nif_wave_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Wave.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Wave.make(env, resource.*.*);
}

fn nif_wave_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Wave.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Wave.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

///////////////////
//  AudioStream  //
///////////////////

fn nif_audio_stream_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.AudioStream.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.AudioStream.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.AudioStream.Resource.release(resource);

    return core.AudioStream.Resource.make(env, resource);
}

fn nif_audio_stream_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.AudioStream.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.AudioStream.make(env, resource.*.*);
}

fn nif_audio_stream_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.AudioStream.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.AudioStream.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////
//  Sound  //
/////////////

fn nif_sound_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Sound.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Sound.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Sound.Resource.release(resource);

    return core.Sound.Resource.make(env, resource);
}

fn nif_sound_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Sound.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Sound.make(env, resource.*.*);
}

fn nif_sound_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Sound.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Sound.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

/////////////
//  Music  //
/////////////

fn nif_music_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.Music.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.Music.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.Music.Resource.release(resource);

    return core.Music.Resource.make(env, resource);
}

fn nif_music_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Music.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.Music.make(env, resource.*.*);
}

fn nif_music_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.Music.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.Music.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////////////
//  VrDeviceInfo  //
////////////////////

fn nif_vr_device_info_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.VrDeviceInfo.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.VrDeviceInfo.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.VrDeviceInfo.Resource.release(resource);

    return core.VrDeviceInfo.Resource.make(env, resource);
}

fn nif_vr_device_info_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.VrDeviceInfo.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.VrDeviceInfo.make(env, resource.*.*);
}

fn nif_vr_device_info_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.VrDeviceInfo.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.VrDeviceInfo.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

//////////////////////
//  VrStereoConfig  //
//////////////////////

fn nif_vr_stereo_config_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.VrStereoConfig.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.VrStereoConfig.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.VrStereoConfig.Resource.release(resource);

    return core.VrStereoConfig.Resource.make(env, resource);
}

fn nif_vr_stereo_config_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.VrStereoConfig.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.VrStereoConfig.make(env, resource.*.*);
}

fn nif_vr_stereo_config_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.VrStereoConfig.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.VrStereoConfig.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

////////////////////
//  FilePathList  //
////////////////////

fn nif_file_path_list_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.FilePathList.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.FilePathList.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.FilePathList.Resource.release(resource);

    return core.FilePathList.Resource.make(env, resource);
}

fn nif_file_path_list_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.FilePathList.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.FilePathList.make(env, resource.*.*);
}

fn nif_file_path_list_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.FilePathList.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.FilePathList.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

///////////////////////
//  AutomationEvent  //
///////////////////////

fn nif_automation_event_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.AutomationEvent.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.AutomationEvent.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.AutomationEvent.Resource.release(resource);

    return core.AutomationEvent.Resource.make(env, resource);
}

fn nif_automation_event_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.AutomationEvent.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.AutomationEvent.make(env, resource.*.*);
}

fn nif_automation_event_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.AutomationEvent.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.AutomationEvent.Resource.free(resource);

    return core.Atom.make(env, "ok");
}

///////////////////////////
//  AutomationEventList  //
///////////////////////////

fn nif_automation_event_list_to_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const value = core.AutomationEventList.get(env, argv[0]) catch {
        return error.invalid_argument_value;
    };

    const resource = core.AutomationEventList.Resource.create(value) catch {
        return error.invalid_argument_value;
    };
    defer core.AutomationEventList.Resource.release(resource);

    return core.AutomationEventList.Resource.make(env, resource);
}

fn nif_automation_event_list_from_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.AutomationEventList.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    return core.AutomationEventList.make(env, resource.*.*);
}

fn nif_automation_event_list_free_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const resource = core.AutomationEventList.Resource.get(env, argv[0]) catch {
        return error.invalid_argument_resource;
    };

    core.AutomationEventList.Resource.free(resource);

    return core.Atom.make(env, "ok");
}
