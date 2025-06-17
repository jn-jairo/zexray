const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Window
    .{ .name = "init_window", .arity = 3, .fptr = core.nif_wrapper(nif_init_window), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "close_window", .arity = 0, .fptr = core.nif_wrapper(nif_close_window), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "window_should_close", .arity = 0, .fptr = core.nif_wrapper(nif_window_should_close), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_window_ready", .arity = 0, .fptr = core.nif_wrapper(nif_is_window_ready), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_window_fullscreen", .arity = 0, .fptr = core.nif_wrapper(nif_is_window_fullscreen), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_window_hidden", .arity = 0, .fptr = core.nif_wrapper(nif_is_window_hidden), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_window_minimized", .arity = 0, .fptr = core.nif_wrapper(nif_is_window_minimized), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_window_maximized", .arity = 0, .fptr = core.nif_wrapper(nif_is_window_maximized), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_window_focused", .arity = 0, .fptr = core.nif_wrapper(nif_is_window_focused), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_window_resized", .arity = 0, .fptr = core.nif_wrapper(nif_is_window_resized), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_window_state", .arity = 1, .fptr = core.nif_wrapper(nif_is_window_state), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_window_state", .arity = 1, .fptr = core.nif_wrapper(nif_set_window_state), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_config_flags", .arity = 1, .fptr = core.nif_wrapper(nif_set_config_flags), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "clear_window_state", .arity = 1, .fptr = core.nif_wrapper(nif_clear_window_state), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "toggle_fullscreen", .arity = 0, .fptr = core.nif_wrapper(nif_toggle_fullscreen), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "toggle_borderless_windowed", .arity = 0, .fptr = core.nif_wrapper(nif_toggle_borderless_windowed), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "maximize_window", .arity = 0, .fptr = core.nif_wrapper(nif_maximize_window), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "minimize_window", .arity = 0, .fptr = core.nif_wrapper(nif_minimize_window), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "restore_window", .arity = 0, .fptr = core.nif_wrapper(nif_restore_window), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_window_icon", .arity = 1, .fptr = core.nif_wrapper(nif_set_window_icon), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_window_icons", .arity = 1, .fptr = core.nif_wrapper(nif_set_window_icons), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_window_title", .arity = 1, .fptr = core.nif_wrapper(nif_set_window_title), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_window_position", .arity = 2, .fptr = core.nif_wrapper(nif_set_window_position), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_window_min_size", .arity = 2, .fptr = core.nif_wrapper(nif_set_window_min_size), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_window_max_size", .arity = 2, .fptr = core.nif_wrapper(nif_set_window_max_size), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_window_size", .arity = 2, .fptr = core.nif_wrapper(nif_set_window_size), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_window_opacity", .arity = 1, .fptr = core.nif_wrapper(nif_set_window_opacity), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_window_focused", .arity = 0, .fptr = core.nif_wrapper(nif_set_window_focused), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_screen_width", .arity = 0, .fptr = core.nif_wrapper(nif_get_screen_width), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_screen_height", .arity = 0, .fptr = core.nif_wrapper(nif_get_screen_height), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_render_width", .arity = 0, .fptr = core.nif_wrapper(nif_get_render_width), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_render_height", .arity = 0, .fptr = core.nif_wrapper(nif_get_render_height), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_window_position", .arity = 0, .fptr = core.nif_wrapper(nif_get_window_position), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_window_position", .arity = 1, .fptr = core.nif_wrapper(nif_get_window_position), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_window_scale_dpi", .arity = 0, .fptr = core.nif_wrapper(nif_get_window_scale_dpi), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_window_scale_dpi", .arity = 1, .fptr = core.nif_wrapper(nif_get_window_scale_dpi), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_clipboard_text", .arity = 1, .fptr = core.nif_wrapper(nif_set_clipboard_text), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_clipboard_text", .arity = 0, .fptr = core.nif_wrapper(nif_get_clipboard_text), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_clipboard_image", .arity = 0, .fptr = core.nif_wrapper(nif_get_clipboard_image), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_clipboard_image", .arity = 1, .fptr = core.nif_wrapper(nif_get_clipboard_image), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "enable_event_waiting", .arity = 0, .fptr = core.nif_wrapper(nif_enable_event_waiting), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "disable_event_waiting", .arity = 0, .fptr = core.nif_wrapper(nif_disable_event_waiting), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "screenshot", .arity = 0, .fptr = core.nif_wrapper(nif_screenshot), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "screenshot", .arity = 1, .fptr = core.nif_wrapper(nif_screenshot), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "take_screenshot", .arity = 1, .fptr = core.nif_wrapper(nif_take_screenshot), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

//////////////
//  Window  //
//////////////

/// Initialize window and OpenGL context
///
/// raylib.h
/// RLAPI void InitWindow(int width, int height, const char *title);
fn nif_init_window(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const width = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_height;
    };

    const arg_title = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[2]) catch {
        return error.invalid_argument_title;
    };
    defer arg_title.free();
    const title = arg_title.data;

    // Function

    rl.InitWindow(width, height, title);

    // Return

    return core.Atom.make(env, "ok");
}

/// Close window and unload OpenGL context
///
/// raylib.h
/// RLAPI void CloseWindow(void);
fn nif_close_window(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.CloseWindow();

    // Return

    return core.Atom.make(env, "ok");
}

/// Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
///
/// raylib.h
/// RLAPI bool WindowShouldClose(void);
fn nif_window_should_close(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const window_should_close = rl.WindowShouldClose();

    // Return

    return core.Boolean.make(env, window_should_close);
}

/// Check if window has been initialized successfully
///
/// raylib.h
/// RLAPI bool IsWindowReady(void);
fn nif_is_window_ready(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const is_window_ready = rl.IsWindowReady();

    // Return

    return core.Boolean.make(env, is_window_ready);
}

/// Check if window is currently fullscreen
///
/// raylib.h
/// RLAPI bool IsWindowFullscreen(void);
fn nif_is_window_fullscreen(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const is_window_fullscreen = rl.IsWindowFullscreen();

    // Return

    return core.Boolean.make(env, is_window_fullscreen);
}

/// Check if window is currently hidden
///
/// raylib.h
/// RLAPI bool IsWindowHidden(void);
fn nif_is_window_hidden(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const is_window_hidden = rl.IsWindowHidden();

    // Return

    return core.Boolean.make(env, is_window_hidden);
}

/// Check if window is currently minimized
///
/// raylib.h
/// RLAPI bool IsWindowMinimized(void);
fn nif_is_window_minimized(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const is_window_minimized = rl.IsWindowMinimized();

    // Return

    return core.Boolean.make(env, is_window_minimized);
}

/// Check if window is currently maximized
///
/// raylib.h
/// RLAPI bool IsWindowMaximized(void);
fn nif_is_window_maximized(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const is_window_maximized = rl.IsWindowMaximized();

    // Return

    return core.Boolean.make(env, is_window_maximized);
}

/// Check if window is currently focused
///
/// raylib.h
/// RLAPI bool IsWindowFocused(void);
fn nif_is_window_focused(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const is_window_focused = rl.IsWindowFocused();

    // Return

    return core.Boolean.make(env, is_window_focused);
}

/// Check if window has been resized last frame
///
/// raylib.h
/// RLAPI bool IsWindowResized(void);
fn nif_is_window_resized(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const is_window_resized = rl.IsWindowResized();

    // Return

    return core.Boolean.make(env, is_window_resized);
}

/// Check if one specific window flag is enabled
///
/// raylib.h
/// RLAPI bool IsWindowState(unsigned int flag);
fn nif_is_window_state(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const flag = core.UInt.get(env, argv[0]) catch {
        return error.invalid_argument_flag;
    };

    // Function

    const is_window_state = rl.IsWindowState(flag);

    // Return

    return core.Boolean.make(env, is_window_state);
}

/// Set window configuration state using flags
///
/// raylib.h
/// RLAPI void SetWindowState(unsigned int flags);
fn nif_set_window_state(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const flag = core.UInt.get(env, argv[0]) catch {
        return error.invalid_argument_flag;
    };

    // Function

    rl.SetWindowState(flag);

    // Return

    return core.Atom.make(env, "ok");
}

/// Setup init configuration flags (view FLAGS)
///
/// raylib.h
/// RLAPI void SetConfigFlags(unsigned int flags);
fn nif_set_config_flags(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const flag = core.UInt.get(env, argv[0]) catch {
        return error.invalid_argument_flag;
    };

    // Function

    rl.SetConfigFlags(flag);

    // Return

    return core.Atom.make(env, "ok");
}

/// Clear window configuration state flags
///
/// raylib.h
/// RLAPI void ClearWindowState(unsigned int flags);
fn nif_clear_window_state(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const flag = core.UInt.get(env, argv[0]) catch {
        return error.invalid_argument_flag;
    };

    // Function

    rl.ClearWindowState(flag);

    // Return

    return core.Atom.make(env, "ok");
}

/// Toggle window state: fullscreen/windowed, resizes monitor to match window resolution
///
/// raylib.h
/// RLAPI void ToggleFullscreen(void);
fn nif_toggle_fullscreen(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.ToggleFullscreen();

    // Return

    return core.Atom.make(env, "ok");
}

/// Toggle window state: borderless windowed, resizes window to match monitor resolution
///
/// raylib.h
/// RLAPI void ToggleBorderlessWindowed(void);
fn nif_toggle_borderless_windowed(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.ToggleBorderlessWindowed();

    // Return

    return core.Atom.make(env, "ok");
}

/// Set window state: maximized, if resizable
///
/// raylib.h
/// RLAPI void MaximizeWindow(void);
fn nif_maximize_window(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.MaximizeWindow();

    // Return

    return core.Atom.make(env, "ok");
}

/// Set window state: minimized, if resizable
///
/// raylib.h
/// RLAPI void MinimizeWindow(void);
fn nif_minimize_window(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.MinimizeWindow();

    // Return

    return core.Atom.make(env, "ok");
}

/// Restore window from being minimized/maximized
///
/// raylib.h
/// RLAPI void RestoreWindow(void);
fn nif_restore_window(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.RestoreWindow();

    // Return

    return core.Atom.make(env, "ok");
}

/// Set icon for window (single image, RGBA 32bit)
///
/// raylib.h
/// RLAPI void SetWindowIcon(Image image);
fn nif_set_window_icon(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_image.free();
    const image = arg_image.data;

    // Function

    rl.SetWindowIcon(image);

    // Return

    return core.Atom.make(env, "ok");
}

/// Set icon for window (multiple images, RGBA 32bit)
///
/// raylib.h
/// RLAPI void SetWindowIcons(Image *images, int count);
fn nif_set_window_icons(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    var arg_images = core.ArgumentArray(core.Image, core.Image.data_type, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_images.free();
    const images = arg_images.data;
    const count = arg_images.length;

    // Function

    rl.SetWindowIcons(@ptrCast(images), @intCast(count));

    // Return

    return core.Atom.make(env, "ok");
}

/// Set title for window
///
/// raylib.h
/// RLAPI void SetWindowTitle(const char *title);
fn nif_set_window_title(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_title = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_title;
    };
    defer arg_title.free();
    const title = arg_title.data;

    // Function

    rl.SetWindowTitle(title);

    // Return

    return core.Atom.make(env, "ok");
}

/// Set window position on screen
///
/// raylib.h
/// RLAPI void SetWindowPosition(int x, int y);
fn nif_set_window_position(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const x = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_x;
    };

    const y = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_y;
    };

    // Function

    rl.SetWindowPosition(x, y);

    // Return

    return core.Atom.make(env, "ok");
}

/// Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
///
/// raylib.h
/// RLAPI void SetWindowMinSize(int width, int height);
fn nif_set_window_min_size(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const width = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_height;
    };

    // Function

    rl.SetWindowMinSize(width, height);

    // Return

    return core.Atom.make(env, "ok");
}

/// Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)
///
/// raylib.h
/// RLAPI void SetWindowMaxSize(int width, int height);
fn nif_set_window_max_size(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const width = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_height;
    };

    // Function

    rl.SetWindowMaxSize(width, height);

    // Return

    return core.Atom.make(env, "ok");
}

/// Set window dimensions
///
/// raylib.h
/// RLAPI void SetWindowSize(int width, int height);
fn nif_set_window_size(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const width = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_height;
    };

    // Function

    rl.SetWindowSize(width, height);

    // Return

    return core.Atom.make(env, "ok");
}

/// Set window opacity [0.0f..1.0f]
///
/// raylib.h
/// RLAPI void SetWindowOpacity(float opacity);
fn nif_set_window_opacity(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const opacity = core.Double.get(env, argv[0]) catch {
        return error.invalid_argument_opacity;
    };

    // Function

    rl.SetWindowOpacity(@floatCast(opacity));

    // Return

    return core.Atom.make(env, "ok");
}

/// Set window focused
///
/// raylib.h
/// RLAPI void SetWindowFocused(void);
fn nif_set_window_focused(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.SetWindowFocused();

    // Return

    return core.Atom.make(env, "ok");
}

/// Get current screen width
///
/// raylib.h
/// RLAPI int GetScreenWidth(void);
fn nif_get_screen_width(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const screen_width = rl.GetScreenWidth();

    // Return

    return core.Int.make(env, screen_width);
}

/// Get current screen height
///
/// raylib.h
/// RLAPI int GetScreenHeight(void);
fn nif_get_screen_height(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const screen_height = rl.GetScreenHeight();

    // Return

    return core.Int.make(env, screen_height);
}

/// Get current render width (it considers HiDPI)
///
/// raylib.h
/// RLAPI int GetRenderWidth(void);
fn nif_get_render_width(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const render_width = rl.GetRenderWidth();

    // Return

    return core.Int.make(env, render_width);
}

/// Get current render height (it considers HiDPI)
///
/// raylib.h
/// RLAPI int GetRenderHeight(void);
fn nif_get_render_height(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const render_height = rl.GetRenderHeight();

    // Return

    return core.Int.make(env, render_height);
}

/// Get window position XY on monitor
///
/// raylib.h
/// RLAPI Vector2 GetWindowPosition(void);
fn nif_get_window_position(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0 or argc == 1);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 0);

    // Function

    const position = rl.GetWindowPosition();
    defer if (!return_resource) core.Vector2.unload(position);
    errdefer if (return_resource) core.Vector2.unload(position);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector2, env, position, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get window scale DPI factor
///
/// raylib.h
/// RLAPI Vector2 GetWindowScaleDPI(void);
fn nif_get_window_scale_dpi(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0 or argc == 1);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 0);

    // Function

    const scale_dpi = rl.GetWindowScaleDPI();
    defer if (!return_resource) core.Vector2.unload(scale_dpi);
    errdefer if (return_resource) core.Vector2.unload(scale_dpi);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector2, env, scale_dpi, return_resource) catch {
        return error.invalid_return;
    };
}

/// Set clipboard text content
///
/// raylib.h
/// RLAPI void SetClipboardText(const char *text);
fn nif_set_clipboard_text(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    // Function

    rl.SetClipboardText(text);

    // Return

    return core.Atom.make(env, "ok");
}

/// Get clipboard text content
///
/// raylib.h
/// RLAPI const char *GetClipboardText(void);
fn nif_get_clipboard_text(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const clipboard_text = rl.GetClipboardText();
    // Do NOT free clipboard_text

    // Return

    return core.CString.make_c_unknown(env, clipboard_text);
}

/// Get clipboard image content
///
/// raylib.h
/// RLAPI Image GetClipboardImage(void);
fn nif_get_clipboard_image(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0 or argc == 1);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 0);

    // Function

    const clipboard_image = rl.GetClipboardImage();
    defer if (!return_resource) core.Image.unload(clipboard_image);
    errdefer if (return_resource) core.Image.unload(clipboard_image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, clipboard_image, return_resource) catch {
        return error.invalid_return;
    };
}

/// Enable waiting for events on EndDrawing(), no automatic event polling
///
/// raylib.h
/// RLAPI void EnableEventWaiting(void);
fn nif_enable_event_waiting(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.EnableEventWaiting();

    // Return

    return core.Atom.make(env, "ok");
}

/// Disable waiting for events on EndDrawing(), automatic events polling
///
/// raylib.h
/// RLAPI void DisableEventWaiting(void);
fn nif_disable_event_waiting(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.DisableEventWaiting();

    // Return

    return core.Atom.make(env, "ok");
}

/// Takes a screenshot of current screen
fn nif_screenshot(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0 or argc == 1);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 0);

    // Function

    const image = rl.Screenshot();
    defer if (!return_resource) core.Image.unload(image);
    errdefer if (return_resource) core.Image.unload(image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image, return_resource) catch {
        return error.invalid_return;
    };
}

/// Takes a screenshot of current screen (filename extension defines format)
///
/// raylib.h
/// RLAPI void TakeScreenshot(const char *fileName);
fn nif_take_screenshot(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_file_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_file_name;
    };
    defer arg_file_name.free();
    const file_name = arg_file_name.data;

    // Function

    const ok = rl.TakeScreenshot2(file_name);

    // Return

    return core.Boolean.make(env, ok);
}
