const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Cursor
    .{ .name = "show_cursor", .arity = 0, .fptr = nif_show_cursor, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "hide_cursor", .arity = 0, .fptr = nif_hide_cursor, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_cursor_hidden", .arity = 0, .fptr = nif_is_cursor_hidden, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "enable_cursor", .arity = 0, .fptr = nif_enable_cursor, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "disable_cursor", .arity = 0, .fptr = nif_disable_cursor, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_cursor_on_screen", .arity = 0, .fptr = nif_is_cursor_on_screen, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

//////////////
//  Cursor  //
//////////////

/// Shows cursor
///
/// raylib.h
/// RLAPI void ShowCursor(void);
fn nif_show_cursor(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.ShowCursor();

    // Return

    return core.Atom.make(env, "ok");
}

/// Hides cursor
///
/// raylib.h
/// RLAPI void HideCursor(void);
fn nif_hide_cursor(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.HideCursor();

    // Return

    return core.Atom.make(env, "ok");
}

/// Check if cursor is not visible
///
/// raylib.h
/// RLAPI bool IsCursorHidden(void);
fn nif_is_cursor_hidden(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const is_cursor_hidden = rl.IsCursorHidden();

    // Return

    return core.Boolean.make(env, is_cursor_hidden);
}

/// Enables cursor (unlock cursor)
///
/// raylib.h
/// RLAPI void EnableCursor(void);
fn nif_enable_cursor(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.EnableCursor();

    // Return

    return core.Atom.make(env, "ok");
}

/// Disables cursor (lock cursor)
/// raylib.h
///
/// RLAPI void DisableCursor(void);
fn nif_disable_cursor(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.DisableCursor();

    // Return

    return core.Atom.make(env, "ok");
}

/// Check if cursor is on the screen
///
/// raylib.h
/// RLAPI bool IsCursorOnScreen(void);
fn nif_is_cursor_on_screen(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const is_cursor_on_screen = rl.IsCursorOnScreen();

    // Return

    return core.Boolean.make(env, is_cursor_on_screen);
}
