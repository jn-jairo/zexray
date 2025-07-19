const e = @import("./erl_nif.zig");

pub export fn nif_alloc(size: usize) callconv(.C) ?*anyopaque {
    return e.enif_alloc(size);
}

pub export fn nif_calloc(num: usize, size: usize) callconv(.C) ?*anyopaque {
    const total_size = num * size;
    const ptr = e.enif_alloc(total_size);
    if (ptr != null) {
        @memset(@as([*]u8, @ptrCast(ptr))[0..total_size], 0);
    }
    return ptr;
}

pub export fn nif_realloc(ptr: ?*anyopaque, new_size: usize) callconv(.C) ?*anyopaque {
    return e.enif_realloc(ptr, new_size);
}

pub export fn nif_free(ptr: ?*anyopaque) callconv(.C) void {
    e.enif_free(ptr);
}
