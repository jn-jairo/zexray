const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Material
    .{ .name = "material_get_max_maps", .arity = 0, .fptr = core.nif_wrapper(nif_material_get_max_maps), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "material_get_max_params", .arity = 0, .fptr = core.nif_wrapper(nif_material_get_max_params), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

////////////////
//  Material  //
////////////////

/// Get material max maps for Material.maps
///
/// config.h
/// MAX_MATERIAL_MAPS
fn nif_material_get_max_maps(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.Material.MAX_MAPS));
}

/// Get material max params for Material.params
fn nif_material_get_max_params(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.Material.MAX_PARAMS));
}
