const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Material
    .{ .name = "material_get_max_maps", .arity = 0, .fptr = nif_material_get_max_maps, .flags = 0 },
    .{ .name = "material_get_max_params", .arity = 0, .fptr = nif_material_get_max_params, .flags = 0 },
};

////////////////
//  Material  //
////////////////

/// Get material max maps for Material.maps
///
/// config.h
/// MAX_MATERIAL_MAPS
fn nif_material_get_max_maps(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.Int.make(env, @intCast(core.Material.MAX_MAPS));
}

/// Get material max params for Material.params
fn nif_material_get_max_params(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.Int.make(env, @intCast(core.Material.MAX_PARAMS));
}
