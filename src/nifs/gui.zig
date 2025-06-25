const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Global gui state control functions
    .{ .name = "gui_enable", .arity = 0, .fptr = core.nif_wrapper(nif_gui_enable), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_disable", .arity = 0, .fptr = core.nif_wrapper(nif_gui_disable), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_lock", .arity = 0, .fptr = core.nif_wrapper(nif_gui_lock), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_unlock", .arity = 0, .fptr = core.nif_wrapper(nif_gui_unlock), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_is_locked", .arity = 0, .fptr = core.nif_wrapper(nif_gui_is_locked), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_set_alpha", .arity = 1, .fptr = core.nif_wrapper(nif_gui_set_alpha), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_set_state", .arity = 1, .fptr = core.nif_wrapper(nif_gui_set_state), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_get_state", .arity = 0, .fptr = core.nif_wrapper(nif_gui_get_state), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Font set/get functions
    .{ .name = "gui_set_font", .arity = 1, .fptr = core.nif_wrapper(nif_gui_set_font), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_get_font", .arity = 0, .fptr = core.nif_wrapper(nif_gui_get_font), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_get_font", .arity = 1, .fptr = core.nif_wrapper(nif_gui_get_font), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Style set/get functions
    .{ .name = "gui_set_style", .arity = 3, .fptr = core.nif_wrapper(nif_gui_set_style), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_set_style_color", .arity = 3, .fptr = core.nif_wrapper(nif_gui_set_style_color), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_get_style", .arity = 2, .fptr = core.nif_wrapper(nif_gui_get_style), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_get_style_color", .arity = 2, .fptr = core.nif_wrapper(nif_gui_get_style_color), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_get_style_color", .arity = 3, .fptr = core.nif_wrapper(nif_gui_get_style_color), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Styles loading functions
    .{ .name = "gui_load_style", .arity = 1, .fptr = core.nif_wrapper(nif_gui_load_style), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_load_style_default", .arity = 0, .fptr = core.nif_wrapper(nif_gui_load_style_default), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Tooltips management functions
    .{ .name = "gui_enable_tooltip", .arity = 0, .fptr = core.nif_wrapper(nif_gui_enable_tooltip), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_disable_tooltip", .arity = 0, .fptr = core.nif_wrapper(nif_gui_disable_tooltip), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_set_tooltip", .arity = 1, .fptr = core.nif_wrapper(nif_gui_set_tooltip), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Icons functionality
    .{ .name = "gui_icon_text", .arity = 2, .fptr = core.nif_wrapper(nif_gui_icon_text), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_set_icon_scale", .arity = 1, .fptr = core.nif_wrapper(nif_gui_set_icon_scale), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_get_icons", .arity = 0, .fptr = core.nif_wrapper(nif_gui_get_icons), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_load_icons", .arity = 1, .fptr = core.nif_wrapper(nif_gui_load_icons), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_draw_icon", .arity = 5, .fptr = core.nif_wrapper(nif_gui_draw_icon), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Controls
    .{ .name = "gui_window_box", .arity = 2, .fptr = core.nif_wrapper(nif_gui_window_box), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_group_box", .arity = 2, .fptr = core.nif_wrapper(nif_gui_group_box), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_line", .arity = 2, .fptr = core.nif_wrapper(nif_gui_line), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_panel", .arity = 2, .fptr = core.nif_wrapper(nif_gui_panel), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_tab_bar", .arity = 3, .fptr = core.nif_wrapper(nif_gui_tab_bar), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_scroll_panel", .arity = 5, .fptr = core.nif_wrapper(nif_gui_scroll_panel), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_scroll_panel", .arity = 6, .fptr = core.nif_wrapper(nif_gui_scroll_panel), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Basic controls set
    .{ .name = "gui_label", .arity = 2, .fptr = core.nif_wrapper(nif_gui_label), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_button", .arity = 2, .fptr = core.nif_wrapper(nif_gui_button), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_label_button", .arity = 2, .fptr = core.nif_wrapper(nif_gui_label_button), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_toggle", .arity = 3, .fptr = core.nif_wrapper(nif_gui_toggle), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_toggle_group", .arity = 3, .fptr = core.nif_wrapper(nif_gui_toggle_group), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_toggle_slider", .arity = 3, .fptr = core.nif_wrapper(nif_gui_toggle_slider), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_check_box", .arity = 3, .fptr = core.nif_wrapper(nif_gui_check_box), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_combo_box", .arity = 3, .fptr = core.nif_wrapper(nif_gui_combo_box), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_dropdown_box", .arity = 4, .fptr = core.nif_wrapper(nif_gui_dropdown_box), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_spinner", .arity = 6, .fptr = core.nif_wrapper(nif_gui_spinner), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_value_box", .arity = 6, .fptr = core.nif_wrapper(nif_gui_value_box), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_value_box_float", .arity = 5, .fptr = core.nif_wrapper(nif_gui_value_box_float), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_text_box", .arity = 4, .fptr = core.nif_wrapper(nif_gui_text_box), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_slider", .arity = 6, .fptr = core.nif_wrapper(nif_gui_slider), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_slider_bar", .arity = 6, .fptr = core.nif_wrapper(nif_gui_slider_bar), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_progress_bar", .arity = 6, .fptr = core.nif_wrapper(nif_gui_progress_bar), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_status_bar", .arity = 2, .fptr = core.nif_wrapper(nif_gui_status_bar), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_dummy_rec", .arity = 2, .fptr = core.nif_wrapper(nif_gui_dummy_rec), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_grid", .arity = 5, .fptr = core.nif_wrapper(nif_gui_grid), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_grid", .arity = 6, .fptr = core.nif_wrapper(nif_gui_grid), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Advance controls set
    .{ .name = "gui_list_view", .arity = 4, .fptr = core.nif_wrapper(nif_gui_list_view), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_list_view_ex", .arity = 5, .fptr = core.nif_wrapper(nif_gui_list_view_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_message_box", .arity = 4, .fptr = core.nif_wrapper(nif_gui_message_box), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_text_input_box", .arity = 7, .fptr = core.nif_wrapper(nif_gui_text_input_box), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_color_picker", .arity = 3, .fptr = core.nif_wrapper(nif_gui_color_picker), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_color_picker", .arity = 4, .fptr = core.nif_wrapper(nif_gui_color_picker), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_color_panel", .arity = 3, .fptr = core.nif_wrapper(nif_gui_color_panel), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_color_panel", .arity = 4, .fptr = core.nif_wrapper(nif_gui_color_panel), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_color_bar_alpha", .arity = 3, .fptr = core.nif_wrapper(nif_gui_color_bar_alpha), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_color_bar_hue", .arity = 3, .fptr = core.nif_wrapper(nif_gui_color_bar_hue), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_color_picker_hsv", .arity = 3, .fptr = core.nif_wrapper(nif_gui_color_picker_hsv), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_color_picker_hsv", .arity = 4, .fptr = core.nif_wrapper(nif_gui_color_picker_hsv), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_color_panel_hsv", .arity = 3, .fptr = core.nif_wrapper(nif_gui_color_panel_hsv), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gui_color_panel_hsv", .arity = 4, .fptr = core.nif_wrapper(nif_gui_color_panel_hsv), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

//////////////////////////////////////////
//  Global gui state control functions  //
//////////////////////////////////////////

/// Enable gui controls (global state)
///
/// raygui.h
/// RAYGUIAPI void GuiEnable(void);
fn nif_gui_enable(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.GuiEnable();

    // Return

    return core.Atom.make(env, "ok");
}

/// Disable gui controls (global state)
///
/// raygui.h
/// RAYGUIAPI void GuiDisable(void);
fn nif_gui_disable(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.GuiDisable();

    // Return

    return core.Atom.make(env, "ok");
}

/// Lock gui controls (global state)
///
/// raygui.h
/// RAYGUIAPI void GuiLock(void);
fn nif_gui_lock(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.GuiLock();

    // Return

    return core.Atom.make(env, "ok");
}

/// Unlock gui controls (global state)
///
/// raygui.h
/// RAYGUIAPI void GuiUnlock(void);
fn nif_gui_unlock(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.GuiUnlock();

    // Return

    return core.Atom.make(env, "ok");
}

/// Check if gui is locked (global state)
///
/// raygui.h
/// RAYGUIAPI bool GuiIsLocked(void);
fn nif_gui_is_locked(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const gui_is_locked = rl.GuiIsLocked();

    // Return

    return core.Boolean.make(env, gui_is_locked);
}

/// Set gui controls alpha (global state), alpha goes from 0.0f to 1.0f
///
/// raygui.h
/// RAYGUIAPI void GuiSetAlpha(float alpha);
fn nif_gui_set_alpha(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const alpha = core.Float.get(env, argv[0]) catch {
        return error.invalid_argument_alpha;
    };

    // Function

    rl.GuiSetAlpha(alpha);

    // Return

    return core.Atom.make(env, "ok");
}

/// Set gui state (global state)
///
/// raygui.h
/// RAYGUIAPI void GuiSetState(int state);
fn nif_gui_set_state(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const state = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_state;
    };

    // Function

    rl.GuiSetState(state);

    // Return

    return core.Atom.make(env, "ok");
}

/// Get gui state (global state)
///
/// raygui.h
/// RAYGUIAPI int GuiGetState(void);
fn nif_gui_get_state(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const state = rl.GuiGetState();

    // Return

    return core.Int.make(env, state);
}

//////////////////////////////
//  Font set/get functions  //
//////////////////////////////

/// Set gui custom font (global state)
///
/// raygui.h
/// RAYGUIAPI void GuiSetFont(Font font);
fn nif_gui_set_font(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_font = core.Argument(core.Font).get(env, argv[0]) catch {
        return error.invalid_argument_font;
    };
    defer arg_font.free();
    const font = arg_font.data;

    // Function

    rl.GuiSetFont(font);

    // Return

    return core.Atom.make(env, "ok");
}

/// Get gui custom font (global state)
///
/// raygui.h
/// RAYGUIAPI Font GuiGetFont(void);
fn nif_gui_get_font(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0 or argc == 1);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 0);

    // Function

    const font = rl.GuiGetFont();
    defer if (!return_resource) core.Font.unload(font);
    errdefer if (return_resource) core.Font.unload(font);

    // Return

    return core.maybe_make_struct_as_resource(core.Font, env, font, return_resource) catch {
        return error.invalid_return;
    };
}

///////////////////////////////
//  Style set/get functions  //
///////////////////////////////

/// Set one style property
///
/// raygui.h
/// RAYGUIAPI void GuiSetStyle(int control, int property, int value);
fn nif_gui_set_style(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const control = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_control;
    };

    const property = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_property;
    };

    const value = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_value;
    };

    // Function

    rl.GuiSetStyle(control, property, value);

    // Return

    return core.Atom.make(env, "ok");
}

/// Set one style property
///
/// raygui.h
/// RAYGUIAPI void GuiSetStyle(int control, int property, int value);
fn nif_gui_set_style_color(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const control = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_control;
    };

    const property = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_property;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    const value = rl.ColorToInt(color);
    rl.GuiSetStyle(control, property, value);

    // Return

    return core.Atom.make(env, "ok");
}

/// Get one style property
///
/// raygui.h
/// RAYGUIAPI int GuiGetStyle(int control, int property);
fn nif_gui_get_style(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const control = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_control;
    };

    const property = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_property;
    };

    // Function

    const style = rl.GuiGetStyle(control, property);

    // Return

    return core.Int.make(env, style);
}

/// Get one style property
///
/// raygui.h
/// RAYGUIAPI int GuiGetStyle(int control, int property);
fn nif_gui_get_style_color(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const control = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_control;
    };

    const property = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_property;
    };

    // Function

    const style = rl.GuiGetStyle(control, property);
    const color = rl.GetColor(@bitCast(style));
    defer if (!return_resource) core.Color.unload(color);
    errdefer if (return_resource) core.Color.unload(color);

    // Return

    return core.maybe_make_struct_as_resource(core.Color, env, color, return_resource) catch {
        return error.invalid_return;
    };
}

////////////////////////////////
//  Styles loading functions  //
////////////////////////////////

/// Load style file over global style variable (.rgs)
///
/// raygui.h
/// RAYGUIAPI void GuiLoadStyle(const char *fileName);
fn nif_gui_load_style(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_file_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_file_name;
    };
    defer arg_file_name.free();
    const file_name = arg_file_name.data;

    // Function

    rl.GuiLoadStyle(file_name);

    // Return

    return core.Atom.make(env, "ok");
}

/// Load style default over global style
///
/// raygui.h
/// RAYGUIAPI void GuiLoadStyleDefault(void);
fn nif_gui_load_style_default(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.GuiLoadStyleDefault();

    // Return

    return core.Atom.make(env, "ok");
}

/////////////////////////////////////
//  Tooltips management functions  //
/////////////////////////////////////

/// Enable gui tooltips (global state)
///
/// raygui.h
/// RAYGUIAPI void GuiEnableTooltip(void);
fn nif_gui_enable_tooltip(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.GuiEnableTooltip();

    // Return

    return core.Atom.make(env, "ok");
}

/// Disable gui tooltips (global state)
///
/// raygui.h
/// RAYGUIAPI void GuiDisableTooltip(void);
fn nif_gui_disable_tooltip(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.GuiDisableTooltip();

    // Return

    return core.Atom.make(env, "ok");
}

/// Set tooltip string
///
/// raygui.h
/// RAYGUIAPI void GuiSetTooltip(const char *tooltip);
fn nif_gui_set_tooltip(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_tooltip = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_tooltip;
    };
    defer arg_tooltip.free();
    const tooltip = arg_tooltip.data;

    // Function

    rl.GuiSetTooltip(tooltip);

    // Return

    return core.Atom.make(env, "ok");
}

///////////////////////////
//  Icons functionality  //
///////////////////////////

/// Get text with icon id prepended (if supported)
///
/// raygui.h
/// RAYGUIAPI const char *GuiIconText(int iconId, const char *text);
fn nif_gui_icon_text(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const icon_id = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_icon_id;
    };

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    // Function

    const icon_text = rl.GuiIconText(icon_id, text);
    // Do NOT free icon_text

    // Return

    return core.CString.make_c_unknown(env, icon_text);
}

/// Set default icon drawing size
///
/// raygui.h
/// RAYGUIAPI void GuiSetIconScale(int scale);
fn nif_gui_set_icon_scale(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const scale = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_scale;
    };

    // Function

    rl.GuiSetIconScale(scale);

    // Return

    return core.Atom.make(env, "ok");
}

/// Get raygui icons data pointer
///
/// raygui.h
/// RAYGUIAPI unsigned int *GuiGetIcons(void);
fn nif_gui_get_icons(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const icons_c = rl.GuiGetIcons();
    // Do NOT free icons_c

    // Return

    const icons_lengths = [_]usize{rl.RAYGUI_ICON_MAX_ICONS * rl.RAYGUI_ICON_DATA_ELEMENTS};

    return core.Array.make_c(core.UInt, core.UInt.data_type, env, icons_c, &icons_lengths);
}

/// Load raygui icons file (.rgi) into internal icons data
///
/// raygui.h
/// RAYGUIAPI char **GuiLoadIcons(const char *fileName, bool loadIconsName);
fn nif_gui_load_icons(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_file_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_file_name;
    };
    defer arg_file_name.free();
    const file_name = arg_file_name.data;

    // Function

    _ = rl.GuiLoadIcons(file_name, false);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw icon using pixel size at specified position
///
/// raygui.h
/// RAYGUIAPI void GuiDrawIcon(int iconId, int posX, int posY, int pixelSize, Color color);
fn nif_gui_draw_icon(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const icon_id = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_icon_id;
    };

    const pos_x = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_pos_x;
    };

    const pos_y = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_pos_y;
    };

    const pixel_size = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_pixel_size;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.GuiDrawIcon(icon_id, pos_x, pos_y, pixel_size, color);

    // Return

    return core.Atom.make(env, "ok");
}

////////////////
//  Controls  //
////////////////

/// Window Box control, shows a window that can be closed
///
/// raygui.h
/// RAYGUIAPI int GuiWindowBox(Rectangle bounds, const char *title);
fn nif_gui_window_box(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_title = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_title;
    };
    defer arg_title.free();
    const title = arg_title.data;

    // Function

    const should_close = rl.GuiWindowBox(bounds, title) != 0;

    // Return

    return core.Boolean.make(env, should_close);
}

/// Group Box control with text name
///
/// raygui.h
/// RAYGUIAPI int GuiGroupBox(Rectangle bounds, const char *text);
fn nif_gui_group_box(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    // Function

    _ = rl.GuiGroupBox(bounds, text);

    // Return

    return core.Atom.make(env, "ok");
}

/// Line separator control, could contain text
///
/// raygui.h
/// RAYGUIAPI int GuiLine(Rectangle bounds, const char *text);
fn nif_gui_line(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    // Function

    _ = rl.GuiLine(bounds, text);

    // Return

    return core.Atom.make(env, "ok");
}

/// Panel control, useful to group controls
///
/// raygui.h
/// RAYGUIAPI int GuiPanel(Rectangle bounds, const char *text);
fn nif_gui_panel(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    // Function

    _ = rl.GuiPanel(bounds, text);

    // Return

    return core.Atom.make(env, "ok");
}

/// Tab Bar control, returns TAB to be closed or -1
///
/// raygui.h
/// RAYGUIAPI int GuiTabBar(Rectangle bounds, const char **text, int count, int *active);
fn nif_gui_tab_bar(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const count = core.Array.get_length(env, argv[1]) catch {
        return error.invalid_argument_text;
    };

    const text_lenghts = [_]usize{ count, 0 };
    const text = try core.Array.get_c(core.CString, [*c]u8, rl.allocator, env, argv[1], &text_lenghts);
    defer core.Array.free_c(core.CString, [*c]u8, rl.allocator, text, &text_lenghts, null);

    var active = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_active;
    };

    // Function

    const should_close = rl.GuiTabBar(bounds, @ptrCast(text), @intCast(count), &active);

    // Return

    const term_should_close = if (should_close != -1) core.Int.make(env, should_close) else core.Boolean.make(env, false);

    const term_active = core.Int.make(env, active);

    return core.Tuple.make(env, &[_]e.ErlNifTerm{
        term_should_close,
        term_active,
    });
}

/// Scroll Panel control
///
/// raygui.h
/// RAYGUIAPI int GuiScrollPanel(Rectangle bounds, const char *text, Rectangle content, Vector2 *scroll, Rectangle *view);
fn nif_gui_scroll_panel(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource_scroll = core.must_return_resource_auto(env, argc, argv, 5, argv[3]);
    const return_resource_view = core.must_return_resource_auto(env, argc, argv, 5, argv[4]);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    const arg_content = core.Argument(core.Rectangle).get(env, argv[2]) catch {
        return error.invalid_argument_content;
    };
    defer arg_content.free();
    const content = arg_content.data;

    var arg_scroll = core.Argument(core.Vector2).get(env, argv[3]) catch {
        return error.invalid_argument_scroll;
    };
    defer if (!return_resource_scroll) arg_scroll.free();
    errdefer if (return_resource_scroll) arg_scroll.free();
    const scroll = &arg_scroll.data;

    var arg_view = core.Argument(core.Rectangle).get(env, argv[4]) catch {
        return error.invalid_argument_view;
    };
    defer if (!return_resource_view) arg_view.free();
    errdefer if (return_resource_view) arg_view.free();
    const view = &arg_view.data;

    // Function

    _ = rl.GuiScrollPanel(bounds, text, content, @ptrCast(scroll), @ptrCast(view));

    // Return

    const term_scroll = core.maybe_make_struct_or_resource(core.Vector2, env, argv[3], scroll.*, return_resource_scroll) catch {
        return error.invalid_return;
    };

    const term_view = core.maybe_make_struct_or_resource(core.Rectangle, env, argv[4], view.*, return_resource_view) catch {
        return error.invalid_return;
    };

    return core.Tuple.make(env, &[_]e.ErlNifTerm{
        term_scroll,
        term_view,
    });
}

//////////////////////////
//  Basic controls set  //
//////////////////////////

/// Label control
///
/// raygui.h
/// RAYGUIAPI int GuiLabel(Rectangle bounds, const char *text);
fn nif_gui_label(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    // Function

    _ = rl.GuiLabel(bounds, text);

    // Return

    return core.Atom.make(env, "ok");
}

/// Button control, returns true when clicked
///
/// raygui.h
/// RAYGUIAPI int GuiButton(Rectangle bounds, const char *text);
fn nif_gui_button(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    // Function

    const pressed = rl.GuiButton(bounds, text) != 0;

    // Return

    return core.Boolean.make(env, pressed);
}

/// Label button control, returns true when clicked
///
/// raygui.h
/// RAYGUIAPI int GuiLabelButton(Rectangle bounds, const char *text);
fn nif_gui_label_button(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    // Function

    const pressed = rl.GuiLabelButton(bounds, text) != 0;

    // Return

    return core.Boolean.make(env, pressed);
}

/// Toggle Button control
///
/// raygui.h
/// RAYGUIAPI int GuiToggle(Rectangle bounds, const char *text, bool *active);
fn nif_gui_toggle(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    var active = core.Boolean.get(env, argv[2]) catch {
        return error.invalid_argument_active;
    };

    // Function

    _ = rl.GuiToggle(bounds, text, &active);

    // Return

    return core.Boolean.make(env, active);
}

/// Toggle Group control
///
/// raygui.h
/// RAYGUIAPI int GuiToggleGroup(Rectangle bounds, const char *text, int *active);
fn nif_gui_toggle_group(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    var active = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_active;
    };

    // Function

    _ = rl.GuiToggleGroup(bounds, text, &active);

    // Return

    return core.Int.make(env, active);
}

/// Toggle Slider control
///
/// raygui.h
/// RAYGUIAPI int GuiToggleSlider(Rectangle bounds, const char *text, int *active);
fn nif_gui_toggle_slider(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    var active = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_active;
    };

    // Function

    _ = rl.GuiToggleSlider(bounds, text, &active);

    // Return

    return core.Int.make(env, active);
}

/// Check Box control, returns true when active
///
/// raygui.h
/// RAYGUIAPI int GuiCheckBox(Rectangle bounds, const char *text, bool *checked);
fn nif_gui_check_box(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    var checked = core.Boolean.get(env, argv[2]) catch {
        return error.invalid_argument_checked;
    };

    // Function

    const changed = rl.GuiCheckBox(bounds, text, &checked) != 0;

    // Return

    const term_changed = core.Boolean.make(env, changed);

    const term_checked = core.Boolean.make(env, checked);

    return core.Tuple.make(env, &[_]e.ErlNifTerm{
        term_changed,
        term_checked,
    });
}

/// Combo Box control
///
/// raygui.h
/// RAYGUIAPI int GuiComboBox(Rectangle bounds, const char *text, int *active);
fn nif_gui_combo_box(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    var active = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_active;
    };

    // Function

    _ = rl.GuiComboBox(bounds, text, &active);

    // Return

    return core.Int.make(env, active);
}

/// Dropdown Box control
///
/// raygui.h
/// RAYGUIAPI int GuiDropdownBox(Rectangle bounds, const char *text, int *active, bool editMode);
fn nif_gui_dropdown_box(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    var active = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_active;
    };

    const edit_mode = core.Boolean.get(env, argv[3]) catch {
        return error.invalid_argument_edit_mode;
    };

    // Function

    const pressed = rl.GuiDropdownBox(bounds, text, &active, edit_mode) != 0;

    // Return

    const term_pressed = core.Boolean.make(env, pressed);

    const term_active = core.Int.make(env, active);

    return core.Tuple.make(env, &[_]e.ErlNifTerm{
        term_pressed,
        term_active,
    });
}

/// Spinner control
///
/// raygui.h
/// RAYGUIAPI int GuiSpinner(Rectangle bounds, const char *text, int *value, int minValue, int maxValue, bool editMode);
fn nif_gui_spinner(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    var value = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_value;
    };

    const min_value = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_min_value;
    };

    const max_value = core.Int.get(env, argv[4]) catch {
        return error.invalid_argument_max_value;
    };

    const edit_mode = core.Boolean.get(env, argv[5]) catch {
        return error.invalid_argument_edit_mode;
    };

    // Function

    const changed = rl.GuiSpinner(bounds, text, &value, min_value, max_value, edit_mode) != 0;

    // Return

    const term_changed = core.Boolean.make(env, changed);

    const term_value = core.Int.make(env, value);

    return core.Tuple.make(env, &[_]e.ErlNifTerm{
        term_changed,
        term_value,
    });
}

/// Value Box control, updates input text with numbers
///
/// raygui.h
/// RAYGUIAPI int GuiValueBox(Rectangle bounds, const char *text, int *value, int minValue, int maxValue, bool editMode);
fn nif_gui_value_box(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    var value = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_value;
    };

    const min_value = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_min_value;
    };

    const max_value = core.Int.get(env, argv[4]) catch {
        return error.invalid_argument_max_value;
    };

    const edit_mode = core.Boolean.get(env, argv[5]) catch {
        return error.invalid_argument_edit_mode;
    };

    // Function

    const changed = rl.GuiValueBox(bounds, text, &value, min_value, max_value, edit_mode) != 0;

    // Return

    const term_changed = core.Boolean.make(env, changed);

    const term_value = core.Int.make(env, value);

    return core.Tuple.make(env, &[_]e.ErlNifTerm{
        term_changed,
        term_value,
    });
}

/// Value box control for float values
///
/// raygui.h
/// RAYGUIAPI int GuiValueBoxFloat(Rectangle bounds, const char *text, char *textValue, float *value, bool editMode);
fn nif_gui_value_box_float(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    var arg_text_value = core.ArgumentBinaryC(core.CString, rl.allocator).get(env, argv[2], rl.RAYGUI_VALUEBOX_MAX_CHARS) catch {
        return error.invalid_argument_text_value;
    };
    defer arg_text_value.free();
    const text_value = arg_text_value.data;

    var value = core.Float.get(env, argv[3]) catch {
        return error.invalid_argument_value;
    };

    const edit_mode = core.Boolean.get(env, argv[4]) catch {
        return error.invalid_argument_edit_mode;
    };

    // Function

    const changed = rl.GuiValueBoxFloat(bounds, text, text_value, &value, edit_mode) != 0;

    // Return

    const term_changed = core.Boolean.make(env, changed);

    const term_text_value = core.CString.make_c_unknown(env, text_value);

    const term_value = core.Float.make(env, value);

    return core.Tuple.make(env, &[_]e.ErlNifTerm{
        term_changed,
        term_text_value,
        term_value,
    });
}

/// Text Box control, updates input text
///
/// raygui.h
/// RAYGUIAPI int GuiTextBox(Rectangle bounds, char *text, int textSize, bool editMode);
fn nif_gui_text_box(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const text_max_size = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_text_max_size;
    };

    var arg_text = core.ArgumentBinaryC(core.CString, rl.allocator).get(env, argv[1], @intCast(text_max_size)) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    const edit_mode = core.Boolean.get(env, argv[3]) catch {
        return error.invalid_argument_edit_mode;
    };

    // Function

    const changed = rl.GuiTextBox(bounds, text, text_max_size, edit_mode) != 0;

    // Return

    const term_changed = core.Boolean.make(env, changed);

    const term_text = core.CString.make_c_unknown(env, text);

    return core.Tuple.make(env, &[_]e.ErlNifTerm{
        term_changed,
        term_text,
    });
}

/// Slider control
///
/// raygui.h
/// RAYGUIAPI int GuiSlider(Rectangle bounds, const char *textLeft, const char *textRight, float *value, float minValue, float maxValue);
fn nif_gui_slider(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text_left = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text_left;
    };
    defer arg_text_left.free();
    const text_left = arg_text_left.data;

    const arg_text_right = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[2]) catch {
        return error.invalid_argument_text_right;
    };
    defer arg_text_right.free();
    const text_right = arg_text_right.data;

    var value = core.Float.get(env, argv[3]) catch {
        return error.invalid_argument_value;
    };

    const min_value = core.Float.get(env, argv[4]) catch {
        return error.invalid_argument_min_value;
    };

    const max_value = core.Float.get(env, argv[5]) catch {
        return error.invalid_argument_max_value;
    };

    // Function

    const changed = rl.GuiSlider(bounds, text_left, text_right, &value, min_value, max_value) != 0;

    // Return

    const term_changed = core.Boolean.make(env, changed);

    const term_value = core.Float.make(env, value);

    return core.Tuple.make(env, &[_]e.ErlNifTerm{
        term_changed,
        term_value,
    });
}

/// Slider Bar control
///
/// raygui.h
/// RAYGUIAPI int GuiSliderBar(Rectangle bounds, const char *textLeft, const char *textRight, float *value, float minValue, float maxValue);
fn nif_gui_slider_bar(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text_left = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text_left;
    };
    defer arg_text_left.free();
    const text_left = arg_text_left.data;

    const arg_text_right = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[2]) catch {
        return error.invalid_argument_text_right;
    };
    defer arg_text_right.free();
    const text_right = arg_text_right.data;

    var value = core.Float.get(env, argv[3]) catch {
        return error.invalid_argument_value;
    };

    const min_value = core.Float.get(env, argv[4]) catch {
        return error.invalid_argument_min_value;
    };

    const max_value = core.Float.get(env, argv[5]) catch {
        return error.invalid_argument_max_value;
    };

    // Function

    const changed = rl.GuiSliderBar(bounds, text_left, text_right, &value, min_value, max_value) != 0;

    // Return

    const term_changed = core.Boolean.make(env, changed);

    const term_value = core.Float.make(env, value);

    return core.Tuple.make(env, &[_]e.ErlNifTerm{
        term_changed,
        term_value,
    });
}

/// Progress Bar control
///
/// raygui.h
/// RAYGUIAPI int GuiProgressBar(Rectangle bounds, const char *textLeft, const char *textRight, float *value, float minValue, float maxValue);
fn nif_gui_progress_bar(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text_left = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text_left;
    };
    defer arg_text_left.free();
    const text_left = arg_text_left.data;

    const arg_text_right = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[2]) catch {
        return error.invalid_argument_text_right;
    };
    defer arg_text_right.free();
    const text_right = arg_text_right.data;

    var value = core.Float.get(env, argv[3]) catch {
        return error.invalid_argument_value;
    };

    const min_value = core.Float.get(env, argv[4]) catch {
        return error.invalid_argument_min_value;
    };

    const max_value = core.Float.get(env, argv[5]) catch {
        return error.invalid_argument_max_value;
    };

    // Function

    _ = rl.GuiProgressBar(bounds, text_left, text_right, &value, min_value, max_value);

    // Return

    return core.Float.make(env, value);
}

/// Status Bar control, shows info text
///
/// raygui.h
/// RAYGUIAPI int GuiStatusBar(Rectangle bounds, const char *text);
fn nif_gui_status_bar(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    // Function

    _ = rl.GuiStatusBar(bounds, text);

    // Return

    return core.Atom.make(env, "ok");
}

/// Dummy control for placeholders
///
/// raygui.h
/// RAYGUIAPI int GuiDummyRec(Rectangle bounds, const char *text);
fn nif_gui_dummy_rec(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    // Function

    _ = rl.GuiDummyRec(bounds, text);

    // Return

    return core.Atom.make(env, "ok");
}

/// Grid control
///
/// raygui.h
/// RAYGUIAPI int GuiGrid(Rectangle bounds, const char *text, float spacing, int subdivs, Vector2 *mouseCell);
fn nif_gui_grid(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource_mouse_cell = core.must_return_resource_auto(env, argc, argv, 5, argv[4]);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    const spacing = core.Float.get(env, argv[2]) catch {
        return error.invalid_argument_spacing;
    };

    const subdivs = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_sub_divs;
    };

    var arg_mouse_cell = core.Argument(core.Vector2).get(env, argv[4]) catch {
        return error.invalid_argument_mouse_cell;
    };
    defer if (!return_resource_mouse_cell) arg_mouse_cell.free();
    errdefer if (return_resource_mouse_cell) arg_mouse_cell.free();
    const mouse_cell = &arg_mouse_cell.data;

    // Function

    _ = rl.GuiGrid(bounds, text, spacing, subdivs, @ptrCast(mouse_cell));

    // Return

    return core.maybe_make_struct_or_resource(core.Vector2, env, argv[4], mouse_cell.*, return_resource_mouse_cell) catch {
        return error.invalid_return;
    };
}

////////////////////////////
//  Advance controls set  //
////////////////////////////

/// List View control
///
/// raygui.h
/// RAYGUIAPI int GuiListView(Rectangle bounds, const char *text, int *scrollIndex, int *active);
fn nif_gui_list_view(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    var scroll_index = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_scroll_index;
    };

    var active = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_active;
    };

    // Function

    _ = rl.GuiListView(bounds, text, &scroll_index, &active);

    // Return

    const term_scroll_index = core.Int.make(env, scroll_index);

    const term_active = core.Int.make(env, active);

    return core.Tuple.make(env, &[_]e.ErlNifTerm{
        term_scroll_index,
        term_active,
    });
}

/// List View with extended parameters
///
/// raygui.h
/// RAYGUIAPI int GuiListViewEx(Rectangle bounds, const char **text, int count, int *scrollIndex, int *active, int *focus);
fn nif_gui_list_view_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const count = core.Array.get_length(env, argv[1]) catch {
        return error.invalid_argument_text;
    };

    const text_lenghts = [_]usize{ count, 0 };
    const text = try core.Array.get_c(core.CString, [*c]u8, rl.allocator, env, argv[1], &text_lenghts);
    defer core.Array.free_c(core.CString, [*c]u8, rl.allocator, text, &text_lenghts, null);

    var scroll_index = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_scroll_index;
    };

    var active = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_active;
    };

    var focus = core.Int.get(env, argv[4]) catch {
        return error.invalid_argument_focus;
    };

    // Function

    _ = rl.GuiListViewEx(bounds, @ptrCast(text), @intCast(count), &scroll_index, &active, &focus);

    // Return

    const term_scroll_index = core.Int.make(env, scroll_index);

    const term_active = core.Int.make(env, active);

    const term_focus = core.Int.make(env, focus);

    return core.Tuple.make(env, &[_]e.ErlNifTerm{
        term_scroll_index,
        term_active,
        term_focus,
    });
}

/// Message Box control, displays a message
///
/// raygui.h
/// RAYGUIAPI int GuiMessageBox(Rectangle bounds, const char *title, const char *message, const char *buttons);
fn nif_gui_message_box(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_title = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_title;
    };
    defer arg_title.free();
    const title = arg_title.data;

    const arg_message = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[2]) catch {
        return error.invalid_argument_message;
    };
    defer arg_message.free();
    const message = arg_message.data;

    const arg_buttons = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[3]) catch {
        return error.invalid_argument_buttons;
    };
    defer arg_buttons.free();
    const buttons = arg_buttons.data;

    // Function

    const result = rl.GuiMessageBox(bounds, title, message, buttons);

    // Return

    const term_should_close = core.Boolean.make(env, result == 0);

    const term_button_pressed = if (result != -1) core.Int.make(env, result) else core.Boolean.make(env, false);

    return core.Tuple.make(env, &[_]e.ErlNifTerm{
        term_should_close,
        term_button_pressed,
    });
}

/// Text Input Box control, ask for text, supports secret
///
/// raygui.h
/// RAYGUIAPI int GuiTextInputBox(Rectangle bounds, const char *title, const char *message, const char *buttons, char *text, int textMaxSize, bool *secretViewActive);
fn nif_gui_text_input_box(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 7);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_title = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_title;
    };
    defer arg_title.free();
    const title = arg_title.data;

    const arg_message = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[2]) catch {
        return error.invalid_argument_message;
    };
    defer arg_message.free();
    const message = arg_message.data;

    const arg_buttons = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[3]) catch {
        return error.invalid_argument_buttons;
    };
    defer arg_buttons.free();
    const buttons = arg_buttons.data;

    const text_max_size = core.Int.get(env, argv[5]) catch {
        return error.invalid_argument_text_max_size;
    };

    var arg_text = core.ArgumentBinaryC(core.CString, rl.allocator).get(env, argv[4], @intCast(text_max_size)) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    var secret_view_active: [*c]bool = undefined;

    if (e.enif_is_identical(core.Atom.make(env, "nil"), argv[6]) != 0) {
        secret_view_active = null;
    } else {
        secret_view_active.* = core.Boolean.get(env, argv[6]) catch {
            return error.invalid_argument_secret_view_active;
        };
    }

    // Function

    const result = rl.GuiTextInputBox(bounds, title, message, buttons, text, text_max_size, secret_view_active);

    // Return

    const term_should_close = core.Boolean.make(env, result == 0);

    const term_button_pressed = if (result != -1) core.Int.make(env, result) else core.Boolean.make(env, false);

    const term_text = core.CString.make_c_unknown(env, text);

    const term_secret_view_active = if (secret_view_active == null) core.Atom.make(env, "nil") else core.Boolean.make(env, secret_view_active.*);

    return core.Tuple.make(env, &[_]e.ErlNifTerm{
        term_should_close,
        term_button_pressed,
        term_text,
        term_secret_view_active,
    });
}

/// Color Picker control (multiple color controls)
///
/// raygui.h
/// RAYGUIAPI int GuiColorPicker(Rectangle bounds, const char *text, Color *color);
fn nif_gui_color_picker(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource_color = core.must_return_resource_auto(env, argc, argv, 3, argv[2]);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    var arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer if (!return_resource_color) arg_color.free();
    errdefer if (return_resource_color) arg_color.free();
    const color = &arg_color.data;

    // Function

    _ = rl.GuiColorPicker(bounds, text, @ptrCast(color));

    // Return

    return core.maybe_make_struct_or_resource(core.Color, env, argv[2], color.*, return_resource_color) catch {
        return error.invalid_return;
    };
}

/// Color Panel control
///
/// raygui.h
/// RAYGUIAPI int GuiColorPanel(Rectangle bounds, const char *text, Color *color);
fn nif_gui_color_panel(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource_color = core.must_return_resource_auto(env, argc, argv, 3, argv[2]);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    var arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer if (!return_resource_color) arg_color.free();
    errdefer if (return_resource_color) arg_color.free();
    const color = &arg_color.data;

    // Function

    _ = rl.GuiColorPanel(bounds, text, @ptrCast(color));

    // Return

    return core.maybe_make_struct_or_resource(core.Color, env, argv[2], color.*, return_resource_color) catch {
        return error.invalid_return;
    };
}

/// Color Bar Alpha control
///
/// raygui.h
/// RAYGUIAPI int GuiColorBarAlpha(Rectangle bounds, const char *text, float *alpha);
fn nif_gui_color_bar_alpha(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    var alpha = core.Float.get(env, argv[2]) catch {
        return error.invalid_argument_alpha;
    };

    // Function

    _ = rl.GuiColorBarAlpha(bounds, text, &alpha);

    // Return

    return core.Float.make(env, alpha);
}

/// Color Bar Hue control
///
/// raygui.h
/// RAYGUIAPI int GuiColorBarHue(Rectangle bounds, const char *text, float *value);
fn nif_gui_color_bar_hue(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    var value = core.Float.get(env, argv[2]) catch {
        return error.invalid_argument_value;
    };

    // Function

    _ = rl.GuiColorBarHue(bounds, text, &value);

    // Return

    return core.Float.make(env, value);
}

/// Color Picker control that avoids conversion to RGB on each call (multiple color controls)
///
/// raygui.h
/// RAYGUIAPI int GuiColorPickerHSV(Rectangle bounds, const char *text, Vector3 *colorHsv);
fn nif_gui_color_picker_hsv(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource_color_hsv = core.must_return_resource_auto(env, argc, argv, 3, argv[2]);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    var arg_color_hsv = core.Argument(core.Vector3).get(env, argv[2]) catch {
        return error.invalid_argument_color_hsv;
    };
    defer if (!return_resource_color_hsv) arg_color_hsv.free();
    errdefer if (return_resource_color_hsv) arg_color_hsv.free();
    const color_hsv = &arg_color_hsv.data;

    // Function

    _ = rl.GuiColorPickerHSV(bounds, text, @ptrCast(color_hsv));

    // Return

    return core.maybe_make_struct_or_resource(core.Vector3, env, argv[2], color_hsv.*, return_resource_color_hsv) catch {
        return error.invalid_return;
    };
}

/// Color Panel control that updates Hue-Saturation-Value color value, used by GuiColorPickerHSV()
///
/// raygui.h
/// RAYGUIAPI int GuiColorPanelHSV(Rectangle bounds, const char *text, Vector3 *colorHsv);
fn nif_gui_color_panel_hsv(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource_color_hsv = core.must_return_resource_auto(env, argc, argv, 3, argv[2]);

    // Arguments

    const arg_bounds = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_bounds;
    };
    defer arg_bounds.free();
    const bounds = arg_bounds.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    var arg_color_hsv = core.Argument(core.Vector3).get(env, argv[2]) catch {
        return error.invalid_argument_color_hsv;
    };
    defer if (!return_resource_color_hsv) arg_color_hsv.free();
    errdefer if (return_resource_color_hsv) arg_color_hsv.free();
    const color_hsv = &arg_color_hsv.data;

    // Function

    _ = rl.GuiColorPanelHSV(bounds, text, @ptrCast(color_hsv));

    // Return

    return core.maybe_make_struct_or_resource(core.Vector3, env, argv[2], color_hsv.*, return_resource_color_hsv) catch {
        return error.invalid_return;
    };
}
