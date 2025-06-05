const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // File system
    .{ .name = "is_file_dropped", .arity = 0, .fptr = core.nif_wrapper(nif_is_file_dropped), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_dropped_files", .arity = 0, .fptr = core.nif_wrapper(nif_load_dropped_files), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

///////////////////
//  File system  //
///////////////////

/// Check if a file has been dropped into window
///
/// raylib.h
/// RLAPI bool IsFileDropped(void);
fn nif_is_file_dropped(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const is_file_dropped = rl.IsFileDropped();

    // Return

    return core.Boolean.make(env, is_file_dropped);
}

/// Load dropped filepaths
///
/// raylib.h
/// RLAPI FilePathList LoadDroppedFiles(void);
fn nif_load_dropped_files(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const dropped_files = rl.LoadDroppedFiles();
    defer rl.UnloadDroppedFiles(dropped_files);

    // Return

    const paths_lengths = [_]usize{ @intCast(dropped_files.count), @intCast(rl.MAX_FILEPATH_LENGTH) };
    return core.Array.make_c(core.CString, [*c]u8, env, dropped_files.paths, &paths_lengths);
}
