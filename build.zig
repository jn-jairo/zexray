const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const erts_include_path = b.option([]const u8, "erts_include_path", "include path for nif headers");
    const raylib_trace_log = b.option(bool, "raylib_trace_log", "raylib trace log") orelse false;
    const raylib_trace_log_debug = b.option(bool, "raylib_trace_log_debug", "raylib trace log debug") orelse false;

    // depedency

    const config_raylib_tracelog = if (raylib_trace_log) "-DSUPPORT_TRACELOG=1" else "-DSUPPORT_TRACELOG= -USUPPORT_TRACELOG";
    const config_raylib_tracelog_debug = if (raylib_trace_log_debug) "-DSUPPORT_TRACELOG_DEBUG=1" else "-DSUPPORT_TRACELOG_DEBUG= -USUPPORT_TRACELOG_DEBUG";

    var config_buf = std.ArrayList(u8).init(b.allocator);
    defer config_buf.deinit();
    const writer = config_buf.writer();

    try writer.writeAll(config_raylib_tracelog);
    try writer.writeAll(" ");
    try writer.writeAll(config_raylib_tracelog_debug);

    const config: []const u8 = config_buf.items;

    const raylib_artifact = getRaylib(b, target, optimize, config);

    // nif_lib

    const nif_lib = b.addSharedLibrary(.{
        .name = "zexray",
        .root_source_file = b.path("src/nif.zig"),
        .target = target,
        .optimize = optimize,
    });

    nif_lib.linkLibrary(raylib_artifact);
    nif_lib.linkLibC();

    if (erts_include_path) |path| {
        nif_lib.addSystemIncludePath(.{ .cwd_relative = path });
    }

    b.installArtifact(nif_lib);
}

fn getRaylib(b: *std.Build, target: std.Build.ResolvedTarget, optimize: std.builtin.OptimizeMode, config: []const u8) *std.Build.Step.Compile {
    const raylib_dep = b.dependency("raylib", .{
        .target = target,
        .optimize = optimize,
        .config = config,
    });

    const raygui_dep = b.dependency("raygui", .{
        .target = target,
        .optimize = optimize,
    });

    const lib = raylib_dep.artifact("raylib");

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
    lib.installHeader(raylib_dep.path("src/config.h"), "raylib_config.h");

    return lib;
}
