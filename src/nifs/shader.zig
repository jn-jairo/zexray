const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Shader
    .{ .name = "shader_get_max_locations", .arity = 0, .fptr = nif_shader_get_max_locations, .flags = 0 },
};

//////////////
//  Shader  //
//////////////

/// Get shader max locations for Shader.locs
///
/// config.h
/// RL_MAX_SHADER_LOCATIONS
fn nif_shader_get_max_locations(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.Shader.MAX_LOCATIONS));
}
