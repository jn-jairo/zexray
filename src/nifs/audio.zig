const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Wave
    .{ .name = "wave_get_data_size", .arity = 3, .fptr = core.nif_wrapper(nif_wave_get_data_size), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

////////////
//  Wave  //
////////////

/// Get wave data size in bytes
///
/// pub fn get_data_size(frame_count: c_uint, channels: c_uint, sample_size: c_uint) usize
fn nif_wave_get_data_size(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const frame_count: c_uint = core.UInt.get(env, argv[0]) catch {
        return error.invalid_argument_frame_count;
    };

    const channels: c_uint = core.UInt.get(env, argv[1]) catch {
        return error.invalid_argument_channels;
    };

    const sample_size: c_uint = core.UInt.get(env, argv[2]) catch {
        return error.invalid_argument_sample_size;
    };

    // Function

    const data_size = core.Wave.get_data_size(frame_count, channels, sample_size);

    // Return

    return core.UInt.make(env, @intCast(data_size));
}
