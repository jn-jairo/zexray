const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Mesh
    .{ .name = "mesh_get_max_vertex_buffers", .arity = 0, .fptr = nif_mesh_get_max_vertex_buffers, .flags = 0 },
};

////////////
//  Mesh  //
////////////

/// Get mesh max vertex buffers for Mesh.vbo_id
///
/// config.h
/// MAX_MESH_VERTEX_BUFFERS
fn nif_mesh_get_max_vertex_buffers(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.Mesh.MAX_VERTEX_BUFFERS));
}
