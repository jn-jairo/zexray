const e = @import("./erl_nif.zig");

const resources = @import("./resources.zig");

fn load(env: ?*e.ErlNifEnv, priv_data: [*c]?*anyopaque, load_info: e.ErlNifTerm) callconv(.C) c_int {
    if (!resources.load_resources(env)) return -1;

    _ = priv_data;
    _ = load_info;

    return 0;
}

fn upgrade(env: ?*e.ErlNifEnv, priv_data: [*c]?*anyopaque, old_priv_data: [*c]?*anyopaque, load_info: e.ErlNifTerm) callconv(.C) c_int {
    if (!resources.load_resources(env)) return -1;

    _ = priv_data;
    _ = old_priv_data;
    _ = load_info;

    return 0;
}

fn unload(env: ?*e.ErlNifEnv, priv_data: ?*anyopaque) callconv(.C) void {
    _ = env;
    _ = priv_data;
}

const nif_resource = @import("./nifs/resource.zig");
const nif_audio = @import("./nifs/audio.zig");
const nif_camera = @import("./nifs/camera.zig");
const nif_color = @import("./nifs/color.zig");
const nif_constant = @import("./nifs/constant.zig");
const nif_cursor = @import("./nifs/cursor.zig");
const nif_drawing = @import("./nifs/drawing.zig");
const nif_file_system = @import("./nifs/file_system.zig");
const nif_font = @import("./nifs/font.zig");
const nif_frame_control = @import("./nifs/frame_control.zig");
const nif_gamepad = @import("./nifs/gamepad.zig");
const nif_gesture = @import("./nifs/gesture.zig");
const nif_gl = @import("./nifs/gl.zig");
const nif_gui = @import("./nifs/gui.zig");
const nif_image = @import("./nifs/image.zig");
const nif_keyboard = @import("./nifs/keyboard.zig");
const nif_monitor = @import("./nifs/monitor.zig");
const nif_mouse = @import("./nifs/mouse.zig");
const nif_random = @import("./nifs/random.zig");
const nif_screen_space = @import("./nifs/screen_space.zig");
const nif_shader = @import("./nifs/shader.zig");
const nif_shape = @import("./nifs/shape.zig");
const nif_shape_3d = @import("./nifs/shape_3d.zig");
const nif_text = @import("./nifs/text.zig");
const nif_texture = @import("./nifs/texture.zig");
const nif_timing = @import("./nifs/timing.zig");
const nif_touch = @import("./nifs/touch.zig");
const nif_trace_log = @import("./nifs/trace_log.zig");
const nif_util = @import("./nifs/util.zig");
const nif_vr = @import("./nifs/vr.zig");
const nif_window = @import("./nifs/window.zig");

const exported_nifs = nif_resource.exported_nifs ++
    nif_audio.exported_nifs ++
    nif_camera.exported_nifs ++
    nif_color.exported_nifs ++
    nif_constant.exported_nifs ++
    nif_cursor.exported_nifs ++
    nif_drawing.exported_nifs ++
    nif_file_system.exported_nifs ++
    nif_font.exported_nifs ++
    nif_frame_control.exported_nifs ++
    nif_gamepad.exported_nifs ++
    nif_gesture.exported_nifs ++
    nif_gl.exported_nifs ++
    nif_gui.exported_nifs ++
    nif_image.exported_nifs ++
    nif_keyboard.exported_nifs ++
    nif_monitor.exported_nifs ++
    nif_mouse.exported_nifs ++
    nif_random.exported_nifs ++
    nif_screen_space.exported_nifs ++
    nif_shader.exported_nifs ++
    nif_shape.exported_nifs ++
    nif_shape_3d.exported_nifs ++
    nif_text.exported_nifs ++
    nif_texture.exported_nifs ++
    nif_timing.exported_nifs ++
    nif_touch.exported_nifs ++
    nif_trace_log.exported_nifs ++
    nif_util.exported_nifs ++
    nif_vr.exported_nifs ++
    nif_window.exported_nifs;

const entry = e.ErlNifEntry{
    .major = e.ERL_NIF_MAJOR_VERSION,
    .minor = e.ERL_NIF_MINOR_VERSION,
    .name = "Elixir.Zexray.NIF",
    .num_of_funcs = exported_nifs.len,
    .funcs = @constCast(&exported_nifs),
    .load = load,
    .reload = null, // never supported as of OTP 20
    .upgrade = upgrade,
    .unload = unload,
    .vm_variant = e.ERL_NIF_VM_VARIANT,
    .options = 1,
    .sizeof_ErlNifResourceTypeInit = @sizeOf(e.ErlNifResourceTypeInit),
    .min_erts = e.ERL_NIF_MIN_ERTS_VERSION,
};

export fn nif_init() *const e.ErlNifEntry {
    return &entry;
}
