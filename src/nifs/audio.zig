const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Wave
    .{ .name = "wave_get_data_size", .arity = 3, .fptr = nif_wave_get_data_size, .flags = 0 },
};

////////////
//  Wave  //
////////////

/// Get wave data size in bytes
///
/// pub fn get_data_size(frame_count: c_uint, channels: c_uint, sample_size: c_uint) usize
fn nif_wave_get_data_size(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const frame_count: c_uint = core.UInt.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'frame_count'.");
    };

    const channels: c_uint = core.UInt.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'channels'.");
    };

    const sample_size: c_uint = core.UInt.get(env, argv[2]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'sample_size'.");
    };

    // Function

    const data_size = core.Wave.get_data_size(frame_count, channels, sample_size);

    // Return

    return core.UInt.make(env, @intCast(data_size));
}
