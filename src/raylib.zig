const raylib = @cImport({
    @cInclude("raylib.h");
    @cInclude("raylib_config.h");
});

const std = @import("std");

pub const allocator = std.heap.raw_c_allocator;

pub usingnamespace raylib;
