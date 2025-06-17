const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Util
    .{ .name = "open_url", .arity = 1, .fptr = core.nif_wrapper(nif_open_url), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

////////////
//  Util  //
////////////

/// Open URL with default system browser (if available)
///
/// raylib.h
/// RLAPI void OpenURL(const char *url);
fn nif_open_url(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_url = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_url;
    };
    defer arg_url.free();
    const url = arg_url.data;

    // Function

    rl.OpenURL(url);

    // Return

    return core.Atom.make(env, "ok");
}
