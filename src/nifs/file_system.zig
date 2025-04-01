const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // FilePathList
    .{ .name = "file_path_list_get_max_filepath_capacity", .arity = 0, .fptr = nif_file_path_list_get_max_filepath_capacity, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "file_path_list_get_max_filepath_length", .arity = 0, .fptr = nif_file_path_list_get_max_filepath_length, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // File System
    .{ .name = "is_file_dropped", .arity = 0, .fptr = nif_is_file_dropped, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_dropped_files", .arity = 0, .fptr = nif_load_dropped_files, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

////////////////////
//  FilePathList  //
////////////////////

/// Get file path list max filepath capacity for FilePathList.paths
fn nif_file_path_list_get_max_filepath_capacity(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.FilePathList.MAX_FILEPATH_CAPACITY));
}

/// Get file path list max filepath length for FilePathList.paths
fn nif_file_path_list_get_max_filepath_length(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.FilePathList.MAX_FILEPATH_LENGTH - 1));
}

///////////////////
//  File System  //
///////////////////

/// Check if a file has been dropped into window
///
/// raylib.h
/// RLAPI bool IsFileDropped(void);
fn nif_is_file_dropped(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
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
fn nif_load_dropped_files(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const dropped_files = rl.LoadDroppedFiles();
    defer rl.UnloadDroppedFiles(dropped_files);

    // Return

    const paths_lengths = [_]usize{ @intCast(dropped_files.count), @intCast(rl.MAX_FILEPATH_LENGTH) };
    return core.Array.make_c(core.CString, [*c]u8, env, dropped_files.paths, &paths_lengths);
}
