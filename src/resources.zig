const std = @import("std");
const e = @import("./erl_nif.zig");

const core = @import("./core.zig");

pub const ResourceType = struct {
    vector2: *e.ErlNifResourceType = undefined,
    ivector2: *e.ErlNifResourceType = undefined,
    uivector2: *e.ErlNifResourceType = undefined,
    vector3: *e.ErlNifResourceType = undefined,
    ivector3: *e.ErlNifResourceType = undefined,
    uivector3: *e.ErlNifResourceType = undefined,
    vector4: *e.ErlNifResourceType = undefined,
    ivector4: *e.ErlNifResourceType = undefined,
    uivector4: *e.ErlNifResourceType = undefined,
    quaternion: *e.ErlNifResourceType = undefined,
    matrix: *e.ErlNifResourceType = undefined,
    color: *e.ErlNifResourceType = undefined,
    rectangle: *e.ErlNifResourceType = undefined,
    image: *e.ErlNifResourceType = undefined,
    texture: *e.ErlNifResourceType = undefined,
    texture_2d: *e.ErlNifResourceType = undefined,
    texture_cubemap: *e.ErlNifResourceType = undefined,
    render_texture: *e.ErlNifResourceType = undefined,
    render_texture_2d: *e.ErlNifResourceType = undefined,
    n_patch_info: *e.ErlNifResourceType = undefined,
    glyph_info: *e.ErlNifResourceType = undefined,
    font: *e.ErlNifResourceType = undefined,
    camera_3d: *e.ErlNifResourceType = undefined,
    camera: *e.ErlNifResourceType = undefined,
    camera_2d: *e.ErlNifResourceType = undefined,
    mesh: *e.ErlNifResourceType = undefined,
    shader: *e.ErlNifResourceType = undefined,
    material_map: *e.ErlNifResourceType = undefined,
    material: *e.ErlNifResourceType = undefined,
    transform: *e.ErlNifResourceType = undefined,
    bone_info: *e.ErlNifResourceType = undefined,
    model: *e.ErlNifResourceType = undefined,
    model_animation: *e.ErlNifResourceType = undefined,
    ray: *e.ErlNifResourceType = undefined,
    ray_collision: *e.ErlNifResourceType = undefined,
    bounding_box: *e.ErlNifResourceType = undefined,
    wave: *e.ErlNifResourceType = undefined,
    audio_buffer: *e.ErlNifResourceType = undefined,
    audio_processor: *e.ErlNifResourceType = undefined,
    audio_stream: *e.ErlNifResourceType = undefined,
    sound: *e.ErlNifResourceType = undefined,
    sound_alias: *e.ErlNifResourceType = undefined,
    music_context_data: *e.ErlNifResourceType = undefined,
    music: *e.ErlNifResourceType = undefined,
    vr_device_info: *e.ErlNifResourceType = undefined,
    vr_stereo_config: *e.ErlNifResourceType = undefined,
    file_path_list: *e.ErlNifResourceType = undefined,
    automation_event: *e.ErlNifResourceType = undefined,
    automation_event_list: *e.ErlNifResourceType = undefined,

    pub const allocator: std.mem.Allocator = e.allocator;

    pub fn vector2_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Vector2.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn ivector2_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.IVector2.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn uivector2_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.UIVector2.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn vector3_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Vector3.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn ivector3_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.IVector3.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn uivector3_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.UIVector3.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn vector4_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Vector4.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn ivector4_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.IVector4.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn uivector4_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.UIVector4.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn quaternion_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Quaternion.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn matrix_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Matrix.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn color_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Color.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn rectangle_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Rectangle.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn image_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Image.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn texture_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Texture.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn texture_2d_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Texture2D.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn texture_cubemap_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.TextureCubemap.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn render_texture_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.RenderTexture.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn render_texture_2d_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.RenderTexture2D.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn n_patch_info_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.NPatchInfo.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn glyph_info_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.GlyphInfo.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn font_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Font.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn camera_3d_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Camera3D.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn camera_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Camera.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn camera_2d_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Camera2D.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn mesh_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Mesh.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn shader_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Shader.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn material_map_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.MaterialMap.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn material_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Material.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn transform_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Transform.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn bone_info_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.BoneInfo.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn model_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Model.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn model_animation_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.ModelAnimation.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn ray_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Ray.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn ray_collision_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.RayCollision.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn bounding_box_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.BoundingBox.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn wave_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Wave.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn audio_buffer_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.AudioBuffer.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn audio_processor_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.AudioProcessor.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn audio_stream_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.AudioStream.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn sound_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Sound.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn sound_alias_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.SoundAlias.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn music_context_data_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.MusicContextData.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn music_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.Music.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn vr_device_info_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.VrDeviceInfo.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn vr_stereo_config_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.VrStereoConfig.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn file_path_list_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.FilePathList.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn automation_event_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.AutomationEvent.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }

    pub fn automation_event_list_dtor(_: ?*e.ErlNifEnv, obj: ?*anyopaque) callconv(.C) void {
        core.AutomationEventList.Resource.destroy(@ptrCast(@alignCast(obj.?)));
    }
};

pub var resource_type = ResourceType{};

pub const ResourceTypeKey = enum {
    vector2,
    ivector2,
    uivector2,
    vector3,
    ivector3,
    uivector3,
    vector4,
    ivector4,
    uivector4,
    quaternion,
    matrix,
    color,
    rectangle,
    image,
    texture,
    texture_2d,
    texture_cubemap,
    render_texture,
    render_texture_2d,
    n_patch_info,
    glyph_info,
    font,
    camera_3d,
    camera,
    camera_2d,
    mesh,
    shader,
    material_map,
    material,
    transform,
    bone_info,
    model,
    model_animation,
    ray,
    ray_collision,
    bounding_box,
    wave,
    audio_buffer,
    audio_processor,
    audio_stream,
    sound,
    sound_alias,
    music_context_data,
    music,
    vr_device_info,
    vr_stereo_config,
    file_path_list,
    automation_event,
    automation_event_list,
};

pub fn get_resource_type_from_key(key: ResourceTypeKey) *e.ErlNifResourceType {
    return switch (key) {
        .vector2 => resource_type.vector2,
        .ivector2 => resource_type.ivector2,
        .uivector2 => resource_type.uivector2,
        .vector3 => resource_type.vector3,
        .ivector3 => resource_type.ivector3,
        .uivector3 => resource_type.uivector3,
        .vector4 => resource_type.vector4,
        .ivector4 => resource_type.ivector4,
        .uivector4 => resource_type.uivector4,
        .quaternion => resource_type.quaternion,
        .matrix => resource_type.matrix,
        .color => resource_type.color,
        .rectangle => resource_type.rectangle,
        .image => resource_type.image,
        .texture => resource_type.texture,
        .texture_2d => resource_type.texture_2d,
        .texture_cubemap => resource_type.texture_cubemap,
        .render_texture => resource_type.render_texture,
        .render_texture_2d => resource_type.render_texture_2d,
        .n_patch_info => resource_type.n_patch_info,
        .glyph_info => resource_type.glyph_info,
        .font => resource_type.font,
        .camera_3d => resource_type.camera_3d,
        .camera => resource_type.camera,
        .camera_2d => resource_type.camera_2d,
        .mesh => resource_type.mesh,
        .shader => resource_type.shader,
        .material_map => resource_type.material_map,
        .material => resource_type.material,
        .transform => resource_type.transform,
        .bone_info => resource_type.bone_info,
        .model => resource_type.model,
        .model_animation => resource_type.model_animation,
        .ray => resource_type.ray,
        .ray_collision => resource_type.ray_collision,
        .bounding_box => resource_type.bounding_box,
        .wave => resource_type.wave,
        .audio_buffer => resource_type.audio_buffer,
        .audio_processor => resource_type.audio_processor,
        .audio_stream => resource_type.audio_stream,
        .sound => resource_type.sound,
        .sound_alias => resource_type.sound_alias,
        .music_context_data => resource_type.music_context_data,
        .music => resource_type.music,
        .vr_device_info => resource_type.vr_device_info,
        .vr_stereo_config => resource_type.vr_stereo_config,
        .file_path_list => resource_type.file_path_list,
        .automation_event => resource_type.automation_event,
        .automation_event_list => resource_type.automation_event_list,
    };
}

pub fn load_resources(env: ?*e.ErlNifEnv) bool {
    const flags = e.ERL_NIF_RT_CREATE | e.ERL_NIF_RT_TAKEOVER;

    resource_type.vector2 = e.enif_open_resource_type(env, null, "Zexray.Resource.Vector2", &ResourceType.vector2_dtor, flags, null) orelse return false;
    resource_type.ivector2 = e.enif_open_resource_type(env, null, "Zexray.Resource.IVector2", &ResourceType.ivector2_dtor, flags, null) orelse return false;
    resource_type.uivector2 = e.enif_open_resource_type(env, null, "Zexray.Resource.UIVector2", &ResourceType.uivector2_dtor, flags, null) orelse return false;
    resource_type.vector3 = e.enif_open_resource_type(env, null, "Zexray.Resource.Vector3", &ResourceType.vector3_dtor, flags, null) orelse return false;
    resource_type.ivector3 = e.enif_open_resource_type(env, null, "Zexray.Resource.IVector3", &ResourceType.ivector3_dtor, flags, null) orelse return false;
    resource_type.uivector3 = e.enif_open_resource_type(env, null, "Zexray.Resource.UIVector3", &ResourceType.uivector3_dtor, flags, null) orelse return false;
    resource_type.vector4 = e.enif_open_resource_type(env, null, "Zexray.Resource.Vector4", &ResourceType.vector4_dtor, flags, null) orelse return false;
    resource_type.ivector4 = e.enif_open_resource_type(env, null, "Zexray.Resource.IVector4", &ResourceType.ivector4_dtor, flags, null) orelse return false;
    resource_type.uivector4 = e.enif_open_resource_type(env, null, "Zexray.Resource.UIVector4", &ResourceType.uivector4_dtor, flags, null) orelse return false;
    resource_type.quaternion = e.enif_open_resource_type(env, null, "Zexray.Resource.Quaternion", &ResourceType.quaternion_dtor, flags, null) orelse return false;
    resource_type.matrix = e.enif_open_resource_type(env, null, "Zexray.Resource.Matrix", &ResourceType.matrix_dtor, flags, null) orelse return false;
    resource_type.color = e.enif_open_resource_type(env, null, "Zexray.Resource.Color", &ResourceType.color_dtor, flags, null) orelse return false;
    resource_type.rectangle = e.enif_open_resource_type(env, null, "Zexray.Resource.Rectangle", &ResourceType.rectangle_dtor, flags, null) orelse return false;
    resource_type.image = e.enif_open_resource_type(env, null, "Zexray.Resource.Image", &ResourceType.image_dtor, flags, null) orelse return false;
    resource_type.texture = e.enif_open_resource_type(env, null, "Zexray.Resource.Texture", &ResourceType.texture_dtor, flags, null) orelse return false;
    resource_type.texture_2d = e.enif_open_resource_type(env, null, "Zexray.Resource.Texture2D", &ResourceType.texture_2d_dtor, flags, null) orelse return false;
    resource_type.texture_cubemap = e.enif_open_resource_type(env, null, "Zexray.Resource.TextureCubemap", &ResourceType.texture_cubemap_dtor, flags, null) orelse return false;
    resource_type.render_texture = e.enif_open_resource_type(env, null, "Zexray.Resource.RenderTexture", &ResourceType.render_texture_dtor, flags, null) orelse return false;
    resource_type.render_texture_2d = e.enif_open_resource_type(env, null, "Zexray.Resource.RenderTexture2D", &ResourceType.render_texture_2d_dtor, flags, null) orelse return false;
    resource_type.n_patch_info = e.enif_open_resource_type(env, null, "Zexray.Resource.NPatchInfo", &ResourceType.n_patch_info_dtor, flags, null) orelse return false;
    resource_type.glyph_info = e.enif_open_resource_type(env, null, "Zexray.Resource.GlyphInfo", &ResourceType.glyph_info_dtor, flags, null) orelse return false;
    resource_type.font = e.enif_open_resource_type(env, null, "Zexray.Resource.Font", &ResourceType.font_dtor, flags, null) orelse return false;
    resource_type.camera_3d = e.enif_open_resource_type(env, null, "Zexray.Resource.Camera3D", &ResourceType.camera_3d_dtor, flags, null) orelse return false;
    resource_type.camera = e.enif_open_resource_type(env, null, "Zexray.Resource.Camera", &ResourceType.camera_dtor, flags, null) orelse return false;
    resource_type.camera_2d = e.enif_open_resource_type(env, null, "Zexray.Resource.Camera2D", &ResourceType.camera_2d_dtor, flags, null) orelse return false;
    resource_type.mesh = e.enif_open_resource_type(env, null, "Zexray.Resource.Mesh", &ResourceType.mesh_dtor, flags, null) orelse return false;
    resource_type.shader = e.enif_open_resource_type(env, null, "Zexray.Resource.Shader", &ResourceType.shader_dtor, flags, null) orelse return false;
    resource_type.material_map = e.enif_open_resource_type(env, null, "Zexray.Resource.MaterialMap", &ResourceType.material_map_dtor, flags, null) orelse return false;
    resource_type.material = e.enif_open_resource_type(env, null, "Zexray.Resource.Material", &ResourceType.material_dtor, flags, null) orelse return false;
    resource_type.transform = e.enif_open_resource_type(env, null, "Zexray.Resource.Transform", &ResourceType.transform_dtor, flags, null) orelse return false;
    resource_type.bone_info = e.enif_open_resource_type(env, null, "Zexray.Resource.BoneInfo", &ResourceType.bone_info_dtor, flags, null) orelse return false;
    resource_type.model = e.enif_open_resource_type(env, null, "Zexray.Resource.Model", &ResourceType.model_dtor, flags, null) orelse return false;
    resource_type.model_animation = e.enif_open_resource_type(env, null, "Zexray.Resource.ModelAnimation", &ResourceType.model_animation_dtor, flags, null) orelse return false;
    resource_type.ray = e.enif_open_resource_type(env, null, "Zexray.Resource.Ray", &ResourceType.ray_dtor, flags, null) orelse return false;
    resource_type.ray_collision = e.enif_open_resource_type(env, null, "Zexray.Resource.RayCollision", &ResourceType.ray_collision_dtor, flags, null) orelse return false;
    resource_type.bounding_box = e.enif_open_resource_type(env, null, "Zexray.Resource.BoundingBox", &ResourceType.bounding_box_dtor, flags, null) orelse return false;
    resource_type.wave = e.enif_open_resource_type(env, null, "Zexray.Resource.Wave", &ResourceType.wave_dtor, flags, null) orelse return false;
    resource_type.audio_buffer = e.enif_open_resource_type(env, null, "Zexray.Resource.AudioBuffer", &ResourceType.audio_buffer_dtor, flags, null) orelse return false;
    resource_type.audio_processor = e.enif_open_resource_type(env, null, "Zexray.Resource.AudioProcessor", &ResourceType.audio_processor_dtor, flags, null) orelse return false;
    resource_type.audio_stream = e.enif_open_resource_type(env, null, "Zexray.Resource.AudioStream", &ResourceType.audio_stream_dtor, flags, null) orelse return false;
    resource_type.sound = e.enif_open_resource_type(env, null, "Zexray.Resource.Sound", &ResourceType.sound_dtor, flags, null) orelse return false;
    resource_type.sound_alias = e.enif_open_resource_type(env, null, "Zexray.Resource.SoundAlias", &ResourceType.sound_alias_dtor, flags, null) orelse return false;
    resource_type.music_context_data = e.enif_open_resource_type(env, null, "Zexray.Resource.MusicContextData", &ResourceType.music_context_data_dtor, flags, null) orelse return false;
    resource_type.music = e.enif_open_resource_type(env, null, "Zexray.Resource.Music", &ResourceType.music_dtor, flags, null) orelse return false;
    resource_type.vr_device_info = e.enif_open_resource_type(env, null, "Zexray.Resource.VrDeviceInfo", &ResourceType.vr_device_info_dtor, flags, null) orelse return false;
    resource_type.vr_stereo_config = e.enif_open_resource_type(env, null, "Zexray.Resource.VrStereoConfig", &ResourceType.vr_stereo_config_dtor, flags, null) orelse return false;
    resource_type.file_path_list = e.enif_open_resource_type(env, null, "Zexray.Resource.FilePathList", &ResourceType.file_path_list_dtor, flags, null) orelse return false;
    resource_type.automation_event = e.enif_open_resource_type(env, null, "Zexray.Resource.AutomationEvent", &ResourceType.automation_event_dtor, flags, null) orelse return false;
    resource_type.automation_event_list = e.enif_open_resource_type(env, null, "Zexray.Resource.AutomationEventList", &ResourceType.automation_event_list_dtor, flags, null) orelse return false;

    return true;
}
