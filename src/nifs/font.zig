const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Font loading
    .{ .name = "load_font", .arity = 1, .fptr = nif_load_font, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_font", .arity = 2, .fptr = nif_load_font, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

////////////////////
//  Font loading  //
////////////////////

/// Load font from file into GPU memory (VRAM)
///
/// raylib.h
/// RLAPI Font LoadFont(const char *fileName);
fn nif_load_font(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = if (argc == 2) e.enif_is_identical(core.Atom.make(env, "resource"), argv[1]) != 0 else false;

    // Arguments

    const arg_file_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'file_name'.");
    };
    defer arg_file_name.free();
    const file_name = arg_file_name.data;

    // Function

    const font = rl.LoadFont(file_name);
    defer if (!return_resource) core.Font.free(font);

    // Return

    return core.maybe_make_struct_as_resource(core.Font, env, font, return_resource) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to get return value.");
    };
}
