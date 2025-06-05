const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // VrStereoConfig
    .{ .name = "load_vr_stereo_config", .arity = 1, .fptr = core.nif_wrapper(nif_load_vr_stereo_config), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_vr_stereo_config", .arity = 2, .fptr = core.nif_wrapper(nif_load_vr_stereo_config), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

//////////////////////
//  VrStereoConfig  //
//////////////////////

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
