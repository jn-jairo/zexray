const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Font loading
    .{ .name = "load_font", .arity = 1, .fptr = nif_load_font, .flags = 0 },
    .{ .name = "load_font", .arity = 2, .fptr = nif_load_font, .flags = 0 },
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

    // Resource check

    const return_resource = if (argc == 2) e.enif_is_identical(core.Atom.make(env, "resource"), argv[1]) != 0 else false;

    // Arguments

    const file_name: []u8 = core.CString.get(e.allocator, env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'file_name'.");
    };
    defer e.allocator.free(file_name);

    // Function

    const font = rl.LoadFont(@as([*:0]u8, @ptrCast(file_name)));
    defer if (!return_resource) core.Font.free(font);

    // Return

    if (return_resource) {
        const font_resource = core.Font.Resource.create(font) catch |err| {
            return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to create resource for return value.");
        };
        defer core.Font.Resource.release(font_resource);

        return core.Font.Resource.make(env, font_resource);
    } else {
        return core.Font.make(env, font);
    }
}
