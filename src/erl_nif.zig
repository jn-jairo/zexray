const std = @import("std");
const e = @cImport(@cInclude("erl_nif.h"));

pub const ErlNifTerm = e.ERL_NIF_TERM;

const Allocator = std.mem.Allocator;

pub const MAX_ALIGN = 8;

pub const allocator = Allocator{
    .ptr = undefined,
    .vtable = &raw_beam_allocator_vtable,
};

const raw_beam_allocator_vtable = Allocator.VTable{
    .alloc = raw_beam_alloc,
    .resize = raw_beam_resize,
    .free = raw_beam_free,
};

fn raw_beam_alloc(
    _: *anyopaque,
    len: usize,
    ptr_align: u8,
    _: usize,
) ?[*]u8 {
    if (ptr_align > MAX_ALIGN) return null;
    const ptr = e.enif_alloc(len) orelse return null;
    return @as([*]u8, @ptrCast(ptr));
}

fn raw_beam_resize(
    _: *anyopaque,
    buf: []u8,
    _: u8,
    new_len: usize,
    _: usize,
) bool {
    if (new_len <= buf.len) return true;
    if (new_len == 0) {
        e.enif_free(buf.ptr);
        return true;
    }
    // We are never able to increase the size of a pointer.
    return false;
}

fn raw_beam_free(
    _: *anyopaque,
    buf: []u8,
    _: u8,
    _: usize,
) void {
    e.enif_free(buf.ptr);
}

pub usingnamespace e;
