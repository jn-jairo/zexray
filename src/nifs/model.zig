const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // BoneInfo
    .{ .name = "bone_info_get_max_name", .arity = 0, .fptr = core.nif_wrapper(nif_bone_info_get_max_name), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // ModelAnimation
    .{ .name = "model_animation_get_max_name", .arity = 0, .fptr = core.nif_wrapper(nif_model_animation_get_max_name), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

////////////////
//  BoneInfo  //
////////////////

/// Get bone info max name for BoneInfo.name
fn nif_bone_info_get_max_name(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.BoneInfo.MAX_NAME - 1));
}

//////////////////////
//  ModelAnimation  //
//////////////////////

/// Get model animation max name for ModelAnimation.name
fn nif_model_animation_get_max_name(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.ModelAnimation.MAX_NAME - 1));
}
