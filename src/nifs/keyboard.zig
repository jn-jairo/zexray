const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Keyboard
    .{ .name = "is_key_pressed", .arity = 1, .fptr = core.nif_wrapper(nif_is_key_pressed), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_key_pressed_repeat", .arity = 1, .fptr = core.nif_wrapper(nif_is_key_pressed_repeat), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_key_down", .arity = 1, .fptr = core.nif_wrapper(nif_is_key_down), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_key_released", .arity = 1, .fptr = core.nif_wrapper(nif_is_key_released), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_key_up", .arity = 1, .fptr = core.nif_wrapper(nif_is_key_up), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_key_pressed", .arity = 0, .fptr = core.nif_wrapper(nif_get_key_pressed), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_char_pressed", .arity = 0, .fptr = core.nif_wrapper(nif_get_char_pressed), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_key_name", .arity = 1, .fptr = core.nif_wrapper(nif_get_key_name), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_exit_key", .arity = 1, .fptr = core.nif_wrapper(nif_set_exit_key), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

////////////////
//  Keyboard  //
////////////////

/// Check if a key has been pressed once
///
/// raylib.h
/// RLAPI bool IsKeyPressed(int key);
fn nif_is_key_pressed(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const key = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_key;
    };

    // Function

    const is_key_pressed = rl.IsKeyPressed(key);

    // Return

    return core.Boolean.make(env, is_key_pressed);
}

/// Check if a key has been pressed again
///
/// raylib.h
/// RLAPI bool IsKeyPressedRepeat(int key);
fn nif_is_key_pressed_repeat(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const key = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_key;
    };

    // Function

    const is_key_pressed_repeat = rl.IsKeyPressedRepeat(key);

    // Return

    return core.Boolean.make(env, is_key_pressed_repeat);
}

/// Check if a key is being pressed
///
/// raylib.h
/// RLAPI bool IsKeyDown(int key);
fn nif_is_key_down(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const key = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_key;
    };

    // Function

    const is_key_down = rl.IsKeyDown(key);

    // Return

    return core.Boolean.make(env, is_key_down);
}

/// Check if a key has been released once
///
/// raylib.h
/// RLAPI bool IsKeyReleased(int key);
fn nif_is_key_released(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const key = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_key;
    };

    // Function

    const is_key_released = rl.IsKeyReleased(key);

    // Return

    return core.Boolean.make(env, is_key_released);
}

/// Check if a key is NOT being pressed
///
/// raylib.h
/// RLAPI bool IsKeyUp(int key);
fn nif_is_key_up(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const key = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_key;
    };

    // Function

    const is_key_up = rl.IsKeyUp(key);

    // Return

    return core.Boolean.make(env, is_key_up);
}

/// Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
///
/// raylib.h
/// RLAPI int GetKeyPressed(void);
fn nif_get_key_pressed(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const key_pressed = rl.GetKeyPressed();

    // Return

    return core.Int.make(env, key_pressed);
}

/// Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
///
/// raylib.h
/// RLAPI int GetCharPressed(void);
fn nif_get_char_pressed(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const char_pressed = rl.GetCharPressed();

    // Return

    return core.Int.make(env, char_pressed);
}

/// Get name of a QWERTY key on the current keyboard layout (eg returns string 'q' for KEY_A on an AZERTY keyboard)
///
/// raylib.h
/// RLAPI const char *GetKeyName(int key);
fn nif_get_key_name(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const key = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_key;
    };

    // Function

    const key_name = rl.GetKeyName(key);
    // Do NOT free key_name

    // Return

    return core.CString.make_c_unknown(env, key_name);
}

/// Set a custom key to exit program (default is ESC)
///
/// raylib.h
/// RLAPI void SetExitKey(int key);
fn nif_set_exit_key(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const key = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_key;
    };

    // Function

    rl.SetExitKey(key);

    // Return

    return core.Atom.make(env, "ok");
}
