const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // AutomationEvent
    .{ .name = "get_automation_event_max_params", .arity = 0, .fptr = core.nif_wrapper(nif_get_automation_event_max_params), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // AutomationEventList
    .{ .name = "get_automation_event_list_max_automation_events", .arity = 0, .fptr = core.nif_wrapper(nif_get_automation_event_list_max_automation_events), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // BoneInfo
    .{ .name = "get_bone_info_max_name", .arity = 0, .fptr = core.nif_wrapper(nif_get_bone_info_max_name), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // FilePathList
    .{ .name = "get_file_path_list_max_filepath_capacity", .arity = 0, .fptr = core.nif_wrapper(nif_get_file_path_list_max_filepath_capacity), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_file_path_list_max_filepath_length", .arity = 0, .fptr = core.nif_wrapper(nif_get_file_path_list_max_filepath_length), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Gui
    .{ .name = "get_gui_icon_max_icons", .arity = 0, .fptr = core.nif_wrapper(nif_get_gui_icon_max_icons), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_gui_icon_size", .arity = 0, .fptr = core.nif_wrapper(nif_get_gui_icon_size), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_gui_icon_data_elements", .arity = 0, .fptr = core.nif_wrapper(nif_get_gui_icon_data_elements), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_gui_valuebox_max_chars", .arity = 0, .fptr = core.nif_wrapper(nif_get_gui_valuebox_max_chars), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Material
    .{ .name = "get_material_max_maps", .arity = 0, .fptr = core.nif_wrapper(nif_get_material_max_maps), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_material_max_params", .arity = 0, .fptr = core.nif_wrapper(nif_get_material_max_params), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Mesh
    .{ .name = "get_mesh_max_vertex_buffers", .arity = 0, .fptr = core.nif_wrapper(nif_get_mesh_max_vertex_buffers), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // ModelAnimation
    .{ .name = "get_model_animation_max_name", .arity = 0, .fptr = core.nif_wrapper(nif_get_model_animation_max_name), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Shader
    .{ .name = "get_shader_max_locations", .arity = 0, .fptr = core.nif_wrapper(nif_get_shader_max_locations), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // VrDeviceInfo
    .{ .name = "get_vr_device_info_max_lens_distortion_values", .arity = 0, .fptr = core.nif_wrapper(nif_get_vr_device_info_max_lens_distortion_values), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_vr_device_info_max_chroma_ab_correction", .arity = 0, .fptr = core.nif_wrapper(nif_get_vr_device_info_max_chroma_ab_correction), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // VrStereoConfig
    .{ .name = "get_vr_stereo_config_max_projection", .arity = 0, .fptr = core.nif_wrapper(nif_get_vr_stereo_config_max_projection), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_vr_stereo_config_max_view_offset", .arity = 0, .fptr = core.nif_wrapper(nif_get_vr_stereo_config_max_view_offset), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_vr_stereo_config_max_left_lens_center", .arity = 0, .fptr = core.nif_wrapper(nif_get_vr_stereo_config_max_left_lens_center), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_vr_stereo_config_max_right_lens_center", .arity = 0, .fptr = core.nif_wrapper(nif_get_vr_stereo_config_max_right_lens_center), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_vr_stereo_config_max_left_screen_center", .arity = 0, .fptr = core.nif_wrapper(nif_get_vr_stereo_config_max_left_screen_center), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_vr_stereo_config_max_right_screen_center", .arity = 0, .fptr = core.nif_wrapper(nif_get_vr_stereo_config_max_right_screen_center), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_vr_stereo_config_max_scale", .arity = 0, .fptr = core.nif_wrapper(nif_get_vr_stereo_config_max_scale), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_vr_stereo_config_max_scale_in", .arity = 0, .fptr = core.nif_wrapper(nif_get_vr_stereo_config_max_scale_in), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

///////////////////////
//  AutomationEvent  //
///////////////////////

/// Get automation event max params for AutomationEvent.params
fn nif_get_automation_event_max_params(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.AutomationEvent.MAX_PARAMS));
}

///////////////////////////
//  AutomationEventList  //
///////////////////////////

/// Get automation event list max automation events for AutomationEventList.events
fn nif_get_automation_event_list_max_automation_events(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.AutomationEventList.MAX_AUTOMATION_EVENTS));
}

////////////////
//  BoneInfo  //
////////////////

/// Get bone info max name for BoneInfo.name
fn nif_get_bone_info_max_name(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.BoneInfo.MAX_NAME - 1));
}

////////////////////
//  FilePathList  //
////////////////////

/// Get file path list max filepath capacity for FilePathList.paths
fn nif_get_file_path_list_max_filepath_capacity(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.FilePathList.MAX_FILEPATH_CAPACITY));
}

/// Get file path list max filepath length for FilePathList.paths
fn nif_get_file_path_list_max_filepath_length(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.FilePathList.MAX_FILEPATH_LENGTH - 1));
}

///////////
//  Gui  //
///////////

/// Maximum number of icons
fn nif_get_gui_icon_max_icons(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(rl.RAYGUI_ICON_MAX_ICONS));
}

/// Size of icons in pixels (squared)
fn nif_get_gui_icon_size(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(rl.RAYGUI_ICON_SIZE));
}

/// Icons data is defined by bit array (every bit represents one pixel)
/// Those arrays are stored as unsigned int data arrays, so,
/// every array element defines 32 pixels (bits) of information
/// One icon is defined by 8 int, (8 int * 32 bit = 256 bit = 16*16 pixels)
/// NOTE: Number of elemens depend on RAYGUI_ICON_SIZE (by default 16x16 pixels)
fn nif_get_gui_icon_data_elements(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(rl.RAYGUI_ICON_DATA_ELEMENTS));
}

/// Value box max chars
fn nif_get_gui_valuebox_max_chars(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(rl.RAYGUI_VALUEBOX_MAX_CHARS));
}

////////////////
//  Material  //
////////////////

/// Get material max maps for Material.maps
///
/// config.h
/// MAX_MATERIAL_MAPS
fn nif_get_material_max_maps(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.Material.MAX_MAPS));
}

/// Get material max params for Material.params
fn nif_get_material_max_params(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.Material.MAX_PARAMS));
}

////////////
//  Mesh  //
////////////

/// Get mesh max vertex buffers for Mesh.vbo_id
///
/// config.h
/// MAX_MESH_VERTEX_BUFFERS
fn nif_get_mesh_max_vertex_buffers(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.Mesh.MAX_VERTEX_BUFFERS));
}

//////////////////////
//  ModelAnimation  //
//////////////////////

/// Get model animation max name for ModelAnimation.name
fn nif_get_model_animation_max_name(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.ModelAnimation.MAX_NAME - 1));
}

//////////////
//  Shader  //
//////////////

/// Get shader max locations for Shader.locs
///
/// config.h
/// RL_MAX_SHADER_LOCATIONS
fn nif_get_shader_max_locations(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.Shader.MAX_LOCATIONS));
}

////////////////////
//  VrDeviceInfo  //
////////////////////

/// Get vr device info max lens distortion values for VrDeviceInfo.lensDistortionValues
fn nif_get_vr_device_info_max_lens_distortion_values(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrDeviceInfo.MAX_LENS_DISTORTION_VALUES));
}

/// Get vr device info max chroma ab correction for VrDeviceInfo.chromaAbCorrection
fn nif_get_vr_device_info_max_chroma_ab_correction(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrDeviceInfo.MAX_CHROMA_AB_CORRECTION));
}

//////////////////////
//  VrStereoConfig  //
//////////////////////

/// Get vr stereo config max projection for VrStereoConfig.projection
fn nif_get_vr_stereo_config_max_projection(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_PROJECTION));
}

/// Get vr stereo config max view offset for VrStereoConfig.viewOffset
fn nif_get_vr_stereo_config_max_view_offset(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_VIEW_OFFSET));
}

/// Get vr stereo config max left lens center for VrStereoConfig.leftLensCenter
fn nif_get_vr_stereo_config_max_left_lens_center(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_LEFT_LENS_CENTER));
}

/// Get vr stereo config max right lens center for VrStereoConfig.rightLensCenter
fn nif_get_vr_stereo_config_max_right_lens_center(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_RIGHT_LENS_CENTER));
}

/// Get vr stereo config max left screen center for VrStereoConfig.leftScreenCenter
fn nif_get_vr_stereo_config_max_left_screen_center(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_LEFT_SCREEN_CENTER));
}

/// Get vr stereo config max right screen center for VrStereoConfig.rightScreenCenter
fn nif_get_vr_stereo_config_max_right_screen_center(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_RIGHT_SCREEN_CENTER));
}

/// Get vr stereo config max scale for VrStereoConfig.scale
fn nif_get_vr_stereo_config_max_scale(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_SCALE));
}

/// Get vr stereo config max scale in for VrStereoConfig.scaleIn
fn nif_get_vr_stereo_config_max_scale_in(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_SCALE_IN));
}
