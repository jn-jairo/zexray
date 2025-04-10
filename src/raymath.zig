const raymath = @cImport({
    @cInclude("raymath.h");
});
pub usingnamespace raymath;

const std = @import("std");

pub const allocator = std.heap.raw_c_allocator;
