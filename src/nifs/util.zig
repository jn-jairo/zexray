const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");
const rlgl = @import("../rlgl.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Util
    .{ .name = "open_url", .arity = 1, .fptr = nif_open_url, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

////////////
//  Util  //
////////////

/// Open URL with default system browser (if available)
///
/// raylib.h
/// RLAPI void OpenURL(const char *url);
fn nif_open_url(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_url = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'url'.");
    };
    defer arg_url.free();
    const url = arg_url.data;

    // Function

    rl.OpenURL(url);

    // Return

    return core.Atom.make(env, "ok");
}
