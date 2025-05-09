const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Mouse
    .{ .name = "is_mouse_button_pressed", .arity = 1, .fptr = core.nif_wrapper(nif_is_mouse_button_pressed), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_mouse_button_down", .arity = 1, .fptr = core.nif_wrapper(nif_is_mouse_button_down), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_mouse_button_released", .arity = 1, .fptr = core.nif_wrapper(nif_is_mouse_button_released), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_mouse_button_up", .arity = 1, .fptr = core.nif_wrapper(nif_is_mouse_button_up), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_mouse_x", .arity = 0, .fptr = core.nif_wrapper(nif_get_mouse_x), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_mouse_y", .arity = 0, .fptr = core.nif_wrapper(nif_get_mouse_y), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_mouse_position", .arity = 0, .fptr = core.nif_wrapper(nif_get_mouse_position), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_mouse_position", .arity = 1, .fptr = core.nif_wrapper(nif_get_mouse_position), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_mouse_delta", .arity = 0, .fptr = core.nif_wrapper(nif_get_mouse_delta), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_mouse_delta", .arity = 1, .fptr = core.nif_wrapper(nif_get_mouse_delta), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_mouse_position", .arity = 2, .fptr = core.nif_wrapper(nif_set_mouse_position), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_mouse_offset", .arity = 2, .fptr = core.nif_wrapper(nif_set_mouse_offset), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_mouse_scale", .arity = 2, .fptr = core.nif_wrapper(nif_set_mouse_scale), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_mouse_wheel_move", .arity = 0, .fptr = core.nif_wrapper(nif_get_mouse_wheel_move), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_mouse_wheel_move_v", .arity = 0, .fptr = core.nif_wrapper(nif_get_mouse_wheel_move_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_mouse_wheel_move_v", .arity = 1, .fptr = core.nif_wrapper(nif_get_mouse_wheel_move_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_mouse_cursor", .arity = 1, .fptr = core.nif_wrapper(nif_set_mouse_cursor), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

/////////////
//  Mouse  //
/////////////

/// Check if a mouse button has been pressed once
///
/// raylib.h
/// RLAPI bool IsMouseButtonPressed(int button);
fn nif_is_mouse_button_pressed(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const button = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_button;
    };

    // Function

    const is_mouse_button_pressed = rl.IsMouseButtonPressed(button);

    // Return

    return core.Boolean.make(env, is_mouse_button_pressed);
}

/// Check if a mouse button is being pressed
///
/// raylib.h
/// RLAPI bool IsMouseButtonDown(int button);
fn nif_is_mouse_button_down(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const button = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_button;
    };

    // Function

    const is_mouse_button_down = rl.IsMouseButtonDown(button);

    // Return

    return core.Boolean.make(env, is_mouse_button_down);
}

/// Check if a mouse button has been released once
///
/// raylib.h
/// RLAPI bool IsMouseButtonReleased(int button);
fn nif_is_mouse_button_released(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const button = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_button;
    };

    // Function

    const is_mouse_button_released = rl.IsMouseButtonReleased(button);

    // Return

    return core.Boolean.make(env, is_mouse_button_released);
}

/// Check if a mouse button is NOT being pressed
///
/// raylib.h
/// RLAPI bool IsMouseButtonUp(int button);
fn nif_is_mouse_button_up(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const button = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_button;
    };

    // Function

    const is_mouse_button_up = rl.IsMouseButtonUp(button);

    // Return

    return core.Boolean.make(env, is_mouse_button_up);
}

/// Get mouse position X
///
/// raylib.h
/// RLAPI int GetMouseX(void);
fn nif_get_mouse_x(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const mouse_x = rl.GetMouseX();

    // Return

    return core.Int.make(env, mouse_x);
}

/// Get mouse position Y
///
/// raylib.h
/// RLAPI int GetMouseY(void);
fn nif_get_mouse_y(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const mouse_y = rl.GetMouseY();

    // Return

    return core.Int.make(env, mouse_y);
}

/// Get mouse position XY
///
/// raylib.h
/// RLAPI Vector2 GetMousePosition(void);
fn nif_get_mouse_position(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0 or argc == 1);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 0);

    // Function

    const position = rl.GetMousePosition();
    defer if (!return_resource) core.Vector2.unload(position);
    errdefer if (return_resource) core.Vector2.unload(position);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector2, env, position, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get mouse delta between frames
///
/// raylib.h
/// RLAPI Vector2 GetMouseDelta(void);
fn nif_get_mouse_delta(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0 or argc == 1);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 0);

    // Function

    const delta = rl.GetMouseDelta();
    defer if (!return_resource) core.Vector2.unload(delta);
    errdefer if (return_resource) core.Vector2.unload(delta);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector2, env, delta, return_resource) catch {
        return error.invalid_return;
    };
}

/// Set mouse position XY
///
/// raylib.h
/// RLAPI void SetMousePosition(int x, int y);
fn nif_set_mouse_position(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const x = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_x;
    };

    const y = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_y;
    };

    // Function

    rl.SetMousePosition(x, y);

    // Return

    return core.Atom.make(env, "ok");
}

/// Set mouse offset
///
/// raylib.h
/// RLAPI void SetMouseOffset(int offsetX, int offsetY);
fn nif_set_mouse_offset(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const offset_x = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_offset_x;
    };

    const offset_y = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_offset_y;
    };

    // Function

    rl.SetMouseOffset(offset_x, offset_y);

    // Return

    return core.Atom.make(env, "ok");
}

/// Set mouse scaling
///
/// raylib.h
/// RLAPI void SetMouseScale(float scaleX, float scaleY);
fn nif_set_mouse_scale(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const scale_x = core.Double.get(env, argv[0]) catch {
        return error.invalid_argument_scale_x;
    };

    const scale_y = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_scale_y;
    };

    // Function

    rl.SetMouseScale(@floatCast(scale_x), @floatCast(scale_y));

    // Return

    return core.Atom.make(env, "ok");
}

/// Get mouse wheel movement for X or Y, whichever is larger
///
/// raylib.h
/// RLAPI float GetMouseWheelMove(void);
fn nif_get_mouse_wheel_move(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const mouse_wheel_move = rl.GetMouseWheelMove();

    // Return

    return core.Double.make(env, @floatCast(mouse_wheel_move));
}

/// Get mouse wheel movement for both X and Y
///
/// raylib.h
/// RLAPI Vector2 GetMouseWheelMoveV(void);
fn nif_get_mouse_wheel_move_v(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0 or argc == 1);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 0);

    // Function

    const delta = rl.GetMouseWheelMoveV();
    defer if (!return_resource) core.Vector2.unload(delta);
    errdefer if (return_resource) core.Vector2.unload(delta);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector2, env, delta, return_resource) catch {
        return error.invalid_return;
    };
}

/// Set mouse cursor
///
/// raylib.h
/// RLAPI void SetMouseCursor(int cursor);
fn nif_set_mouse_cursor(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const cursor = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_cursor;
    };

    // Function

    rl.SetMouseCursor(cursor);

    // Return

    return core.Atom.make(env, "ok");
}
