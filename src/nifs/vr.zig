const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // VrDeviceInfo
    .{ .name = "vr_device_info_get_max_lens_distortion_values", .arity = 0, .fptr = nif_vr_device_info_get_max_lens_distortion_values, .flags = 0 },
    .{ .name = "vr_device_info_get_max_chroma_ab_correction", .arity = 0, .fptr = nif_vr_device_info_get_max_chroma_ab_correction, .flags = 0 },
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
