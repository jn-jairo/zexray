const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Gamepad
    .{ .name = "is_gamepad_available", .arity = 1, .fptr = nif_is_gamepad_available, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_gamepad_name", .arity = 1, .fptr = nif_get_gamepad_name, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_gamepad_button_pressed", .arity = 2, .fptr = nif_is_gamepad_button_pressed, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_gamepad_button_down", .arity = 2, .fptr = nif_is_gamepad_button_down, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_gamepad_button_released", .arity = 2, .fptr = nif_is_gamepad_button_released, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_gamepad_button_up", .arity = 2, .fptr = nif_is_gamepad_button_up, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_gamepad_button_pressed", .arity = 0, .fptr = nif_get_gamepad_button_pressed, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_gamepad_axis_count", .arity = 1, .fptr = nif_get_gamepad_axis_count, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_gamepad_axis_movement", .arity = 2, .fptr = nif_get_gamepad_axis_movement, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_gamepad_mappings", .arity = 1, .fptr = nif_set_gamepad_mappings, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_gamepad_vibration", .arity = 4, .fptr = nif_set_gamepad_vibration, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

///////////////
//  Gamepad  //
///////////////

/// Check if a gamepad is available
///
/// raylib.h
/// RLAPI bool IsGamepadAvailable(int gamepad);
fn nif_is_gamepad_available(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const gamepad = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'gamepad'.");
    };

    // Function

    const is_gamepad_available = rl.IsGamepadAvailable(gamepad);

    // Return

    return core.Boolean.make(env, is_gamepad_available);
}

/// Get gamepad internal name id
///
/// raylib.h
/// RLAPI const char *GetGamepadName(int gamepad);
fn nif_get_gamepad_name(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const gamepad = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'gamepad'.");
    };

    // Function

    const gamepad_name = rl.GetGamepadName(gamepad);
    // Do NOT free gamepad_name

    // Return

    return core.CString.make_c_unknown(env, gamepad_name);
}

/// Check if a gamepad button has been pressed once
///
/// raylib.h
/// RLAPI bool IsGamepadButtonPressed(int gamepad, int button);
fn nif_is_gamepad_button_pressed(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const gamepad = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'gamepad'.");
    };

    const button = core.Int.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'button'.");
    };

    // Function

    const is_gamepad_button_pressed = rl.IsGamepadButtonPressed(gamepad, button);

    // Return

    return core.Boolean.make(env, is_gamepad_button_pressed);
}

/// Check if a gamepad button is being pressed
///
/// raylib.h
/// RLAPI bool IsGamepadButtonDown(int gamepad, int button);
fn nif_is_gamepad_button_down(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const gamepad = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'gamepad'.");
    };

    const button = core.Int.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'button'.");
    };

    // Function

    const is_gamepad_button_down = rl.IsGamepadButtonDown(gamepad, button);

    // Return

    return core.Boolean.make(env, is_gamepad_button_down);
}

/// Check if a gamepad button has been released once
///
/// raylib.h
/// RLAPI bool IsGamepadButtonReleased(int gamepad, int button);
fn nif_is_gamepad_button_released(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const gamepad = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'gamepad'.");
    };

    const button = core.Int.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'button'.");
    };

    // Function

    const is_gamepad_button_released = rl.IsGamepadButtonReleased(gamepad, button);

    // Return

    return core.Boolean.make(env, is_gamepad_button_released);
}

/// Check if a gamepad button is NOT being pressed
///
/// raylib.h
/// RLAPI bool IsGamepadButtonUp(int gamepad, int button);
fn nif_is_gamepad_button_up(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const gamepad = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'gamepad'.");
    };

    const button = core.Int.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'button'.");
    };

    // Function

    const is_gamepad_button_up = rl.IsGamepadButtonUp(gamepad, button);

    // Return

    return core.Boolean.make(env, is_gamepad_button_up);
}

/// Get the last gamepad button pressed
///
/// raylib.h
/// RLAPI int GetGamepadButtonPressed(void);
fn nif_get_gamepad_button_pressed(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const gamepad_button_pressed = rl.GetGamepadButtonPressed();

    // Return

    return core.Int.make(env, gamepad_button_pressed);
}

/// Get gamepad axis count for a gamepad
///
/// raylib.h
/// RLAPI int GetGamepadAxisCount(int gamepad);
fn nif_get_gamepad_axis_count(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const gamepad = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'gamepad'.");
    };

    // Function

    const gamepad_axis_count = rl.GetGamepadAxisCount(gamepad);

    // Return

    return core.Int.make(env, gamepad_axis_count);
}

/// Get axis movement value for a gamepad axis
///
/// raylib.h
/// RLAPI float GetGamepadAxisMovement(int gamepad, int axis);
fn nif_get_gamepad_axis_movement(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const gamepad = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'gamepad'.");
    };

    const axis = core.Int.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'axis'.");
    };

    // Function

    const gamepad_axis_movement = rl.GetGamepadAxisMovement(gamepad, axis);

    // Return

    return core.Double.make(env, @floatCast(gamepad_axis_movement));
}

/// Set internal gamepad mappings (SDL_GameControllerDB)
///
/// raylib.h
/// RLAPI int SetGamepadMappings(const char *mappings);
fn nif_set_gamepad_mappings(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_mappings = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'mappings'.");
    };
    defer arg_mappings.free();
    const mappings = arg_mappings.data;

    // Function

    var ok: bool = false;

    const min_line_length: usize = 32;

    if (arg_mappings.length > min_line_length) {
        var buf: []u8 = @as([*]u8, @ptrCast(mappings))[0..arg_mappings.length];

        var start: usize = 0;
        var end: usize = 0;

        for (0..arg_mappings.length) |i| {
            if (buf[i] == '\n' or buf[i] == '\r' or buf[i] == 0) {
                buf[i] = 0;
                end = i;

                if ((end - start) > min_line_length) {
                    const line = buf[start..end];
                    if (line[0] != '#') {
                        if (rl.SetGamepadMappings(@ptrCast(buf[start..end])) != 0) {
                            ok = true;
                        }
                    }
                }

                start = end + 1;
            }
        }
    }

    // Return

    return core.Boolean.make(env, ok);
}

/// Set gamepad vibration for both motors (duration in seconds)
///
/// raylib.h
/// RLAPI void SetGamepadVibration(int gamepad, float leftMotor, float rightMotor, float duration);
fn nif_set_gamepad_vibration(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const gamepad = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'gamepad'.");
    };

    const left_motor = core.Double.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'left_motor'.");
    };

    const right_motor = core.Double.get(env, argv[2]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'right_motor'.");
    };

    const duration = core.Double.get(env, argv[3]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'duration'.");
    };

    // Function

    rl.SetGamepadVibration(gamepad, @floatCast(left_motor), @floatCast(right_motor), @floatCast(duration));

    // Return

    return core.Atom.make(env, "ok");
}
