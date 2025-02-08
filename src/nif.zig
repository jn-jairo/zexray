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
const nif_font = @import("./nifs/font.zig");
const nif_image = @import("./nifs/image.zig");
const nif_material = @import("./nifs/material.zig");
const nif_mesh = @import("./nifs/mesh.zig");
const nif_model = @import("./nifs/model.zig");
const nif_shader = @import("./nifs/shader.zig");
const nif_util = @import("./nifs/util.zig");

const exported_nifs = nif_resource.exported_nifs ++
    nif_font.exported_nifs ++
    nif_image.exported_nifs ++
    nif_material.exported_nifs ++
    nif_mesh.exported_nifs ++
    nif_model.exported_nifs ++
    nif_shader.exported_nifs ++
    nif_util.exported_nifs;

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
