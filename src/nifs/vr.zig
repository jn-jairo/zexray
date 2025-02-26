const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // VrDeviceInfo
    .{ .name = "vr_device_info_get_max_lens_distortion_values", .arity = 0, .fptr = nif_vr_device_info_get_max_lens_distortion_values, .flags = 0 },
    .{ .name = "vr_device_info_get_max_chroma_ab_correction", .arity = 0, .fptr = nif_vr_device_info_get_max_chroma_ab_correction, .flags = 0 },

    // VrStereoConfig
    .{ .name = "vr_stereo_config_get_max_projection", .arity = 0, .fptr = nif_vr_stereo_config_get_max_projection, .flags = 0 },
    .{ .name = "vr_stereo_config_get_max_view_offset", .arity = 0, .fptr = nif_vr_stereo_config_get_max_view_offset, .flags = 0 },
    .{ .name = "vr_stereo_config_get_max_left_lens_center", .arity = 0, .fptr = nif_vr_stereo_config_get_max_left_lens_center, .flags = 0 },
    .{ .name = "vr_stereo_config_get_max_right_lens_center", .arity = 0, .fptr = nif_vr_stereo_config_get_max_right_lens_center, .flags = 0 },
    .{ .name = "vr_stereo_config_get_max_left_screen_center", .arity = 0, .fptr = nif_vr_stereo_config_get_max_left_screen_center, .flags = 0 },
    .{ .name = "vr_stereo_config_get_max_right_screen_center", .arity = 0, .fptr = nif_vr_stereo_config_get_max_right_screen_center, .flags = 0 },
    .{ .name = "vr_stereo_config_get_max_scale", .arity = 0, .fptr = nif_vr_stereo_config_get_max_scale, .flags = 0 },
    .{ .name = "vr_stereo_config_get_max_scale_in", .arity = 0, .fptr = nif_vr_stereo_config_get_max_scale_in, .flags = 0 },
};

////////////////////
//  VrDeviceInfo  //
////////////////////

/// Get vr device info max lens distortion values for VrDeviceInfo.lensDistortionValues
fn nif_vr_device_info_get_max_lens_distortion_values(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrDeviceInfo.MAX_LENS_DISTORTION_VALUES));
}

/// Get vr device info max chroma ab correction for VrDeviceInfo.chromaAbCorrection
fn nif_vr_device_info_get_max_chroma_ab_correction(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrDeviceInfo.MAX_CHROMA_AB_CORRECTION));
}

//////////////////////
//  VrStereoConfig  //
//////////////////////

/// Get vr stereo config max projection for VrStereoConfig.projection
fn nif_vr_stereo_config_get_max_projection(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_PROJECTION));
}

/// Get vr stereo config max view offset for VrStereoConfig.viewOffset
fn nif_vr_stereo_config_get_max_view_offset(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_VIEW_OFFSET));
}

/// Get vr stereo config max left lens center for VrStereoConfig.leftLensCenter
fn nif_vr_stereo_config_get_max_left_lens_center(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_LEFT_LENS_CENTER));
}

/// Get vr stereo config max right lens center for VrStereoConfig.rightLensCenter
fn nif_vr_stereo_config_get_max_right_lens_center(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_RIGHT_LENS_CENTER));
}

/// Get vr stereo config max left screen center for VrStereoConfig.leftScreenCenter
fn nif_vr_stereo_config_get_max_left_screen_center(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_LEFT_SCREEN_CENTER));
}

/// Get vr stereo config max right screen center for VrStereoConfig.rightScreenCenter
fn nif_vr_stereo_config_get_max_right_screen_center(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_RIGHT_SCREEN_CENTER));
}

/// Get vr stereo config max scale for VrStereoConfig.scale
fn nif_vr_stereo_config_get_max_scale(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_SCALE));
}

/// Get vr stereo config max scale in for VrStereoConfig.scaleIn
fn nif_vr_stereo_config_get_max_scale_in(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_SCALE_IN));
}
