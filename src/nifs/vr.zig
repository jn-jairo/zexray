const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // VrDeviceInfo
    .{ .name = "vr_device_info_get_max_lens_distortion_values", .arity = 0, .fptr = core.nif_wrapper(nif_vr_device_info_get_max_lens_distortion_values), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "vr_device_info_get_max_chroma_ab_correction", .arity = 0, .fptr = core.nif_wrapper(nif_vr_device_info_get_max_chroma_ab_correction), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // VrStereoConfig
    .{ .name = "vr_stereo_config_get_max_projection", .arity = 0, .fptr = core.nif_wrapper(nif_vr_stereo_config_get_max_projection), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "vr_stereo_config_get_max_view_offset", .arity = 0, .fptr = core.nif_wrapper(nif_vr_stereo_config_get_max_view_offset), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "vr_stereo_config_get_max_left_lens_center", .arity = 0, .fptr = core.nif_wrapper(nif_vr_stereo_config_get_max_left_lens_center), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "vr_stereo_config_get_max_right_lens_center", .arity = 0, .fptr = core.nif_wrapper(nif_vr_stereo_config_get_max_right_lens_center), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "vr_stereo_config_get_max_left_screen_center", .arity = 0, .fptr = core.nif_wrapper(nif_vr_stereo_config_get_max_left_screen_center), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "vr_stereo_config_get_max_right_screen_center", .arity = 0, .fptr = core.nif_wrapper(nif_vr_stereo_config_get_max_right_screen_center), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "vr_stereo_config_get_max_scale", .arity = 0, .fptr = core.nif_wrapper(nif_vr_stereo_config_get_max_scale), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "vr_stereo_config_get_max_scale_in", .arity = 0, .fptr = core.nif_wrapper(nif_vr_stereo_config_get_max_scale_in), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_vr_stereo_config", .arity = 1, .fptr = core.nif_wrapper(nif_load_vr_stereo_config), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_vr_stereo_config", .arity = 2, .fptr = core.nif_wrapper(nif_load_vr_stereo_config), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

////////////////////
//  VrDeviceInfo  //
////////////////////

/// Get vr device info max lens distortion values for VrDeviceInfo.lensDistortionValues
fn nif_vr_device_info_get_max_lens_distortion_values(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrDeviceInfo.MAX_LENS_DISTORTION_VALUES));
}

/// Get vr device info max chroma ab correction for VrDeviceInfo.chromaAbCorrection
fn nif_vr_device_info_get_max_chroma_ab_correction(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrDeviceInfo.MAX_CHROMA_AB_CORRECTION));
}

//////////////////////
//  VrStereoConfig  //
//////////////////////

/// Get vr stereo config max projection for VrStereoConfig.projection
fn nif_vr_stereo_config_get_max_projection(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_PROJECTION));
}

/// Get vr stereo config max view offset for VrStereoConfig.viewOffset
fn nif_vr_stereo_config_get_max_view_offset(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_VIEW_OFFSET));
}

/// Get vr stereo config max left lens center for VrStereoConfig.leftLensCenter
fn nif_vr_stereo_config_get_max_left_lens_center(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_LEFT_LENS_CENTER));
}

/// Get vr stereo config max right lens center for VrStereoConfig.rightLensCenter
fn nif_vr_stereo_config_get_max_right_lens_center(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_RIGHT_LENS_CENTER));
}

/// Get vr stereo config max left screen center for VrStereoConfig.leftScreenCenter
fn nif_vr_stereo_config_get_max_left_screen_center(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_LEFT_SCREEN_CENTER));
}

/// Get vr stereo config max right screen center for VrStereoConfig.rightScreenCenter
fn nif_vr_stereo_config_get_max_right_screen_center(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_RIGHT_SCREEN_CENTER));
}

/// Get vr stereo config max scale for VrStereoConfig.scale
fn nif_vr_stereo_config_get_max_scale(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_SCALE));
}

/// Get vr stereo config max scale in for VrStereoConfig.scaleIn
fn nif_vr_stereo_config_get_max_scale_in(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.VrStereoConfig.MAX_SCALE_IN));
}

/// Load VR stereo config for VR simulator device parameters
///
/// raylib.h
/// RLAPI VrStereoConfig LoadVrStereoConfig(VrDeviceInfo device);
fn nif_load_vr_stereo_config(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_device = core.Argument(core.VrDeviceInfo).get(env, argv[0]) catch {
        return error.invalid_argument_device;
    };
    defer arg_device.free();
    const device = arg_device.data;

    // Function

    const vr_stereo_config = rl.LoadVrStereoConfig(device);
    defer if (!return_resource) core.VrStereoConfig.unload(vr_stereo_config);
    errdefer if (return_resource) core.VrStereoConfig.unload(vr_stereo_config);

    // Return

    return core.maybe_make_struct_as_resource(core.VrStereoConfig, env, vr_stereo_config, return_resource) catch {
        return error.invalid_return;
    };
}
