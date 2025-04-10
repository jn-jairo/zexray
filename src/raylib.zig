const raylib = @cImport({
    @cInclude("raylib.h");
    @cInclude("config.h");
    @cInclude("rcamera.h");
    @cInclude("stdio.h");
});

const std = @import("std");
const e = @import("./erl_nif.zig");

pub const allocator = e.allocator;

pub const IVector2 = struct {
    x: c_int = std.mem.zeroes(c_int),
    y: c_int = std.mem.zeroes(c_int),
};

pub const IVector3 = struct {
    x: c_int = std.mem.zeroes(c_int),
    y: c_int = std.mem.zeroes(c_int),
    z: c_int = std.mem.zeroes(c_int),
};

pub const IVector4 = struct {
    x: c_int = std.mem.zeroes(c_int),
    y: c_int = std.mem.zeroes(c_int),
    z: c_int = std.mem.zeroes(c_int),
    w: c_int = std.mem.zeroes(c_int),
};

pub const UIVector2 = struct {
    x: c_uint = std.mem.zeroes(c_uint),
    y: c_uint = std.mem.zeroes(c_uint),
};

pub const UIVector3 = struct {
    x: c_uint = std.mem.zeroes(c_uint),
    y: c_uint = std.mem.zeroes(c_uint),
    z: c_uint = std.mem.zeroes(c_uint),
};

pub const UIVector4 = struct {
    x: c_uint = std.mem.zeroes(c_uint),
    y: c_uint = std.mem.zeroes(c_uint),
    z: c_uint = std.mem.zeroes(c_uint),
    w: c_uint = std.mem.zeroes(c_uint),
};

pub usingnamespace raylib;
