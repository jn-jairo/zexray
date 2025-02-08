const raygui = @cImport({
    @cInclude("raygui.h");
});

const std = @import("std");

pub const allocator = std.heap.raw_c_allocator;

pub usingnamespace raygui;
