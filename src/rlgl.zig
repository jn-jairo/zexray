const rlgl = @cImport({
    @cInclude("rlgl.h");
});
pub usingnamespace rlgl;

const std = @import("std");

pub const allocator = std.heap.raw_c_allocator;
