const std = @import("std");

const raylib = @import("raylib");
const raylib_config = @import("src/config.zig");

const PlatformBackend = raylib.PlatformBackend;
const LinuxDisplayBackend = raylib.LinuxDisplayBackend;
const OpenglVersion = raylib.OpenglVersion;

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const platform = b.option(PlatformBackend, "platform", "Choose the platform backend for desktop target") orelse PlatformBackend.glfw;
    const linux_display_backend = b.option(LinuxDisplayBackend, "linux_display_backend", "Linux display backend to use") orelse LinuxDisplayBackend.Both;
    const opengl_version = b.option(OpenglVersion, "opengl_version", "OpenGL version to use") orelse OpenglVersion.auto;

    const erts_include_path = b.option([]const u8, "erts_include_path", "include path for nif headers");
    const raylib_trace_log = b.option(bool, "raylib_trace_log", "raylib: trace log") orelse false;
    const raylib_trace_log_debug = b.option(bool, "raylib_trace_log_debug", "raylib: trace log debug") orelse false;
    const raylib_screen_capture = b.option(bool, "raylib_screen_capture", "raylib: allow automatic screen capture of current screen pressing F12") orelse false;
    const raylib_gif_recording = b.option(bool, "raylib_gif_recording", "raylib: allow automatic gif recording of current screen pressing CTRL+F12") orelse false;
    const raylib_custom_frame_control = b.option(bool, "raylib_custom_frame_control", "raylib: allows manual control of the frame processes, use at your own risk") orelse false;

    const options = b.addOptions();
    options.addOption(bool, "trace_log", raylib_trace_log);
    options.addOption(bool, "trace_log_debug", raylib_trace_log_debug);

    // depedency

    const config_raylib_tracelog = if (raylib_trace_log) "-DSUPPORT_TRACELOG=1" else "-DSUPPORT_TRACELOG= -USUPPORT_TRACELOG";
    const config_raylib_tracelog_debug = if (raylib_trace_log_debug) "-DSUPPORT_TRACELOG_DEBUG=1" else "-DSUPPORT_TRACELOG_DEBUG= -USUPPORT_TRACELOG_DEBUG";
    const config_raylib_screen_capture = if (raylib_screen_capture) "-DSUPPORT_SCREEN_CAPTURE=1" else "-DSUPPORT_SCREEN_CAPTURE= -USUPPORT_SCREEN_CAPTURE";
    const config_raylib_gif_recording = if (raylib_gif_recording) "-DSUPPORT_GIF_RECORDING=1" else "-DSUPPORT_GIF_RECORDING= -USUPPORT_GIF_RECORDING";
    const config_raylib_custom_frame_control = if (raylib_custom_frame_control) "-DSUPPORT_CUSTOM_FRAME_CONTROL=1" else "-DSUPPORT_CUSTOM_FRAME_CONTROL= -USUPPORT_CUSTOM_FRAME_CONTROL";

    var config_buf = std.ArrayList(u8).init(b.allocator);
    defer config_buf.deinit();
    const writer = config_buf.writer();

    try writer.writeAll(config_raylib_tracelog);
    try writer.writeAll(" ");
    try writer.writeAll(config_raylib_tracelog_debug);
    try writer.writeAll(" ");
    try writer.writeAll(config_raylib_screen_capture);
    try writer.writeAll(" ");
    try writer.writeAll(config_raylib_gif_recording);
    try writer.writeAll(" ");
    try writer.writeAll(config_raylib_custom_frame_control);

    if (erts_include_path) |path| {
        const erl_nif_path = try std.fs.path.join(b.allocator, &[_][]const u8{ path, "erl_nif.h" });
        try writer.print(" -include {s}", .{erl_nif_path});

        const nif_allocator_path = try b.path("src/nif_allocator.h").getPath3(b, null).toString(b.allocator);
        try writer.print(" -include {s}", .{nif_allocator_path});

        try writer.writeAll(" -DRL_MALLOC(sz)=nif_alloc(sz)");
        try writer.writeAll(" -DRL_CALLOC(n,sz)=nif_calloc(n,sz)");
        try writer.writeAll(" -DRL_REALLOC(ptr,sz)=nif_realloc(ptr,sz)");
        try writer.writeAll(" -DRL_FREE(ptr)=nif_free(ptr)");

        try writer.writeAll(" -DRPRAND_CALLOC(ptr,sz)=nif_calloc(ptr,sz)");
        try writer.writeAll(" -DRPRAND_FREE(ptr)=nif_free(ptr)");

        try writer.writeAll(" -DSTBTT_malloc(x,u)=((void)(u),nif_alloc(x))");
        try writer.writeAll(" -DSTBTT_free(x,u)=((void)(u),nif_free(x))");

        try writer.writeAll(" -DRAYGUI_MALLOC(sz)=nif_alloc(sz)");
        try writer.writeAll(" -DRAYGUI_CALLOC(n,sz)=nif_calloc(n,sz)");
        try writer.writeAll(" -DRAYGUI_FREE(p)=nif_free(p)");

        try writer.writeAll(" -DRAYGUI_SUPPORT_LOG_INFO= -URAYGUI_SUPPORT_LOG_INFO");
    }

    try writer.print(" -DFONT_TTF_DEFAULT_SIZE={}", .{raylib_config.FONT_TTF_DEFAULT_SIZE});
    try writer.print(" -DFONT_TTF_DEFAULT_NUMCHARS={}", .{raylib_config.FONT_TTF_DEFAULT_NUMCHARS});
    try writer.print(" -DFONT_TTF_DEFAULT_FIRST_CHAR={}", .{raylib_config.FONT_TTF_DEFAULT_FIRST_CHAR});
    try writer.print(" -DFONT_TTF_DEFAULT_CHARS_PADDING={}", .{raylib_config.FONT_TTF_DEFAULT_CHARS_PADDING});

    const config: []const u8 = config_buf.items;

    const raylib_pkg = getRaylib(b, target, optimize, config, platform, linux_display_backend, opengl_version);
    const raylib_lib = raylib_pkg.lib;
    const raylib_dep = raylib_pkg.dep;

    raylib_lib.addIncludePath(b.path("src"));

    if (erts_include_path) |path| {
        raylib_lib.addSystemIncludePath(.{ .cwd_relative = path });
    } else {
        raylib_lib.step.dependOn(&b.addFail("Missing include path for nif headers").step);
    }

    // nif_lib

    const nif_mod = b.createModule(.{
        .root_source_file = b.path("src/nif.zig"),
        .target = target,
        .optimize = optimize,
    });

    const nif_lib = b.addLibrary(.{
        .linkage = .dynamic,
        .name = "zexray",
        .root_module = nif_mod,
    });

    nif_lib.root_module.addOptions("config", options);

    nif_lib.addIncludePath(b.path("src"));

    nif_lib.addIncludePath(raylib_dep.path("src"));
    nif_lib.linkLibrary(raylib_lib);
    nif_lib.linkLibC();

    if (erts_include_path) |path| {
        nif_lib.addSystemIncludePath(.{ .cwd_relative = path });
    } else {
        nif_lib.step.dependOn(&b.addFail("Missing include path for nif headers").step);
    }

    b.installArtifact(nif_lib);
}

fn getRaylib(b: *std.Build, target: std.Build.ResolvedTarget, optimize: std.builtin.OptimizeMode, config: []const u8, platform: PlatformBackend, linux_display_backend: LinuxDisplayBackend, opengl_version: OpenglVersion) struct { lib: *std.Build.Step.Compile, dep: *std.Build.Dependency } {
    const raylib_dep = b.dependency("raylib", .{
        .target = target,
        .optimize = optimize,
        .config = config,
        .shared = false,
        .platform = platform,
        .linux_display_backend = linux_display_backend,
        .opengl_version = opengl_version,
    });

    const raygui_dep = b.dependency("raygui", .{
        .target = target,
        .optimize = optimize,
    });

    const lib = raylib_dep.artifact("raylib");

    if (platform == PlatformBackend.sdl) {
        lib.linkSystemLibrary("SDL2");
    }

    var gen_step = b.addWriteFiles();
    lib.step.dependOn(&gen_step.step);

    const raygui_c_path = gen_step.add("raygui.c", "#define RAYGUI_IMPLEMENTATION\n#include \"raygui.h\"\n");
    lib.addCSourceFile(.{
        .file = raygui_c_path,
        .flags = &[_][]const u8{
            "-std=gnu99",
            "-D_GNU_SOURCE",
            "-DGL_SILENCE_DEPRECATION=199309L",
            "-fno-sanitize=undefined", // https://github.com/raysan5/raylib/issues/3674
        },
    });

    lib.addIncludePath(raylib_dep.path("src"));
    lib.addIncludePath(raygui_dep.path("src"));

    lib.installHeader(raygui_dep.path("src/raygui.h"), "raygui.h");
    lib.installHeader(raylib_dep.path("src/external/miniaudio.h"), "miniaudio.h");
    lib.installHeader(raylib_dep.path("src/utils.h"), "utils.h");

    return .{
        .lib = lib,
        .dep = raylib_dep,
    };
}
