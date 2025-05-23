const std = @import("std");
const assert = std.debug.assert;
const e = @import("./erl_nif.zig");
const rl = @import("./raylib.zig");
const rlgl = @import("./rlgl.zig");

const resources = @import("./resources.zig");

fn get_field_array_length(comptime T: type, field_name: []const u8) usize {
    return @intCast(blk: {
        switch (@typeInfo(T)) {
            .@"struct" => |struct_info| {
                for (struct_info.fields) |field| {
                    if (std.mem.eql(u8, field.name, field_name)) {
                        switch (@typeInfo(field.type)) {
                            .array => |field_info| {
                                break :blk field_info.len;
                            },
                            else => @compileError("Invalid " ++ @typeName(T) ++ "." ++ field_name ++ " type"),
                        }
                    }
                }
            },
            else => @compileError("Invalid " ++ @typeName(T) ++ " type"),
        }
        @compileError("Could not find the field " ++ @typeName(T) ++ "." ++ field_name);
    });
}

pub inline fn ptr_to_c_string(ptr: anytype) [*c]u8 {
    var buf = std.ArrayList(u8).init(e.allocator);
    defer buf.deinit();

    std.fmt.format(buf.writer(), "{*}", .{ptr}) catch unreachable;

    return @ptrCast(buf.toOwnedSliceSentinel(0) catch unreachable);
}

pub fn keep_type(comptime T: type) type {
    switch (@typeInfo(T)) {
        .pointer => |info| {
            return @Type(.{
                .pointer = .{
                    .size = info.size,
                    .is_const = info.is_const,
                    .is_volatile = info.is_volatile,
                    .alignment = 0,
                    .address_space = info.address_space,
                    .child = keep_type(info.child),
                    .is_allowzero = info.is_allowzero,
                    .sentinel_ptr = info.sentinel_ptr,
                },
            });
        },
        .array => |info| {
            return @Type(.{
                .array = .{
                    .len = info.len,
                    .child = keep_type(info.child),
                    .sentinel_ptr = info.sentinel_ptr,
                },
            });
        },
        .optional => |info| {
            return @Type(.{
                .optional = .{
                    .child = keep_type(info.child),
                },
            });
        },
        else => {},
    }

    return bool;
}

//////////////
//  Double  //
//////////////

pub const Double = struct {
    pub const data_type = f64;

    pub fn make(env: ?*e.ErlNifEnv, value: f64) e.ErlNifTerm {
        return e.enif_make_double(env, value);
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !f64 {
        var value: f64 = undefined;
        if (e.enif_get_double(env, term, &value) == 0) return error.ArgumentError;
        return value;
    }
};

////////////
//  Int  //
////////////

pub const Int = struct {
    pub const data_type = c_int;

    pub fn make(env: ?*e.ErlNifEnv, value: c_int) e.ErlNifTerm {
        return e.enif_make_int(env, value);
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !c_int {
        var value: c_int = undefined;
        if (e.enif_get_int(env, term, &value) == 0) return error.ArgumentError;
        return value;
    }
};

////////////
//  UInt  //
////////////

pub const UInt = struct {
    pub const data_type = c_uint;

    pub fn make(env: ?*e.ErlNifEnv, value: c_uint) e.ErlNifTerm {
        return e.enif_make_uint(env, value);
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !c_uint {
        var value: c_uint = undefined;
        if (e.enif_get_uint(env, term, &value) == 0) return error.ArgumentError;
        return value;
    }
};

//////////////////////
//  TermIsResource  //
//////////////////////

pub const TermIsResource = struct {
    pub const data_type = bool;

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !bool {
        return e.enif_is_ref(env, term) != 0;
    }
};

///////////////
//  Boolean  //
///////////////

pub const Boolean = struct {
    pub const data_type = bool;

    pub fn make(env: ?*e.ErlNifEnv, value: bool) e.ErlNifTerm {
        return if (value) Atom.make(env, "true") else Atom.make(env, "false");
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !bool {
        return e.enif_is_identical(Atom.make(env, "true"), term) != 0;
    }
};

////////////
//  Atom  //
////////////

pub const Atom = struct {
    pub const data_type = u8;

    pub fn make(env: ?*e.ErlNifEnv, value: []const u8) e.ErlNifTerm {
        return e.enif_make_atom_len(env, value.ptr, value.len);
    }

    pub fn get(allocator: std.mem.Allocator, env: ?*e.ErlNifEnv, term: e.ErlNifTerm) ![]u8 {
        var len: c_uint = undefined;
        if (e.enif_get_atom_length(env, term, &len, e.ERL_NIF_LATIN1) == 0) return error.ArgumentError;
        len += 1;

        const value = try allocator.alloc(u8, len);
        errdefer allocator.free(value);

        if (e.enif_get_atom(env, term, value.ptr, @intCast(value.len), e.ERL_NIF_LATIN1) == 0) return error.ArgumentError;

        return value[0 .. len - 1];
    }

    pub fn free(allocator: std.mem.Allocator, value: []u8) void {
        allocator.free(value);
    }
};

//////////////
//  Binary  //
//////////////

pub const Binary = struct {
    pub const data_type = u8;

    pub fn make(env: ?*e.ErlNifEnv, value: []const u8) e.ErlNifTerm {
        var term: e.ErlNifTerm = undefined;
        var buf = e.enif_make_new_binary(env, value.len, &term);
        @memcpy(buf[0..value.len], value);
        return term;
    }

    pub fn make_c(env: ?*e.ErlNifEnv, value_c: [*c]u8, length_c: usize) e.ErlNifTerm {
        var term: e.ErlNifTerm = undefined;
        if (length_c > 0 and value_c != null) {
            var buf = e.enif_make_new_binary(env, length_c, &term);
            @memcpy(buf[0..length_c], @as([*]u8, @ptrCast(value_c))[0..length_c]);
        } else {
            _ = e.enif_make_new_binary(env, 0, &term);
        }
        return term;
    }

    pub fn get(allocator: std.mem.Allocator, env: ?*e.ErlNifEnv, term: e.ErlNifTerm) ![]u8 {
        var binary: e.ErlNifBinary = undefined;
        if (e.enif_inspect_binary(env, term, &binary) == 0) return error.ArgumentError;

        const value = try allocator.alloc(u8, binary.size);
        errdefer allocator.free(value);

        @memcpy(value, binary.data[0..binary.size]);

        return value;
    }

    pub fn get_c(allocator: std.mem.Allocator, env: ?*e.ErlNifEnv, term: e.ErlNifTerm, length_c: usize) ![*c]u8 {
        var binary: e.ErlNifBinary = undefined;
        if (e.enif_inspect_binary(env, term, &binary) == 0) return error.ArgumentError;
        if (binary.size != 0 and binary.size != length_c) return error.ArgumentError;

        if (binary.size <= 0) {
            return null;
        }

        const value = try allocator.alloc(u8, binary.size);
        errdefer allocator.free(value);

        @memcpy(value, binary.data[0..binary.size]);

        return @ptrCast(value);
    }

    pub fn get_copy(env: ?*e.ErlNifEnv, term: e.ErlNifTerm, dest: []u8) !void {
        var binary: e.ErlNifBinary = undefined;
        if (e.enif_inspect_binary(env, term, &binary) == 0) return error.ArgumentError;
        if (binary.size > dest.len) return error.ArgumentError;

        const length =
            if (dest.len > binary.size) binary.size else dest.len;

        std.mem.copyForwards(u8, dest[0..length], binary.data[0..length]);
    }

    pub fn get_size(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !usize {
        var binary: e.ErlNifBinary = undefined;
        if (e.enif_inspect_binary(env, term, &binary) == 0) return error.ArgumentError;
        return @intCast(binary.size);
    }

    pub fn free(allocator: std.mem.Allocator, value: []u8) void {
        allocator.free(value);
    }

    pub fn free_c(allocator: std.mem.Allocator, value_c: [*c]u8, length_c: usize) void {
        if (length_c > 0) {
            allocator.free(@as([*]u8, @ptrCast(value_c))[0..length_c]);
        }
    }

    pub fn free_copy(allocator: std.mem.Allocator, value: []u8) void {
        _ = allocator;
        _ = value;
    }
};

///////////////
//  CString  //
///////////////

pub const CString = struct {
    pub const data_type = u8;

    pub fn make(env: ?*e.ErlNifEnv, value: []const u8) e.ErlNifTerm {
        var term: e.ErlNifTerm = undefined;
        const value_length: usize = @intCast(blk: {
            for (0..value.len) |i| {
                if (value[i] == 0) {
                    break :blk i;
                }
            }
            break :blk value.len;
        });

        var buf = e.enif_make_new_binary(env, value_length, &term);
        if (value_length > 0) {
            std.mem.copyForwards(u8, buf[0..value_length], value[0..value_length]);
        }
        return term;
    }

    pub fn make_c(env: ?*e.ErlNifEnv, value_c: [*c]const u8, length_c: usize) e.ErlNifTerm {
        var term: e.ErlNifTerm = undefined;
        if (length_c > 0 and value_c != null) {
            const value = @as([*]const u8, @ptrCast(value_c))[0..length_c];
            const value_length: usize = @intCast(blk: {
                for (0..value.len) |i| {
                    if (value[i] == 0) {
                        break :blk i;
                    }
                }
                break :blk value.len;
            });

            var buf = e.enif_make_new_binary(env, value_length, &term);
            std.mem.copyForwards(u8, buf[0..value_length], value[0..value_length]);
        } else {
            _ = e.enif_make_new_binary(env, 0, &term);
        }
        return term;
    }

    pub fn make_c_unknown(env: ?*e.ErlNifEnv, value_c: [*c]const u8) e.ErlNifTerm {
        return make_c(env, value_c, get_value_length_c(value_c));
    }

    pub fn get(allocator: std.mem.Allocator, env: ?*e.ErlNifEnv, term: e.ErlNifTerm) ![]u8 {
        var binary: e.ErlNifBinary = undefined;
        if (e.enif_inspect_binary(env, term, &binary) == 0) return error.ArgumentError;

        const value = try allocator.alloc(u8, binary.size + 1);
        errdefer allocator.free(value);

        std.mem.copyForwards(u8, value, binary.data[0..binary.size]);
        value[binary.size] = 0;

        return value;
    }

    pub fn get_c(allocator: std.mem.Allocator, env: ?*e.ErlNifEnv, term: e.ErlNifTerm, length_c: usize) ![*c]u8 {
        var binary: e.ErlNifBinary = undefined;
        if (e.enif_inspect_binary(env, term, &binary) == 0) return error.ArgumentError;
        if (binary.size != 0 and (binary.size + 1) > length_c) return error.ArgumentError;

        if (binary.size <= 0) {
            return null;
        }

        const value = try allocator.alloc(u8, length_c);
        errdefer allocator.free(value);

        for (0..value.len) |i| {
            if (i < binary.size) {
                value[i] = binary.data[i];
            } else {
                value[i] = 0;
            }
        }
        return @ptrCast(value);
    }

    pub fn get_c_unknown(allocator: std.mem.Allocator, env: ?*e.ErlNifEnv, term: e.ErlNifTerm) ![*c]u8 {
        return get_c(allocator, env, term, try get_size(env, term));
    }

    pub fn get_copy(env: ?*e.ErlNifEnv, term: e.ErlNifTerm, dest: []u8) !void {
        var binary: e.ErlNifBinary = undefined;
        if (e.enif_inspect_binary(env, term, &binary) == 0) return error.ArgumentError;
        if (binary.size > dest.len) return error.ArgumentError;

        for (0..dest.len) |i| {
            if (i < binary.size) {
                dest[i] = binary.data[i];
            } else {
                dest[i] = 0;
            }
        }
    }

    pub fn get_size(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !usize {
        var binary: e.ErlNifBinary = undefined;
        if (e.enif_inspect_binary(env, term, &binary) == 0) return error.ArgumentError;
        return @intCast(binary.size + 1);
    }

    pub fn get_value_length(value_c: [*c]const u8) usize {
        var i: usize = 0;
        if (value_c != null) {
            while (value_c[i] != 0) {
                i += 1;
            }
        }
        return i;
    }

    pub fn get_value_length_c(value_c: [*c]const u8) usize {
        var i: usize = 0;
        if (value_c != null) {
            while (value_c[i] != 0) {
                i += 1;
            }
            i += 1;
        }
        return i;
    }

    pub fn free(allocator: std.mem.Allocator, value: []u8) void {
        allocator.free(value);
    }

    pub fn free_c(allocator: std.mem.Allocator, value_c: [*c]const u8, length_c: usize) void {
        if (length_c > 0) {
            allocator.free(@as([*]const u8, @ptrCast(value_c))[0..length_c]);
        }
    }

    pub fn free_c_unknown(allocator: std.mem.Allocator, value_c: [*c]const u8) void {
        free_c(allocator, value_c, get_value_length_c(value_c));
    }

    pub fn free_copy(allocator: std.mem.Allocator, value: []u8) void {
        _ = allocator;
        _ = value;
    }
};

/////////////
//  Array  //
/////////////

pub const Array = struct {
    pub fn make(comptime T: type, comptime T_rl: type, env: ?*e.ErlNifEnv, values: []const T_rl) e.ErlNifTerm {
        var term_value = e.enif_make_list_from_array(env, null, 0);
        if (values.len > 0) {
            const child: ?type = blk: {
                break :blk switch (@typeInfo(T_rl)) {
                    .pointer => |info| info.child,
                    .array => |info| info.child,
                    else => null,
                };
            };

            const child_child: ?type = blk: {
                if (child) |c| {
                    break :blk switch (@typeInfo(c)) {
                        .pointer => |info| info.child,
                        .array => |info| info.child,
                        else => null,
                    };
                }
                break :blk null;
            };

            for (0..values.len) |i| {
                if (child) |c| {
                    if (child_child == null and (T == Binary or T == CString)) {
                        term_value = e.enif_make_list_cell(env, T.make(env, values[values.len - 1 - i]), term_value);
                    } else {
                        term_value = e.enif_make_list_cell(env, make(T, c, env, values[values.len - 1 - i]), term_value);
                    }
                } else {
                    const term = switch (@typeInfo(T_rl)) {
                        .int => T.make(env, @intCast(values[values.len - 1 - i])),
                        .float => T.make(env, @floatCast(values[values.len - 1 - i])),
                        else => T.make(env, values[values.len - 1 - i]),
                    };
                    term_value = e.enif_make_list_cell(env, term, term_value);
                }
            }
        }
        return term_value;
    }

    pub fn make_c(comptime T: type, comptime T_rl: type, env: ?*e.ErlNifEnv, values_c: [*c]T_rl, lengths_c: []const usize) e.ErlNifTerm {
        return _make_c(T, T_rl, env, values_c, lengths_c, 0);
    }

    fn _make_c(comptime T: type, comptime T_rl: type, env: ?*e.ErlNifEnv, values_c: [*c]T_rl, lengths_c: []const usize, depth: usize) e.ErlNifTerm {
        assert(lengths_c.len > 0 and depth < lengths_c.len);

        const length_c = lengths_c[depth];

        var term_value = e.enif_make_list_from_array(env, null, 0);

        if (length_c > 0 and values_c != null) {
            const values = @as([*]T_rl, @ptrCast(values_c))[0..length_c];

            const child: ?type = blk: {
                break :blk switch (@typeInfo(T_rl)) {
                    .pointer => |info| info.child,
                    .array => |info| info.child,
                    else => null,
                };
            };
            const child_is_array = depth < (lengths_c.len - 1);
            assert(child_is_array and child != null or !child_is_array and child == null);

            const child_child: ?type = blk: {
                if (child) |c| {
                    break :blk switch (@typeInfo(c)) {
                        .pointer => |info| info.child,
                        .array => |info| info.child,
                        else => null,
                    };
                }
                break :blk null;
            };

            for (0..values.len) |i| {
                if (child) |c| {
                    if (child_child == null and (T == Binary or T == CString)) {
                        term_value = e.enif_make_list_cell(env, T.make_c(env, values[values.len - 1 - i], lengths_c[depth + 1]), term_value);
                    } else {
                        term_value = e.enif_make_list_cell(env, _make_c(T, c, env, values[values.len - 1 - i], lengths_c, depth + 1), term_value);
                    }
                } else {
                    const term = switch (@typeInfo(T_rl)) {
                        .int => T.make(env, @intCast(values[values.len - 1 - i])),
                        .float => T.make(env, @floatCast(values[values.len - 1 - i])),
                        else => T.make(env, values[values.len - 1 - i]),
                    };
                    term_value = e.enif_make_list_cell(env, term, term_value);
                }
            }
        }

        return term_value;
    }

    pub fn get(comptime T: type, comptime T_rl: type, allocator: std.mem.Allocator, env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !?[]T_rl {
        var length: c_uint = undefined;
        if (e.enif_get_list_length(env, term, &length) == 0) return error.ArgumentError;

        if (length <= 0) {
            return null;
        }

        var values = try allocator.alloc(T_rl, @intCast(length));
        errdefer allocator.free(values);

        const child: ?type = blk: {
            break :blk switch (@typeInfo(T_rl)) {
                .pointer => |info| info.child,
                .array => |info| info.child,
                else => null,
            };
        };

        const child_child: ?type = blk: {
            if (child) |c| {
                break :blk switch (@typeInfo(c)) {
                    .pointer => |info| info.child,
                    .array => |info| info.child,
                    else => null,
                };
            }
            break :blk null;
        };

        var term_value = term;
        var term_value_head: e.ErlNifTerm = undefined;
        for (0..@intCast(length)) |i| {
            if (e.enif_get_list_cell(env, term_value, &term_value_head, &term_value) == 0) return error.ArgumentError;
            if (child) |c| {
                if (child_child == null and (T == Binary or T == CString)) {
                    values[i] = blk: {
                        switch (@typeInfo(@TypeOf(T.get))) {
                            .@"fn" => |fn_info| {
                                if (fn_info.params.len == 3) {
                                    break :blk try T.get(allocator, env, term_value_head);
                                } else {
                                    break :blk try T.get(env, term_value_head);
                                }
                            },
                            else => @compileError("Get callback is not a function"),
                        }
                        @compileError("Invalid get callback");
                    };
                } else {
                    values[i] = try get(T, c, allocator, env, term_value_head);
                }
            } else {
                values[i] = switch (@typeInfo(T_rl)) {
                    .int => @intCast(try T.get(env, term_value_head)),
                    .float => @floatCast(try T.get(env, term_value_head)),
                    else => blk: {
                        switch (@typeInfo(@TypeOf(T.get))) {
                            .@"fn" => |fn_info| {
                                if (fn_info.params.len == 3) {
                                    break :blk try T.get(allocator, env, term_value_head);
                                } else {
                                    break :blk try T.get(env, term_value_head);
                                }
                            },
                            else => @compileError("Get callback is not a function"),
                        }
                        @compileError("Invalid get callback");
                    },
                };
            }
        }

        return values;
    }

    pub fn get_c(comptime T: type, comptime T_rl: type, allocator: std.mem.Allocator, env: ?*e.ErlNifEnv, term: e.ErlNifTerm, lengths_c: []const usize) ![*c]T_rl {
        return _get_c(T, T_rl, allocator, env, term, lengths_c, 0);
    }

    fn _get_c(comptime T: type, comptime T_rl: type, allocator: std.mem.Allocator, env: ?*e.ErlNifEnv, term: e.ErlNifTerm, lengths_c: []const usize, depth: usize) ![*c]T_rl {
        assert(lengths_c.len > 0 and depth < lengths_c.len);

        const length_c = lengths_c[depth];

        var length: c_uint = undefined;
        if (e.enif_get_list_length(env, term, &length) == 0) return error.ArgumentError;
        if (length != 0 and length != length_c) return error.ArgumentError;

        if (length <= 0) {
            return null;
        }

        var values = try allocator.alloc(T_rl, @intCast(length));
        errdefer allocator.free(values);

        const child: ?type = blk: {
            break :blk switch (@typeInfo(T_rl)) {
                .pointer => |info| info.child,
                .array => |info| info.child,
                else => null,
            };
        };
        const child_is_array = depth < (lengths_c.len - 1);
        assert(child_is_array and child != null or !child_is_array and child == null);

        const child_child: ?type = blk: {
            if (child) |c| {
                break :blk switch (@typeInfo(c)) {
                    .pointer => |info| info.child,
                    .array => |info| info.child,
                    else => null,
                };
            }
            break :blk null;
        };

        var term_value = term;
        var term_value_head: e.ErlNifTerm = undefined;
        for (0..@intCast(length)) |i| {
            if (e.enif_get_list_cell(env, term_value, &term_value_head, &term_value) == 0) return error.ArgumentError;
            if (child) |c| {
                if (child_child == null and (T == Binary or T == CString)) {
                    values[i] = blk: {
                        switch (@typeInfo(@TypeOf(T.get_c))) {
                            .@"fn" => |fn_info| {
                                if (fn_info.params.len == 4) {
                                    break :blk try T.get_c(allocator, env, term_value_head, lengths_c[depth + 1]);
                                } else {
                                    break :blk try T.get_c(env, term_value_head, lengths_c[depth + 1]);
                                }
                            },
                            else => @compileError("Get callback is not a function"),
                        }
                        @compileError("Invalid get callback");
                    };
                } else {
                    values[i] = try _get_c(T, c, allocator, env, term_value_head, lengths_c, depth + 1);
                }
            } else {
                values[i] = switch (@typeInfo(T_rl)) {
                    .int => @intCast(try T.get(env, term_value_head)),
                    .float => @floatCast(try T.get(env, term_value_head)),
                    else => blk: {
                        switch (@typeInfo(@TypeOf(T.get))) {
                            .@"fn" => |fn_info| {
                                if (fn_info.params.len == 3) {
                                    break :blk try T.get(allocator, env, term_value_head);
                                } else {
                                    break :blk try T.get(env, term_value_head);
                                }
                            },
                            else => @compileError("Get callback is not a function"),
                        }
                        @compileError("Invalid get callback");
                    },
                };
            }
        }

        return @ptrCast(values);
    }

    pub fn get_copy(comptime T: type, comptime T_rl: type, allocator: std.mem.Allocator, env: ?*e.ErlNifEnv, term: e.ErlNifTerm, dest: []T_rl) !void {
        var length: c_uint = undefined;
        if (e.enif_get_list_length(env, term, &length) == 0) return error.ArgumentError;
        if (length != 0 and length != dest.len) return error.ArgumentError;

        const child: ?type = blk: {
            break :blk switch (@typeInfo(T_rl)) {
                .pointer => |info| info.child,
                .array => |info| info.child,
                else => null,
            };
        };

        const child_child: ?type = blk: {
            if (child) |c| {
                break :blk switch (@typeInfo(c)) {
                    .pointer => |info| info.child,
                    .array => |info| info.child,
                    else => null,
                };
            }
            break :blk null;
        };

        if (length < dest.len) {
            // fill with empty
            for (length..dest.len) |i| {
                if (child) |c| {
                    // term is empty list
                    try get_copy(T, c, allocator, env, term, dest[i]);
                } else {
                    dest[i] = switch (@typeInfo(T_rl)) {
                        .optional => null,
                        .int => 0,
                        .float => 0.0,
                        .bool => false,
                        .@"struct" => T_rl{},
                        else => @compileError("Cannot set empty value for this type"),
                    };
                }
            }
            return;
        }

        var term_value = term;
        var term_value_head: e.ErlNifTerm = undefined;
        for (0..@intCast(length)) |i| {
            if (e.enif_get_list_cell(env, term_value, &term_value_head, &term_value) == 0) return error.ArgumentError;
            if (child) |c| {
                if (child_child == null and (T == Binary or T == CString)) {
                    blk: {
                        switch (@typeInfo(@TypeOf(T.get_copy))) {
                            .@"fn" => |fn_info| {
                                if (fn_info.params.len == 4) {
                                    break :blk try T.get_copy(allocator, env, term_value_head, dest[i]);
                                } else {
                                    break :blk try T.get_copy(env, term_value_head, dest[i]);
                                }
                            },
                            else => @compileError("Get callback is not a function"),
                        }
                        @compileError("Invalid get callback");
                    }
                } else {
                    try get_copy(T, c, allocator, env, term_value_head, dest[i]);
                }
            } else {
                dest[i] = switch (@typeInfo(T_rl)) {
                    .int => @intCast(try T.get(env, term_value_head)),
                    .float => @floatCast(try T.get(env, term_value_head)),
                    else => blk: {
                        switch (@typeInfo(@TypeOf(T.get))) {
                            .@"fn" => |fn_info| {
                                if (fn_info.params.len == 3) {
                                    break :blk try T.get(allocator, env, term_value_head);
                                } else {
                                    break :blk try T.get(env, term_value_head);
                                }
                            },
                            else => @compileError("Get callback is not a function"),
                        }
                        @compileError("Invalid get callback");
                    },
                };
            }
        }
    }

    pub fn get_length(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !usize {
        var length: c_uint = undefined;
        if (e.enif_get_list_length(env, term, &length) == 0) return error.ArgumentError;
        return @intCast(length);
    }

    pub fn free(comptime T: type, comptime T_rl: type, allocator: std.mem.Allocator, values: ?[]T_rl, keep: keep_type(@TypeOf(values))) void {
        if (values) |v| {
            const child: ?type = blk: {
                break :blk switch (@typeInfo(T_rl)) {
                    .pointer => |info| info.child,
                    .array => |info| info.child,
                    else => null,
                };
            };

            const child_child: ?type = blk: {
                if (child) |c| {
                    break :blk switch (@typeInfo(c)) {
                        .pointer => |info| info.child,
                        .array => |info| info.child,
                        else => null,
                    };
                }
                break :blk null;
            };

            for (0..v.len) |i| {
                if (child) |c| {
                    if (child_child == null and (T == Binary or T == CString)) {
                        blk: {
                            switch (@typeInfo(@TypeOf(T.free))) {
                                .@"fn" => |fn_info| {
                                    if (fn_info.params.len == 2) {
                                        break :blk T.free(allocator, v[i]);
                                    } else {
                                        break :blk T.free(v[i]);
                                    }
                                },
                                else => @compileError("Free callback is not a function"),
                            }
                            @compileError("Invalid free callback");
                        }
                    } else {
                        const k = if (keep) |k| k[i] else null;
                        free(T, c, allocator, v[i], k);
                    }
                } else {
                    const do_free = if (keep) |k| !k[i] else true;
                    if (do_free) {
                        switch (@typeInfo(T_rl)) {
                            .int => {},
                            .float => {},
                            .bool => {},
                            else => blk: {
                                switch (@typeInfo(@TypeOf(T.free))) {
                                    .@"fn" => |fn_info| {
                                        if (fn_info.params.len == 2) {
                                            break :blk T.free(allocator, v[i]);
                                        } else {
                                            break :blk T.free(v[i]);
                                        }
                                    },
                                    else => @compileError("Free callback is not a function"),
                                }
                                @compileError("Invalid free callback");
                            },
                        }
                    }
                }
            }

            allocator.free(v);
        }
    }

    pub fn free_c(comptime T: type, comptime T_rl: type, allocator: std.mem.Allocator, values_c: [*c]T_rl, lengths_c: []const usize, keep: keep_type(@TypeOf(values_c))) void {
        _free_c(T, T_rl, allocator, values_c, lengths_c, 0, keep);
    }

    fn _free_c(comptime T: type, comptime T_rl: type, allocator: std.mem.Allocator, values_c: [*c]T_rl, lengths_c: []const usize, depth: usize, keep: keep_type(@TypeOf(values_c))) void {
        assert(lengths_c.len > 0 and depth < lengths_c.len);

        const length_c = lengths_c[depth];

        if (length_c > 0) {
            const values = @as([*]T_rl, @ptrCast(values_c))[0..length_c];

            const child: ?type = blk: {
                break :blk switch (@typeInfo(T_rl)) {
                    .pointer => |info| info.child,
                    .array => |info| info.child,
                    else => null,
                };
            };
            const child_is_array = depth < (lengths_c.len - 1);
            assert(child_is_array and child != null or !child_is_array and child == null);

            const child_child: ?type = blk: {
                if (child) |c| {
                    break :blk switch (@typeInfo(c)) {
                        .pointer => |info| info.child,
                        .array => |info| info.child,
                        else => null,
                    };
                }
                break :blk null;
            };

            for (0..length_c) |i| {
                if (child) |c| {
                    if (child_child == null and (T == Binary or T == CString)) {
                        blk: {
                            switch (@typeInfo(@TypeOf(T.free))) {
                                .@"fn" => |fn_info| {
                                    if (fn_info.params.len == 3) {
                                        break :blk T.free_c(allocator, values[i], lengths_c[depth + 1]);
                                    } else {
                                        break :blk T.free_c(values[i], lengths_c[depth + 1]);
                                    }
                                },
                                else => @compileError("Free callback is not a function"),
                            }
                            @compileError("Invalid free callback");
                        }
                    } else {
                        const k = if (keep) |k| k[i] else null;
                        _free_c(T, c, allocator, values[i], lengths_c, depth + 1, k);
                    }
                } else {
                    const do_free = if (keep) |k| !k[i] else true;
                    if (do_free) {
                        switch (@typeInfo(T_rl)) {
                            .int => {},
                            .float => {},
                            .bool => {},
                            else => blk: {
                                switch (@typeInfo(@TypeOf(T.free))) {
                                    .@"fn" => |fn_info| {
                                        if (fn_info.params.len == 2) {
                                            break :blk T.free(allocator, values[i]);
                                        } else {
                                            break :blk T.free(values[i]);
                                        }
                                    },
                                    else => @compileError("Free callback is not a function"),
                                }
                                @compileError("Invalid free callback");
                            },
                        }
                    }
                }
            }

            allocator.free(values);
        }
    }

    pub fn free_copy(comptime T: type, comptime T_rl: type, allocator: std.mem.Allocator, values: ?[]T_rl, keep: keep_type(@TypeOf(values))) void {
        if (values) |v| {
            const child: ?type = blk: {
                break :blk switch (@typeInfo(T_rl)) {
                    .pointer => |info| info.child,
                    .array => |info| info.child,
                    else => null,
                };
            };

            const child_child: ?type = blk: {
                if (child) |c| {
                    break :blk switch (@typeInfo(c)) {
                        .pointer => |info| info.child,
                        .array => |info| info.child,
                        else => null,
                    };
                }
                break :blk null;
            };

            for (0..v.len) |i| {
                if (child) |c| {
                    if (child_child == null and (T == Binary or T == CString)) {
                        blk: {
                            switch (@typeInfo(@TypeOf(T.free))) {
                                .@"fn" => |fn_info| {
                                    if (fn_info.params.len == 2) {
                                        break :blk T.free_copy(allocator, v[i]);
                                    } else {
                                        break :blk T.free_copy(v[i]);
                                    }
                                },
                                else => @compileError("Free callback is not a function"),
                            }
                            @compileError("Invalid free callback");
                        }
                    } else {
                        const k = if (keep) |k| k[i] else null;
                        free_copy(T, c, allocator, v[i], k);
                    }
                } else {
                    const do_free = blk: {
                        if (keep) |k| {
                            if (k.len > i) {
                                break :blk !k[i];
                            } else {
                                break :blk true;
                            }
                        }
                        break :blk true;
                    };

                    if (do_free) {
                        switch (@typeInfo(T_rl)) {
                            .int => {},
                            .float => {},
                            .bool => {},
                            else => blk: {
                                switch (@typeInfo(@TypeOf(T.free))) {
                                    .@"fn" => |fn_info| {
                                        if (fn_info.params.len == 2) {
                                            break :blk T.free(allocator, v[i]);
                                        } else {
                                            break :blk T.free(v[i]);
                                        }
                                    },
                                    else => @compileError("Free callback is not a function"),
                                }
                                @compileError("Invalid free callback");
                            },
                        }
                    }
                }
            }
        }
    }
};

////////////////
//  Resource  //
////////////////

const Resource = struct {
    fn make(env: ?*e.ErlNifEnv, obj: ?*anyopaque) e.ErlNifTerm {
        return e.enif_make_resource(env, obj);
    }

    fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm, resource_type: *e.ErlNifResourceType) !*anyopaque {
        var objp: ?*anyopaque = undefined;
        if (e.enif_get_resource(env, term, resource_type, &objp) == 0) return error.ArgumentError;
        return objp.?;
    }

    fn create(resource_type: *e.ErlNifResourceType, size: usize) !*anyopaque {
        return e.enif_alloc_resource(resource_type, size) orelse return error.OutOfMemory;
    }

    fn release(obj: ?*anyopaque) void {
        e.enif_release_resource(obj);
    }
};

pub fn ResourceBase(comptime T: type) type {
    return struct {
        pub fn make(env: ?*e.ErlNifEnv, resource: **T.data_type) e.ErlNifTerm {
            return Resource.make(env, @ptrCast(@alignCast(resource)));
        }

        pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !**T.data_type {
            const resource_type = @field(resources.resource_type, T.resource_name);

            return @ptrCast(@alignCast(try Resource.get(env, term, resource_type)));
        }

        pub fn create(value: T.data_type) !**T.data_type {
            const allocator = resources.ResourceType.allocator;
            const resource_type = @field(resources.resource_type, T.resource_name);

            const resource: **T.data_type = @ptrCast(@alignCast(try Resource.create(resource_type, @sizeOf(*T.data_type))));
            defer rl.TRACELOGD("RESOURCE: Created %s %s", .{ T.resource_name, ptr_to_c_string(resource) });

            resource.* = try allocator.create(T.data_type);
            resource.*.* = value;

            return resource;
        }

        pub fn update(env: ?*e.ErlNifEnv, term: e.ErlNifTerm, value: T.data_type) !void {
            const resource = try get(env, term);
            defer rl.TRACELOGD("RESOURCE: Updated %s %s", .{ T.resource_name, ptr_to_c_string(resource) });
            resource.*.* = value;
        }

        pub fn replace(env: ?*e.ErlNifEnv, term: e.ErlNifTerm, value: T.data_type) !void {
            const resource = try get(env, term);
            defer rl.TRACELOGD("RESOURCE: Replaced %s %s", .{ T.resource_name, ptr_to_c_string(resource) });
            T.free(resource.*.*);
            resource.*.* = value;
        }

        pub fn destroy(resource: **T.data_type) void {
            defer rl.TRACELOGD("RESOURCE: Destroyed %s %s", .{ T.resource_name, ptr_to_c_string(resource) });
            const allocator = resources.ResourceType.allocator;
            allocator.destroy(resource.*);
        }

        pub fn release(resource: **T.data_type) void {
            Resource.release(@ptrCast(@alignCast(resource)));
        }

        pub fn free(resource: **T.data_type) void {
            defer rl.TRACELOGD("RESOURCE: Freed %s %s", .{ T.resource_name, ptr_to_c_string(resource) });
            T.unload(resource.*.*);
        }
    };
}

////////////////
//  Argument  //
////////////////

pub fn Argument(comptime T: type) type {
    return struct {
        data: T.data_type,
        keep: bool,

        const Self = @This();

        pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !Self {
            const data = try T.get(env, term);
            const keep = e.enif_is_ref(env, term) != 0;

            return Self{
                .data = data,
                .keep = keep,
            };
        }

        pub fn free(value: Self) void {
            if (!value.keep) {
                T.free(value.data);
            }
        }
    };
}

pub fn ArgumentBinary(comptime T: type, allocator: std.mem.Allocator) type {
    return struct {
        data: []T.data_type,
        length: usize,

        const Self = @This();

        pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !Self {
            const data = try T.get(allocator, env, term);
            const length = try T.get_size(env, term);

            return Self{
                .data = data,
                .length = length,
            };
        }

        pub fn free(value: Self) void {
            T.free(allocator, value.data);
        }
    };
}

pub fn ArgumentBinaryC(comptime T: type, allocator: std.mem.Allocator) type {
    return struct {
        data: [*c]T.data_type,
        length: usize,

        const Self = @This();

        pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm, length_c: usize) !Self {
            const data = try T.get_c(allocator, env, term, length_c);

            return Self{
                .data = data,
                .length = length_c,
            };
        }

        pub fn free(value: Self) void {
            T.free_c(allocator, value.data, value.length);
        }
    };
}

pub fn ArgumentBinaryCUnknown(comptime T: type, allocator: std.mem.Allocator) type {
    return struct {
        data: [*c]T.data_type,
        length: usize,

        const Self = @This();

        pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !Self {
            const data = try T.get_c_unknown(allocator, env, term);
            const length = try T.get_size(env, term);

            return Self{
                .data = data,
                .length = length,
            };
        }

        pub fn free(value: Self) void {
            T.free_c_unknown(allocator, value.data);
        }
    };
}

pub fn ArgumentBinaryCopy(comptime T: type, allocator: std.mem.Allocator) type {
    return struct {
        data: []T.data_type,
        length: usize,

        const Self = @This();

        pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm, dest: []T.data_type) !Self {
            try T.get_copy(env, term, dest);
            const length = try T.get_size(env, term);

            return Self{
                .data = dest,
                .length = length,
            };
        }

        pub fn free(value: Self) void {
            T.free_copy(allocator, value.data);
        }
    };
}

pub fn ArgumentArray(comptime T: type, comptime T_rl: type, allocator: std.mem.Allocator) type {
    return struct {
        data: ?[]T_rl,
        keep: keep_type(?[]T_rl),
        length: usize,

        const Self = @This();

        pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !Self {
            const data = try Array.get(T, T_rl, allocator, env, term);
            const keep = try Array.get(TermIsResource, keep_type(T_rl), allocator, env, term);
            const length = try Array.get_length(env, term);

            return Self{
                .data = data,
                .keep = keep,
                .length = length,
            };
        }

        pub fn free(value: *Self) void {
            Array.free(T, T_rl, allocator, value.data, value.keep);
            Array.free(TermIsResource, keep_type(T_rl), allocator, value.keep, null);
            value.keep = null;
        }

        pub fn free_keep(value: *Self) void {
            if (value.keep == null) return;
            Array.free(TermIsResource, keep_type(T_rl), allocator, value.keep, null);
            value.keep = null;
        }
    };
}

pub fn ArgumentArrayC(comptime T: type, comptime T_rl: type, allocator: std.mem.Allocator) type {
    return struct {
        data: [*c]T_rl,
        keep: keep_type([*c]T_rl),
        lengths: []const usize,

        const Self = @This();

        pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm, lengths_c: []const usize) !Self {
            const data = try Array.get_c(T, T_rl, allocator, env, term, lengths_c);
            const keep = try Array.get_c(TermIsResource, keep_type(T_rl), allocator, env, term, lengths_c);

            return Self{ .data = data, .keep = keep, .lengths = lengths_c };
        }

        pub fn free(value: *Self) void {
            Array.free_c(T, T_rl, allocator, value.data, value.lengths, value.keep);
            Array.free_c(TermIsResource, keep_type(T_rl), allocator, value.keep, value.lengths, null);
            value.keep = null;
        }

        pub fn free_keep(value: *Self) void {
            if (value.keep == null) return;
            Array.free_c(TermIsResource, keep_type(T_rl), allocator, value.keep, value.lengths, null);
            value.keep = null;
        }
    };
}

pub fn ArgumentArrayCopy(comptime T: type, comptime T_rl: type, allocator: std.mem.Allocator) type {
    return struct {
        data: ?[]T_rl,
        keep: keep_type(?[]T_rl),
        length: usize,

        const Self = @This();

        pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm, dest: []T_rl) !Self {
            try Array.get_copy(T, T_rl, allocator, env, term, dest);
            const keep = try Array.get(TermIsResource, keep_type(T_rl), allocator, env, term);
            const length = try Array.get_length(env, term);

            return Self{
                .data = dest,
                .keep = keep,
                .length = length,
            };
        }

        pub fn free(value: *Self) void {
            Array.free_copy(T, T_rl, allocator, value.data, value.keep);
            Array.free(TermIsResource, keep_type(T_rl), allocator, value.keep, null);
            value.keep = null;
        }

        pub fn free_keep(value: *Self) void {
            if (value.keep == null) return;
            Array.free(TermIsResource, keep_type(T_rl), allocator, value.keep, null);
            value.keep = null;
        }
    };
}

///////////////
//  Vector2  //
///////////////

pub const Vector2 = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Vector2;
    pub const resource_name = "vector2";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Vector2) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // x

        const term_x_key = Atom.make(env, "x");
        const term_x_value = Double.make(env, @floatCast(value.x));
        assert(e.enif_make_map_put(env, term, term_x_key, term_x_value, &term) != 0);

        // y

        const term_y_key = Atom.make(env, "y");
        const term_y_value = Double.make(env, @floatCast(value.y));
        assert(e.enif_make_map_put(env, term, term_y_key, term_y_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Vector2 {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Vector2{};

        // x

        const term_x_key = Atom.make(env, "x");
        var term_x_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_x_key, &term_x_value) == 0) return error.ArgumentError;
        value.x = @floatCast(try Double.get(env, term_x_value));

        // y

        const term_y_key = Atom.make(env, "y");
        var term_y_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_y_key, &term_y_value) == 0) return error.ArgumentError;
        value.y = @floatCast(try Double.get(env, term_y_value));

        return value;
    }

    pub fn unload(value: rl.Vector2) void {
        _ = value;
    }

    pub fn free(value: rl.Vector2) void {
        _ = value;
    }
};

////////////////
//  IVector2  //
////////////////

pub const IVector2 = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.IVector2;
    pub const resource_name = "ivector2";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.IVector2) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // x

        const term_x_key = Atom.make(env, "x");
        const term_x_value = Int.make(env, @intCast(value.x));
        assert(e.enif_make_map_put(env, term, term_x_key, term_x_value, &term) != 0);

        // y

        const term_y_key = Atom.make(env, "y");
        const term_y_value = Int.make(env, @intCast(value.y));
        assert(e.enif_make_map_put(env, term, term_y_key, term_y_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.IVector2 {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.IVector2{};

        // x

        const term_x_key = Atom.make(env, "x");
        var term_x_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_x_key, &term_x_value) == 0) return error.ArgumentError;
        value.x = @intCast(try Int.get(env, term_x_value));

        // y

        const term_y_key = Atom.make(env, "y");
        var term_y_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_y_key, &term_y_value) == 0) return error.ArgumentError;
        value.y = @intCast(try Int.get(env, term_y_value));

        return value;
    }

    pub fn unload(value: rl.IVector2) void {
        _ = value;
    }

    pub fn free(value: rl.IVector2) void {
        _ = value;
    }
};

/////////////////
//  UIVector2  //
/////////////////

pub const UIVector2 = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.UIVector2;
    pub const resource_name = "uivector2";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.UIVector2) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // x

        const term_x_key = Atom.make(env, "x");
        const term_x_value = UInt.make(env, @intCast(value.x));
        assert(e.enif_make_map_put(env, term, term_x_key, term_x_value, &term) != 0);

        // y

        const term_y_key = Atom.make(env, "y");
        const term_y_value = UInt.make(env, @intCast(value.y));
        assert(e.enif_make_map_put(env, term, term_y_key, term_y_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.UIVector2 {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.UIVector2{};

        // x

        const term_x_key = Atom.make(env, "x");
        var term_x_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_x_key, &term_x_value) == 0) return error.ArgumentError;
        value.x = @intCast(try UInt.get(env, term_x_value));

        // y

        const term_y_key = Atom.make(env, "y");
        var term_y_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_y_key, &term_y_value) == 0) return error.ArgumentError;
        value.y = @intCast(try UInt.get(env, term_y_value));

        return value;
    }

    pub fn unload(value: rl.UIVector2) void {
        _ = value;
    }

    pub fn free(value: rl.UIVector2) void {
        _ = value;
    }
};

///////////////
//  Vector3  //
///////////////

pub const Vector3 = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Vector3;
    pub const resource_name = "vector3";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Vector3) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // x

        const term_x_key = Atom.make(env, "x");
        const term_x_value = Double.make(env, @floatCast(value.x));
        assert(e.enif_make_map_put(env, term, term_x_key, term_x_value, &term) != 0);

        // y

        const term_y_key = Atom.make(env, "y");
        const term_y_value = Double.make(env, @floatCast(value.y));
        assert(e.enif_make_map_put(env, term, term_y_key, term_y_value, &term) != 0);

        // z

        const term_z_key = Atom.make(env, "z");
        const term_z_value = Double.make(env, @floatCast(value.z));
        assert(e.enif_make_map_put(env, term, term_z_key, term_z_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Vector3 {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Vector3{};

        // x

        const term_x_key = Atom.make(env, "x");
        var term_x_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_x_key, &term_x_value) == 0) return error.ArgumentError;
        value.x = @floatCast(try Double.get(env, term_x_value));

        // y

        const term_y_key = Atom.make(env, "y");
        var term_y_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_y_key, &term_y_value) == 0) return error.ArgumentError;
        value.y = @floatCast(try Double.get(env, term_y_value));

        // z

        const term_z_key = Atom.make(env, "z");
        var term_z_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_z_key, &term_z_value) == 0) return error.ArgumentError;
        value.z = @floatCast(try Double.get(env, term_z_value));

        return value;
    }

    pub fn unload(value: rl.Vector3) void {
        _ = value;
    }

    pub fn free(value: rl.Vector3) void {
        _ = value;
    }
};

////////////////
//  IVector3  //
////////////////

pub const IVector3 = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.IVector3;
    pub const resource_name = "ivector3";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.IVector3) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // x

        const term_x_key = Atom.make(env, "x");
        const term_x_value = Int.make(env, @intCast(value.x));
        assert(e.enif_make_map_put(env, term, term_x_key, term_x_value, &term) != 0);

        // y

        const term_y_key = Atom.make(env, "y");
        const term_y_value = Int.make(env, @intCast(value.y));
        assert(e.enif_make_map_put(env, term, term_y_key, term_y_value, &term) != 0);

        // z

        const term_z_key = Atom.make(env, "z");
        const term_z_value = Int.make(env, @intCast(value.z));
        assert(e.enif_make_map_put(env, term, term_z_key, term_z_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.IVector3 {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.IVector3{};

        // x

        const term_x_key = Atom.make(env, "x");
        var term_x_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_x_key, &term_x_value) == 0) return error.ArgumentError;
        value.x = @intCast(try Int.get(env, term_x_value));

        // y

        const term_y_key = Atom.make(env, "y");
        var term_y_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_y_key, &term_y_value) == 0) return error.ArgumentError;
        value.y = @intCast(try Int.get(env, term_y_value));

        // z

        const term_z_key = Atom.make(env, "z");
        var term_z_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_z_key, &term_z_value) == 0) return error.ArgumentError;
        value.z = @intCast(try Int.get(env, term_z_value));

        return value;
    }

    pub fn unload(value: rl.IVector3) void {
        _ = value;
    }

    pub fn free(value: rl.IVector3) void {
        _ = value;
    }
};

/////////////////
//  UIVector3  //
/////////////////

pub const UIVector3 = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.UIVector3;
    pub const resource_name = "uivector3";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.UIVector3) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // x

        const term_x_key = Atom.make(env, "x");
        const term_x_value = UInt.make(env, @intCast(value.x));
        assert(e.enif_make_map_put(env, term, term_x_key, term_x_value, &term) != 0);

        // y

        const term_y_key = Atom.make(env, "y");
        const term_y_value = UInt.make(env, @intCast(value.y));
        assert(e.enif_make_map_put(env, term, term_y_key, term_y_value, &term) != 0);

        // z

        const term_z_key = Atom.make(env, "z");
        const term_z_value = UInt.make(env, @intCast(value.z));
        assert(e.enif_make_map_put(env, term, term_z_key, term_z_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.UIVector3 {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.UIVector3{};

        // x

        const term_x_key = Atom.make(env, "x");
        var term_x_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_x_key, &term_x_value) == 0) return error.ArgumentError;
        value.x = @intCast(try UInt.get(env, term_x_value));

        // y

        const term_y_key = Atom.make(env, "y");
        var term_y_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_y_key, &term_y_value) == 0) return error.ArgumentError;
        value.y = @intCast(try UInt.get(env, term_y_value));

        // z

        const term_z_key = Atom.make(env, "z");
        var term_z_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_z_key, &term_z_value) == 0) return error.ArgumentError;
        value.z = @intCast(try UInt.get(env, term_z_value));

        return value;
    }

    pub fn unload(value: rl.UIVector3) void {
        _ = value;
    }

    pub fn free(value: rl.UIVector3) void {
        _ = value;
    }
};

///////////////
//  Vector4  //
///////////////

pub const Vector4 = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Vector4;
    pub const resource_name = "vector4";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Vector4) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // x

        const term_x_key = Atom.make(env, "x");
        const term_x_value = Double.make(env, @floatCast(value.x));
        assert(e.enif_make_map_put(env, term, term_x_key, term_x_value, &term) != 0);

        // y

        const term_y_key = Atom.make(env, "y");
        const term_y_value = Double.make(env, @floatCast(value.y));
        assert(e.enif_make_map_put(env, term, term_y_key, term_y_value, &term) != 0);

        // z

        const term_z_key = Atom.make(env, "z");
        const term_z_value = Double.make(env, @floatCast(value.z));
        assert(e.enif_make_map_put(env, term, term_z_key, term_z_value, &term) != 0);

        // w

        const term_w_key = Atom.make(env, "w");
        const term_w_value = Double.make(env, @floatCast(value.w));
        assert(e.enif_make_map_put(env, term, term_w_key, term_w_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Vector4 {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Vector4{};

        // x

        const term_x_key = Atom.make(env, "x");
        var term_x_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_x_key, &term_x_value) == 0) return error.ArgumentError;
        value.x = @floatCast(try Double.get(env, term_x_value));

        // y

        const term_y_key = Atom.make(env, "y");
        var term_y_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_y_key, &term_y_value) == 0) return error.ArgumentError;
        value.y = @floatCast(try Double.get(env, term_y_value));

        // z

        const term_z_key = Atom.make(env, "z");
        var term_z_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_z_key, &term_z_value) == 0) return error.ArgumentError;
        value.z = @floatCast(try Double.get(env, term_z_value));

        // w

        const term_w_key = Atom.make(env, "w");
        var term_w_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_w_key, &term_w_value) == 0) return error.ArgumentError;
        value.w = @floatCast(try Double.get(env, term_w_value));

        return value;
    }

    pub fn unload(value: rl.Vector4) void {
        _ = value;
    }

    pub fn free(value: rl.Vector4) void {
        _ = value;
    }
};

////////////////
//  IVector4  //
////////////////

pub const IVector4 = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.IVector4;
    pub const resource_name = "ivector4";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.IVector4) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // x

        const term_x_key = Atom.make(env, "x");
        const term_x_value = Int.make(env, @intCast(value.x));
        assert(e.enif_make_map_put(env, term, term_x_key, term_x_value, &term) != 0);

        // y

        const term_y_key = Atom.make(env, "y");
        const term_y_value = Int.make(env, @intCast(value.y));
        assert(e.enif_make_map_put(env, term, term_y_key, term_y_value, &term) != 0);

        // z

        const term_z_key = Atom.make(env, "z");
        const term_z_value = Int.make(env, @intCast(value.z));
        assert(e.enif_make_map_put(env, term, term_z_key, term_z_value, &term) != 0);

        // w

        const term_w_key = Atom.make(env, "w");
        const term_w_value = Int.make(env, @intCast(value.w));
        assert(e.enif_make_map_put(env, term, term_w_key, term_w_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.IVector4 {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.IVector4{};

        // x

        const term_x_key = Atom.make(env, "x");
        var term_x_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_x_key, &term_x_value) == 0) return error.ArgumentError;
        value.x = @intCast(try Int.get(env, term_x_value));

        // y

        const term_y_key = Atom.make(env, "y");
        var term_y_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_y_key, &term_y_value) == 0) return error.ArgumentError;
        value.y = @intCast(try Int.get(env, term_y_value));

        // z

        const term_z_key = Atom.make(env, "z");
        var term_z_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_z_key, &term_z_value) == 0) return error.ArgumentError;
        value.z = @intCast(try Int.get(env, term_z_value));

        // w

        const term_w_key = Atom.make(env, "w");
        var term_w_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_w_key, &term_w_value) == 0) return error.ArgumentError;
        value.w = @intCast(try Int.get(env, term_w_value));

        return value;
    }

    pub fn unload(value: rl.IVector4) void {
        _ = value;
    }

    pub fn free(value: rl.IVector4) void {
        _ = value;
    }
};

/////////////////
//  UIVector4  //
/////////////////

pub const UIVector4 = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.UIVector4;
    pub const resource_name = "uivector4";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.UIVector4) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // x

        const term_x_key = Atom.make(env, "x");
        const term_x_value = UInt.make(env, @intCast(value.x));
        assert(e.enif_make_map_put(env, term, term_x_key, term_x_value, &term) != 0);

        // y

        const term_y_key = Atom.make(env, "y");
        const term_y_value = UInt.make(env, @intCast(value.y));
        assert(e.enif_make_map_put(env, term, term_y_key, term_y_value, &term) != 0);

        // z

        const term_z_key = Atom.make(env, "z");
        const term_z_value = UInt.make(env, @intCast(value.z));
        assert(e.enif_make_map_put(env, term, term_z_key, term_z_value, &term) != 0);

        // w

        const term_w_key = Atom.make(env, "w");
        const term_w_value = UInt.make(env, @intCast(value.w));
        assert(e.enif_make_map_put(env, term, term_w_key, term_w_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.UIVector4 {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.UIVector4{};

        // x

        const term_x_key = Atom.make(env, "x");
        var term_x_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_x_key, &term_x_value) == 0) return error.ArgumentError;
        value.x = @intCast(try UInt.get(env, term_x_value));

        // y

        const term_y_key = Atom.make(env, "y");
        var term_y_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_y_key, &term_y_value) == 0) return error.ArgumentError;
        value.y = @intCast(try UInt.get(env, term_y_value));

        // z

        const term_z_key = Atom.make(env, "z");
        var term_z_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_z_key, &term_z_value) == 0) return error.ArgumentError;
        value.z = @intCast(try UInt.get(env, term_z_value));

        // w

        const term_w_key = Atom.make(env, "w");
        var term_w_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_w_key, &term_w_value) == 0) return error.ArgumentError;
        value.w = @intCast(try UInt.get(env, term_w_value));

        return value;
    }

    pub fn unload(value: rl.UIVector4) void {
        _ = value;
    }

    pub fn free(value: rl.UIVector4) void {
        _ = value;
    }
};

//////////////////
//  Quaternion  //
//////////////////

pub const Quaternion = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Quaternion;
    pub const resource_name = "quaternion";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Quaternion) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // x

        const term_x_key = Atom.make(env, "x");
        const term_x_value = Double.make(env, @floatCast(value.x));
        assert(e.enif_make_map_put(env, term, term_x_key, term_x_value, &term) != 0);

        // y

        const term_y_key = Atom.make(env, "y");
        const term_y_value = Double.make(env, @floatCast(value.y));
        assert(e.enif_make_map_put(env, term, term_y_key, term_y_value, &term) != 0);

        // z

        const term_z_key = Atom.make(env, "z");
        const term_z_value = Double.make(env, @floatCast(value.z));
        assert(e.enif_make_map_put(env, term, term_z_key, term_z_value, &term) != 0);

        // w

        const term_w_key = Atom.make(env, "w");
        const term_w_value = Double.make(env, @floatCast(value.w));
        assert(e.enif_make_map_put(env, term, term_w_key, term_w_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Quaternion {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Quaternion{};

        // x

        const term_x_key = Atom.make(env, "x");
        var term_x_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_x_key, &term_x_value) == 0) return error.ArgumentError;
        value.x = @floatCast(try Double.get(env, term_x_value));

        // y

        const term_y_key = Atom.make(env, "y");
        var term_y_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_y_key, &term_y_value) == 0) return error.ArgumentError;
        value.y = @floatCast(try Double.get(env, term_y_value));

        // z

        const term_z_key = Atom.make(env, "z");
        var term_z_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_z_key, &term_z_value) == 0) return error.ArgumentError;
        value.z = @floatCast(try Double.get(env, term_z_value));

        // w

        const term_w_key = Atom.make(env, "w");
        var term_w_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_w_key, &term_w_value) == 0) return error.ArgumentError;
        value.w = @floatCast(try Double.get(env, term_w_value));

        return value;
    }

    pub fn unload(value: rl.Quaternion) void {
        _ = value;
    }

    pub fn free(value: rl.Quaternion) void {
        _ = value;
    }
};

//////////////
//  Matrix  //
//////////////

pub const Matrix = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Matrix;
    pub const resource_name = "matrix";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Matrix) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // m0

        const term_m0_key = Atom.make(env, "m0");
        const term_m0_value = Double.make(env, @floatCast(value.m0));
        assert(e.enif_make_map_put(env, term, term_m0_key, term_m0_value, &term) != 0);

        // m1

        const term_m1_key = Atom.make(env, "m1");
        const term_m1_value = Double.make(env, @floatCast(value.m1));
        assert(e.enif_make_map_put(env, term, term_m1_key, term_m1_value, &term) != 0);

        // m2

        const term_m2_key = Atom.make(env, "m2");
        const term_m2_value = Double.make(env, @floatCast(value.m2));
        assert(e.enif_make_map_put(env, term, term_m2_key, term_m2_value, &term) != 0);

        // m3

        const term_m3_key = Atom.make(env, "m3");
        const term_m3_value = Double.make(env, @floatCast(value.m3));
        assert(e.enif_make_map_put(env, term, term_m3_key, term_m3_value, &term) != 0);

        // m4

        const term_m4_key = Atom.make(env, "m4");
        const term_m4_value = Double.make(env, @floatCast(value.m4));
        assert(e.enif_make_map_put(env, term, term_m4_key, term_m4_value, &term) != 0);

        // m5

        const term_m5_key = Atom.make(env, "m5");
        const term_m5_value = Double.make(env, @floatCast(value.m5));
        assert(e.enif_make_map_put(env, term, term_m5_key, term_m5_value, &term) != 0);

        // m6

        const term_m6_key = Atom.make(env, "m6");
        const term_m6_value = Double.make(env, @floatCast(value.m6));
        assert(e.enif_make_map_put(env, term, term_m6_key, term_m6_value, &term) != 0);

        // m7

        const term_m7_key = Atom.make(env, "m7");
        const term_m7_value = Double.make(env, @floatCast(value.m7));
        assert(e.enif_make_map_put(env, term, term_m7_key, term_m7_value, &term) != 0);

        // m8

        const term_m8_key = Atom.make(env, "m8");
        const term_m8_value = Double.make(env, @floatCast(value.m8));
        assert(e.enif_make_map_put(env, term, term_m8_key, term_m8_value, &term) != 0);

        // m9

        const term_m9_key = Atom.make(env, "m9");
        const term_m9_value = Double.make(env, @floatCast(value.m9));
        assert(e.enif_make_map_put(env, term, term_m9_key, term_m9_value, &term) != 0);

        // m10

        const term_m10_key = Atom.make(env, "m10");
        const term_m10_value = Double.make(env, @floatCast(value.m10));
        assert(e.enif_make_map_put(env, term, term_m10_key, term_m10_value, &term) != 0);

        // m11

        const term_m11_key = Atom.make(env, "m11");
        const term_m11_value = Double.make(env, @floatCast(value.m11));
        assert(e.enif_make_map_put(env, term, term_m11_key, term_m11_value, &term) != 0);

        // m12

        const term_m12_key = Atom.make(env, "m12");
        const term_m12_value = Double.make(env, @floatCast(value.m12));
        assert(e.enif_make_map_put(env, term, term_m12_key, term_m12_value, &term) != 0);

        // m13

        const term_m13_key = Atom.make(env, "m13");
        const term_m13_value = Double.make(env, @floatCast(value.m13));
        assert(e.enif_make_map_put(env, term, term_m13_key, term_m13_value, &term) != 0);

        // m14

        const term_m14_key = Atom.make(env, "m14");
        const term_m14_value = Double.make(env, @floatCast(value.m14));
        assert(e.enif_make_map_put(env, term, term_m14_key, term_m14_value, &term) != 0);

        // m15

        const term_m15_key = Atom.make(env, "m15");
        const term_m15_value = Double.make(env, @floatCast(value.m15));
        assert(e.enif_make_map_put(env, term, term_m15_key, term_m15_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Matrix {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Matrix{};

        // m0

        const term_m0_key = Atom.make(env, "m0");
        var term_m0_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_m0_key, &term_m0_value) == 0) return error.ArgumentError;
        value.m0 = @floatCast(try Double.get(env, term_m0_value));

        // m1

        const term_m1_key = Atom.make(env, "m1");
        var term_m1_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_m1_key, &term_m1_value) == 0) return error.ArgumentError;
        value.m1 = @floatCast(try Double.get(env, term_m1_value));

        // m2

        const term_m2_key = Atom.make(env, "m2");
        var term_m2_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_m2_key, &term_m2_value) == 0) return error.ArgumentError;
        value.m2 = @floatCast(try Double.get(env, term_m2_value));

        // m3

        const term_m3_key = Atom.make(env, "m3");
        var term_m3_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_m3_key, &term_m3_value) == 0) return error.ArgumentError;
        value.m3 = @floatCast(try Double.get(env, term_m3_value));

        // m4

        const term_m4_key = Atom.make(env, "m4");
        var term_m4_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_m4_key, &term_m4_value) == 0) return error.ArgumentError;
        value.m4 = @floatCast(try Double.get(env, term_m4_value));

        // m5

        const term_m5_key = Atom.make(env, "m5");
        var term_m5_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_m5_key, &term_m5_value) == 0) return error.ArgumentError;
        value.m5 = @floatCast(try Double.get(env, term_m5_value));

        // m6

        const term_m6_key = Atom.make(env, "m6");
        var term_m6_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_m6_key, &term_m6_value) == 0) return error.ArgumentError;
        value.m6 = @floatCast(try Double.get(env, term_m6_value));

        // m7

        const term_m7_key = Atom.make(env, "m7");
        var term_m7_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_m7_key, &term_m7_value) == 0) return error.ArgumentError;
        value.m7 = @floatCast(try Double.get(env, term_m7_value));

        // m8

        const term_m8_key = Atom.make(env, "m8");
        var term_m8_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_m8_key, &term_m8_value) == 0) return error.ArgumentError;
        value.m8 = @floatCast(try Double.get(env, term_m8_value));

        // m9

        const term_m9_key = Atom.make(env, "m9");
        var term_m9_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_m9_key, &term_m9_value) == 0) return error.ArgumentError;
        value.m9 = @floatCast(try Double.get(env, term_m9_value));

        // m10

        const term_m10_key = Atom.make(env, "m10");
        var term_m10_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_m10_key, &term_m10_value) == 0) return error.ArgumentError;
        value.m10 = @floatCast(try Double.get(env, term_m10_value));

        // m11

        const term_m11_key = Atom.make(env, "m11");
        var term_m11_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_m11_key, &term_m11_value) == 0) return error.ArgumentError;
        value.m11 = @floatCast(try Double.get(env, term_m11_value));

        // m12

        const term_m12_key = Atom.make(env, "m12");
        var term_m12_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_m12_key, &term_m12_value) == 0) return error.ArgumentError;
        value.m12 = @floatCast(try Double.get(env, term_m12_value));

        // m13

        const term_m13_key = Atom.make(env, "m13");
        var term_m13_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_m13_key, &term_m13_value) == 0) return error.ArgumentError;
        value.m13 = @floatCast(try Double.get(env, term_m13_value));

        // m14

        const term_m14_key = Atom.make(env, "m14");
        var term_m14_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_m14_key, &term_m14_value) == 0) return error.ArgumentError;
        value.m14 = @floatCast(try Double.get(env, term_m14_value));

        // m15

        const term_m15_key = Atom.make(env, "m15");
        var term_m15_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_m15_key, &term_m15_value) == 0) return error.ArgumentError;
        value.m15 = @floatCast(try Double.get(env, term_m15_value));

        return value;
    }

    pub fn unload(value: rl.Matrix) void {
        _ = value;
    }

    pub fn free(value: rl.Matrix) void {
        _ = value;
    }
};

/////////////
//  Color  //
/////////////

pub const Color = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Color;
    pub const resource_name = "color";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Color) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // r

        const term_r_key = Atom.make(env, "r");
        const term_r_value = UInt.make(env, @intCast(value.r));
        assert(e.enif_make_map_put(env, term, term_r_key, term_r_value, &term) != 0);

        // g

        const term_g_key = Atom.make(env, "g");
        const term_g_value = UInt.make(env, @intCast(value.g));
        assert(e.enif_make_map_put(env, term, term_g_key, term_g_value, &term) != 0);

        // b

        const term_b_key = Atom.make(env, "b");
        const term_b_value = UInt.make(env, @intCast(value.b));
        assert(e.enif_make_map_put(env, term, term_b_key, term_b_value, &term) != 0);

        // a

        const term_a_key = Atom.make(env, "a");
        const term_a_value = UInt.make(env, @intCast(value.a));
        assert(e.enif_make_map_put(env, term, term_a_key, term_a_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Color {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Color{};

        // r

        const term_r_key = Atom.make(env, "r");
        var term_r_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_r_key, &term_r_value) == 0) return error.ArgumentError;
        value.r = @intCast(try UInt.get(env, term_r_value));

        // g

        const term_g_key = Atom.make(env, "g");
        var term_g_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_g_key, &term_g_value) == 0) return error.ArgumentError;
        value.g = @intCast(try UInt.get(env, term_g_value));

        // b

        const term_b_key = Atom.make(env, "b");
        var term_b_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_b_key, &term_b_value) == 0) return error.ArgumentError;
        value.b = @intCast(try UInt.get(env, term_b_value));

        // a

        const term_a_key = Atom.make(env, "a");
        var term_a_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_a_key, &term_a_value) == 0) return error.ArgumentError;
        value.a = @intCast(try UInt.get(env, term_a_value));

        return value;
    }

    pub fn unload(value: rl.Color) void {
        _ = value;
    }

    pub fn free(value: rl.Color) void {
        _ = value;
    }
};

/////////////////
//  Rectangle  //
/////////////////

pub const Rectangle = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Rectangle;
    pub const resource_name = "rectangle";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Rectangle) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // x

        const term_x_key = Atom.make(env, "x");
        const term_x_value = Double.make(env, @floatCast(value.x));
        assert(e.enif_make_map_put(env, term, term_x_key, term_x_value, &term) != 0);

        // y

        const term_y_key = Atom.make(env, "y");
        const term_y_value = Double.make(env, @floatCast(value.y));
        assert(e.enif_make_map_put(env, term, term_y_key, term_y_value, &term) != 0);

        // width

        const term_width_key = Atom.make(env, "width");
        const term_width_value = Double.make(env, @floatCast(value.width));
        assert(e.enif_make_map_put(env, term, term_width_key, term_width_value, &term) != 0);

        // height

        const term_height_key = Atom.make(env, "height");
        const term_height_value = Double.make(env, @floatCast(value.height));
        assert(e.enif_make_map_put(env, term, term_height_key, term_height_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Rectangle {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Rectangle{};

        // x

        const term_x_key = Atom.make(env, "x");
        var term_x_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_x_key, &term_x_value) == 0) return error.ArgumentError;
        value.x = @floatCast(try Double.get(env, term_x_value));

        // y

        const term_y_key = Atom.make(env, "y");
        var term_y_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_y_key, &term_y_value) == 0) return error.ArgumentError;
        value.y = @floatCast(try Double.get(env, term_y_value));

        // width

        const term_width_key = Atom.make(env, "width");
        var term_width_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_width_key, &term_width_value) == 0) return error.ArgumentError;
        value.width = @floatCast(try Double.get(env, term_width_value));

        // height

        const term_height_key = Atom.make(env, "height");
        var term_height_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_height_key, &term_height_value) == 0) return error.ArgumentError;
        value.height = @floatCast(try Double.get(env, term_height_value));

        return value;
    }

    pub fn unload(value: rl.Rectangle) void {
        _ = value;
    }

    pub fn free(value: rl.Rectangle) void {
        _ = value;
    }
};

/////////////
//  Image  //
/////////////

pub const Image = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Image;
    pub const resource_name = "image";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Image) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // width

        const term_width_key = Atom.make(env, "width");
        const term_width_value = Int.make(env, @intCast(value.width));
        assert(e.enif_make_map_put(env, term, term_width_key, term_width_value, &term) != 0);

        // height

        const term_height_key = Atom.make(env, "height");
        const term_height_value = Int.make(env, @intCast(value.height));
        assert(e.enif_make_map_put(env, term, term_height_key, term_height_value, &term) != 0);

        // mipmaps

        const term_mipmaps_key = Atom.make(env, "mipmaps");
        const term_mipmaps_value = Int.make(env, @intCast(value.mipmaps));
        assert(e.enif_make_map_put(env, term, term_mipmaps_key, term_mipmaps_value, &term) != 0);

        // format

        const term_format_key = Atom.make(env, "format");
        const term_format_value = Int.make(env, @intCast(value.format));
        assert(e.enif_make_map_put(env, term, term_format_key, term_format_value, &term) != 0);

        // data

        const data_size: usize = get_data_size(
            value.width,
            value.height,
            value.format,
            value.mipmaps,
        );

        const term_data_key = Atom.make(env, "data");
        const term_data_value = Binary.make_c(env, @ptrCast(value.data), data_size);
        assert(e.enif_make_map_put(env, term, term_data_key, term_data_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Image {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Image{};

        // width

        const term_width_key = Atom.make(env, "width");
        var term_width_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_width_key, &term_width_value) == 0) return error.ArgumentError;
        value.width = @intCast(try Int.get(env, term_width_value));

        // height

        const term_height_key = Atom.make(env, "height");
        var term_height_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_height_key, &term_height_value) == 0) return error.ArgumentError;
        value.height = @intCast(try Int.get(env, term_height_value));

        // mipmaps

        const term_mipmaps_key = Atom.make(env, "mipmaps");
        var term_mipmaps_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_mipmaps_key, &term_mipmaps_value) == 0) return error.ArgumentError;
        value.mipmaps = @intCast(try Int.get(env, term_mipmaps_value));

        // format

        const term_format_key = Atom.make(env, "format");
        var term_format_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_format_key, &term_format_value) == 0) return error.ArgumentError;
        value.format = @intCast(try Int.get(env, term_format_value));

        // data

        const data_size: usize = get_data_size(
            value.width,
            value.height,
            value.format,
            value.mipmaps,
        );

        const term_data_key = Atom.make(env, "data");
        var term_data_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_data_key, &term_data_value) == 0) return error.ArgumentError;
        const data = try ArgumentBinaryC(Binary, Self.allocator).get(env, term_data_value, data_size);
        errdefer data.free();
        value.data = data.data;

        return value;
    }

    pub fn unload(value: rl.Image) void {
        free(value);
    }

    pub fn free(value: rl.Image) void {
        rl.UnloadImage(value);
    }

    pub fn get_data_size(width: c_int, height: c_int, format: c_int, mipmaps: c_int) usize {
        var size: c_int = 0;

        var w = width;
        var h = height;
        const m: usize = @intCast(mipmaps);

        for (0..m) |_| {
            size += rl.GetPixelDataSize(
                width,
                height,
                format,
            );

            w = @divTrunc(w, 2);
            h = @divTrunc(h, 2);

            // Security check for NPOT textures
            if (w < 1) w = 1;
            if (h < 1) h = 1;
        }

        return @intCast(size);
    }
};

///////////////
//  Texture  //
///////////////

pub const Texture = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Texture;
    pub const resource_name = "texture";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Texture) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // id

        const term_id_key = Atom.make(env, "id");
        const term_id_value = UInt.make(env, @intCast(value.id));
        assert(e.enif_make_map_put(env, term, term_id_key, term_id_value, &term) != 0);

        // width

        const term_width_key = Atom.make(env, "width");
        const term_width_value = Int.make(env, @intCast(value.width));
        assert(e.enif_make_map_put(env, term, term_width_key, term_width_value, &term) != 0);

        // height

        const term_height_key = Atom.make(env, "height");
        const term_height_value = Int.make(env, @intCast(value.height));
        assert(e.enif_make_map_put(env, term, term_height_key, term_height_value, &term) != 0);

        // mipmaps

        const term_mipmaps_key = Atom.make(env, "mipmaps");
        const term_mipmaps_value = Int.make(env, @intCast(value.mipmaps));
        assert(e.enif_make_map_put(env, term, term_mipmaps_key, term_mipmaps_value, &term) != 0);

        // format

        const term_format_key = Atom.make(env, "format");
        const term_format_value = Int.make(env, @intCast(value.format));
        assert(e.enif_make_map_put(env, term, term_format_key, term_format_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Texture {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Texture{};

        // id

        const term_id_key = Atom.make(env, "id");
        var term_id_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_id_key, &term_id_value) == 0) return error.ArgumentError;
        value.id = @intCast(try UInt.get(env, term_id_value));

        // width

        const term_width_key = Atom.make(env, "width");
        var term_width_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_width_key, &term_width_value) == 0) return error.ArgumentError;
        value.width = @intCast(try Int.get(env, term_width_value));

        // height

        const term_height_key = Atom.make(env, "height");
        var term_height_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_height_key, &term_height_value) == 0) return error.ArgumentError;
        value.height = @intCast(try Int.get(env, term_height_value));

        // mipmaps

        const term_mipmaps_key = Atom.make(env, "mipmaps");
        var term_mipmaps_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_mipmaps_key, &term_mipmaps_value) == 0) return error.ArgumentError;
        value.mipmaps = @intCast(try Int.get(env, term_mipmaps_value));

        // format

        const term_format_key = Atom.make(env, "format");
        var term_format_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_format_key, &term_format_value) == 0) return error.ArgumentError;
        value.format = @intCast(try Int.get(env, term_format_value));

        return value;
    }

    pub fn unload(value: rl.Texture) void {
        rl.UnloadTexture(value);
    }

    pub fn free(value: rl.Texture) void {
        _ = value;
    }
};

/////////////////
//  Texture2D  //
/////////////////

pub const Texture2D = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Texture2D;
    pub const resource_name = "texture_2d";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Texture2D) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // id

        const term_id_key = Atom.make(env, "id");
        const term_id_value = UInt.make(env, @intCast(value.id));
        assert(e.enif_make_map_put(env, term, term_id_key, term_id_value, &term) != 0);

        // width

        const term_width_key = Atom.make(env, "width");
        const term_width_value = Int.make(env, @intCast(value.width));
        assert(e.enif_make_map_put(env, term, term_width_key, term_width_value, &term) != 0);

        // height

        const term_height_key = Atom.make(env, "height");
        const term_height_value = Int.make(env, @intCast(value.height));
        assert(e.enif_make_map_put(env, term, term_height_key, term_height_value, &term) != 0);

        // mipmaps

        const term_mipmaps_key = Atom.make(env, "mipmaps");
        const term_mipmaps_value = Int.make(env, @intCast(value.mipmaps));
        assert(e.enif_make_map_put(env, term, term_mipmaps_key, term_mipmaps_value, &term) != 0);

        // format

        const term_format_key = Atom.make(env, "format");
        const term_format_value = Int.make(env, @intCast(value.format));
        assert(e.enif_make_map_put(env, term, term_format_key, term_format_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Texture2D {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Texture2D{};

        // id

        const term_id_key = Atom.make(env, "id");
        var term_id_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_id_key, &term_id_value) == 0) return error.ArgumentError;
        value.id = @intCast(try UInt.get(env, term_id_value));

        // width

        const term_width_key = Atom.make(env, "width");
        var term_width_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_width_key, &term_width_value) == 0) return error.ArgumentError;
        value.width = @intCast(try Int.get(env, term_width_value));

        // height

        const term_height_key = Atom.make(env, "height");
        var term_height_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_height_key, &term_height_value) == 0) return error.ArgumentError;
        value.height = @intCast(try Int.get(env, term_height_value));

        // mipmaps

        const term_mipmaps_key = Atom.make(env, "mipmaps");
        var term_mipmaps_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_mipmaps_key, &term_mipmaps_value) == 0) return error.ArgumentError;
        value.mipmaps = @intCast(try Int.get(env, term_mipmaps_value));

        // format

        const term_format_key = Atom.make(env, "format");
        var term_format_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_format_key, &term_format_value) == 0) return error.ArgumentError;
        value.format = @intCast(try Int.get(env, term_format_value));

        return value;
    }

    pub fn unload(value: rl.Texture2D) void {
        rl.UnloadTexture(value);
    }

    pub fn free(value: rl.Texture2D) void {
        _ = value;
    }
};

//////////////////////
//  TextureCubemap  //
//////////////////////

pub const TextureCubemap = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.TextureCubemap;
    pub const resource_name = "texture_cubemap";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.TextureCubemap) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // id

        const term_id_key = Atom.make(env, "id");
        const term_id_value = UInt.make(env, @intCast(value.id));
        assert(e.enif_make_map_put(env, term, term_id_key, term_id_value, &term) != 0);

        // width

        const term_width_key = Atom.make(env, "width");
        const term_width_value = Int.make(env, @intCast(value.width));
        assert(e.enif_make_map_put(env, term, term_width_key, term_width_value, &term) != 0);

        // height

        const term_height_key = Atom.make(env, "height");
        const term_height_value = Int.make(env, @intCast(value.height));
        assert(e.enif_make_map_put(env, term, term_height_key, term_height_value, &term) != 0);

        // mipmaps

        const term_mipmaps_key = Atom.make(env, "mipmaps");
        const term_mipmaps_value = Int.make(env, @intCast(value.mipmaps));
        assert(e.enif_make_map_put(env, term, term_mipmaps_key, term_mipmaps_value, &term) != 0);

        // format

        const term_format_key = Atom.make(env, "format");
        const term_format_value = Int.make(env, @intCast(value.format));
        assert(e.enif_make_map_put(env, term, term_format_key, term_format_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.TextureCubemap {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.TextureCubemap{};

        // id

        const term_id_key = Atom.make(env, "id");
        var term_id_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_id_key, &term_id_value) == 0) return error.ArgumentError;
        value.id = @intCast(try UInt.get(env, term_id_value));

        // width

        const term_width_key = Atom.make(env, "width");
        var term_width_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_width_key, &term_width_value) == 0) return error.ArgumentError;
        value.width = @intCast(try Int.get(env, term_width_value));

        // height

        const term_height_key = Atom.make(env, "height");
        var term_height_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_height_key, &term_height_value) == 0) return error.ArgumentError;
        value.height = @intCast(try Int.get(env, term_height_value));

        // mipmaps

        const term_mipmaps_key = Atom.make(env, "mipmaps");
        var term_mipmaps_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_mipmaps_key, &term_mipmaps_value) == 0) return error.ArgumentError;
        value.mipmaps = @intCast(try Int.get(env, term_mipmaps_value));

        // format

        const term_format_key = Atom.make(env, "format");
        var term_format_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_format_key, &term_format_value) == 0) return error.ArgumentError;
        value.format = @intCast(try Int.get(env, term_format_value));

        return value;
    }

    pub fn unload(value: rl.TextureCubemap) void {
        rl.UnloadTexture(value);
    }

    pub fn free(value: rl.TextureCubemap) void {
        _ = value;
    }
};

/////////////////////
//  RenderTexture  //
/////////////////////

pub const RenderTexture = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.RenderTexture;
    pub const resource_name = "render_texture";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.RenderTexture) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // id

        const term_id_key = Atom.make(env, "id");
        const term_id_value = UInt.make(env, @intCast(value.id));
        assert(e.enif_make_map_put(env, term, term_id_key, term_id_value, &term) != 0);

        // texture

        const term_texture_key = Atom.make(env, "texture");
        const term_texture_value = Texture.make(env, value.texture);
        assert(e.enif_make_map_put(env, term, term_texture_key, term_texture_value, &term) != 0);

        // depth

        const term_depth_key = Atom.make(env, "depth");
        const term_depth_value = Texture.make(env, value.depth);
        assert(e.enif_make_map_put(env, term, term_depth_key, term_depth_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.RenderTexture {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.RenderTexture{};

        // id

        const term_id_key = Atom.make(env, "id");
        var term_id_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_id_key, &term_id_value) == 0) return error.ArgumentError;
        value.id = @intCast(try UInt.get(env, term_id_value));

        // texture

        const term_texture_key = Atom.make(env, "texture");
        var term_texture_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_texture_key, &term_texture_value) == 0) return error.ArgumentError;
        const texture = try Argument(Texture).get(env, term_texture_value);
        errdefer texture.free();
        value.texture = texture.data;

        // depth

        const term_depth_key = Atom.make(env, "depth");
        var term_depth_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_depth_key, &term_depth_value) == 0) return error.ArgumentError;
        const depth = try Argument(Texture).get(env, term_depth_value);
        errdefer depth.free();
        value.depth = depth.data;

        return value;
    }

    pub fn unload(value: rl.RenderTexture) void {
        rl.UnloadRenderTexture(value);
    }

    pub fn free(value: rl.RenderTexture) void {
        _ = value;
    }
};

///////////////////////
//  RenderTexture2D  //
///////////////////////

pub const RenderTexture2D = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.RenderTexture2D;
    pub const resource_name = "render_texture_2d";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.RenderTexture2D) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // id

        const term_id_key = Atom.make(env, "id");
        const term_id_value = UInt.make(env, @intCast(value.id));
        assert(e.enif_make_map_put(env, term, term_id_key, term_id_value, &term) != 0);

        // texture

        const term_texture_key = Atom.make(env, "texture");
        const term_texture_value = Texture.make(env, value.texture);
        assert(e.enif_make_map_put(env, term, term_texture_key, term_texture_value, &term) != 0);

        // depth

        const term_depth_key = Atom.make(env, "depth");
        const term_depth_value = Texture.make(env, value.depth);
        assert(e.enif_make_map_put(env, term, term_depth_key, term_depth_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.RenderTexture2D {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.RenderTexture2D{};

        // id

        const term_id_key = Atom.make(env, "id");
        var term_id_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_id_key, &term_id_value) == 0) return error.ArgumentError;
        value.id = @intCast(try UInt.get(env, term_id_value));

        // texture

        const term_texture_key = Atom.make(env, "texture");
        var term_texture_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_texture_key, &term_texture_value) == 0) return error.ArgumentError;
        const texture = try Argument(Texture).get(env, term_texture_value);
        errdefer texture.free();
        value.texture = texture.data;

        // depth

        const term_depth_key = Atom.make(env, "depth");
        var term_depth_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_depth_key, &term_depth_value) == 0) return error.ArgumentError;
        const depth = try Argument(Texture).get(env, term_depth_value);
        errdefer depth.free();
        value.depth = depth.data;

        return value;
    }

    pub fn unload(value: rl.RenderTexture2D) void {
        rl.UnloadRenderTexture(value);
    }

    pub fn free(value: rl.RenderTexture2D) void {
        _ = value;
    }
};

//////////////////
//  NPatchInfo  //
//////////////////

pub const NPatchInfo = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.NPatchInfo;
    pub const resource_name = "n_patch_info";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.NPatchInfo) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // source

        const term_source_key = Atom.make(env, "source");
        const term_source_value = Rectangle.make(env, value.source);
        assert(e.enif_make_map_put(env, term, term_source_key, term_source_value, &term) != 0);

        // left

        const term_left_key = Atom.make(env, "left");
        const term_left_value = Int.make(env, @intCast(value.left));
        assert(e.enif_make_map_put(env, term, term_left_key, term_left_value, &term) != 0);

        // top

        const term_top_key = Atom.make(env, "top");
        const term_top_value = Int.make(env, @intCast(value.top));
        assert(e.enif_make_map_put(env, term, term_top_key, term_top_value, &term) != 0);

        // right

        const term_right_key = Atom.make(env, "right");
        const term_right_value = Int.make(env, @intCast(value.right));
        assert(e.enif_make_map_put(env, term, term_right_key, term_right_value, &term) != 0);

        // bottom

        const term_bottom_key = Atom.make(env, "bottom");
        const term_bottom_value = Int.make(env, @intCast(value.bottom));
        assert(e.enif_make_map_put(env, term, term_bottom_key, term_bottom_value, &term) != 0);

        // layout

        const term_layout_key = Atom.make(env, "layout");
        const term_layout_value = Int.make(env, @intCast(value.layout));
        assert(e.enif_make_map_put(env, term, term_layout_key, term_layout_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.NPatchInfo {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.NPatchInfo{};

        // source

        const term_source_key = Atom.make(env, "source");
        var term_source_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_source_key, &term_source_value) == 0) return error.ArgumentError;
        const source = try Argument(Rectangle).get(env, term_source_value);
        errdefer source.free();
        value.source = source.data;

        // left

        const term_left_key = Atom.make(env, "left");
        var term_left_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_left_key, &term_left_value) == 0) return error.ArgumentError;
        value.left = @intCast(try Int.get(env, term_left_value));

        // top

        const term_top_key = Atom.make(env, "top");
        var term_top_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_top_key, &term_top_value) == 0) return error.ArgumentError;
        value.top = @intCast(try Int.get(env, term_top_value));

        // right

        const term_right_key = Atom.make(env, "right");
        var term_right_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_right_key, &term_right_value) == 0) return error.ArgumentError;
        value.right = @intCast(try Int.get(env, term_right_value));

        // bottom

        const term_bottom_key = Atom.make(env, "bottom");
        var term_bottom_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_bottom_key, &term_bottom_value) == 0) return error.ArgumentError;
        value.bottom = @intCast(try Int.get(env, term_bottom_value));

        // layout

        const term_layout_key = Atom.make(env, "layout");
        var term_layout_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_layout_key, &term_layout_value) == 0) return error.ArgumentError;
        value.layout = @intCast(try Int.get(env, term_layout_value));

        return value;
    }

    pub fn unload(value: rl.NPatchInfo) void {
        free(value);
    }

    pub fn free(value: rl.NPatchInfo) void {
        Rectangle.free(value.source);
    }
};

/////////////////
//  GlyphInfo  //
/////////////////

pub const GlyphInfo = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.GlyphInfo;
    pub const resource_name = "glyph_info";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.GlyphInfo) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // value

        const term_value_key = Atom.make(env, "value");
        const term_value_value = Int.make(env, @intCast(value.value));
        assert(e.enif_make_map_put(env, term, term_value_key, term_value_value, &term) != 0);

        // offset_x

        const term_offset_x_key = Atom.make(env, "offset_x");
        const term_offset_x_value = Int.make(env, @intCast(value.offsetX));
        assert(e.enif_make_map_put(env, term, term_offset_x_key, term_offset_x_value, &term) != 0);

        // offset_y

        const term_offset_y_key = Atom.make(env, "offset_y");
        const term_offset_y_value = Int.make(env, @intCast(value.offsetY));
        assert(e.enif_make_map_put(env, term, term_offset_y_key, term_offset_y_value, &term) != 0);

        // advance_x

        const term_advance_x_key = Atom.make(env, "advance_x");
        const term_advance_x_value = Int.make(env, @intCast(value.advanceX));
        assert(e.enif_make_map_put(env, term, term_advance_x_key, term_advance_x_value, &term) != 0);

        // image

        const term_image_key = Atom.make(env, "image");
        const term_image_value = Image.make(env, value.image);
        assert(e.enif_make_map_put(env, term, term_image_key, term_image_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.GlyphInfo {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.GlyphInfo{};

        // value

        const term_value_key = Atom.make(env, "value");
        var term_value_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_value_key, &term_value_value) == 0) return error.ArgumentError;
        value.value = @intCast(try Int.get(env, term_value_value));

        // offset_x

        const term_offset_x_key = Atom.make(env, "offset_x");
        var term_offset_x_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_offset_x_key, &term_offset_x_value) == 0) return error.ArgumentError;
        value.offsetX = @intCast(try Int.get(env, term_offset_x_value));

        // offset_y

        const term_offset_y_key = Atom.make(env, "offset_y");
        var term_offset_y_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_offset_y_key, &term_offset_y_value) == 0) return error.ArgumentError;
        value.offsetY = @intCast(try Int.get(env, term_offset_y_value));

        // advance_x

        const term_advance_x_key = Atom.make(env, "advance_x");
        var term_advance_x_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_advance_x_key, &term_advance_x_value) == 0) return error.ArgumentError;
        value.advanceX = @intCast(try Int.get(env, term_advance_x_value));

        // image

        const term_image_key = Atom.make(env, "image");
        var term_image_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_image_key, &term_image_value) == 0) return error.ArgumentError;
        const image = try Argument(Image).get(env, term_image_value);
        errdefer image.free();
        value.image = image.data;

        return value;
    }

    pub fn unload(value: rl.GlyphInfo) void {
        free(value);
    }

    pub fn free(value: rl.GlyphInfo) void {
        Image.free(value.image);
    }
};

////////////
//  Font  //
////////////

pub const Font = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Font;
    pub const resource_name = "font";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Font) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // base_size

        const term_base_size_key = Atom.make(env, "base_size");
        const term_base_size_value = Int.make(env, @intCast(value.baseSize));
        assert(e.enif_make_map_put(env, term, term_base_size_key, term_base_size_value, &term) != 0);

        // glyph_count

        const term_glyph_count_key = Atom.make(env, "glyph_count");
        const term_glyph_count_value = Int.make(env, @intCast(value.glyphCount));
        assert(e.enif_make_map_put(env, term, term_glyph_count_key, term_glyph_count_value, &term) != 0);

        // glyph_padding

        const term_glyph_padding_key = Atom.make(env, "glyph_padding");
        const term_glyph_padding_value = Int.make(env, @intCast(value.glyphPadding));
        assert(e.enif_make_map_put(env, term, term_glyph_padding_key, term_glyph_padding_value, &term) != 0);

        // texture

        const term_texture_key = Atom.make(env, "texture");
        const term_texture_value = Texture.make(env, value.texture);
        assert(e.enif_make_map_put(env, term, term_texture_key, term_texture_value, &term) != 0);

        // recs

        const term_recs_key = Atom.make(env, "recs");
        const recs_lengths = [_]usize{@intCast(value.glyphCount)};
        const term_recs_value = Array.make_c(Rectangle, rl.Rectangle, env, value.recs, &recs_lengths);
        assert(e.enif_make_map_put(env, term, term_recs_key, term_recs_value, &term) != 0);

        // glyphs

        const term_glyphs_key = Atom.make(env, "glyphs");
        const glyphs_lengths = [_]usize{@intCast(value.glyphCount)};
        const term_glyphs_value = Array.make_c(GlyphInfo, rl.GlyphInfo, env, value.glyphs, &glyphs_lengths);
        assert(e.enif_make_map_put(env, term, term_glyphs_key, term_glyphs_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Font {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Font{};

        // base_size

        const term_base_size_key = Atom.make(env, "base_size");
        var term_base_size_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_base_size_key, &term_base_size_value) == 0) return error.ArgumentError;
        value.baseSize = @intCast(try Int.get(env, term_base_size_value));

        // glyph_count

        const term_glyph_count_key = Atom.make(env, "glyph_count");
        var term_glyph_count_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_glyph_count_key, &term_glyph_count_value) == 0) return error.ArgumentError;
        value.glyphCount = @intCast(try Int.get(env, term_glyph_count_value));

        // glyph_padding

        const term_glyph_padding_key = Atom.make(env, "glyph_padding");
        var term_glyph_padding_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_glyph_padding_key, &term_glyph_padding_value) == 0) return error.ArgumentError;
        value.glyphPadding = @intCast(try Int.get(env, term_glyph_padding_value));

        // texture

        const term_texture_key = Atom.make(env, "texture");
        var term_texture_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_texture_key, &term_texture_value) == 0) return error.ArgumentError;
        const texture = try Argument(Texture).get(env, term_texture_value);
        errdefer texture.free();
        value.texture = texture.data;

        // recs

        const term_recs_key = Atom.make(env, "recs");
        var term_recs_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_recs_key, &term_recs_value) == 0) return error.ArgumentError;

        const recs_lengths = [_]usize{@intCast(value.glyphCount)};
        var recs = try ArgumentArrayC(Rectangle, Rectangle.data_type, Self.allocator).get(env, term_recs_value, &recs_lengths);
        defer recs.free_keep();
        errdefer recs.free();
        value.recs = recs.data;

        // glyphs

        const term_glyphs_key = Atom.make(env, "glyphs");
        var term_glyphs_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_glyphs_key, &term_glyphs_value) == 0) return error.ArgumentError;

        const glyphs_lengths = [_]usize{@intCast(value.glyphCount)};
        var glyphs = try ArgumentArrayC(GlyphInfo, GlyphInfo.data_type, Self.allocator).get(env, term_glyphs_value, &glyphs_lengths);
        defer glyphs.free_keep();
        errdefer glyphs.free();
        value.glyphs = glyphs.data;

        return value;
    }

    pub fn unload(value: rl.Font) void {
        rl.UnloadFont(value);
    }

    pub fn free(value: rl.Font) void {
        if (value.glyphs != null) {
            for (0..@intCast(value.glyphCount)) |i| {
                GlyphInfo.free(value.glyphs[i]);
            }
        }
        rl.MemFree(value.glyphs);
        Texture.free(value.texture);
        rl.MemFree(value.recs);
    }
};

////////////////
//  Camera3D  //
////////////////

pub const Camera3D = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Camera3D;
    pub const resource_name = "camera_3d";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Camera3D) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // position

        const term_position_key = Atom.make(env, "position");
        const term_position_value = Vector3.make(env, value.position);
        assert(e.enif_make_map_put(env, term, term_position_key, term_position_value, &term) != 0);

        // target

        const term_target_key = Atom.make(env, "target");
        const term_target_value = Vector3.make(env, value.target);
        assert(e.enif_make_map_put(env, term, term_target_key, term_target_value, &term) != 0);

        // up

        const term_up_key = Atom.make(env, "up");
        const term_up_value = Vector3.make(env, value.up);
        assert(e.enif_make_map_put(env, term, term_up_key, term_up_value, &term) != 0);

        // fovy

        const term_fovy_key = Atom.make(env, "fovy");
        const term_fovy_value = Double.make(env, @floatCast(value.fovy));
        assert(e.enif_make_map_put(env, term, term_fovy_key, term_fovy_value, &term) != 0);

        // projection

        const term_projection_key = Atom.make(env, "projection");
        const term_projection_value = Int.make(env, @intCast(value.projection));
        assert(e.enif_make_map_put(env, term, term_projection_key, term_projection_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Camera3D {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Camera3D{};

        // position

        const term_position_key = Atom.make(env, "position");
        var term_position_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_position_key, &term_position_value) == 0) return error.ArgumentError;
        const position = try Argument(Vector3).get(env, term_position_value);
        errdefer position.free();
        value.position = position.data;

        // target

        const term_target_key = Atom.make(env, "target");
        var term_target_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_target_key, &term_target_value) == 0) return error.ArgumentError;
        const target = try Argument(Vector3).get(env, term_target_value);
        errdefer target.free();
        value.target = target.data;

        // up

        const term_up_key = Atom.make(env, "up");
        var term_up_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_up_key, &term_up_value) == 0) return error.ArgumentError;
        const up = try Argument(Vector3).get(env, term_up_value);
        errdefer up.free();
        value.up = up.data;

        // fovy

        const term_fovy_key = Atom.make(env, "fovy");
        var term_fovy_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_fovy_key, &term_fovy_value) == 0) return error.ArgumentError;
        value.fovy = @floatCast(try Double.get(env, term_fovy_value));

        // projection

        const term_projection_key = Atom.make(env, "projection");
        var term_projection_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_projection_key, &term_projection_value) == 0) return error.ArgumentError;
        value.projection = @intCast(try Int.get(env, term_projection_value));

        return value;
    }

    pub fn unload(value: rl.Camera3D) void {
        _ = value;
    }

    pub fn free(value: rl.Camera3D) void {
        _ = value;
    }
};

//////////////
//  Camera  //
//////////////

pub const Camera = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Camera;
    pub const resource_name = "camera";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Camera) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // position

        const term_position_key = Atom.make(env, "position");
        const term_position_value = Vector3.make(env, value.position);
        assert(e.enif_make_map_put(env, term, term_position_key, term_position_value, &term) != 0);

        // target

        const term_target_key = Atom.make(env, "target");
        const term_target_value = Vector3.make(env, value.target);
        assert(e.enif_make_map_put(env, term, term_target_key, term_target_value, &term) != 0);

        // up

        const term_up_key = Atom.make(env, "up");
        const term_up_value = Vector3.make(env, value.up);
        assert(e.enif_make_map_put(env, term, term_up_key, term_up_value, &term) != 0);

        // fovy

        const term_fovy_key = Atom.make(env, "fovy");
        const term_fovy_value = Double.make(env, @floatCast(value.fovy));
        assert(e.enif_make_map_put(env, term, term_fovy_key, term_fovy_value, &term) != 0);

        // projection

        const term_projection_key = Atom.make(env, "projection");
        const term_projection_value = Int.make(env, @intCast(value.projection));
        assert(e.enif_make_map_put(env, term, term_projection_key, term_projection_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Camera {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Camera{};

        // position

        const term_position_key = Atom.make(env, "position");
        var term_position_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_position_key, &term_position_value) == 0) return error.ArgumentError;
        const position = try Argument(Vector3).get(env, term_position_value);
        errdefer position.free();
        value.position = position.data;

        // target

        const term_target_key = Atom.make(env, "target");
        var term_target_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_target_key, &term_target_value) == 0) return error.ArgumentError;
        const target = try Argument(Vector3).get(env, term_target_value);
        errdefer target.free();
        value.target = target.data;

        // up

        const term_up_key = Atom.make(env, "up");
        var term_up_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_up_key, &term_up_value) == 0) return error.ArgumentError;
        const up = try Argument(Vector3).get(env, term_up_value);
        errdefer up.free();
        value.up = up.data;

        // fovy

        const term_fovy_key = Atom.make(env, "fovy");
        var term_fovy_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_fovy_key, &term_fovy_value) == 0) return error.ArgumentError;
        value.fovy = @floatCast(try Double.get(env, term_fovy_value));

        // projection

        const term_projection_key = Atom.make(env, "projection");
        var term_projection_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_projection_key, &term_projection_value) == 0) return error.ArgumentError;
        value.projection = @intCast(try Int.get(env, term_projection_value));

        return value;
    }

    pub fn unload(value: rl.Camera) void {
        _ = value;
    }

    pub fn free(value: rl.Camera) void {
        _ = value;
    }
};

////////////////
//  Camera2D  //
////////////////

pub const Camera2D = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Camera2D;
    pub const resource_name = "camera_2d";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Camera2D) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // offset

        const term_offset_key = Atom.make(env, "offset");
        const term_offset_value = Vector2.make(env, value.offset);
        assert(e.enif_make_map_put(env, term, term_offset_key, term_offset_value, &term) != 0);

        // target

        const term_target_key = Atom.make(env, "target");
        const term_target_value = Vector2.make(env, value.target);
        assert(e.enif_make_map_put(env, term, term_target_key, term_target_value, &term) != 0);

        // rotation

        const term_rotation_key = Atom.make(env, "rotation");
        const term_rotation_value = Double.make(env, @floatCast(value.rotation));
        assert(e.enif_make_map_put(env, term, term_rotation_key, term_rotation_value, &term) != 0);

        // zoom

        const term_zoom_key = Atom.make(env, "zoom");
        const term_zoom_value = Double.make(env, @floatCast(value.zoom));
        assert(e.enif_make_map_put(env, term, term_zoom_key, term_zoom_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Camera2D {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Camera2D{};

        // offset

        const term_offset_key = Atom.make(env, "offset");
        var term_offset_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_offset_key, &term_offset_value) == 0) return error.ArgumentError;
        const offset = try Argument(Vector2).get(env, term_offset_value);
        errdefer offset.free();
        value.offset = offset.data;

        // target

        const term_target_key = Atom.make(env, "target");
        var term_target_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_target_key, &term_target_value) == 0) return error.ArgumentError;
        const target = try Argument(Vector2).get(env, term_target_value);
        errdefer target.free();
        value.target = target.data;

        // rotation

        const term_rotation_key = Atom.make(env, "rotation");
        var term_rotation_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_rotation_key, &term_rotation_value) == 0) return error.ArgumentError;
        value.rotation = @floatCast(try Double.get(env, term_rotation_value));

        // zoom

        const term_zoom_key = Atom.make(env, "zoom");
        var term_zoom_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_zoom_key, &term_zoom_value) == 0) return error.ArgumentError;
        value.zoom = @floatCast(try Double.get(env, term_zoom_value));

        return value;
    }

    pub fn unload(value: rl.Camera2D) void {
        _ = value;
    }

    pub fn free(value: rl.Camera2D) void {
        _ = value;
    }
};

////////////
//  Mesh  //
////////////

pub const Mesh = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Mesh;
    pub const resource_name = "mesh";

    pub const Resource = ResourceBase(Self);

    pub const MAX_VERTEX_BUFFERS: usize = @intCast(rl.MAX_MESH_VERTEX_BUFFERS);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Mesh) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // vertex_count

        const term_vertex_count_key = Atom.make(env, "vertex_count");
        const term_vertex_count_value = Int.make(env, @intCast(value.vertexCount));
        assert(e.enif_make_map_put(env, term, term_vertex_count_key, term_vertex_count_value, &term) != 0);

        // triangle_count

        const term_triangle_count_key = Atom.make(env, "triangle_count");
        const term_triangle_count_value = Int.make(env, @intCast(value.triangleCount));
        assert(e.enif_make_map_put(env, term, term_triangle_count_key, term_triangle_count_value, &term) != 0);

        // vertices
        // = vertex_count * 3

        const term_vertices_key = Atom.make(env, "vertices");
        const vertices_lengths = [_]usize{@intCast(value.vertexCount * 3)};
        const term_vertices_value = Array.make_c(Double, f32, env, value.vertices, &vertices_lengths);
        assert(e.enif_make_map_put(env, term, term_vertices_key, term_vertices_value, &term) != 0);

        // texcoords
        // = vertex_count * 2

        const term_texcoords_key = Atom.make(env, "texcoords");
        const texcoords_lengths = [_]usize{@intCast(value.vertexCount * 2)};
        const term_texcoords_value = Array.make_c(Double, f32, env, value.texcoords, &texcoords_lengths);
        assert(e.enif_make_map_put(env, term, term_texcoords_key, term_texcoords_value, &term) != 0);

        // texcoords2
        // = vertex_count * 2

        const term_texcoords2_key = Atom.make(env, "texcoords2");
        const texcoords2_lengths = [_]usize{@intCast(value.vertexCount * 2)};
        const term_texcoords2_value = Array.make_c(Double, f32, env, value.texcoords2, &texcoords2_lengths);
        assert(e.enif_make_map_put(env, term, term_texcoords2_key, term_texcoords2_value, &term) != 0);

        // normals
        // = vertex_count * 3

        const term_normals_key = Atom.make(env, "normals");
        const normals_lengths = [_]usize{@intCast(value.vertexCount * 3)};
        const term_normals_value = Array.make_c(Double, f32, env, value.normals, &normals_lengths);
        assert(e.enif_make_map_put(env, term, term_normals_key, term_normals_value, &term) != 0);

        // tangents
        // = vertex_count * 4

        const term_tangents_key = Atom.make(env, "tangents");
        const tangents_lengths = [_]usize{@intCast(value.vertexCount * 4)};
        const term_tangents_value = Array.make_c(Double, f32, env, value.tangents, &tangents_lengths);
        assert(e.enif_make_map_put(env, term, term_tangents_key, term_tangents_value, &term) != 0);

        // colors
        // = vertex_count * 4

        const term_colors_key = Atom.make(env, "colors");
        const colors_lengths = [_]usize{@intCast(value.vertexCount * 4)};
        const term_colors_value = Array.make_c(UInt, u8, env, value.colors, &colors_lengths);
        assert(e.enif_make_map_put(env, term, term_colors_key, term_colors_value, &term) != 0);

        // indices
        // = triangle_count * 3

        const term_indices_key = Atom.make(env, "indices");
        const indices_lengths = [_]usize{@intCast(value.triangleCount * 3)};
        const term_indices_value = Array.make_c(UInt, c_ushort, env, value.indices, &indices_lengths);
        assert(e.enif_make_map_put(env, term, term_indices_key, term_indices_value, &term) != 0);

        // anim_vertices
        // = vertex_count * 3

        const anim_vertices_length: usize = @intCast(value.vertexCount * 3);
        var term_anim_vertices_value = e.enif_make_list_from_array(env, null, 0);
        if (value.animVertices != null) {
            const anim_vertices = @as([*]f32, @ptrCast(value.animVertices))[0..anim_vertices_length];
            for (0..anim_vertices_length) |i| {
                term_anim_vertices_value = e.enif_make_list_cell(env, Double.make(env, @floatCast(anim_vertices[anim_vertices_length - 1 - i])), term_anim_vertices_value);
            }
        }
        const term_anim_vertices_key = Atom.make(env, "anim_vertices");
        assert(e.enif_make_map_put(env, term, term_anim_vertices_key, term_anim_vertices_value, &term) != 0);

        // anim_normals
        // = vertex_count * 3

        const term_anim_normals_key = Atom.make(env, "anim_normals");
        const anim_normals_lengths = [_]usize{@intCast(value.vertexCount * 3)};
        const term_anim_normals_value = Array.make_c(Double, f32, env, value.animNormals, &anim_normals_lengths);
        assert(e.enif_make_map_put(env, term, term_anim_normals_key, term_anim_normals_value, &term) != 0);

        // bone_ids
        // = vertex_count * 4

        const term_bone_ids_key = Atom.make(env, "bone_ids");
        const bone_ids_lengths = [_]usize{@intCast(value.vertexCount * 4)};
        const term_bone_ids_value = Array.make_c(UInt, u8, env, value.boneIds, &bone_ids_lengths);
        assert(e.enif_make_map_put(env, term, term_bone_ids_key, term_bone_ids_value, &term) != 0);

        // bone_weights
        // = vertex_count * 4

        const term_bone_weights_key = Atom.make(env, "bone_weights");
        const bone_weights_lengths = [_]usize{@intCast(value.vertexCount * 4)};
        const term_bone_weights_value = Array.make_c(Double, f32, env, value.boneWeights, &bone_weights_lengths);
        assert(e.enif_make_map_put(env, term, term_bone_weights_key, term_bone_weights_value, &term) != 0);

        // bone_count

        const term_bone_count_key = Atom.make(env, "bone_count");
        const term_bone_count_value = Int.make(env, @intCast(value.boneCount));
        assert(e.enif_make_map_put(env, term, term_bone_count_key, term_bone_count_value, &term) != 0);

        // bone_matrices
        // = bone_count

        const term_bone_matrices_key = Atom.make(env, "bone_matrices");
        const bone_matrices_lengths = [_]usize{@intCast(value.boneCount)};
        const term_bone_matrices_value = Array.make_c(Matrix, rl.Matrix, env, value.boneMatrices, &bone_matrices_lengths);
        assert(e.enif_make_map_put(env, term, term_bone_matrices_key, term_bone_matrices_value, &term) != 0);

        // vao_id

        const term_vao_id_key = Atom.make(env, "vao_id");
        const term_vao_id_value = UInt.make(env, @intCast(value.vaoId));
        assert(e.enif_make_map_put(env, term, term_vao_id_key, term_vao_id_value, &term) != 0);

        // vbo_id

        const term_vbo_id_key = Atom.make(env, "vbo_id");
        const vbo_id_lengths = [_]usize{@intCast(Self.MAX_VERTEX_BUFFERS)};
        const term_vbo_id_value = Array.make_c(UInt, c_uint, env, value.vboId, &vbo_id_lengths);
        assert(e.enif_make_map_put(env, term, term_vbo_id_key, term_vbo_id_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Mesh {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Mesh{};

        // vertex_count

        const term_vertex_count_key = Atom.make(env, "vertex_count");
        var term_vertex_count_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_vertex_count_key, &term_vertex_count_value) == 0) return error.ArgumentError;
        value.vertexCount = @intCast(try Int.get(env, term_vertex_count_value));

        // triangle_count

        const term_triangle_count_key = Atom.make(env, "triangle_count");
        var term_triangle_count_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_triangle_count_key, &term_triangle_count_value) == 0) return error.ArgumentError;
        value.triangleCount = @intCast(try Int.get(env, term_triangle_count_value));

        // vertices
        // = vertex_count * 3

        const term_vertices_key = Atom.make(env, "vertices");
        var term_vertices_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_vertices_key, &term_vertices_value) == 0) return error.ArgumentError;

        const vertices_lengths = [_]usize{@intCast(value.vertexCount * 3)};
        value.vertices = try Array.get_c(Double, f32, Self.allocator, env, term_vertices_value, &vertices_lengths);
        errdefer Array.free_c(Double, f32, Self.allocator, value.vertices, &vertices_lengths, null);

        // texcoords
        // = vertex_count * 2

        const term_texcoords_key = Atom.make(env, "texcoords");
        var term_texcoords_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_texcoords_key, &term_texcoords_value) == 0) return error.ArgumentError;

        const texcoords_lengths = [_]usize{@intCast(value.vertexCount * 2)};
        value.texcoords = try Array.get_c(Double, f32, Self.allocator, env, term_texcoords_value, &texcoords_lengths);
        errdefer Array.free_c(Double, f32, Self.allocator, value.texcoords, &texcoords_lengths, null);

        // texcoords2
        // = vertex_count * 2

        const term_texcoords2_key = Atom.make(env, "texcoords2");
        var term_texcoords2_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_texcoords2_key, &term_texcoords2_value) == 0) return error.ArgumentError;

        const texcoords2_lengths = [_]usize{@intCast(value.vertexCount * 2)};
        value.texcoords2 = try Array.get_c(Double, f32, Self.allocator, env, term_texcoords2_value, &texcoords2_lengths);
        errdefer Array.free_c(Double, f32, Self.allocator, value.texcoords2, &texcoords2_lengths, null);

        // normals
        // = vertex_count * 3

        const term_normals_key = Atom.make(env, "normals");
        var term_normals_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_normals_key, &term_normals_value) == 0) return error.ArgumentError;

        const normals_lengths = [_]usize{@intCast(value.vertexCount * 3)};
        value.normals = try Array.get_c(Double, f32, Self.allocator, env, term_normals_value, &normals_lengths);
        errdefer Array.free_c(Double, f32, Self.allocator, value.normals, &normals_lengths, null);

        // tangents
        // = vertex_count * 4

        const term_tangents_key = Atom.make(env, "tangents");
        var term_tangents_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_tangents_key, &term_tangents_value) == 0) return error.ArgumentError;

        const tangents_lengths = [_]usize{@intCast(value.vertexCount * 4)};
        value.tangents = try Array.get_c(Double, f32, Self.allocator, env, term_tangents_value, &tangents_lengths);
        errdefer Array.free_c(Double, f32, Self.allocator, value.tangents, &tangents_lengths, null);

        // colors
        // = vertex_count * 4

        const term_colors_key = Atom.make(env, "colors");
        var term_colors_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_colors_key, &term_colors_value) == 0) return error.ArgumentError;

        const colors_lengths = [_]usize{@intCast(value.vertexCount * 4)};
        value.colors = try Array.get_c(UInt, u8, Self.allocator, env, term_colors_value, &colors_lengths);
        errdefer Array.free_c(UInt, u8, Self.allocator, value.colors, &colors_lengths, null);

        // indices
        // = triangle_count * 3

        const term_indices_key = Atom.make(env, "indices");
        var term_indices_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_indices_key, &term_indices_value) == 0) return error.ArgumentError;

        const indices_lengths = [_]usize{@intCast(value.triangleCount * 3)};
        value.indices = try Array.get_c(UInt, c_ushort, Self.allocator, env, term_indices_value, &indices_lengths);
        errdefer Array.free_c(UInt, c_ushort, Self.allocator, value.indices, &indices_lengths, null);

        // anim_vertices
        // = vertex_count * 3

        const term_anim_vertices_key = Atom.make(env, "anim_vertices");
        var term_anim_vertices_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_anim_vertices_key, &term_anim_vertices_value) == 0) return error.ArgumentError;

        const anim_vertices_lengths = [_]usize{@intCast(value.vertexCount * 3)};
        value.animVertices = try Array.get_c(Double, f32, Self.allocator, env, term_anim_vertices_value, &anim_vertices_lengths);
        errdefer Array.free_c(Double, f32, Self.allocator, value.animVertices, &anim_vertices_lengths, null);

        // anim_normals
        // = vertex_count * 3

        const term_anim_normals_key = Atom.make(env, "anim_normals");
        var term_anim_normals_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_anim_normals_key, &term_anim_normals_value) == 0) return error.ArgumentError;

        const anim_normals_lengths = [_]usize{@intCast(value.vertexCount * 3)};
        value.animNormals = try Array.get_c(Double, f32, Self.allocator, env, term_anim_normals_value, &anim_normals_lengths);
        errdefer Array.free_c(Double, f32, Self.allocator, value.animNormals, &anim_normals_lengths, null);

        // bone_ids
        // = vertex_count * 4

        const term_bone_ids_key = Atom.make(env, "bone_ids");
        var term_bone_ids_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_bone_ids_key, &term_bone_ids_value) == 0) return error.ArgumentError;

        const bone_ids_lengths = [_]usize{@intCast(value.vertexCount * 4)};
        value.boneIds = try Array.get_c(UInt, u8, Self.allocator, env, term_bone_ids_value, &bone_ids_lengths);
        errdefer Array.free_c(UInt, u8, Self.allocator, value.boneIds, &bone_ids_lengths, null);

        // bone_weights
        // = vertex_count * 4

        const term_bone_weights_key = Atom.make(env, "bone_weights");
        var term_bone_weights_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_bone_weights_key, &term_bone_weights_value) == 0) return error.ArgumentError;

        const bone_weights_lengths = [_]usize{@intCast(value.vertexCount * 4)};
        value.boneWeights = try Array.get_c(Double, f32, Self.allocator, env, term_bone_weights_value, &bone_weights_lengths);
        errdefer Array.free_c(Double, f32, Self.allocator, value.boneWeights, &bone_weights_lengths, null);

        // bone_count

        const term_bone_count_key = Atom.make(env, "bone_count");
        var term_bone_count_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_bone_count_key, &term_bone_count_value) == 0) return error.ArgumentError;
        value.boneCount = @intCast(try Int.get(env, term_bone_count_value));

        // bone_matrices
        // = bone_count

        const term_bone_matrices_key = Atom.make(env, "bone_matrices");
        var term_bone_matrices_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_bone_matrices_key, &term_bone_matrices_value) == 0) return error.ArgumentError;

        const bone_matrices_lengths = [_]usize{@intCast(value.boneCount)};
        var bone_matrices = try ArgumentArrayC(Matrix, Matrix.data_type, Self.allocator).get(env, term_bone_matrices_value, &bone_matrices_lengths);
        defer bone_matrices.free_keep();
        errdefer bone_matrices.free();
        value.boneMatrices = bone_matrices.data;

        // vao_id

        const term_vao_id_key = Atom.make(env, "vao_id");
        var term_vao_id_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_vao_id_key, &term_vao_id_value) == 0) return error.ArgumentError;
        value.vaoId = @intCast(try UInt.get(env, term_vao_id_value));

        // vbo_id

        const term_vbo_id_key = Atom.make(env, "vbo_id");
        var term_vbo_id_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_vbo_id_key, &term_vbo_id_value) == 0) return error.ArgumentError;

        const vbo_id_lengths = [_]usize{@intCast(Self.MAX_VERTEX_BUFFERS)};
        value.vboId = try Array.get_c(UInt, c_uint, Self.allocator, env, term_vbo_id_value, &vbo_id_lengths);
        errdefer Array.free_c(UInt, c_uint, Self.allocator, value.vboId, &vbo_id_lengths, null);

        return value;
    }

    pub fn unload(value: rl.Mesh) void {
        var should_unload: bool = true;

        // vbo_id = 0 is used on tests so we remove it before calling UnloadMesh
        if (value.vboId != null) {
            var test_vbo_id: u8 = 0;
            for (0..Self.MAX_VERTEX_BUFFERS) |i| {
                if (value.vboId[i] == 0) {
                    test_vbo_id += 1;
                }
            }

            if (test_vbo_id == Self.MAX_VERTEX_BUFFERS) {
                should_unload = false;
            }
        }

        if (should_unload) {
            rl.UnloadMesh(value);
        } else {
            free(value);
        }
    }

    pub fn free(value: rl.Mesh) void {
        rl.MemFree(value.vboId);

        rl.MemFree(value.vertices);
        rl.MemFree(value.texcoords);
        rl.MemFree(value.normals);
        rl.MemFree(value.colors);
        rl.MemFree(value.tangents);
        rl.MemFree(value.texcoords2);
        rl.MemFree(value.indices);

        rl.MemFree(value.animVertices);
        rl.MemFree(value.animNormals);
        rl.MemFree(value.boneWeights);
        rl.MemFree(value.boneIds);
        rl.MemFree(value.boneMatrices);
    }
};

//////////////
//  Shader  //
//////////////

pub const Shader = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Shader;
    pub const resource_name = "shader";

    pub const Resource = ResourceBase(Self);

    pub const MAX_LOCATIONS: usize = @intCast(rl.RL_MAX_SHADER_LOCATIONS);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Shader) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // id

        const term_id_key = Atom.make(env, "id");
        const term_id_value = UInt.make(env, @intCast(value.id));
        assert(e.enif_make_map_put(env, term, term_id_key, term_id_value, &term) != 0);

        // locs

        const term_locs_key = Atom.make(env, "locs");
        const locs_lengths = [_]usize{@intCast(Self.MAX_LOCATIONS)};
        const term_locs_value = Array.make_c(Int, c_int, env, value.locs, &locs_lengths);
        assert(e.enif_make_map_put(env, term, term_locs_key, term_locs_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Shader {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Shader{};

        // id

        const term_id_key = Atom.make(env, "id");
        var term_id_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_id_key, &term_id_value) == 0) return error.ArgumentError;
        value.id = @intCast(try UInt.get(env, term_id_value));

        // locs

        const term_locs_key = Atom.make(env, "locs");
        var term_locs_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_locs_key, &term_locs_value) == 0) return error.ArgumentError;

        const locs_lengths = [_]usize{@intCast(Self.MAX_LOCATIONS)};
        value.locs = try Array.get_c(Int, c_int, Self.allocator, env, term_locs_value, &locs_lengths);
        errdefer Array.free_c(Double, f32, Self.allocator, value.locs, &locs_lengths, null);

        return value;
    }

    pub fn unload(value: rl.Shader) void {
        rl.UnloadShader(value);
    }

    pub fn free(value: rl.Shader) void {
        // NOTE: If shader loading failed, it should be 0
        rl.MemFree(value.locs);
    }
};

///////////////////
//  MaterialMap  //
///////////////////

pub const MaterialMap = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.MaterialMap;
    pub const resource_name = "material_map";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.MaterialMap) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // texture

        const term_texture_key = Atom.make(env, "texture");
        const term_texture_value = Texture2D.make(env, value.texture);
        assert(e.enif_make_map_put(env, term, term_texture_key, term_texture_value, &term) != 0);

        // color

        const term_color_key = Atom.make(env, "color");
        const term_color_value = Color.make(env, value.color);
        assert(e.enif_make_map_put(env, term, term_color_key, term_color_value, &term) != 0);

        // value

        const term_value_key = Atom.make(env, "value");
        const term_value_value = Double.make(env, @floatCast(value.value));
        assert(e.enif_make_map_put(env, term, term_value_key, term_value_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.MaterialMap {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.MaterialMap{};

        // texture

        const term_texture_key = Atom.make(env, "texture");
        var term_texture_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_texture_key, &term_texture_value) == 0) return error.ArgumentError;
        const texture = try Argument(Texture2D).get(env, term_texture_value);
        errdefer texture.free();
        value.texture = texture.data;

        // color

        const term_color_key = Atom.make(env, "color");
        var term_color_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_color_key, &term_color_value) == 0) return error.ArgumentError;
        const color = try Argument(Color).get(env, term_color_value);
        errdefer color.free();
        value.color = color.data;

        // value

        const term_value_key = Atom.make(env, "value");
        var term_value_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_value_key, &term_value_value) == 0) return error.ArgumentError;
        value.value = @floatCast(try Double.get(env, term_value_value));

        return value;
    }

    pub fn unload(value: rl.MaterialMap) void {
        Texture2D.unload(value.texture);
    }

    pub fn free(value: rl.MaterialMap) void {
        Texture2D.free(value.texture);
    }
};

////////////////
//  Material  //
////////////////

pub const Material = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Material;
    pub const resource_name = "material";

    pub const Resource = ResourceBase(Self);

    pub const MAX_MAPS: usize = @intCast(rl.MAX_MATERIAL_MAPS);

    pub const MAX_PARAMS: usize = get_field_array_length(rl.Material, "params");

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Material) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // shader

        const term_shader_key = Atom.make(env, "shader");
        const term_shader_value = Shader.make(env, value.shader);
        assert(e.enif_make_map_put(env, term, term_shader_key, term_shader_value, &term) != 0);

        // maps

        const term_maps_key = Atom.make(env, "maps");
        const maps_lengths = [_]usize{@intCast(Self.MAX_MAPS)};
        const term_maps_value = Array.make_c(MaterialMap, rl.MaterialMap, env, value.maps, &maps_lengths);
        assert(e.enif_make_map_put(env, term, term_maps_key, term_maps_value, &term) != 0);

        // params

        const term_params_key = Atom.make(env, "params");
        const term_params_value = Array.make(Double, f32, env, &value.params);
        assert(e.enif_make_map_put(env, term, term_params_key, term_params_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Material {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Material{};

        // shader

        const term_shader_key = Atom.make(env, "shader");
        var term_shader_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_shader_key, &term_shader_value) == 0) return error.ArgumentError;
        const shader = try Argument(Shader).get(env, term_shader_value);
        errdefer shader.free();
        value.shader = shader.data;

        // maps

        const term_maps_key = Atom.make(env, "maps");
        var term_maps_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_maps_key, &term_maps_value) == 0) return error.ArgumentError;

        const maps_lengths = [_]usize{@intCast(Self.MAX_MAPS)};
        var maps = try ArgumentArrayC(MaterialMap, MaterialMap.data_type, Self.allocator).get(env, term_maps_value, &maps_lengths);
        defer maps.free_keep();
        errdefer maps.free();
        value.maps = maps.data;

        // params

        const term_params_key = Atom.make(env, "params");
        var term_params_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_params_key, &term_params_value) == 0) return error.ArgumentError;
        try Array.get_copy(Double, f32, Self.allocator, env, term_params_value, &value.params);
        errdefer Array.free_copy(Double, f32, Self.allocator, &value.params, null);

        return value;
    }

    pub fn unload(value: rl.Material) void {
        rl.UnloadMaterial(value);
    }

    pub fn free(value: rl.Material) void {
        // Unload material shader
        Shader.free(value.shader);

        // Unload loaded texture maps
        if (value.maps != null) {
            for (0..@intCast(Self.MAX_MAPS)) |i| {
                MaterialMap.free(value.maps[i]);
            }
        }

        rl.MemFree(value.maps);
    }
};

/////////////////
//  Transform  //
/////////////////

pub const Transform = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Transform;
    pub const resource_name = "transform";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Transform) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // translation

        const term_translation_key = Atom.make(env, "translation");
        const term_translation_value = Vector3.make(env, value.translation);
        assert(e.enif_make_map_put(env, term, term_translation_key, term_translation_value, &term) != 0);

        // rotation

        const term_rotation_key = Atom.make(env, "rotation");
        const term_rotation_value = Quaternion.make(env, value.rotation);
        assert(e.enif_make_map_put(env, term, term_rotation_key, term_rotation_value, &term) != 0);

        // scale

        const term_scale_key = Atom.make(env, "scale");
        const term_scale_value = Vector3.make(env, value.scale);
        assert(e.enif_make_map_put(env, term, term_scale_key, term_scale_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Transform {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Transform{};

        // translation

        const term_translation_key = Atom.make(env, "translation");
        var term_translation_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_translation_key, &term_translation_value) == 0) return error.ArgumentError;
        const translation = try Argument(Vector3).get(env, term_translation_value);
        errdefer translation.free();
        value.translation = translation.data;

        // rotation

        const term_rotation_key = Atom.make(env, "rotation");
        var term_rotation_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_rotation_key, &term_rotation_value) == 0) return error.ArgumentError;
        const rotation = try Argument(Quaternion).get(env, term_rotation_value);
        errdefer rotation.free();
        value.rotation = rotation.data;

        // scale

        const term_scale_key = Atom.make(env, "scale");
        var term_scale_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_scale_key, &term_scale_value) == 0) return error.ArgumentError;
        const scale = try Argument(Vector3).get(env, term_scale_value);
        errdefer scale.free();
        value.scale = scale.data;

        return value;
    }

    pub fn unload(value: rl.Transform) void {
        _ = value;
    }

    pub fn free(value: rl.Transform) void {
        _ = value;
    }
};

////////////////
//  BoneInfo  //
////////////////

pub const BoneInfo = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.BoneInfo;
    pub const resource_name = "bone_info";

    pub const Resource = ResourceBase(Self);

    pub const MAX_NAME: usize = get_field_array_length(rl.BoneInfo, "name");

    pub fn make(env: ?*e.ErlNifEnv, value: rl.BoneInfo) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // name

        const term_name_key = Atom.make(env, "name");
        const term_name_value = CString.make(env, &value.name);
        assert(e.enif_make_map_put(env, term, term_name_key, term_name_value, &term) != 0);

        // parent

        const term_parent_key = Atom.make(env, "parent");
        const term_parent_value = Int.make(env, @intCast(value.parent));
        assert(e.enif_make_map_put(env, term, term_parent_key, term_parent_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.BoneInfo {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.BoneInfo{};

        // name

        const term_name_key = Atom.make(env, "name");
        var term_name_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_name_key, &term_name_value) == 0) return error.ArgumentError;
        try CString.get_copy(env, term_name_value, &value.name);

        // parent

        const term_parent_key = Atom.make(env, "parent");
        var term_parent_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_parent_key, &term_parent_value) == 0) return error.ArgumentError;
        value.parent = @intCast(try Int.get(env, term_parent_value));

        return value;
    }

    pub fn unload(value: rl.BoneInfo) void {
        _ = value;
    }

    pub fn free(value: rl.BoneInfo) void {
        _ = value;
    }
};

/////////////
//  Model  //
/////////////

pub const Model = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Model;
    pub const resource_name = "model";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Model) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // transform

        const term_transform_key = Atom.make(env, "transform");
        const term_transform_value = Matrix.make(env, value.transform);
        assert(e.enif_make_map_put(env, term, term_transform_key, term_transform_value, &term) != 0);

        // mesh_count

        const term_mesh_count_key = Atom.make(env, "mesh_count");
        const term_mesh_count_value = Int.make(env, @intCast(value.meshCount));
        assert(e.enif_make_map_put(env, term, term_mesh_count_key, term_mesh_count_value, &term) != 0);

        // material_count

        const term_material_count_key = Atom.make(env, "material_count");
        const term_material_count_value = Int.make(env, @intCast(value.materialCount));
        assert(e.enif_make_map_put(env, term, term_material_count_key, term_material_count_value, &term) != 0);

        // bone_count

        const term_bone_count_key = Atom.make(env, "bone_count");
        const term_bone_count_value = Int.make(env, @intCast(value.boneCount));
        assert(e.enif_make_map_put(env, term, term_bone_count_key, term_bone_count_value, &term) != 0);

        // meshes
        // = mesh_count

        const term_meshes_key = Atom.make(env, "meshes");
        const meshes_lengths = [_]usize{@intCast(value.meshCount)};
        const term_meshes_value = Array.make_c(Mesh, rl.Mesh, env, value.meshes, &meshes_lengths);
        assert(e.enif_make_map_put(env, term, term_meshes_key, term_meshes_value, &term) != 0);

        // materials
        // = material_count

        const term_materials_key = Atom.make(env, "materials");
        const materials_lengths = [_]usize{@intCast(value.materialCount)};
        const term_materials_value = Array.make_c(Material, rl.Material, env, value.materials, &materials_lengths);
        assert(e.enif_make_map_put(env, term, term_materials_key, term_materials_value, &term) != 0);

        // mesh_material
        // = mesh_count

        const term_mesh_material_key = Atom.make(env, "mesh_material");
        const mesh_material_lengths = [_]usize{@intCast(value.meshCount)};
        const term_mesh_material_value = Array.make_c(Int, c_int, env, value.meshMaterial, &mesh_material_lengths);
        assert(e.enif_make_map_put(env, term, term_mesh_material_key, term_mesh_material_value, &term) != 0);

        // bones
        // = bone_count

        const term_bones_key = Atom.make(env, "bones");
        const bones_lengths = [_]usize{@intCast(value.boneCount)};
        const term_bones_value = Array.make_c(BoneInfo, rl.BoneInfo, env, value.bones, &bones_lengths);
        assert(e.enif_make_map_put(env, term, term_bones_key, term_bones_value, &term) != 0);

        // bind_pose
        // = bone_count

        const term_bind_pose_key = Atom.make(env, "bind_pose");
        const bind_pose_lengths = [_]usize{@intCast(value.boneCount)};
        const term_bind_pose_value = Array.make_c(Transform, rl.Transform, env, value.bindPose, &bind_pose_lengths);
        assert(e.enif_make_map_put(env, term, term_bind_pose_key, term_bind_pose_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Model {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Model{};

        // transform

        const term_transform_key = Atom.make(env, "transform");
        var term_transform_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_transform_key, &term_transform_value) == 0) return error.ArgumentError;
        const transform = try Argument(Matrix).get(env, term_transform_value);
        errdefer transform.free();
        value.transform = transform.data;

        // mesh_count

        const term_mesh_count_key = Atom.make(env, "mesh_count");
        var term_mesh_count_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_mesh_count_key, &term_mesh_count_value) == 0) return error.ArgumentError;
        value.meshCount = @intCast(try Int.get(env, term_mesh_count_value));

        // material_count

        const term_material_count_key = Atom.make(env, "material_count");
        var term_material_count_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_material_count_key, &term_material_count_value) == 0) return error.ArgumentError;
        value.materialCount = @intCast(try Int.get(env, term_material_count_value));

        // bone_count

        const term_bone_count_key = Atom.make(env, "bone_count");
        var term_bone_count_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_bone_count_key, &term_bone_count_value) == 0) return error.ArgumentError;
        value.boneCount = @intCast(try Int.get(env, term_bone_count_value));

        // meshes
        // = mesh_count

        const term_meshes_key = Atom.make(env, "meshes");
        var term_meshes_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_meshes_key, &term_meshes_value) == 0) return error.ArgumentError;

        const meshes_lengths = [_]usize{@intCast(value.meshCount)};
        var meshes = try ArgumentArrayC(Mesh, Mesh.data_type, Self.allocator).get(env, term_meshes_value, &meshes_lengths);
        defer meshes.free_keep();
        errdefer meshes.free();
        value.meshes = meshes.data;

        // materials
        // = material_count

        const term_materials_key = Atom.make(env, "materials");
        var term_materials_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_materials_key, &term_materials_value) == 0) return error.ArgumentError;

        const materials_lengths = [_]usize{@intCast(value.materialCount)};
        var materials = try ArgumentArrayC(Material, Material.data_type, Self.allocator).get(env, term_materials_value, &materials_lengths);
        defer materials.free_keep();
        errdefer materials.free();
        value.materials = materials.data;

        // mesh_material
        // = mesh_count

        const term_mesh_material_key = Atom.make(env, "mesh_material");
        var term_mesh_material_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_mesh_material_key, &term_mesh_material_value) == 0) return error.ArgumentError;

        const mesh_material_lengths = [_]usize{@intCast(value.meshCount)};
        value.meshMaterial = try Array.get_c(Int, c_int, Self.allocator, env, term_mesh_material_value, &mesh_material_lengths);
        errdefer Array.free_c(Int, c_int, Self.allocator, value.meshMaterial, &mesh_material_lengths, null);

        // bones
        // = bone_count

        const term_bones_key = Atom.make(env, "bones");
        var term_bones_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_bones_key, &term_bones_value) == 0) return error.ArgumentError;

        const bones_lengths = [_]usize{@intCast(value.boneCount)};
        var bones = try ArgumentArrayC(BoneInfo, BoneInfo.data_type, Self.allocator).get(env, term_bones_value, &bones_lengths);
        defer bones.free_keep();
        errdefer bones.free();
        value.bones = bones.data;

        // bind_pose
        // = bone_count

        const term_bind_pose_key = Atom.make(env, "bind_pose");
        var term_bind_pose_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_bind_pose_key, &term_bind_pose_value) == 0) return error.ArgumentError;

        const bind_pose_lengths = [_]usize{@intCast(value.boneCount)};
        var bind_pose = try ArgumentArrayC(Transform, Transform.data_type, Self.allocator).get(env, term_bind_pose_value, &bind_pose_lengths);
        defer bind_pose.free_keep();
        errdefer bind_pose.free();
        value.bindPose = bind_pose.data;

        return value;
    }

    pub fn unload(value: rl.Model) void {
        // Unload meshes
        if (value.meshes != null) {
            for (0..@intCast(value.meshCount)) |i| {
                Mesh.unload(value.meshes[i]);
            }
        }

        // Unload materials maps
        // NOTE: As the user could be sharing shaders and textures between models,
        // we don't unload the material but just free its maps,
        // the user is responsible for freeing models shaders and textures
        if (value.materials != null) {
            for (0..@intCast(value.materialCount)) |i| {
                rl.MemFree(value.materials[i].maps);
            }
        }

        // Unload arrays
        rl.MemFree(value.meshes);
        rl.MemFree(value.materials);
        rl.MemFree(value.meshMaterial);

        // Unload animation data
        rl.MemFree(value.bones);
        rl.MemFree(value.bindPose);

        rl.TRACELOG(rl.LOG_INFO, "MODEL: Unloaded model (and meshes) from RAM and VRAM", .{});
    }

    pub fn free(value: rl.Model) void {
        // Unload meshes
        if (value.meshes != null) {
            for (0..@intCast(value.meshCount)) |i| {
                Mesh.free(value.meshes[i]);
            }
        }

        // Unload materials maps
        // NOTE: As the user could be sharing shaders and textures between models,
        // we don't unload the material but just free its maps,
        // the user is responsible for freeing models shaders and textures
        if (value.materials != null) {
            for (0..@intCast(value.materialCount)) |i| {
                rl.MemFree(value.materials[i].maps);
            }
        }

        // Unload arrays
        rl.MemFree(value.meshes);
        rl.MemFree(value.materials);
        rl.MemFree(value.meshMaterial);

        // Unload animation data
        rl.MemFree(value.bones);
        rl.MemFree(value.bindPose);
    }
};

//////////////////////
//  ModelAnimation  //
//////////////////////

pub const ModelAnimation = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.ModelAnimation;
    pub const resource_name = "model_animation";

    pub const Resource = ResourceBase(Self);

    pub const MAX_NAME: usize = get_field_array_length(rl.ModelAnimation, "name");

    pub fn make(env: ?*e.ErlNifEnv, value: rl.ModelAnimation) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // bone_count

        const term_bone_count_key = Atom.make(env, "bone_count");
        const term_bone_count_value = Int.make(env, @intCast(value.boneCount));
        assert(e.enif_make_map_put(env, term, term_bone_count_key, term_bone_count_value, &term) != 0);

        // frame_count

        const term_frame_count_key = Atom.make(env, "frame_count");
        const term_frame_count_value = Int.make(env, @intCast(value.frameCount));
        assert(e.enif_make_map_put(env, term, term_frame_count_key, term_frame_count_value, &term) != 0);

        // bones
        // = bone_count

        const term_bones_key = Atom.make(env, "bones");
        const bones_lengths = [_]usize{@intCast(value.boneCount)};
        const term_bones_value = Array.make_c(BoneInfo, rl.BoneInfo, env, value.bones, &bones_lengths);
        assert(e.enif_make_map_put(env, term, term_bones_key, term_bones_value, &term) != 0);

        // frame_poses
        // = frame_count , bone_count

        const term_frame_poses_key = Atom.make(env, "frame_poses");
        const frame_poses_lengths = [_]usize{ @intCast(value.frameCount), @intCast(value.boneCount) };
        const term_frame_poses_value = Array.make_c(Transform, [*c]rl.Transform, env, value.framePoses, &frame_poses_lengths);
        assert(e.enif_make_map_put(env, term, term_frame_poses_key, term_frame_poses_value, &term) != 0);

        // name

        const term_name_key = Atom.make(env, "name");
        const term_name_value = CString.make(env, &value.name);
        assert(e.enif_make_map_put(env, term, term_name_key, term_name_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.ModelAnimation {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.ModelAnimation{};

        // bone_count

        const term_bone_count_key = Atom.make(env, "bone_count");
        var term_bone_count_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_bone_count_key, &term_bone_count_value) == 0) return error.ArgumentError;
        value.boneCount = @intCast(try Int.get(env, term_bone_count_value));

        // frame_count

        const term_frame_count_key = Atom.make(env, "frame_count");
        var term_frame_count_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_frame_count_key, &term_frame_count_value) == 0) return error.ArgumentError;
        value.frameCount = @intCast(try Int.get(env, term_frame_count_value));

        // bones
        // = bone_count

        const term_bones_key = Atom.make(env, "bones");
        var term_bones_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_bones_key, &term_bones_value) == 0) return error.ArgumentError;

        const bones_lengths = [_]usize{@intCast(value.boneCount)};
        var bones = try ArgumentArrayC(BoneInfo, BoneInfo.data_type, Self.allocator).get(env, term_bones_value, &bones_lengths);
        defer bones.free_keep();
        errdefer bones.free();
        value.bones = bones.data;

        // frame_poses
        // = frame_count , bone_count

        const term_frame_poses_key = Atom.make(env, "frame_poses");
        var term_frame_poses_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_frame_poses_key, &term_frame_poses_value) == 0) return error.ArgumentError;

        const frame_poses_lengths = [_]usize{ @intCast(value.frameCount), @intCast(value.boneCount) };
        var frame_poses = try ArgumentArrayC(Transform, [*c]Transform.data_type, Self.allocator).get(env, term_frame_poses_value, &frame_poses_lengths);
        defer frame_poses.free_keep();
        errdefer frame_poses.free();
        value.framePoses = frame_poses.data;

        // name

        const term_name_key = Atom.make(env, "name");
        var term_name_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_name_key, &term_name_value) == 0) return error.ArgumentError;
        try CString.get_copy(env, term_name_value, &value.name);

        return value;
    }

    pub fn unload(value: rl.ModelAnimation) void {
        free(value);
    }

    pub fn free(value: rl.ModelAnimation) void {
        rl.UnloadModelAnimation(value);
    }
};

///////////
//  Ray  //
///////////

pub const Ray = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Ray;
    pub const resource_name = "ray";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Ray) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // position

        const term_position_key = Atom.make(env, "position");
        const term_position_value = Vector3.make(env, value.position);
        assert(e.enif_make_map_put(env, term, term_position_key, term_position_value, &term) != 0);

        // direction

        const term_direction_key = Atom.make(env, "direction");
        const term_direction_value = Vector3.make(env, value.direction);
        assert(e.enif_make_map_put(env, term, term_direction_key, term_direction_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Ray {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Ray{};

        // position

        const term_position_key = Atom.make(env, "position");
        var term_position_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_position_key, &term_position_value) == 0) return error.ArgumentError;
        const position = try Argument(Vector3).get(env, term_position_value);
        errdefer position.free();
        value.position = position.data;

        // direction

        const term_direction_key = Atom.make(env, "direction");
        var term_direction_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_direction_key, &term_direction_value) == 0) return error.ArgumentError;
        const direction = try Argument(Vector3).get(env, term_direction_value);
        errdefer direction.free();
        value.direction = direction.data;

        return value;
    }

    pub fn unload(value: rl.Ray) void {
        _ = value;
    }

    pub fn free(value: rl.Ray) void {
        _ = value;
    }
};

////////////////////
//  RayCollision  //
////////////////////

pub const RayCollision = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.RayCollision;
    pub const resource_name = "ray_collision";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.RayCollision) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // hit

        const term_hit_key = Atom.make(env, "hit");
        const term_hit_value = Boolean.make(env, value.hit);
        assert(e.enif_make_map_put(env, term, term_hit_key, term_hit_value, &term) != 0);

        // distance

        const term_distance_key = Atom.make(env, "distance");
        const term_distance_value = Double.make(env, @floatCast(value.distance));
        assert(e.enif_make_map_put(env, term, term_distance_key, term_distance_value, &term) != 0);

        // point

        const term_point_key = Atom.make(env, "point");
        const term_point_value = Vector3.make(env, value.point);
        assert(e.enif_make_map_put(env, term, term_point_key, term_point_value, &term) != 0);

        // normal

        const term_normal_key = Atom.make(env, "normal");
        const term_normal_value = Vector3.make(env, value.normal);
        assert(e.enif_make_map_put(env, term, term_normal_key, term_normal_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.RayCollision {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.RayCollision{};

        // hit

        const term_hit_key = Atom.make(env, "hit");
        var term_hit_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_hit_key, &term_hit_value) == 0) return error.ArgumentError;
        value.hit = try Boolean.get(env, term_hit_value);

        // distance

        const term_distance_key = Atom.make(env, "distance");
        var term_distance_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_distance_key, &term_distance_value) == 0) return error.ArgumentError;
        value.distance = @floatCast(try Double.get(env, term_distance_value));

        // point

        const term_point_key = Atom.make(env, "point");
        var term_point_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_point_key, &term_point_value) == 0) return error.ArgumentError;
        const point = try Argument(Vector3).get(env, term_point_value);
        errdefer point.free();
        value.point = point.data;

        // normal

        const term_normal_key = Atom.make(env, "normal");
        var term_normal_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_normal_key, &term_normal_value) == 0) return error.ArgumentError;
        const normal = try Argument(Vector3).get(env, term_normal_value);
        errdefer normal.free();
        value.normal = normal.data;

        return value;
    }

    pub fn unload(value: rl.RayCollision) void {
        _ = value;
    }

    pub fn free(value: rl.RayCollision) void {
        _ = value;
    }
};

///////////////////
//  BoundingBox  //
///////////////////

pub const BoundingBox = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.BoundingBox;
    pub const resource_name = "bounding_box";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.BoundingBox) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // min

        const term_min_key = Atom.make(env, "min");
        const term_min_value = Vector3.make(env, value.min);
        assert(e.enif_make_map_put(env, term, term_min_key, term_min_value, &term) != 0);

        // max

        const term_max_key = Atom.make(env, "max");
        const term_max_value = Vector3.make(env, value.max);
        assert(e.enif_make_map_put(env, term, term_max_key, term_max_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.BoundingBox {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.BoundingBox{};

        // min

        const term_min_key = Atom.make(env, "min");
        var term_min_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_min_key, &term_min_value) == 0) return error.ArgumentError;
        const min = try Argument(Vector3).get(env, term_min_value);
        errdefer min.free();
        value.min = min.data;

        // max

        const term_max_key = Atom.make(env, "max");
        var term_max_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_max_key, &term_max_value) == 0) return error.ArgumentError;
        const max = try Argument(Vector3).get(env, term_max_value);
        errdefer max.free();
        value.max = max.data;

        return value;
    }

    pub fn unload(value: rl.BoundingBox) void {
        _ = value;
    }

    pub fn free(value: rl.BoundingBox) void {
        _ = value;
    }
};

////////////
//  Wave  //
////////////

pub const Wave = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Wave;
    pub const resource_name = "wave";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Wave) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // frame_count

        const term_frame_count_key = Atom.make(env, "frame_count");
        const term_frame_count_value = UInt.make(env, @intCast(value.frameCount));
        assert(e.enif_make_map_put(env, term, term_frame_count_key, term_frame_count_value, &term) != 0);

        // sample_rate

        const term_sample_rate_key = Atom.make(env, "sample_rate");
        const term_sample_rate_value = UInt.make(env, @intCast(value.sampleRate));
        assert(e.enif_make_map_put(env, term, term_sample_rate_key, term_sample_rate_value, &term) != 0);

        // sample_size

        const term_sample_size_key = Atom.make(env, "sample_size");
        const term_sample_size_value = UInt.make(env, @intCast(value.sampleSize));
        assert(e.enif_make_map_put(env, term, term_sample_size_key, term_sample_size_value, &term) != 0);

        // channels

        const term_channels_key = Atom.make(env, "channels");
        const term_channels_value = UInt.make(env, @intCast(value.channels));
        assert(e.enif_make_map_put(env, term, term_channels_key, term_channels_value, &term) != 0);

        // data

        const data_size: usize = get_data_size(
            value.frameCount,
            value.channels,
            value.sampleSize,
        );

        const term_data_key = Atom.make(env, "data");
        const term_data_value = Binary.make_c(env, @ptrCast(value.data), data_size);
        assert(e.enif_make_map_put(env, term, term_data_key, term_data_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Wave {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Wave{};

        // frame_count

        const term_frame_count_key = Atom.make(env, "frame_count");
        var term_frame_count_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_frame_count_key, &term_frame_count_value) == 0) return error.ArgumentError;
        value.frameCount = @intCast(try UInt.get(env, term_frame_count_value));

        // sample_rate

        const term_sample_rate_key = Atom.make(env, "sample_rate");
        var term_sample_rate_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_sample_rate_key, &term_sample_rate_value) == 0) return error.ArgumentError;
        value.sampleRate = @intCast(try UInt.get(env, term_sample_rate_value));

        // sample_size

        const term_sample_size_key = Atom.make(env, "sample_size");
        var term_sample_size_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_sample_size_key, &term_sample_size_value) == 0) return error.ArgumentError;
        value.sampleSize = @intCast(try UInt.get(env, term_sample_size_value));

        // channels

        const term_channels_key = Atom.make(env, "channels");
        var term_channels_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_channels_key, &term_channels_value) == 0) return error.ArgumentError;
        value.channels = @intCast(try UInt.get(env, term_channels_value));

        // data

        const data_size: usize = get_data_size(
            value.frameCount,
            value.channels,
            value.sampleSize,
        );

        const term_data_key = Atom.make(env, "data");
        var term_data_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_data_key, &term_data_value) == 0) return error.ArgumentError;
        const data = try ArgumentBinaryC(Binary, Self.allocator).get(env, term_data_value, data_size);
        errdefer data.free();
        value.data = data.data;

        return value;
    }

    pub fn unload(value: rl.Wave) void {
        free(value);
    }

    pub fn free(value: rl.Wave) void {
        rl.UnloadWave(value);
    }

    pub fn get_data_size(frame_count: c_uint, channels: c_uint, sample_size: c_uint) usize {
        const sample_size_bytes: c_uint = @intFromFloat(@ceil(@as(f64, @floatFromInt(sample_size)) / 8));
        return @intCast(frame_count * channels * sample_size_bytes);
    }
};

///////////////////
//  AudioBuffer  //
///////////////////

pub const AudioBuffer = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = *rl.rAudioBuffer;
    pub const resource_name = "audio_buffer";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: ?*rl.rAudioBuffer) e.ErlNifTerm {
        if (value) |v| {
            const resource = Self.Resource.create(v) catch return Atom.make(env, "nil");
            defer Self.Resource.release(resource);

            return Self.Resource.make(env, resource);
        }

        return Atom.make(env, "nil");
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !?*rl.rAudioBuffer {
        if (e.enif_is_identical(Atom.make(env, "nil"), term) == 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        return null;
    }

    pub fn unload(value: ?*rl.rAudioBuffer) void {
        _ = value;
    }

    pub fn free(value: ?*rl.rAudioBuffer) void {
        _ = value;
    }
};

//////////////////////
//  AudioProcessor  //
//////////////////////

pub const AudioProcessor = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = *rl.rAudioProcessor;
    pub const resource_name = "audio_processor";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: ?*rl.rAudioProcessor) e.ErlNifTerm {
        if (value) |v| {
            const resource = Self.Resource.create(v) catch return Atom.make(env, "nil");
            defer Self.Resource.release(resource);

            return Self.Resource.make(env, resource);
        }

        return Atom.make(env, "nil");
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !?*rl.rAudioProcessor {
        if (e.enif_is_identical(Atom.make(env, "nil"), term) == 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        return null;
    }

    pub fn unload(value: ?*rl.rAudioProcessor) void {
        _ = value;
    }

    pub fn free(value: ?*rl.rAudioProcessor) void {
        _ = value;
    }
};

///////////////////
//  AudioStream  //
///////////////////

pub const AudioStream = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.AudioStream;
    pub const resource_name = "audio_stream";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.AudioStream) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // buffer

        const term_buffer_key = Atom.make(env, "buffer");
        const term_buffer_value = AudioBuffer.make(env, value.buffer);
        assert(e.enif_make_map_put(env, term, term_buffer_key, term_buffer_value, &term) != 0);

        // processor

        const term_processor_key = Atom.make(env, "processor");
        const term_processor_value = AudioProcessor.make(env, value.processor);
        assert(e.enif_make_map_put(env, term, term_processor_key, term_processor_value, &term) != 0);

        // sample_rate

        const term_sample_rate_key = Atom.make(env, "sample_rate");
        const term_sample_rate_value = UInt.make(env, @intCast(value.sampleRate));
        assert(e.enif_make_map_put(env, term, term_sample_rate_key, term_sample_rate_value, &term) != 0);

        // sample_size

        const term_sample_size_key = Atom.make(env, "sample_size");
        const term_sample_size_value = UInt.make(env, @intCast(value.sampleSize));
        assert(e.enif_make_map_put(env, term, term_sample_size_key, term_sample_size_value, &term) != 0);

        // channels

        const term_channels_key = Atom.make(env, "channels");
        const term_channels_value = UInt.make(env, @intCast(value.channels));
        assert(e.enif_make_map_put(env, term, term_channels_key, term_channels_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.AudioStream {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.AudioStream{};

        // buffer

        const term_buffer_key = Atom.make(env, "buffer");
        var term_buffer_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_buffer_key, &term_buffer_value) == 0) return error.ArgumentError;
        value.buffer = try AudioBuffer.get(env, term_buffer_value);
        errdefer AudioBuffer.free(value.buffer);

        // processor

        const term_processor_key = Atom.make(env, "processor");
        var term_processor_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_processor_key, &term_processor_value) == 0) return error.ArgumentError;
        value.processor = try AudioProcessor.get(env, term_processor_value);
        errdefer AudioProcessor.free(value.processor);

        // sample_rate

        const term_sample_rate_key = Atom.make(env, "sample_rate");
        var term_sample_rate_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_sample_rate_key, &term_sample_rate_value) == 0) return error.ArgumentError;
        value.sampleRate = @intCast(try UInt.get(env, term_sample_rate_value));

        // sample_size

        const term_sample_size_key = Atom.make(env, "sample_size");
        var term_sample_size_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_sample_size_key, &term_sample_size_value) == 0) return error.ArgumentError;
        value.sampleSize = @intCast(try UInt.get(env, term_sample_size_value));

        // channels

        const term_channels_key = Atom.make(env, "channels");
        var term_channels_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_channels_key, &term_channels_value) == 0) return error.ArgumentError;
        value.channels = @intCast(try UInt.get(env, term_channels_value));

        return value;
    }

    pub fn unload(value: rl.AudioStream) void {
        rl.UnloadAudioStream(value);
    }

    pub fn free(value: rl.AudioStream) void {
        AudioBuffer.free(value.buffer);
        AudioProcessor.free(value.processor);
    }
};

/////////////
//  Sound  //
/////////////

pub const Sound = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Sound;
    pub const resource_name = "sound";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Sound) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // stream

        const term_stream_key = Atom.make(env, "stream");
        const term_stream_value = AudioStream.make(env, value.stream);
        assert(e.enif_make_map_put(env, term, term_stream_key, term_stream_value, &term) != 0);

        // frame_count

        const term_frame_count_key = Atom.make(env, "frame_count");
        const term_frame_count_value = UInt.make(env, @intCast(value.frameCount));
        assert(e.enif_make_map_put(env, term, term_frame_count_key, term_frame_count_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Sound {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Sound{};

        // stream

        const term_stream_key = Atom.make(env, "stream");
        var term_stream_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_stream_key, &term_stream_value) == 0) return error.ArgumentError;
        const stream = try Argument(AudioStream).get(env, term_stream_value);
        errdefer stream.free();
        value.stream = stream.data;

        // frame_count

        const term_frame_count_key = Atom.make(env, "frame_count");
        var term_frame_count_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_frame_count_key, &term_frame_count_value) == 0) return error.ArgumentError;
        value.frameCount = @intCast(try UInt.get(env, term_frame_count_value));

        return value;
    }

    pub fn unload(value: rl.Sound) void {
        rl.UnloadSound(value);
    }

    pub fn free(value: rl.Sound) void {
        AudioStream.free(value.stream);
    }
};

//////////////////
//  SoundAlias  //
//////////////////

pub const SoundAlias = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Sound;
    pub const resource_name = "sound_alias";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Sound) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // stream

        const term_stream_key = Atom.make(env, "stream");
        const term_stream_value = AudioStream.make(env, value.stream);
        assert(e.enif_make_map_put(env, term, term_stream_key, term_stream_value, &term) != 0);

        // frame_count

        const term_frame_count_key = Atom.make(env, "frame_count");
        const term_frame_count_value = UInt.make(env, @intCast(value.frameCount));
        assert(e.enif_make_map_put(env, term, term_frame_count_key, term_frame_count_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Sound {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Sound{};

        // stream

        const term_stream_key = Atom.make(env, "stream");
        var term_stream_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_stream_key, &term_stream_value) == 0) return error.ArgumentError;
        const stream = try Argument(AudioStream).get(env, term_stream_value);
        errdefer stream.free();
        value.stream = stream.data;

        // frame_count

        const term_frame_count_key = Atom.make(env, "frame_count");
        var term_frame_count_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_frame_count_key, &term_frame_count_value) == 0) return error.ArgumentError;
        value.frameCount = @intCast(try UInt.get(env, term_frame_count_value));

        return value;
    }

    pub fn unload(value: rl.Sound) void {
        rl.UnloadSoundAlias(value);
    }

    pub fn free(value: rl.Sound) void {
        AudioStream.free(value.stream);
    }
};

////////////////////////
//  MusicContextData  //
////////////////////////

pub const MusicContextData = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = *anyopaque;
    pub const resource_name = "music_context_data";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: ?data_type) e.ErlNifTerm {
        if (value) |v| {
            const resource = Self.Resource.create(v) catch return Atom.make(env, "nil");
            defer Self.Resource.release(resource);

            return Self.Resource.make(env, resource);
        }

        return Atom.make(env, "nil");
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !?data_type {
        if (e.enif_is_identical(Atom.make(env, "nil"), term) == 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        return null;
    }

    pub fn unload(value: ?data_type) void {
        _ = value;
    }

    pub fn free(value: ?data_type) void {
        _ = value;
    }
};

/////////////
//  Music  //
/////////////

pub const Music = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.Music;
    pub const resource_name = "music";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Music) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // stream

        const term_stream_key = Atom.make(env, "stream");
        const term_stream_value = AudioStream.make(env, value.stream);
        assert(e.enif_make_map_put(env, term, term_stream_key, term_stream_value, &term) != 0);

        // frame_count

        const term_frame_count_key = Atom.make(env, "frame_count");
        const term_frame_count_value = UInt.make(env, @intCast(value.frameCount));
        assert(e.enif_make_map_put(env, term, term_frame_count_key, term_frame_count_value, &term) != 0);

        // looping

        const term_looping_key = Atom.make(env, "looping");
        const term_looping_value = Boolean.make(env, value.looping);
        assert(e.enif_make_map_put(env, term, term_looping_key, term_looping_value, &term) != 0);

        // ctx_type

        const term_ctx_type_key = Atom.make(env, "ctx_type");
        const term_ctx_type_value = Int.make(env, @intCast(value.ctxType));
        assert(e.enif_make_map_put(env, term, term_ctx_type_key, term_ctx_type_value, &term) != 0);

        // ctx_data

        const term_ctx_data_key = Atom.make(env, "ctx_data");
        const term_ctx_data_value = MusicContextData.make(env, value.ctxData);
        assert(e.enif_make_map_put(env, term, term_ctx_data_key, term_ctx_data_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Music {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.Music{};

        // stream

        const term_stream_key = Atom.make(env, "stream");
        var term_stream_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_stream_key, &term_stream_value) == 0) return error.ArgumentError;
        const stream = try Argument(AudioStream).get(env, term_stream_value);
        errdefer stream.free();
        value.stream = stream.data;

        // frame_count

        const term_frame_count_key = Atom.make(env, "frame_count");
        var term_frame_count_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_frame_count_key, &term_frame_count_value) == 0) return error.ArgumentError;
        value.frameCount = @intCast(try UInt.get(env, term_frame_count_value));

        // looping

        const term_looping_key = Atom.make(env, "looping");
        var term_looping_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_looping_key, &term_looping_value) == 0) return error.ArgumentError;
        value.looping = try Boolean.get(env, term_looping_value);

        // ctx_type

        const term_ctx_type_key = Atom.make(env, "ctx_type");
        var term_ctx_type_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_ctx_type_key, &term_ctx_type_value) == 0) return error.ArgumentError;
        value.ctxType = @intCast(try Int.get(env, term_ctx_type_value));

        // ctx_data

        const term_ctx_data_key = Atom.make(env, "ctx_data");
        var term_ctx_data_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_ctx_data_key, &term_ctx_data_value) == 0) return error.ArgumentError;
        value.ctxData = try MusicContextData.get(env, term_ctx_data_value);
        errdefer MusicContextData.free(value.ctxData);

        return value;
    }

    pub fn unload(value: rl.Music) void {
        rl.UnloadMusicStream(value);
    }

    pub fn free(value: rl.Music) void {
        AudioStream.free(value.stream);
        MusicContextData.free(value.ctxData);
    }
};

////////////////////
//  VrDeviceInfo  //
////////////////////

pub const VrDeviceInfo = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.VrDeviceInfo;
    pub const resource_name = "vr_device_info";

    pub const Resource = ResourceBase(Self);

    pub const MAX_LENS_DISTORTION_VALUES: usize = get_field_array_length(rl.VrDeviceInfo, "lensDistortionValues");

    pub const MAX_CHROMA_AB_CORRECTION: usize = get_field_array_length(rl.VrDeviceInfo, "chromaAbCorrection");

    pub fn make(env: ?*e.ErlNifEnv, value: rl.VrDeviceInfo) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // h_resolution

        const term_h_resolution_key = Atom.make(env, "h_resolution");
        const term_h_resolution_value = Int.make(env, @intCast(value.hResolution));
        assert(e.enif_make_map_put(env, term, term_h_resolution_key, term_h_resolution_value, &term) != 0);

        // v_resolution

        const term_v_resolution_key = Atom.make(env, "v_resolution");
        const term_v_resolution_value = Int.make(env, @intCast(value.vResolution));
        assert(e.enif_make_map_put(env, term, term_v_resolution_key, term_v_resolution_value, &term) != 0);

        // h_screen_size

        const term_h_screen_size_key = Atom.make(env, "h_screen_size");
        const term_h_screen_size_value = Double.make(env, @floatCast(value.hScreenSize));
        assert(e.enif_make_map_put(env, term, term_h_screen_size_key, term_h_screen_size_value, &term) != 0);

        // v_screen_size

        const term_v_screen_size_key = Atom.make(env, "v_screen_size");
        const term_v_screen_size_value = Double.make(env, @floatCast(value.vScreenSize));
        assert(e.enif_make_map_put(env, term, term_v_screen_size_key, term_v_screen_size_value, &term) != 0);

        // eye_to_screen_distance

        const term_eye_to_screen_distance_key = Atom.make(env, "eye_to_screen_distance");
        const term_eye_to_screen_distance_value = Double.make(env, @floatCast(value.eyeToScreenDistance));
        assert(e.enif_make_map_put(env, term, term_eye_to_screen_distance_key, term_eye_to_screen_distance_value, &term) != 0);

        // lens_separation_distance

        const term_lens_separation_distance_key = Atom.make(env, "lens_separation_distance");
        const term_lens_separation_distance_value = Double.make(env, @floatCast(value.lensSeparationDistance));
        assert(e.enif_make_map_put(env, term, term_lens_separation_distance_key, term_lens_separation_distance_value, &term) != 0);

        // interpupillary_distance

        const term_interpupillary_distance_key = Atom.make(env, "interpupillary_distance");
        const term_interpupillary_distance_value = Double.make(env, @floatCast(value.interpupillaryDistance));
        assert(e.enif_make_map_put(env, term, term_interpupillary_distance_key, term_interpupillary_distance_value, &term) != 0);

        // lens_distortion_values

        const term_lens_distortion_values_key = Atom.make(env, "lens_distortion_values");
        const term_lens_distortion_values_value = Array.make(Double, f32, env, &value.lensDistortionValues);
        assert(e.enif_make_map_put(env, term, term_lens_distortion_values_key, term_lens_distortion_values_value, &term) != 0);

        // chroma_ab_correction

        const term_chroma_ab_correction_key = Atom.make(env, "chroma_ab_correction");
        const term_chroma_ab_correction_value = Array.make(Double, f32, env, &value.chromaAbCorrection);
        assert(e.enif_make_map_put(env, term, term_chroma_ab_correction_key, term_chroma_ab_correction_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.VrDeviceInfo {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.VrDeviceInfo{};

        // h_resolution

        const term_h_resolution_key = Atom.make(env, "h_resolution");
        var term_h_resolution_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_h_resolution_key, &term_h_resolution_value) == 0) return error.ArgumentError;
        value.hResolution = @intCast(try Int.get(env, term_h_resolution_value));

        // v_resolution

        const term_v_resolution_key = Atom.make(env, "v_resolution");
        var term_v_resolution_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_v_resolution_key, &term_v_resolution_value) == 0) return error.ArgumentError;
        value.vResolution = @intCast(try Int.get(env, term_v_resolution_value));

        // h_screen_size

        const term_h_screen_size_key = Atom.make(env, "h_screen_size");
        var term_h_screen_size_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_h_screen_size_key, &term_h_screen_size_value) == 0) return error.ArgumentError;
        value.hScreenSize = @floatCast(try Double.get(env, term_h_screen_size_value));

        // v_screen_size

        const term_v_screen_size_key = Atom.make(env, "v_screen_size");
        var term_v_screen_size_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_v_screen_size_key, &term_v_screen_size_value) == 0) return error.ArgumentError;
        value.vScreenSize = @floatCast(try Double.get(env, term_v_screen_size_value));

        // eye_to_screen_distance

        const term_eye_to_screen_distance_key = Atom.make(env, "eye_to_screen_distance");
        var term_eye_to_screen_distance_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_eye_to_screen_distance_key, &term_eye_to_screen_distance_value) == 0) return error.ArgumentError;
        value.eyeToScreenDistance = @floatCast(try Double.get(env, term_eye_to_screen_distance_value));

        // lens_separation_distance

        const term_lens_separation_distance_key = Atom.make(env, "lens_separation_distance");
        var term_lens_separation_distance_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_lens_separation_distance_key, &term_lens_separation_distance_value) == 0) return error.ArgumentError;
        value.lensSeparationDistance = @floatCast(try Double.get(env, term_lens_separation_distance_value));

        // interpupillary_distance

        const term_interpupillary_distance_key = Atom.make(env, "interpupillary_distance");
        var term_interpupillary_distance_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_interpupillary_distance_key, &term_interpupillary_distance_value) == 0) return error.ArgumentError;
        value.interpupillaryDistance = @floatCast(try Double.get(env, term_interpupillary_distance_value));

        // lens_distortion_values

        const term_lens_distortion_values_key = Atom.make(env, "lens_distortion_values");
        var term_lens_distortion_values_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_lens_distortion_values_key, &term_lens_distortion_values_value) == 0) return error.ArgumentError;
        try Array.get_copy(Double, f32, Self.allocator, env, term_lens_distortion_values_value, &value.lensDistortionValues);
        errdefer Array.free_copy(Double, f32, Self.allocator, &value.lensDistortionValues, null);

        // chroma_ab_correction

        const term_chroma_ab_correction_key = Atom.make(env, "chroma_ab_correction");
        var term_chroma_ab_correction_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_chroma_ab_correction_key, &term_chroma_ab_correction_value) == 0) return error.ArgumentError;
        try Array.get_copy(Double, f32, Self.allocator, env, term_chroma_ab_correction_value, &value.chromaAbCorrection);
        errdefer Array.free_copy(Double, f32, Self.allocator, &value.chromaAbCorrection, null);

        return value;
    }

    pub fn unload(value: rl.VrDeviceInfo) void {
        _ = value;
    }

    pub fn free(value: rl.VrDeviceInfo) void {
        _ = value;
    }
};

//////////////////////
//  VrStereoConfig  //
//////////////////////

pub const VrStereoConfig = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.VrStereoConfig;
    pub const resource_name = "vr_stereo_config";

    pub const Resource = ResourceBase(Self);

    pub const MAX_PROJECTION: usize = get_field_array_length(rl.VrStereoConfig, "projection");

    pub const MAX_VIEW_OFFSET: usize = get_field_array_length(rl.VrStereoConfig, "viewOffset");

    pub const MAX_LEFT_LENS_CENTER: usize = get_field_array_length(rl.VrStereoConfig, "leftLensCenter");

    pub const MAX_RIGHT_LENS_CENTER: usize = get_field_array_length(rl.VrStereoConfig, "rightLensCenter");

    pub const MAX_LEFT_SCREEN_CENTER: usize = get_field_array_length(rl.VrStereoConfig, "leftScreenCenter");

    pub const MAX_RIGHT_SCREEN_CENTER: usize = get_field_array_length(rl.VrStereoConfig, "rightScreenCenter");

    pub const MAX_SCALE: usize = get_field_array_length(rl.VrStereoConfig, "scale");

    pub const MAX_SCALE_IN: usize = get_field_array_length(rl.VrStereoConfig, "scaleIn");

    pub fn make(env: ?*e.ErlNifEnv, value: rl.VrStereoConfig) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // projection

        const term_projection_key = Atom.make(env, "projection");
        const term_projection_value = Array.make(Matrix, rl.Matrix, env, &value.projection);
        assert(e.enif_make_map_put(env, term, term_projection_key, term_projection_value, &term) != 0);

        // view_offset

        const term_view_offset_key = Atom.make(env, "view_offset");
        const term_view_offset_value = Array.make(Matrix, rl.Matrix, env, &value.viewOffset);
        assert(e.enif_make_map_put(env, term, term_view_offset_key, term_view_offset_value, &term) != 0);

        // left_lens_center

        const term_left_lens_center_key = Atom.make(env, "left_lens_center");
        const term_left_lens_center_value = Array.make(Double, f32, env, &value.leftLensCenter);
        assert(e.enif_make_map_put(env, term, term_left_lens_center_key, term_left_lens_center_value, &term) != 0);

        // right_lens_center

        const term_right_lens_center_key = Atom.make(env, "right_lens_center");
        const term_right_lens_center_value = Array.make(Double, f32, env, &value.rightLensCenter);
        assert(e.enif_make_map_put(env, term, term_right_lens_center_key, term_right_lens_center_value, &term) != 0);

        // left_screen_center

        const term_left_screen_center_key = Atom.make(env, "left_screen_center");
        const term_left_screen_center_value = Array.make(Double, f32, env, &value.leftScreenCenter);
        assert(e.enif_make_map_put(env, term, term_left_screen_center_key, term_left_screen_center_value, &term) != 0);

        // right_screen_center

        const term_right_screen_center_key = Atom.make(env, "right_screen_center");
        const term_right_screen_center_value = Array.make(Double, f32, env, &value.rightScreenCenter);
        assert(e.enif_make_map_put(env, term, term_right_screen_center_key, term_right_screen_center_value, &term) != 0);

        // scale

        const term_scale_key = Atom.make(env, "scale");
        const term_scale_value = Array.make(Double, f32, env, &value.scale);
        assert(e.enif_make_map_put(env, term, term_scale_key, term_scale_value, &term) != 0);

        // scale_in

        const term_scale_in_key = Atom.make(env, "scale_in");
        const term_scale_in_value = Array.make(Double, f32, env, &value.scaleIn);
        assert(e.enif_make_map_put(env, term, term_scale_in_key, term_scale_in_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.VrStereoConfig {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.VrStereoConfig{};

        // projection

        const term_projection_key = Atom.make(env, "projection");
        var term_projection_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_projection_key, &term_projection_value) == 0) return error.ArgumentError;
        var projection = try ArgumentArrayCopy(Matrix, Matrix.data_type, Self.allocator).get(env, term_projection_value, &value.projection);
        defer projection.free_keep();
        errdefer projection.free();

        // view_offset

        const term_view_offset_key = Atom.make(env, "view_offset");
        var term_view_offset_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_view_offset_key, &term_view_offset_value) == 0) return error.ArgumentError;
        var view_offset = try ArgumentArrayCopy(Matrix, Matrix.data_type, Self.allocator).get(env, term_view_offset_value, &value.viewOffset);
        defer view_offset.free_keep();
        errdefer view_offset.free();

        // left_lens_center

        const term_left_lens_center_key = Atom.make(env, "left_lens_center");
        var term_left_lens_center_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_left_lens_center_key, &term_left_lens_center_value) == 0) return error.ArgumentError;
        try Array.get_copy(Double, f32, Self.allocator, env, term_left_lens_center_value, &value.leftLensCenter);
        errdefer Array.free_copy(Double, f32, Self.allocator, &value.leftLensCenter, null);

        // right_lens_center

        const term_right_lens_center_key = Atom.make(env, "right_lens_center");
        var term_right_lens_center_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_right_lens_center_key, &term_right_lens_center_value) == 0) return error.ArgumentError;
        try Array.get_copy(Double, f32, Self.allocator, env, term_right_lens_center_value, &value.rightLensCenter);
        errdefer Array.free_copy(Double, f32, Self.allocator, &value.rightLensCenter, null);

        // left_screen_center

        const term_left_screen_center_key = Atom.make(env, "left_screen_center");
        var term_left_screen_center_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_left_screen_center_key, &term_left_screen_center_value) == 0) return error.ArgumentError;
        try Array.get_copy(Double, f32, Self.allocator, env, term_left_screen_center_value, &value.leftScreenCenter);
        errdefer Array.free_copy(Double, f32, Self.allocator, &value.leftScreenCenter, null);

        // right_screen_center

        const term_right_screen_center_key = Atom.make(env, "right_screen_center");
        var term_right_screen_center_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_right_screen_center_key, &term_right_screen_center_value) == 0) return error.ArgumentError;
        try Array.get_copy(Double, f32, Self.allocator, env, term_right_screen_center_value, &value.rightScreenCenter);
        errdefer Array.free_copy(Double, f32, Self.allocator, &value.rightScreenCenter, null);

        // scale

        const term_scale_key = Atom.make(env, "scale");
        var term_scale_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_scale_key, &term_scale_value) == 0) return error.ArgumentError;
        try Array.get_copy(Double, f32, Self.allocator, env, term_scale_value, &value.scale);
        errdefer Array.free_copy(Double, f32, Self.allocator, &value.scale, null);

        // scale_in

        const term_scale_in_key = Atom.make(env, "scale_in");
        var term_scale_in_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_scale_in_key, &term_scale_in_value) == 0) return error.ArgumentError;
        try Array.get_copy(Double, f32, Self.allocator, env, term_scale_in_value, &value.scaleIn);
        errdefer Array.free_copy(Double, f32, Self.allocator, &value.scaleIn, null);

        return value;
    }

    pub fn unload(value: rl.VrStereoConfig) void {
        free(value);
    }

    pub fn free(value: rl.VrStereoConfig) void {
        rl.UnloadVrStereoConfig(value);
    }
};

////////////////////
//  FilePathList  //
////////////////////

pub const FilePathList = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.FilePathList;
    pub const resource_name = "file_path_list";

    pub const Resource = ResourceBase(Self);

    pub const MAX_FILEPATH_CAPACITY: usize = @intCast(rl.MAX_FILEPATH_CAPACITY);

    pub const MAX_FILEPATH_LENGTH: usize = @intCast(rl.MAX_FILEPATH_LENGTH);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.FilePathList) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // capacity

        const term_capacity_key = Atom.make(env, "capacity");
        const term_capacity_value = UInt.make(env, @intCast(value.capacity));
        assert(e.enif_make_map_put(env, term, term_capacity_key, term_capacity_value, &term) != 0);

        // count

        const term_count_key = Atom.make(env, "count");
        const term_count_value = UInt.make(env, @intCast(value.count));
        assert(e.enif_make_map_put(env, term, term_count_key, term_count_value, &term) != 0);

        // paths
        // = capacity , MAX_FILEPATH_LENGTH

        const term_paths_key = Atom.make(env, "paths");
        const paths_lengths = [_]usize{ @intCast(value.capacity), MAX_FILEPATH_LENGTH };
        const term_paths_value = Array.make_c(CString, [*c]u8, env, value.paths, &paths_lengths);
        assert(e.enif_make_map_put(env, term, term_paths_key, term_paths_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.FilePathList {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.FilePathList{};

        // capacity

        const term_capacity_key = Atom.make(env, "capacity");
        var term_capacity_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_capacity_key, &term_capacity_value) == 0) return error.ArgumentError;
        value.capacity = @intCast(try UInt.get(env, term_capacity_value));

        // count

        const term_count_key = Atom.make(env, "count");
        var term_count_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_count_key, &term_count_value) == 0) return error.ArgumentError;
        value.count = @intCast(try UInt.get(env, term_count_value));

        // paths
        // = capacity , MAX_FILEPATH_LENGTH

        const term_paths_key = Atom.make(env, "paths");
        var term_paths_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_paths_key, &term_paths_value) == 0) return error.ArgumentError;

        const paths_lengths = [_]usize{ @intCast(value.capacity), MAX_FILEPATH_LENGTH };
        value.paths = try Array.get_c(CString, [*c]u8, Self.allocator, env, term_paths_value, &paths_lengths);
        errdefer Array.free_c(CString, [*c]u8, Self.allocator, value.paths, &paths_lengths, null);

        return value;
    }

    pub fn unload(value: rl.FilePathList) void {
        free(value);
    }

    pub fn free(value: rl.FilePathList) void {
        rl.UnloadDirectoryFiles(value);
    }
};

///////////////////////
//  AutomationEvent  //
///////////////////////

pub const AutomationEvent = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.AutomationEvent;
    pub const resource_name = "automation_event";

    pub const Resource = ResourceBase(Self);

    pub const MAX_PARAMS: usize = get_field_array_length(rl.AutomationEvent, "params");

    pub fn make(env: ?*e.ErlNifEnv, value: rl.AutomationEvent) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // frame

        const term_frame_key = Atom.make(env, "frame");
        const term_frame_value = UInt.make(env, @intCast(value.frame));
        assert(e.enif_make_map_put(env, term, term_frame_key, term_frame_value, &term) != 0);

        // type

        const term_type_key = Atom.make(env, "type");
        const term_type_value = UInt.make(env, @intCast(value.type));
        assert(e.enif_make_map_put(env, term, term_type_key, term_type_value, &term) != 0);

        // params

        const term_params_key = Atom.make(env, "params");
        const term_params_value = Array.make(Int, c_int, env, &value.params);
        assert(e.enif_make_map_put(env, term, term_params_key, term_params_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.AutomationEvent {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.AutomationEvent{};

        // frame

        const term_frame_key = Atom.make(env, "frame");
        var term_frame_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_frame_key, &term_frame_value) == 0) return error.ArgumentError;
        value.frame = @intCast(try UInt.get(env, term_frame_value));

        // type

        const term_type_key = Atom.make(env, "type");
        var term_type_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_type_key, &term_type_value) == 0) return error.ArgumentError;
        value.type = @intCast(try UInt.get(env, term_type_value));

        // params

        const term_params_key = Atom.make(env, "params");
        var term_params_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_params_key, &term_params_value) == 0) return error.ArgumentError;
        try Array.get_copy(Int, c_int, Self.allocator, env, term_params_value, &value.params);
        errdefer Array.free_copy(Int, c_int, Self.allocator, &value.params, null);

        return value;
    }

    pub fn unload(value: rl.AutomationEvent) void {
        _ = value;
    }

    pub fn free(value: rl.AutomationEvent) void {
        _ = value;
    }
};

///////////////////////////
//  AutomationEventList  //
///////////////////////////

pub const AutomationEventList = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.AutomationEventList;
    pub const resource_name = "automation_event_list";

    pub const Resource = ResourceBase(Self);

    pub const MAX_AUTOMATION_EVENTS: usize = @intCast(rl.MAX_AUTOMATION_EVENTS);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.AutomationEventList) e.ErlNifTerm {
        var term = e.enif_make_new_map(env);

        // capacity

        const term_capacity_key = Atom.make(env, "capacity");
        const term_capacity_value = UInt.make(env, @intCast(value.capacity));
        assert(e.enif_make_map_put(env, term, term_capacity_key, term_capacity_value, &term) != 0);

        // count

        const term_count_key = Atom.make(env, "count");
        const term_count_value = UInt.make(env, @intCast(value.count));
        assert(e.enif_make_map_put(env, term, term_count_key, term_count_value, &term) != 0);

        // events
        // = capacity

        const term_events_key = Atom.make(env, "events");
        const events_lengths = [_]usize{@intCast(value.capacity)};
        const term_events_value = Array.make_c(AutomationEvent, rl.AutomationEvent, env, value.events, &events_lengths);
        assert(e.enif_make_map_put(env, term, term_events_key, term_events_value, &term) != 0);

        return term;
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.AutomationEventList {
        if (e.enif_is_ref(env, term) != 0) {
            return (try Self.Resource.get(env, term)).*.*;
        }

        var value = rl.AutomationEventList{};

        // capacity

        const term_capacity_key = Atom.make(env, "capacity");
        var term_capacity_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_capacity_key, &term_capacity_value) == 0) return error.ArgumentError;
        value.capacity = @intCast(try UInt.get(env, term_capacity_value));

        // count

        const term_count_key = Atom.make(env, "count");
        var term_count_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_count_key, &term_count_value) == 0) return error.ArgumentError;
        value.count = @intCast(try UInt.get(env, term_count_value));

        // events
        // = capacity

        const term_events_key = Atom.make(env, "events");
        var term_events_value: e.ErlNifTerm = undefined;
        if (e.enif_get_map_value(env, term, term_events_key, &term_events_value) == 0) return error.ArgumentError;

        const events_lengths = [_]usize{@intCast(value.capacity)};
        var events = try ArgumentArrayC(AutomationEvent, AutomationEvent.data_type, Self.allocator).get(env, term_events_value, &events_lengths);
        defer events.free_keep();
        errdefer events.free();
        value.events = events.data;

        return value;
    }

    pub fn unload(value: rl.AutomationEventList) void {
        free(value);
    }

    pub fn free(value: rl.AutomationEventList) void {
        rl.UnloadAutomationEventList(value);
    }
};
