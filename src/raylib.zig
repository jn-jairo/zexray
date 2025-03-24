const raylib = @cImport({
    @cInclude("raylib.h");
    @cInclude("raylib_config.h");
    @cInclude("stdio.h");
});

const std = @import("std");
const e = @import("./erl_nif.zig");

pub const allocator = e.allocator;

pub usingnamespace raylib;
