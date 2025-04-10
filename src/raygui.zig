const raygui = @cImport({
    @cInclude("raygui.h");
});
pub usingnamespace raygui;

const std = @import("std");

pub const allocator = std.heap.raw_c_allocator;
