const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Random
    .{ .name = "set_random_seed", .arity = 1, .fptr = nif_set_random_seed, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_random_value", .arity = 2, .fptr = nif_get_random_value, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_random_sequence", .arity = 3, .fptr = nif_load_random_sequence, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

//////////////
//  Random  //
//////////////

/// Set the seed for the random number generator
///
/// raylib.h
/// RLAPI void SetRandomSeed(unsigned int seed);
fn nif_set_random_seed(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const seed = core.UInt.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'seed'.");
    };

    // Function

    rl.SetRandomSeed(seed);

    // Return

    return core.Atom.make(env, "ok");
}

/// Get a random value between min and max (both included)
///
/// raylib.h
/// RLAPI int GetRandomValue(int min, int max);
fn nif_get_random_value(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const min = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'min'.");
    };

    const max = core.Int.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'max'.");
    };

    // Function

    const random_value = rl.GetRandomValue(min, max);

    // Return

    return core.Int.make(env, random_value);
}

/// Load random values sequence, no values repeated
///
/// raylib.h
/// RLAPI int *LoadRandomSequence(unsigned int count, int min, int max);
fn nif_load_random_sequence(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const count = core.UInt.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'count'.");
    };

    const min = core.Int.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'min'.");
    };

    const max = core.Int.get(env, argv[2]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'max'.");
    };

    // Function

    const random_sequence = rl.LoadRandomSequence(count, min, max);
    defer rl.UnloadRandomSequence(random_sequence);

    // Return

    const random_sequence_lengths = [_]usize{@intCast(count)};

    return core.Array.make_c(core.Int, core.Int.data_type, env, random_sequence, &random_sequence_lengths);
}
