const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // FilePathList
    .{ .name = "file_path_list_get_max_filepath_capacity", .arity = 0, .fptr = nif_file_path_list_get_max_filepath_capacity, .flags = 0 },
    .{ .name = "file_path_list_get_max_filepath_length", .arity = 0, .fptr = nif_file_path_list_get_max_filepath_length, .flags = 0 },
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
