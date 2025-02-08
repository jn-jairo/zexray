const raymath = @cImport({
    @cInclude("raymath.h");
});

const std = @import("std");

pub const allocator = std.heap.raw_c_allocator;

pub usingnamespace raymath;
