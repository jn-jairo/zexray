const std = @import("std");
const assert = std.debug.assert;
const e = @import("./erl_nif.zig");
const rl = @import("./raylib.zig");
const utils = @import("./utils.zig");

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

pub fn is_term_resource(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) bool {
    const record = Tuple.get(env, term) catch {
        return false;
    };

    if (record.len != 2) {
        return false;
    }

    return e.enif_is_ref(env, record[1]) != 0;
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

/////////////
//  Tuple  //
/////////////

pub const Tuple = struct {
    pub fn make(env: ?*e.ErlNifEnv, value: []const e.ErlNifTerm) e.ErlNifTerm {
        return e.enif_make_tuple_from_array(env, @ptrCast(value), @intCast(value.len));
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) ![]const e.ErlNifTerm {
        var arity: c_int = undefined;
        var tuple: [*c]e.ErlNifTerm = null;
        if (e.enif_get_tuple(env, term, &arity, @ptrCast(&tuple)) == 0) return error.ArgumentError;

        return @as([*]e.ErlNifTerm, @ptrCast(tuple))[0..@intCast(arity)];
    }
};

//////////////
//  Number  //
//////////////

pub fn Number(comptime T_zig: type) type {
    return struct {
        pub const data_type = T_zig;

        pub fn make(env: ?*e.ErlNifEnv, value: T_zig) e.ErlNifTerm {
            return switch (@typeInfo(T_zig)) {
                .int => |info| blk: {
                    if (info.signedness == std.builtin.Signedness.unsigned) {
                        break :blk e.enif_make_uint(env, @intCast(value));
                    } else {
                        break :blk e.enif_make_int(env, @intCast(value));
                    }
                },
                .float => e.enif_make_double(env, @floatCast(value)),
                else => @compileError("Invalid type"),
            };
        }

        pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !T_zig {
            return switch (e.enif_term_type(env, term)) {
                e.ERL_NIF_TERM_TYPE_FLOAT => blk: {
                    var value: f64 = undefined;
                    if (e.enif_get_double(env, term, &value) == 0) return error.ArgumentError;
                    switch (@typeInfo(T_zig)) {
                        .float => break :blk @as(T_zig, @floatCast(value)),
                        .int => break :blk @as(T_zig, @intFromFloat(@trunc(value))),
                        else => @compileError("Invalid type"),
                    }
                },
                e.ERL_NIF_TERM_TYPE_INTEGER => blk: {
                    switch (@typeInfo(T_zig)) {
                        .float => {
                            var value: c_int = undefined;
                            if (e.enif_get_int(env, term, &value) == 0) return error.ArgumentError;
                            break :blk @as(T_zig, @floatFromInt(value));
                        },
                        .int => |info| {
                            if (info.signedness == std.builtin.Signedness.unsigned) {
                                var value: c_uint = undefined;
                                if (e.enif_get_uint(env, term, &value) == 0) return error.ArgumentError;
                                break :blk @as(T_zig, @intCast(value));
                            } else {
                                var value: c_int = undefined;
                                if (e.enif_get_int(env, term, &value) == 0) return error.ArgumentError;
                                break :blk @as(T_zig, @intCast(value));
                            }
                        },
                        else => @compileError("Invalid type"),
                    }
                },
                else => error.ArgumentError,
            };
        }
    };
}

//////////////
//  Double  //
//////////////

pub const Double = Number(f64);

/////////////
//  Float  //
/////////////

pub const Float = Number(f32);

///////////
//  Int  //
///////////

pub const Int = Number(c_int);

/////////////
//  Short  //
/////////////

pub const Short = Number(c_short);

////////////
//  UInt  //
////////////

pub const UInt = Number(c_uint);

//////////////
//  UShort  //
//////////////

pub const UShort = Number(c_ushort);

////////////
//  Char  //
////////////

pub const Char = Number(u8);

//////////////////////
//  TermIsResource  //
//////////////////////

pub const TermIsResource = struct {
    pub const data_type = bool;

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !bool {
        return is_term_resource(env, term);
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

        var length_c = lengths_c[depth];

        var length: c_uint = undefined;
        if (e.enif_get_list_length(env, term, &length) == 0) return error.ArgumentError;
        if (length_c == 0 and T == CString) length_c = @intCast(length);
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
                        if (lengths_c[depth + 1] == 0 and T == CString) {
                            switch (@typeInfo(@TypeOf(T.get_c_unknown))) {
                                .@"fn" => |fn_info| {
                                    if (fn_info.params.len == 3) {
                                        break :blk try T.get_c_unknown(allocator, env, term_value_head);
                                    } else {
                                        break :blk try T.get_c_unknown(env, term_value_head);
                                    }
                                },
                                else => @compileError("Get callback is not a function"),
                            }
                            @compileError("Invalid get callback");
                        } else {
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
                        }
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
                            if (lengths_c[depth + 1] == 0 and T == CString) {
                                switch (@typeInfo(@TypeOf(T.free_c_unknown))) {
                                    .@"fn" => |fn_info| {
                                        if (fn_info.params.len == 2) {
                                            break :blk T.free_c_unknown(allocator, values[i]);
                                        } else {
                                            break :blk T.free_c_unknown(values[i]);
                                        }
                                    },
                                    else => @compileError("Free callback is not a function"),
                                }
                                @compileError("Invalid free callback");
                            } else {
                                switch (@typeInfo(@TypeOf(T.free_c))) {
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
            return Tuple.make(env, &[_]e.ErlNifTerm{ Atom.make(env, T.resource_name ++ "_resource"), Resource.make(env, @ptrCast(@alignCast(resource))) });
        }

        pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !**T.data_type {
            const record = try Tuple.get(env, term);
            return get_record(env, record);
        }

        pub fn get_record(env: ?*e.ErlNifEnv, record: []const e.ErlNifTerm) !**T.data_type {
            if (record.len != 2) {
                return error.ArgumentError;
            }

            const resource_type = @field(resources.resource_type, T.resource_name);

            if (@hasDecl(T, "resource_type_aliases")) {
                const resource = Resource.get(env, record[1], resource_type) catch |err| {
                    for (T.resource_type_aliases) |resource_type_alias| {
                        const resource_alias = Resource.get(env, record[1], resources.get_resource_type_from_key(resource_type_alias)) catch continue;
                        return @ptrCast(@alignCast(resource_alias));
                    }
                    return err;
                };
                return @ptrCast(@alignCast(resource));
            } else {
                return @ptrCast(@alignCast(try Resource.get(env, record[1], resource_type)));
            }
        }

        pub fn create(value: T.data_type) !**T.data_type {
            const allocator = resources.ResourceType.allocator;
            const resource_type = @field(resources.resource_type, T.resource_name);

            const resource: **T.data_type = @ptrCast(@alignCast(try Resource.create(resource_type, @sizeOf(*T.data_type))));
            defer utils.TRACELOGD("RESOURCE: Created %s %s", .{ T.resource_name, ptr_to_c_string(resource) });

            resource.* = try allocator.create(T.data_type);
            resource.*.* = value;

            return resource;
        }

        pub fn update(env: ?*e.ErlNifEnv, term: e.ErlNifTerm, value: T.data_type) !void {
            const resource = try get(env, term);
            defer utils.TRACELOGD("RESOURCE: Updated %s %s", .{ T.resource_name, ptr_to_c_string(resource) });
            resource.*.* = value;
        }

        pub fn replace(env: ?*e.ErlNifEnv, term: e.ErlNifTerm, value: T.data_type) !void {
            const resource = try get(env, term);
            defer utils.TRACELOGD("RESOURCE: Replaced %s %s", .{ T.resource_name, ptr_to_c_string(resource) });
            T.free(resource.*.*);
            resource.*.* = value;
        }

        pub fn destroy(resource: **T.data_type) void {
            defer utils.TRACELOGD("RESOURCE: Destroyed %s %s", .{ T.resource_name, ptr_to_c_string(resource) });
            const allocator = resources.ResourceType.allocator;
            allocator.destroy(resource.*);
        }

        pub fn release(resource: **T.data_type) void {
            Resource.release(@ptrCast(@alignCast(resource)));
        }

        pub fn free(resource: **T.data_type) void {
            defer utils.TRACELOGD("RESOURCE: Freed %s %s", .{ T.resource_name, ptr_to_c_string(resource) });
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
            const keep = is_term_resource(env, term);

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
        // x

        const term_x_value = Float.make(env, value.x);

        // y

        const term_y_value = Float.make(env, value.y);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_x_value,
            term_y_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Vector2 {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 3) {
            return error.ArgumentError;
        }

        const term_x_value = record[1];
        const term_y_value = record[2];

        var value = rl.Vector2{};

        // x

        value.x = try Float.get(env, term_x_value);

        // y

        value.y = try Float.get(env, term_y_value);

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
        // x

        const term_x_value = Int.make(env, value.x);

        // y

        const term_y_value = Int.make(env, value.y);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_x_value,
            term_y_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.IVector2 {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 3) {
            return error.ArgumentError;
        }

        const term_x_value = record[1];
        const term_y_value = record[2];

        var value = rl.IVector2{};

        // x

        value.x = try Int.get(env, term_x_value);

        // y

        value.y = try Int.get(env, term_y_value);

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
        // x

        const term_x_value = UInt.make(env, value.x);

        // y

        const term_y_value = UInt.make(env, value.y);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_x_value,
            term_y_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.UIVector2 {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 3) {
            return error.ArgumentError;
        }

        const term_x_value = record[1];
        const term_y_value = record[2];

        var value = rl.UIVector2{};

        // x

        value.x = try UInt.get(env, term_x_value);

        // y

        value.y = try UInt.get(env, term_y_value);

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
        // x

        const term_x_value = Float.make(env, value.x);

        // y

        const term_y_value = Float.make(env, value.y);

        // z

        const term_z_value = Float.make(env, value.z);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_x_value,
            term_y_value,
            term_z_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Vector3 {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 4) {
            return error.ArgumentError;
        }

        const term_x_value = record[1];
        const term_y_value = record[2];
        const term_z_value = record[3];

        var value = rl.Vector3{};

        // x

        value.x = try Float.get(env, term_x_value);

        // y

        value.y = try Float.get(env, term_y_value);

        // z

        value.z = try Float.get(env, term_z_value);

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
        // x

        const term_x_value = Int.make(env, value.x);

        // y

        const term_y_value = Int.make(env, value.y);

        // z

        const term_z_value = Int.make(env, value.z);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_x_value,
            term_y_value,
            term_z_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.IVector3 {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 4) {
            return error.ArgumentError;
        }

        const term_x_value = record[1];
        const term_y_value = record[2];
        const term_z_value = record[3];

        var value = rl.IVector3{};

        // x

        value.x = try Int.get(env, term_x_value);

        // y

        value.y = try Int.get(env, term_y_value);

        // z

        value.z = try Int.get(env, term_z_value);

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
        // x

        const term_x_value = UInt.make(env, value.x);

        // y

        const term_y_value = UInt.make(env, value.y);

        // z

        const term_z_value = UInt.make(env, value.z);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_x_value,
            term_y_value,
            term_z_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.UIVector3 {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 4) {
            return error.ArgumentError;
        }

        const term_x_value = record[1];
        const term_y_value = record[2];
        const term_z_value = record[3];

        var value = rl.UIVector3{};

        // x

        value.x = try UInt.get(env, term_x_value);

        // y

        value.y = try UInt.get(env, term_y_value);

        // z

        value.z = try UInt.get(env, term_z_value);

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
        // x

        const term_x_value = Float.make(env, value.x);

        // y

        const term_y_value = Float.make(env, value.y);

        // z

        const term_z_value = Float.make(env, value.z);

        // w

        const term_w_value = Float.make(env, value.w);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_x_value,
            term_y_value,
            term_z_value,
            term_w_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Vector4 {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 5) {
            return error.ArgumentError;
        }

        const term_x_value = record[1];
        const term_y_value = record[2];
        const term_z_value = record[3];
        const term_w_value = record[4];

        var value = rl.Vector4{};

        // x

        value.x = try Float.get(env, term_x_value);

        // y

        value.y = try Float.get(env, term_y_value);

        // z

        value.z = try Float.get(env, term_z_value);

        // w

        value.w = try Float.get(env, term_w_value);

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
        // x

        const term_x_value = Int.make(env, value.x);

        // y

        const term_y_value = Int.make(env, value.y);

        // z

        const term_z_value = Int.make(env, value.z);

        // w

        const term_w_value = Int.make(env, value.w);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_x_value,
            term_y_value,
            term_z_value,
            term_w_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.IVector4 {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 5) {
            return error.ArgumentError;
        }

        const term_x_value = record[1];
        const term_y_value = record[2];
        const term_z_value = record[3];
        const term_w_value = record[4];

        var value = rl.IVector4{};

        // x

        value.x = try Int.get(env, term_x_value);

        // y

        value.y = try Int.get(env, term_y_value);

        // z

        value.z = try Int.get(env, term_z_value);

        // w

        value.w = try Int.get(env, term_w_value);

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
        // x

        const term_x_value = UInt.make(env, value.x);

        // y

        const term_y_value = UInt.make(env, value.y);

        // z

        const term_z_value = UInt.make(env, value.z);

        // w

        const term_w_value = UInt.make(env, value.w);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_x_value,
            term_y_value,
            term_z_value,
            term_w_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.UIVector4 {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 5) {
            return error.ArgumentError;
        }

        const term_x_value = record[1];
        const term_y_value = record[2];
        const term_z_value = record[3];
        const term_w_value = record[4];

        var value = rl.UIVector4{};

        // x

        value.x = try UInt.get(env, term_x_value);

        // y

        value.y = try UInt.get(env, term_y_value);

        // z

        value.z = try UInt.get(env, term_z_value);

        // w

        value.w = try UInt.get(env, term_w_value);

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
        // x

        const term_x_value = Float.make(env, value.x);

        // y

        const term_y_value = Float.make(env, value.y);

        // z

        const term_z_value = Float.make(env, value.z);

        // w

        const term_w_value = Float.make(env, value.w);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_x_value,
            term_y_value,
            term_z_value,
            term_w_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Quaternion {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 5) {
            return error.ArgumentError;
        }

        const term_x_value = record[1];
        const term_y_value = record[2];
        const term_z_value = record[3];
        const term_w_value = record[4];

        var value = rl.Quaternion{};

        // x

        value.x = try Float.get(env, term_x_value);

        // y

        value.y = try Float.get(env, term_y_value);

        // z

        value.z = try Float.get(env, term_z_value);

        // w

        value.w = try Float.get(env, term_w_value);

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
        // m0

        const term_m0_value = Float.make(env, value.m0);

        // m1

        const term_m1_value = Float.make(env, value.m1);

        // m2

        const term_m2_value = Float.make(env, value.m2);

        // m3

        const term_m3_value = Float.make(env, value.m3);

        // m4

        const term_m4_value = Float.make(env, value.m4);

        // m5

        const term_m5_value = Float.make(env, value.m5);

        // m6

        const term_m6_value = Float.make(env, value.m6);

        // m7

        const term_m7_value = Float.make(env, value.m7);

        // m8

        const term_m8_value = Float.make(env, value.m8);

        // m9

        const term_m9_value = Float.make(env, value.m9);

        // m10

        const term_m10_value = Float.make(env, value.m10);

        // m11

        const term_m11_value = Float.make(env, value.m11);

        // m12

        const term_m12_value = Float.make(env, value.m12);

        // m13

        const term_m13_value = Float.make(env, value.m13);

        // m14

        const term_m14_value = Float.make(env, value.m14);

        // m15

        const term_m15_value = Float.make(env, value.m15);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_m0_value,
            term_m1_value,
            term_m2_value,
            term_m3_value,
            term_m4_value,
            term_m5_value,
            term_m6_value,
            term_m7_value,
            term_m8_value,
            term_m9_value,
            term_m10_value,
            term_m11_value,
            term_m12_value,
            term_m13_value,
            term_m14_value,
            term_m15_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Matrix {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 17) {
            return error.ArgumentError;
        }

        const term_m0_value = record[1];
        const term_m1_value = record[2];
        const term_m2_value = record[3];
        const term_m3_value = record[4];
        const term_m4_value = record[5];
        const term_m5_value = record[6];
        const term_m6_value = record[7];
        const term_m7_value = record[8];
        const term_m8_value = record[9];
        const term_m9_value = record[10];
        const term_m10_value = record[11];
        const term_m11_value = record[12];
        const term_m12_value = record[13];
        const term_m13_value = record[14];
        const term_m14_value = record[15];
        const term_m15_value = record[16];

        var value = rl.Matrix{};

        // m0

        value.m0 = try Float.get(env, term_m0_value);

        // m1

        value.m1 = try Float.get(env, term_m1_value);

        // m2

        value.m2 = try Float.get(env, term_m2_value);

        // m3

        value.m3 = try Float.get(env, term_m3_value);

        // m4

        value.m4 = try Float.get(env, term_m4_value);

        // m5

        value.m5 = try Float.get(env, term_m5_value);

        // m6

        value.m6 = try Float.get(env, term_m6_value);

        // m7

        value.m7 = try Float.get(env, term_m7_value);

        // m8

        value.m8 = try Float.get(env, term_m8_value);

        // m9

        value.m9 = try Float.get(env, term_m9_value);

        // m10

        value.m10 = try Float.get(env, term_m10_value);

        // m11

        value.m11 = try Float.get(env, term_m11_value);

        // m12

        value.m12 = try Float.get(env, term_m12_value);

        // m13

        value.m13 = try Float.get(env, term_m13_value);

        // m14

        value.m14 = try Float.get(env, term_m14_value);

        // m15

        value.m15 = try Float.get(env, term_m15_value);

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
        // r

        const term_r_value = Char.make(env, value.r);

        // g

        const term_g_value = Char.make(env, value.g);

        // b

        const term_b_value = Char.make(env, value.b);

        // a

        const term_a_value = Char.make(env, value.a);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_r_value,
            term_g_value,
            term_b_value,
            term_a_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Color {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 5) {
            return error.ArgumentError;
        }

        const term_r_value = record[1];
        const term_g_value = record[2];
        const term_b_value = record[3];
        const term_a_value = record[4];

        var value = rl.Color{};

        // r

        value.r = try Char.get(env, term_r_value);

        // g

        value.g = try Char.get(env, term_g_value);

        // b

        value.b = try Char.get(env, term_b_value);

        // a

        value.a = try Char.get(env, term_a_value);

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
        // x

        const term_x_value = Float.make(env, value.x);

        // y

        const term_y_value = Float.make(env, value.y);

        // width

        const term_width_value = Float.make(env, value.width);

        // height

        const term_height_value = Float.make(env, value.height);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_x_value,
            term_y_value,
            term_width_value,
            term_height_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Rectangle {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 5) {
            return error.ArgumentError;
        }

        const term_x_value = record[1];
        const term_y_value = record[2];
        const term_width_value = record[3];
        const term_height_value = record[4];

        var value = rl.Rectangle{};

        // x

        value.x = try Float.get(env, term_x_value);

        // y

        value.y = try Float.get(env, term_y_value);

        // width

        value.width = try Float.get(env, term_width_value);

        // height

        value.height = try Float.get(env, term_height_value);

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
        // width

        const term_width_value = Int.make(env, value.width);

        // height

        const term_height_value = Int.make(env, value.height);

        // mipmaps

        const term_mipmaps_value = Int.make(env, value.mipmaps);

        // format

        const term_format_value = Int.make(env, value.format);

        // data

        const data_size: usize = get_data_size(
            value.width,
            value.height,
            value.format,
            value.mipmaps,
        );

        const term_data_value = Binary.make_c(env, @ptrCast(value.data), data_size);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_data_value,
            term_width_value,
            term_height_value,
            term_mipmaps_value,
            term_format_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Image {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 6) {
            return error.ArgumentError;
        }

        const term_data_value = record[1];
        const term_width_value = record[2];
        const term_height_value = record[3];
        const term_mipmaps_value = record[4];
        const term_format_value = record[5];

        var value = rl.Image{};

        // width

        value.width = try Int.get(env, term_width_value);

        // height

        value.height = try Int.get(env, term_height_value);

        // mipmaps

        value.mipmaps = try Int.get(env, term_mipmaps_value);

        // format

        value.format = try Int.get(env, term_format_value);

        // data

        const data_size: usize = get_data_size(
            value.width,
            value.height,
            value.format,
            value.mipmaps,
        );

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
    pub const resource_type_aliases = [_]resources.ResourceTypeKey{ resources.ResourceTypeKey.texture_2d, resources.ResourceTypeKey.texture_cubemap };

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Texture) e.ErlNifTerm {
        // id

        const term_id_value = UInt.make(env, value.id);

        // width

        const term_width_value = Int.make(env, value.width);

        // height

        const term_height_value = Int.make(env, value.height);

        // mipmaps

        const term_mipmaps_value = Int.make(env, value.mipmaps);

        // format

        const term_format_value = Int.make(env, value.format);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_id_value,
            term_width_value,
            term_height_value,
            term_mipmaps_value,
            term_format_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Texture {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 6) {
            return error.ArgumentError;
        }

        const term_id_value = record[1];
        const term_width_value = record[2];
        const term_height_value = record[3];
        const term_mipmaps_value = record[4];
        const term_format_value = record[5];

        var value = rl.Texture{};

        // id

        value.id = try UInt.get(env, term_id_value);

        // width

        value.width = try Int.get(env, term_width_value);

        // height

        value.height = try Int.get(env, term_height_value);

        // mipmaps

        value.mipmaps = try Int.get(env, term_mipmaps_value);

        // format

        value.format = try Int.get(env, term_format_value);

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
    pub const resource_type_aliases = [_]resources.ResourceTypeKey{ resources.ResourceTypeKey.texture, resources.ResourceTypeKey.texture_cubemap };

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Texture2D) e.ErlNifTerm {
        // id

        const term_id_value = UInt.make(env, value.id);

        // width

        const term_width_value = Int.make(env, value.width);

        // height

        const term_height_value = Int.make(env, value.height);

        // mipmaps

        const term_mipmaps_value = Int.make(env, value.mipmaps);

        // format

        const term_format_value = Int.make(env, value.format);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_id_value,
            term_width_value,
            term_height_value,
            term_mipmaps_value,
            term_format_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Texture2D {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 6) {
            return error.ArgumentError;
        }

        const term_id_value = record[1];
        const term_width_value = record[2];
        const term_height_value = record[3];
        const term_mipmaps_value = record[4];
        const term_format_value = record[5];

        var value = rl.Texture2D{};

        // id

        value.id = try UInt.get(env, term_id_value);

        // width

        value.width = try Int.get(env, term_width_value);

        // height

        value.height = try Int.get(env, term_height_value);

        // mipmaps

        value.mipmaps = try Int.get(env, term_mipmaps_value);

        // format

        value.format = try Int.get(env, term_format_value);

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
    pub const resource_type_aliases = [_]resources.ResourceTypeKey{ resources.ResourceTypeKey.texture, resources.ResourceTypeKey.texture_2d };

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.TextureCubemap) e.ErlNifTerm {
        // id

        const term_id_value = UInt.make(env, value.id);

        // width

        const term_width_value = Int.make(env, value.width);

        // height

        const term_height_value = Int.make(env, value.height);

        // mipmaps

        const term_mipmaps_value = Int.make(env, value.mipmaps);

        // format

        const term_format_value = Int.make(env, value.format);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_id_value,
            term_width_value,
            term_height_value,
            term_mipmaps_value,
            term_format_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.TextureCubemap {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 6) {
            return error.ArgumentError;
        }

        const term_id_value = record[1];
        const term_width_value = record[2];
        const term_height_value = record[3];
        const term_mipmaps_value = record[4];
        const term_format_value = record[5];

        var value = rl.TextureCubemap{};

        // id

        value.id = try UInt.get(env, term_id_value);

        // width

        value.width = try Int.get(env, term_width_value);

        // height

        value.height = try Int.get(env, term_height_value);

        // mipmaps

        value.mipmaps = try Int.get(env, term_mipmaps_value);

        // format

        value.format = try Int.get(env, term_format_value);

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
        // id

        const term_id_value = UInt.make(env, value.id);

        // texture

        const term_texture_value = Texture.make(env, value.texture);

        // depth

        const term_depth_value = Texture.make(env, value.depth);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_id_value,
            term_texture_value,
            term_depth_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.RenderTexture {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 4) {
            return error.ArgumentError;
        }

        const term_id_value = record[1];
        const term_texture_value = record[2];
        const term_depth_value = record[3];

        var value = rl.RenderTexture{};

        // id

        value.id = try UInt.get(env, term_id_value);

        // texture

        const texture = try Argument(Texture).get(env, term_texture_value);
        errdefer texture.free();
        value.texture = texture.data;

        // depth

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
        // id

        const term_id_value = UInt.make(env, value.id);

        // texture

        const term_texture_value = Texture.make(env, value.texture);

        // depth

        const term_depth_value = Texture.make(env, value.depth);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_id_value,
            term_texture_value,
            term_depth_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.RenderTexture2D {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 4) {
            return error.ArgumentError;
        }

        const term_id_value = record[1];
        const term_texture_value = record[2];
        const term_depth_value = record[3];

        var value = rl.RenderTexture2D{};

        // id

        value.id = try UInt.get(env, term_id_value);

        // texture

        const texture = try Argument(Texture).get(env, term_texture_value);
        errdefer texture.free();
        value.texture = texture.data;

        // depth

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
        // source

        const term_source_value = Rectangle.make(env, value.source);

        // left

        const term_left_value = Int.make(env, value.left);

        // top

        const term_top_value = Int.make(env, value.top);

        // right

        const term_right_value = Int.make(env, value.right);

        // bottom

        const term_bottom_value = Int.make(env, value.bottom);

        // layout

        const term_layout_value = Int.make(env, value.layout);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_source_value,
            term_left_value,
            term_top_value,
            term_right_value,
            term_bottom_value,
            term_layout_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.NPatchInfo {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 7) {
            return error.ArgumentError;
        }

        const term_source_value = record[1];
        const term_left_value = record[2];
        const term_top_value = record[3];
        const term_right_value = record[4];
        const term_bottom_value = record[5];
        const term_layout_value = record[6];

        var value = rl.NPatchInfo{};

        // source

        const source = try Argument(Rectangle).get(env, term_source_value);
        errdefer source.free();
        value.source = source.data;

        // left

        value.left = try Int.get(env, term_left_value);

        // top

        value.top = try Int.get(env, term_top_value);

        // right

        value.right = try Int.get(env, term_right_value);

        // bottom

        value.bottom = try Int.get(env, term_bottom_value);

        // layout

        value.layout = try Int.get(env, term_layout_value);

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
        // value

        const term_value_value = Int.make(env, value.value);

        // offset_x

        const term_offset_x_value = Int.make(env, value.offsetX);

        // offset_y

        const term_offset_y_value = Int.make(env, value.offsetY);

        // advance_x

        const term_advance_x_value = Int.make(env, value.advanceX);

        // image

        const term_image_value = Image.make(env, value.image);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_value_value,
            term_offset_x_value,
            term_offset_y_value,
            term_advance_x_value,
            term_image_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.GlyphInfo {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 6) {
            return error.ArgumentError;
        }

        const term_value_value = record[1];
        const term_offset_x_value = record[2];
        const term_offset_y_value = record[3];
        const term_advance_x_value = record[4];
        const term_image_value = record[5];

        var value = rl.GlyphInfo{};

        // value

        value.value = try Int.get(env, term_value_value);

        // offset_x

        value.offsetX = try Int.get(env, term_offset_x_value);

        // offset_y

        value.offsetY = try Int.get(env, term_offset_y_value);

        // advance_x

        value.advanceX = try Int.get(env, term_advance_x_value);

        // image

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
        // base_size

        const term_base_size_value = Int.make(env, value.baseSize);

        // glyph_count

        const term_glyph_count_value = Int.make(env, value.glyphCount);

        // glyph_padding

        const term_glyph_padding_value = Int.make(env, value.glyphPadding);

        // texture

        const term_texture_value = Texture.make(env, value.texture);

        // recs

        const recs_lengths = [_]usize{@intCast(value.glyphCount)};
        const term_recs_value = Array.make_c(Rectangle, rl.Rectangle, env, value.recs, &recs_lengths);

        // glyphs

        const glyphs_lengths = [_]usize{@intCast(value.glyphCount)};
        const term_glyphs_value = Array.make_c(GlyphInfo, rl.GlyphInfo, env, value.glyphs, &glyphs_lengths);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_base_size_value,
            term_glyph_count_value,
            term_glyph_padding_value,
            term_texture_value,
            term_recs_value,
            term_glyphs_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Font {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 7) {
            return error.ArgumentError;
        }

        const term_base_size_value = record[1];
        const term_glyph_count_value = record[2];
        const term_glyph_padding_value = record[3];
        const term_texture_value = record[4];
        const term_recs_value = record[5];
        const term_glyphs_value = record[6];

        var value = rl.Font{};

        // base_size

        value.baseSize = try Int.get(env, term_base_size_value);

        // glyph_count

        value.glyphCount = try Int.get(env, term_glyph_count_value);

        // glyph_padding

        value.glyphPadding = try Int.get(env, term_glyph_padding_value);

        // texture

        const texture = try Argument(Texture).get(env, term_texture_value);
        errdefer texture.free();
        value.texture = texture.data;

        // recs

        const recs_lengths = [_]usize{@intCast(value.glyphCount)};
        var recs = try ArgumentArrayC(Rectangle, Rectangle.data_type, Self.allocator).get(env, term_recs_value, &recs_lengths);
        defer recs.free_keep();
        errdefer recs.free();
        value.recs = recs.data;

        // glyphs

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
    pub const resource_type_aliases = [_]resources.ResourceTypeKey{resources.ResourceTypeKey.camera};

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Camera3D) e.ErlNifTerm {
        // position

        const term_position_value = Vector3.make(env, value.position);

        // target

        const term_target_value = Vector3.make(env, value.target);

        // up

        const term_up_value = Vector3.make(env, value.up);

        // fovy

        const term_fovy_value = Float.make(env, value.fovy);

        // projection

        const term_projection_value = Int.make(env, value.projection);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_position_value,
            term_target_value,
            term_up_value,
            term_fovy_value,
            term_projection_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Camera3D {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 6) {
            return error.ArgumentError;
        }

        const term_position_value = record[1];
        const term_target_value = record[2];
        const term_up_value = record[3];
        const term_fovy_value = record[4];
        const term_projection_value = record[5];

        var value = rl.Camera3D{};

        // position

        const position = try Argument(Vector3).get(env, term_position_value);
        errdefer position.free();
        value.position = position.data;

        // target

        const target = try Argument(Vector3).get(env, term_target_value);
        errdefer target.free();
        value.target = target.data;

        // up

        const up = try Argument(Vector3).get(env, term_up_value);
        errdefer up.free();
        value.up = up.data;

        // fovy

        value.fovy = try Float.get(env, term_fovy_value);

        // projection

        value.projection = try Int.get(env, term_projection_value);

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
    pub const resource_type_aliases = [_]resources.ResourceTypeKey{resources.ResourceTypeKey.camera_3d};

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Camera) e.ErlNifTerm {
        // position

        const term_position_value = Vector3.make(env, value.position);

        // target

        const term_target_value = Vector3.make(env, value.target);

        // up

        const term_up_value = Vector3.make(env, value.up);

        // fovy

        const term_fovy_value = Float.make(env, value.fovy);

        // projection

        const term_projection_value = Int.make(env, value.projection);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_position_value,
            term_target_value,
            term_up_value,
            term_fovy_value,
            term_projection_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Camera {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 6) {
            return error.ArgumentError;
        }

        const term_position_value = record[1];
        const term_target_value = record[2];
        const term_up_value = record[3];
        const term_fovy_value = record[4];
        const term_projection_value = record[5];

        var value = rl.Camera{};

        // position

        const position = try Argument(Vector3).get(env, term_position_value);
        errdefer position.free();
        value.position = position.data;

        // target

        const target = try Argument(Vector3).get(env, term_target_value);
        errdefer target.free();
        value.target = target.data;

        // up

        const up = try Argument(Vector3).get(env, term_up_value);
        errdefer up.free();
        value.up = up.data;

        // fovy

        value.fovy = try Float.get(env, term_fovy_value);

        // projection

        value.projection = try Int.get(env, term_projection_value);

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
        // offset

        const term_offset_value = Vector2.make(env, value.offset);

        // target

        const term_target_value = Vector2.make(env, value.target);

        // rotation

        const term_rotation_value = Float.make(env, value.rotation);

        // zoom

        const term_zoom_value = Float.make(env, value.zoom);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_offset_value,
            term_target_value,
            term_rotation_value,
            term_zoom_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Camera2D {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 5) {
            return error.ArgumentError;
        }

        const term_offset_value = record[1];
        const term_target_value = record[2];
        const term_rotation_value = record[3];
        const term_zoom_value = record[4];

        var value = rl.Camera2D{};

        // offset

        const offset = try Argument(Vector2).get(env, term_offset_value);
        errdefer offset.free();
        value.offset = offset.data;

        // target

        const target = try Argument(Vector2).get(env, term_target_value);
        errdefer target.free();
        value.target = target.data;

        // rotation

        value.rotation = try Float.get(env, term_rotation_value);

        // zoom

        value.zoom = try Float.get(env, term_zoom_value);

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
        // vertex_count

        const term_vertex_count_value = Int.make(env, value.vertexCount);

        // triangle_count

        const term_triangle_count_value = Int.make(env, value.triangleCount);

        // vertices
        // = vertex_count * 3

        const vertices_lengths = [_]usize{@intCast(value.vertexCount * 3)};
        const term_vertices_value = Array.make_c(Float, f32, env, value.vertices, &vertices_lengths);

        // texcoords
        // = vertex_count * 2

        const texcoords_lengths = [_]usize{@intCast(value.vertexCount * 2)};
        const term_texcoords_value = Array.make_c(Float, f32, env, value.texcoords, &texcoords_lengths);

        // texcoords2
        // = vertex_count * 2

        const texcoords2_lengths = [_]usize{@intCast(value.vertexCount * 2)};
        const term_texcoords2_value = Array.make_c(Float, f32, env, value.texcoords2, &texcoords2_lengths);

        // normals
        // = vertex_count * 3

        const normals_lengths = [_]usize{@intCast(value.vertexCount * 3)};
        const term_normals_value = Array.make_c(Float, f32, env, value.normals, &normals_lengths);

        // tangents
        // = vertex_count * 4

        const tangents_lengths = [_]usize{@intCast(value.vertexCount * 4)};
        const term_tangents_value = Array.make_c(Float, f32, env, value.tangents, &tangents_lengths);

        // colors
        // = vertex_count * 4

        const colors_lengths = [_]usize{@intCast(value.vertexCount * 4)};
        const term_colors_value = Array.make_c(Char, u8, env, value.colors, &colors_lengths);

        // indices
        // = triangle_count * 3

        const indices_lengths = [_]usize{@intCast(value.triangleCount * 3)};
        const term_indices_value = Array.make_c(UShort, c_ushort, env, value.indices, &indices_lengths);

        // anim_vertices
        // = vertex_count * 3

        const anim_vertices_lengths = [_]usize{@intCast(value.vertexCount * 3)};
        const term_anim_vertices_value = Array.make_c(Float, f32, env, value.animVertices, &anim_vertices_lengths);

        // anim_normals
        // = vertex_count * 3

        const anim_normals_lengths = [_]usize{@intCast(value.vertexCount * 3)};
        const term_anim_normals_value = Array.make_c(Float, f32, env, value.animNormals, &anim_normals_lengths);

        // bone_ids
        // = vertex_count * 4

        const bone_ids_lengths = [_]usize{@intCast(value.vertexCount * 4)};
        const term_bone_ids_value = Array.make_c(Char, u8, env, value.boneIds, &bone_ids_lengths);

        // bone_weights
        // = vertex_count * 4

        const bone_weights_lengths = [_]usize{@intCast(value.vertexCount * 4)};
        const term_bone_weights_value = Array.make_c(Float, f32, env, value.boneWeights, &bone_weights_lengths);

        // bone_count

        const term_bone_count_value = Int.make(env, value.boneCount);

        // bone_matrices
        // = bone_count

        const bone_matrices_lengths = [_]usize{@intCast(value.boneCount)};
        const term_bone_matrices_value = Array.make_c(Matrix, rl.Matrix, env, value.boneMatrices, &bone_matrices_lengths);

        // vao_id

        const term_vao_id_value = UInt.make(env, value.vaoId);

        // vbo_id

        const vbo_id_lengths = [_]usize{Self.MAX_VERTEX_BUFFERS};
        const term_vbo_id_value = Array.make_c(UInt, c_uint, env, value.vboId, &vbo_id_lengths);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_vertex_count_value,
            term_triangle_count_value,
            term_vertices_value,
            term_texcoords_value,
            term_texcoords2_value,
            term_normals_value,
            term_tangents_value,
            term_colors_value,
            term_indices_value,
            term_anim_vertices_value,
            term_anim_normals_value,
            term_bone_ids_value,
            term_bone_weights_value,
            term_bone_matrices_value,
            term_bone_count_value,
            term_vao_id_value,
            term_vbo_id_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Mesh {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 18) {
            return error.ArgumentError;
        }

        const term_vertex_count_value = record[1];
        const term_triangle_count_value = record[2];
        const term_vertices_value = record[3];
        const term_texcoords_value = record[4];
        const term_texcoords2_value = record[5];
        const term_normals_value = record[6];
        const term_tangents_value = record[7];
        const term_colors_value = record[8];
        const term_indices_value = record[9];
        const term_anim_vertices_value = record[10];
        const term_anim_normals_value = record[11];
        const term_bone_ids_value = record[12];
        const term_bone_weights_value = record[13];
        const term_bone_matrices_value = record[14];
        const term_bone_count_value = record[15];
        const term_vao_id_value = record[16];
        const term_vbo_id_value = record[17];

        var value = rl.Mesh{};

        // vertex_count

        value.vertexCount = try Int.get(env, term_vertex_count_value);

        // triangle_count

        value.triangleCount = try Int.get(env, term_triangle_count_value);

        // vertices
        // = vertex_count * 3

        const vertices_lengths = [_]usize{@intCast(value.vertexCount * 3)};
        value.vertices = try Array.get_c(Float, f32, Self.allocator, env, term_vertices_value, &vertices_lengths);
        errdefer Array.free_c(Float, f32, Self.allocator, value.vertices, &vertices_lengths, null);

        // texcoords
        // = vertex_count * 2

        const texcoords_lengths = [_]usize{@intCast(value.vertexCount * 2)};
        value.texcoords = try Array.get_c(Float, f32, Self.allocator, env, term_texcoords_value, &texcoords_lengths);
        errdefer Array.free_c(Float, f32, Self.allocator, value.texcoords, &texcoords_lengths, null);

        // texcoords2
        // = vertex_count * 2

        const texcoords2_lengths = [_]usize{@intCast(value.vertexCount * 2)};
        value.texcoords2 = try Array.get_c(Float, f32, Self.allocator, env, term_texcoords2_value, &texcoords2_lengths);
        errdefer Array.free_c(Float, f32, Self.allocator, value.texcoords2, &texcoords2_lengths, null);

        // normals
        // = vertex_count * 3

        const normals_lengths = [_]usize{@intCast(value.vertexCount * 3)};
        value.normals = try Array.get_c(Float, f32, Self.allocator, env, term_normals_value, &normals_lengths);
        errdefer Array.free_c(Float, f32, Self.allocator, value.normals, &normals_lengths, null);

        // tangents
        // = vertex_count * 4

        const tangents_lengths = [_]usize{@intCast(value.vertexCount * 4)};
        value.tangents = try Array.get_c(Float, f32, Self.allocator, env, term_tangents_value, &tangents_lengths);
        errdefer Array.free_c(Float, f32, Self.allocator, value.tangents, &tangents_lengths, null);

        // colors
        // = vertex_count * 4

        const colors_lengths = [_]usize{@intCast(value.vertexCount * 4)};
        value.colors = try Array.get_c(Char, u8, Self.allocator, env, term_colors_value, &colors_lengths);
        errdefer Array.free_c(Char, u8, Self.allocator, value.colors, &colors_lengths, null);

        // indices
        // = triangle_count * 3

        const indices_lengths = [_]usize{@intCast(value.triangleCount * 3)};
        value.indices = try Array.get_c(UShort, c_ushort, Self.allocator, env, term_indices_value, &indices_lengths);
        errdefer Array.free_c(UShort, c_ushort, Self.allocator, value.indices, &indices_lengths, null);

        // anim_vertices
        // = vertex_count * 3

        const anim_vertices_lengths = [_]usize{@intCast(value.vertexCount * 3)};
        value.animVertices = try Array.get_c(Float, f32, Self.allocator, env, term_anim_vertices_value, &anim_vertices_lengths);
        errdefer Array.free_c(Float, f32, Self.allocator, value.animVertices, &anim_vertices_lengths, null);

        // anim_normals
        // = vertex_count * 3

        const anim_normals_lengths = [_]usize{@intCast(value.vertexCount * 3)};
        value.animNormals = try Array.get_c(Float, f32, Self.allocator, env, term_anim_normals_value, &anim_normals_lengths);
        errdefer Array.free_c(Float, f32, Self.allocator, value.animNormals, &anim_normals_lengths, null);

        // bone_ids
        // = vertex_count * 4

        const bone_ids_lengths = [_]usize{@intCast(value.vertexCount * 4)};
        value.boneIds = try Array.get_c(Char, u8, Self.allocator, env, term_bone_ids_value, &bone_ids_lengths);
        errdefer Array.free_c(Char, u8, Self.allocator, value.boneIds, &bone_ids_lengths, null);

        // bone_weights
        // = vertex_count * 4

        const bone_weights_lengths = [_]usize{@intCast(value.vertexCount * 4)};
        value.boneWeights = try Array.get_c(Float, f32, Self.allocator, env, term_bone_weights_value, &bone_weights_lengths);
        errdefer Array.free_c(Float, f32, Self.allocator, value.boneWeights, &bone_weights_lengths, null);

        // bone_count

        value.boneCount = try Int.get(env, term_bone_count_value);

        // bone_matrices
        // = bone_count

        const bone_matrices_lengths = [_]usize{@intCast(value.boneCount)};
        var bone_matrices = try ArgumentArrayC(Matrix, Matrix.data_type, Self.allocator).get(env, term_bone_matrices_value, &bone_matrices_lengths);
        defer bone_matrices.free_keep();
        errdefer bone_matrices.free();
        value.boneMatrices = bone_matrices.data;

        // vao_id

        value.vaoId = try UInt.get(env, term_vao_id_value);

        // vbo_id

        const vbo_id_lengths = [_]usize{Self.MAX_VERTEX_BUFFERS};
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
        // id

        const term_id_value = UInt.make(env, value.id);

        // locs

        const locs_lengths = [_]usize{Self.MAX_LOCATIONS};
        const term_locs_value = Array.make_c(Int, c_int, env, value.locs, &locs_lengths);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_id_value,
            term_locs_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Shader {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 3) {
            return error.ArgumentError;
        }

        const term_id_value = record[1];
        const term_locs_value = record[2];

        var value = rl.Shader{};

        // id

        value.id = try UInt.get(env, term_id_value);

        // locs

        const locs_lengths = [_]usize{Self.MAX_LOCATIONS};
        value.locs = try Array.get_c(Int, c_int, Self.allocator, env, term_locs_value, &locs_lengths);
        errdefer Array.free_c(Int, c_int, Self.allocator, value.locs, &locs_lengths, null);

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
        // texture

        const term_texture_value = Texture2D.make(env, value.texture);

        // color

        const term_color_value = Color.make(env, value.color);

        // value

        const term_value_value = Float.make(env, value.value);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_texture_value,
            term_color_value,
            term_value_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.MaterialMap {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 4) {
            return error.ArgumentError;
        }

        const term_texture_value = record[1];
        const term_color_value = record[2];
        const term_value_value = record[3];

        var value = rl.MaterialMap{};

        // texture

        const texture = try Argument(Texture2D).get(env, term_texture_value);
        errdefer texture.free();
        value.texture = texture.data;

        // color

        const color = try Argument(Color).get(env, term_color_value);
        errdefer color.free();
        value.color = color.data;

        // value

        value.value = try Float.get(env, term_value_value);

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
        // shader

        const term_shader_value = Shader.make(env, value.shader);

        // maps

        const maps_lengths = [_]usize{Self.MAX_MAPS};
        const term_maps_value = Array.make_c(MaterialMap, rl.MaterialMap, env, value.maps, &maps_lengths);

        // params

        const term_params_value = Array.make(Float, f32, env, &value.params);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_shader_value,
            term_maps_value,
            term_params_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Material {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 4) {
            return error.ArgumentError;
        }

        const term_shader_value = record[1];
        const term_maps_value = record[2];
        const term_params_value = record[3];

        var value = rl.Material{};

        // shader

        const shader = try Argument(Shader).get(env, term_shader_value);
        errdefer shader.free();
        value.shader = shader.data;

        // maps

        const maps_lengths = [_]usize{Self.MAX_MAPS};
        var maps = try ArgumentArrayC(MaterialMap, MaterialMap.data_type, Self.allocator).get(env, term_maps_value, &maps_lengths);
        defer maps.free_keep();
        errdefer maps.free();
        value.maps = maps.data;

        // params

        try Array.get_copy(Float, f32, Self.allocator, env, term_params_value, &value.params);
        errdefer Array.free_copy(Float, f32, Self.allocator, &value.params, null);

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
            for (0..Self.MAX_MAPS) |i| {
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
        // translation

        const term_translation_value = Vector3.make(env, value.translation);

        // rotation

        const term_rotation_value = Quaternion.make(env, value.rotation);

        // scale

        const term_scale_value = Vector3.make(env, value.scale);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_translation_value,
            term_rotation_value,
            term_scale_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Transform {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 4) {
            return error.ArgumentError;
        }

        const term_translation_value = record[1];
        const term_rotation_value = record[2];
        const term_scale_value = record[3];

        var value = rl.Transform{};

        // translation

        const translation = try Argument(Vector3).get(env, term_translation_value);
        errdefer translation.free();
        value.translation = translation.data;

        // rotation

        const rotation = try Argument(Quaternion).get(env, term_rotation_value);
        errdefer rotation.free();
        value.rotation = rotation.data;

        // scale

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
        // name

        const term_name_value = CString.make(env, &value.name);

        // parent

        const term_parent_value = Int.make(env, value.parent);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_name_value,
            term_parent_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.BoneInfo {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 3) {
            return error.ArgumentError;
        }

        const term_name_value = record[1];
        const term_parent_value = record[2];

        var value = rl.BoneInfo{};

        // name

        try CString.get_copy(env, term_name_value, &value.name);

        // parent

        value.parent = try Int.get(env, term_parent_value);

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
        // transform

        const term_transform_value = Matrix.make(env, value.transform);

        // mesh_count

        const term_mesh_count_value = Int.make(env, value.meshCount);

        // material_count

        const term_material_count_value = Int.make(env, value.materialCount);

        // meshes
        // = mesh_count

        const meshes_lengths = [_]usize{@intCast(value.meshCount)};
        const term_meshes_value = Array.make_c(Mesh, rl.Mesh, env, value.meshes, &meshes_lengths);

        // materials
        // = material_count

        const materials_lengths = [_]usize{@intCast(value.materialCount)};
        const term_materials_value = Array.make_c(Material, rl.Material, env, value.materials, &materials_lengths);

        // mesh_material
        // = mesh_count

        const mesh_material_lengths = [_]usize{@intCast(value.meshCount)};
        const term_mesh_material_value = Array.make_c(Int, c_int, env, value.meshMaterial, &mesh_material_lengths);

        // bone_count

        const term_bone_count_value = Int.make(env, value.boneCount);

        // bones
        // = bone_count

        const bones_lengths = [_]usize{@intCast(value.boneCount)};
        const term_bones_value = Array.make_c(BoneInfo, rl.BoneInfo, env, value.bones, &bones_lengths);

        // bind_pose
        // = bone_count

        const bind_pose_lengths = [_]usize{@intCast(value.boneCount)};
        const term_bind_pose_value = Array.make_c(Transform, rl.Transform, env, value.bindPose, &bind_pose_lengths);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_transform_value,
            term_mesh_count_value,
            term_material_count_value,
            term_meshes_value,
            term_materials_value,
            term_mesh_material_value,
            term_bone_count_value,
            term_bones_value,
            term_bind_pose_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Model {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 10) {
            return error.ArgumentError;
        }

        const term_transform_value = record[1];
        const term_mesh_count_value = record[2];
        const term_material_count_value = record[3];
        const term_meshes_value = record[4];
        const term_materials_value = record[5];
        const term_mesh_material_value = record[6];
        const term_bone_count_value = record[7];
        const term_bones_value = record[8];
        const term_bind_pose_value = record[9];

        var value = rl.Model{};

        // transform

        const transform = try Argument(Matrix).get(env, term_transform_value);
        errdefer transform.free();
        value.transform = transform.data;

        // mesh_count

        value.meshCount = try Int.get(env, term_mesh_count_value);

        // material_count

        value.materialCount = try Int.get(env, term_material_count_value);

        // meshes
        // = mesh_count

        const meshes_lengths = [_]usize{@intCast(value.meshCount)};
        var meshes = try ArgumentArrayC(Mesh, Mesh.data_type, Self.allocator).get(env, term_meshes_value, &meshes_lengths);
        defer meshes.free_keep();
        errdefer meshes.free();
        value.meshes = meshes.data;

        // materials
        // = material_count

        const materials_lengths = [_]usize{@intCast(value.materialCount)};
        var materials = try ArgumentArrayC(Material, Material.data_type, Self.allocator).get(env, term_materials_value, &materials_lengths);
        defer materials.free_keep();
        errdefer materials.free();
        value.materials = materials.data;

        // mesh_material
        // = mesh_count

        const mesh_material_lengths = [_]usize{@intCast(value.meshCount)};
        value.meshMaterial = try Array.get_c(Int, c_int, Self.allocator, env, term_mesh_material_value, &mesh_material_lengths);
        errdefer Array.free_c(Int, c_int, Self.allocator, value.meshMaterial, &mesh_material_lengths, null);

        // bone_count

        value.boneCount = try Int.get(env, term_bone_count_value);

        // bones
        // = bone_count

        const bones_lengths = [_]usize{@intCast(value.boneCount)};
        var bones = try ArgumentArrayC(BoneInfo, BoneInfo.data_type, Self.allocator).get(env, term_bones_value, &bones_lengths);
        defer bones.free_keep();
        errdefer bones.free();
        value.bones = bones.data;

        // bind_pose
        // = bone_count

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

        utils.TRACELOG(rl.LOG_INFO, "MODEL: Unloaded model (and meshes) from RAM and VRAM", .{});
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
        // bone_count

        const term_bone_count_value = Int.make(env, value.boneCount);

        // frame_count

        const term_frame_count_value = Int.make(env, value.frameCount);

        // bones
        // = bone_count

        const bones_lengths = [_]usize{@intCast(value.boneCount)};
        const term_bones_value = Array.make_c(BoneInfo, rl.BoneInfo, env, value.bones, &bones_lengths);

        // frame_poses
        // = frame_count , bone_count

        const frame_poses_lengths = [_]usize{ @intCast(value.frameCount), @intCast(value.boneCount) };
        const term_frame_poses_value = Array.make_c(Transform, [*c]rl.Transform, env, value.framePoses, &frame_poses_lengths);

        // name

        const term_name_value = CString.make(env, &value.name);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_bone_count_value,
            term_frame_count_value,
            term_bones_value,
            term_frame_poses_value,
            term_name_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.ModelAnimation {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 6) {
            return error.ArgumentError;
        }

        const term_bone_count_value = record[1];
        const term_frame_count_value = record[2];
        const term_bones_value = record[3];
        const term_frame_poses_value = record[4];
        const term_name_value = record[5];

        var value = rl.ModelAnimation{};

        // bone_count

        value.boneCount = try Int.get(env, term_bone_count_value);

        // frame_count

        value.frameCount = try Int.get(env, term_frame_count_value);

        // bones
        // = bone_count

        const bones_lengths = [_]usize{@intCast(value.boneCount)};
        var bones = try ArgumentArrayC(BoneInfo, BoneInfo.data_type, Self.allocator).get(env, term_bones_value, &bones_lengths);
        defer bones.free_keep();
        errdefer bones.free();
        value.bones = bones.data;

        // frame_poses
        // = frame_count , bone_count

        const frame_poses_lengths = [_]usize{ @intCast(value.frameCount), @intCast(value.boneCount) };
        var frame_poses = try ArgumentArrayC(Transform, [*c]Transform.data_type, Self.allocator).get(env, term_frame_poses_value, &frame_poses_lengths);
        defer frame_poses.free_keep();
        errdefer frame_poses.free();
        value.framePoses = frame_poses.data;

        // name

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
        // position

        const term_position_value = Vector3.make(env, value.position);

        // direction

        const term_direction_value = Vector3.make(env, value.direction);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_position_value,
            term_direction_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Ray {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 3) {
            return error.ArgumentError;
        }

        const term_position_value = record[1];
        const term_direction_value = record[2];

        var value = rl.Ray{};

        // position

        const position = try Argument(Vector3).get(env, term_position_value);
        errdefer position.free();
        value.position = position.data;

        // direction

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
        // hit

        const term_hit_value = Boolean.make(env, value.hit);

        // distance

        const term_distance_value = Float.make(env, value.distance);

        // point

        const term_point_value = Vector3.make(env, value.point);

        // normal

        const term_normal_value = Vector3.make(env, value.normal);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_hit_value,
            term_distance_value,
            term_point_value,
            term_normal_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.RayCollision {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 5) {
            return error.ArgumentError;
        }

        const term_hit_value = record[1];
        const term_distance_value = record[2];
        const term_point_value = record[3];
        const term_normal_value = record[4];

        var value = rl.RayCollision{};

        // hit

        value.hit = try Boolean.get(env, term_hit_value);

        // distance

        value.distance = try Float.get(env, term_distance_value);

        // point

        const point = try Argument(Vector3).get(env, term_point_value);
        errdefer point.free();
        value.point = point.data;

        // normal

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
        // min

        const term_min_value = Vector3.make(env, value.min);

        // max

        const term_max_value = Vector3.make(env, value.max);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_min_value,
            term_max_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.BoundingBox {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 3) {
            return error.ArgumentError;
        }

        const term_min_value = record[1];
        const term_max_value = record[2];

        var value = rl.BoundingBox{};

        // min

        const min = try Argument(Vector3).get(env, term_min_value);
        errdefer min.free();
        value.min = min.data;

        // max

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
        // frame_count

        const term_frame_count_value = UInt.make(env, value.frameCount);

        // sample_rate

        const term_sample_rate_value = UInt.make(env, value.sampleRate);

        // sample_size

        const term_sample_size_value = UInt.make(env, value.sampleSize);

        // channels

        const term_channels_value = UInt.make(env, value.channels);

        // data

        const data_size: usize = get_data_size(
            value.frameCount,
            value.channels,
            value.sampleSize,
        );

        const data_lengths = [_]usize{@intCast(value.frameCount * value.channels)};

        const term_data_value = switch (value.sampleSize) {
            8 => Array.make_c(Char, u8, env, @ptrCast(@alignCast(value.data)), &data_lengths),
            16 => Array.make_c(Short, c_short, env, @ptrCast(@alignCast(value.data)), &data_lengths),
            32 => Array.make_c(Float, f32, env, @ptrCast(@alignCast(value.data)), &data_lengths),
            else => Binary.make_c(env, @ptrCast(@alignCast(value.data)), data_size),
        };

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_frame_count_value,
            term_sample_rate_value,
            term_sample_size_value,
            term_channels_value,
            term_data_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Wave {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 6) {
            return error.ArgumentError;
        }

        const term_frame_count_value = record[1];
        const term_sample_rate_value = record[2];
        const term_sample_size_value = record[3];
        const term_channels_value = record[4];
        const term_data_value = record[5];

        var value = rl.Wave{};

        // frame_count

        value.frameCount = try UInt.get(env, term_frame_count_value);

        // sample_rate

        value.sampleRate = try UInt.get(env, term_sample_rate_value);

        // sample_size

        value.sampleSize = try UInt.get(env, term_sample_size_value);

        // channels

        value.channels = try UInt.get(env, term_channels_value);

        // data

        const data_size: usize = get_data_size(
            value.frameCount,
            value.channels,
            value.sampleSize,
        );

        const data_lengths = [_]usize{@intCast(value.frameCount * value.channels)};

        switch (value.sampleSize) {
            8 => {
                var data = try ArgumentArrayC(Char, u8, Self.allocator).get(env, term_data_value, &data_lengths);
                errdefer data.free();
                value.data = @ptrCast(data.data);
            },
            16 => {
                var data = try ArgumentArrayC(Short, c_short, Self.allocator).get(env, term_data_value, &data_lengths);
                errdefer data.free();
                value.data = @ptrCast(data.data);
            },
            32 => {
                var data = try ArgumentArrayC(Float, f32, Self.allocator).get(env, term_data_value, &data_lengths);
                errdefer data.free();
                value.data = @ptrCast(data.data);
            },
            else => {
                const data = try ArgumentBinaryC(Binary, Self.allocator).get(env, term_data_value, data_size);
                errdefer data.free();
                value.data = @ptrCast(data.data);
            },
        }

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

/////////////////
//  AudioInfo  //
/////////////////

pub const AudioInfo = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.AudioInfo;
    pub const resource_name = "audio_info";

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.AudioInfo) e.ErlNifTerm {
        // frame_count

        const term_frame_count_value = UInt.make(env, value.frameCount);

        // sample_rate

        const term_sample_rate_value = UInt.make(env, value.sampleRate);

        // sample_size

        const term_sample_size_value = UInt.make(env, value.sampleSize);

        // channels

        const term_channels_value = UInt.make(env, value.channels);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_frame_count_value,
            term_sample_rate_value,
            term_sample_size_value,
            term_channels_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.AudioInfo {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 5) {
            return error.ArgumentError;
        }

        const term_frame_count_value = record[1];
        const term_sample_rate_value = record[2];
        const term_sample_size_value = record[3];
        const term_channels_value = record[4];

        var value = rl.AudioInfo{};

        // frame_count

        value.frameCount = try UInt.get(env, term_frame_count_value);

        // sample_rate

        value.sampleRate = try UInt.get(env, term_sample_rate_value);

        // sample_size

        value.sampleSize = try UInt.get(env, term_sample_size_value);

        // channels

        value.channels = try UInt.get(env, term_channels_value);

        return value;
    }

    pub fn unload(value: rl.AudioInfo) void {
        _ = value;
    }

    pub fn free(value: rl.AudioInfo) void {
        _ = value;
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
        // buffer

        const term_buffer_value = AudioBuffer.make(env, value.buffer);

        // processor

        const term_processor_value = AudioProcessor.make(env, value.processor);

        // sample_rate

        const term_sample_rate_value = UInt.make(env, value.sampleRate);

        // sample_size

        const term_sample_size_value = UInt.make(env, value.sampleSize);

        // channels

        const term_channels_value = UInt.make(env, value.channels);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_buffer_value,
            term_processor_value,
            term_sample_rate_value,
            term_sample_size_value,
            term_channels_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.AudioStream {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 6) {
            return error.ArgumentError;
        }

        const term_buffer_value = record[1];
        const term_processor_value = record[2];
        const term_sample_rate_value = record[3];
        const term_sample_size_value = record[4];
        const term_channels_value = record[5];

        var value = rl.AudioStream{};

        // buffer

        value.buffer = try AudioBuffer.get(env, term_buffer_value);
        errdefer AudioBuffer.free(value.buffer);

        // processor

        value.processor = try AudioProcessor.get(env, term_processor_value);
        errdefer AudioProcessor.free(value.processor);

        // sample_rate

        value.sampleRate = try UInt.get(env, term_sample_rate_value);

        // sample_size

        value.sampleSize = try UInt.get(env, term_sample_size_value);

        // channels

        value.channels = try UInt.get(env, term_channels_value);

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
    pub const resource_type_aliases = [_]resources.ResourceTypeKey{resources.ResourceTypeKey.sound_alias};

    pub const Resource = ResourceBase(Self);

    pub fn make(env: ?*e.ErlNifEnv, value: rl.Sound) e.ErlNifTerm {
        // stream

        const term_stream_value = AudioStream.make(env, value.stream);

        // frame_count

        const term_frame_count_value = UInt.make(env, value.frameCount);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_stream_value,
            term_frame_count_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Sound {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 3) {
            return error.ArgumentError;
        }

        const term_stream_value = record[1];
        const term_frame_count_value = record[2];

        var value = rl.Sound{};

        // stream

        const stream = try Argument(AudioStream).get(env, term_stream_value);
        errdefer stream.free();
        value.stream = stream.data;

        // frame_count

        value.frameCount = try UInt.get(env, term_frame_count_value);

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
        // stream

        const term_stream_value = AudioStream.make(env, value.stream);

        // frame_count

        const term_frame_count_value = UInt.make(env, value.frameCount);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_stream_value,
            term_frame_count_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Sound {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 3) {
            return error.ArgumentError;
        }

        const term_stream_value = record[1];
        const term_frame_count_value = record[2];

        var value = rl.Sound{};

        // stream

        const stream = try Argument(AudioStream).get(env, term_stream_value);
        errdefer stream.free();
        value.stream = stream.data;

        // frame_count

        value.frameCount = try UInt.get(env, term_frame_count_value);

        return value;
    }

    pub fn unload(value: rl.Sound) void {
        rl.UnloadSoundAlias(value);
    }

    pub fn free(value: rl.Sound) void {
        AudioStream.free(value.stream);
    }
};

///////////////////
//  SoundStream  //
///////////////////

pub const SoundStream = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.SoundStream;
    pub const resource_name = "sound_stream";
    pub const resource_type_aliases = [_]resources.ResourceTypeKey{resources.ResourceTypeKey.sound_stream_alias};

    pub const Resource = ResourceBase(Self);

    pub const MAX_POSITION_STATE: usize = get_field_array_length(rl.SoundStream, "position_state");

    pub fn make(env: ?*e.ErlNifEnv, value: rl.SoundStream) e.ErlNifTerm {
        // stream

        const term_stream_value = AudioStream.make(env, value.stream);

        // frame_count

        const term_frame_count_value = UInt.make(env, value.frameCount);

        // looping

        const term_looping_value = Boolean.make(env, value.looping);

        // position

        const term_position_value = if (value.position == null) Atom.make(env, "nil") else Vector3.make(env, value.position.?);

        // position_state

        const term_position_state_value = Array.make(Float, f32, env, &value.position_state);

        // data

        const data_size: usize = get_data_size(
            value.frameCount,
            value.stream.channels,
            value.stream.sampleSize,
        );

        const data_lengths = [_]usize{@intCast(value.frameCount * value.stream.channels)};

        const term_data_value = switch (value.stream.sampleSize) {
            8 => Array.make_c(Char, u8, env, @ptrCast(@alignCast(value.data)), &data_lengths),
            16 => Array.make_c(Short, c_short, env, @ptrCast(@alignCast(value.data)), &data_lengths),
            32 => Array.make_c(Float, f32, env, @ptrCast(@alignCast(value.data)), &data_lengths),
            else => Binary.make_c(env, @ptrCast(@alignCast(value.data)), data_size),
        };

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_stream_value,
            term_frame_count_value,
            term_looping_value,
            term_position_value,
            term_position_state_value,
            term_data_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.SoundStream {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 7) {
            return error.ArgumentError;
        }

        const term_stream_value = record[1];
        const term_frame_count_value = record[2];
        const term_looping_value = record[3];
        const term_position_value = record[4];
        const term_position_state_value = record[5];
        const term_data_value = record[6];

        var value = rl.SoundStream{};

        // stream

        const stream = try Argument(AudioStream).get(env, term_stream_value);
        errdefer stream.free();
        value.stream = stream.data;

        // frame_count

        value.frameCount = try UInt.get(env, term_frame_count_value);

        // looping

        value.looping = try Boolean.get(env, term_looping_value);

        // position

        const is_position_nil = e.enif_is_identical(Atom.make(env, "nil"), term_position_value) != 0;

        if (is_position_nil) {
            value.position = null;
        } else {
            const position = try Argument(Vector3).get(env, term_position_value);
            errdefer position.free();
            value.position = position.data;
        }

        // position_state

        try Array.get_copy(Float, f32, Self.allocator, env, term_position_state_value, &value.position_state);
        errdefer Array.free_copy(Float, f32, Self.allocator, &value.position_state, null);

        // data

        const data_size: usize = get_data_size(
            value.frameCount,
            value.stream.channels,
            value.stream.sampleSize,
        );

        const data_lengths = [_]usize{@intCast(value.frameCount * value.stream.channels)};

        switch (value.stream.sampleSize) {
            8 => {
                var data = try ArgumentArrayC(Char, u8, Self.allocator).get(env, term_data_value, &data_lengths);
                errdefer data.free();
                value.data = @ptrCast(data.data);
            },
            16 => {
                var data = try ArgumentArrayC(Short, c_short, Self.allocator).get(env, term_data_value, &data_lengths);
                errdefer data.free();
                value.data = @ptrCast(data.data);
            },
            32 => {
                var data = try ArgumentArrayC(Float, f32, Self.allocator).get(env, term_data_value, &data_lengths);
                errdefer data.free();
                value.data = @ptrCast(data.data);
            },
            else => {
                const data = try ArgumentBinaryC(Binary, Self.allocator).get(env, term_data_value, data_size);
                errdefer data.free();
                value.data = @ptrCast(data.data);
            },
        }

        return value;
    }

    pub fn unload(value: rl.SoundStream) void {
        rl.UnloadSoundStream(value);
    }

    pub fn free(value: rl.SoundStream) void {
        AudioStream.free(value.stream);
        rl.MemFree(value.data);
    }

    pub fn get_data_size(frame_count: c_uint, channels: c_uint, sample_size: c_uint) usize {
        const sample_size_bytes: c_uint = @intFromFloat(@ceil(@as(f64, @floatFromInt(sample_size)) / 8));
        return @intCast(frame_count * channels * sample_size_bytes);
    }
};

////////////////////////
//  SoundStreamAlias  //
////////////////////////

pub const SoundStreamAlias = struct {
    const Self = @This();

    pub const allocator = rl.allocator;
    pub const data_type = rl.SoundStream;
    pub const resource_name = "sound_stream_alias";

    pub const Resource = ResourceBase(Self);

    pub const MAX_POSITION_STATE: usize = get_field_array_length(rl.SoundStream, "position_state");

    pub fn make(env: ?*e.ErlNifEnv, value: rl.SoundStream) e.ErlNifTerm {
        // stream

        const term_stream_value = AudioStream.make(env, value.stream);

        // frame_count

        const term_frame_count_value = UInt.make(env, value.frameCount);

        // looping

        const term_looping_value = Boolean.make(env, value.looping);

        // position

        const term_position_value = if (value.position == null) Atom.make(env, "nil") else Vector3.make(env, value.position.?);

        // position_state

        const term_position_state_value = Array.make(Float, f32, env, &value.position_state);

        // data

        const data_size: usize = get_data_size(
            value.frameCount,
            value.stream.channels,
            value.stream.sampleSize,
        );

        const data_lengths = [_]usize{@intCast(value.frameCount * value.stream.channels)};

        const term_data_value = switch (value.stream.sampleSize) {
            8 => Array.make_c(Char, u8, env, @ptrCast(@alignCast(value.data)), &data_lengths),
            16 => Array.make_c(Short, c_short, env, @ptrCast(@alignCast(value.data)), &data_lengths),
            32 => Array.make_c(Float, f32, env, @ptrCast(@alignCast(value.data)), &data_lengths),
            else => Binary.make_c(env, @ptrCast(@alignCast(value.data)), data_size),
        };

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_stream_value,
            term_frame_count_value,
            term_looping_value,
            term_position_value,
            term_position_state_value,
            term_data_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.SoundStream {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 7) {
            return error.ArgumentError;
        }

        const term_stream_value = record[1];
        const term_frame_count_value = record[2];
        const term_looping_value = record[3];
        const term_position_value = record[4];
        const term_position_state_value = record[5];
        const term_data_value = record[6];

        var value = rl.SoundStream{};

        // stream

        const stream = try Argument(AudioStream).get(env, term_stream_value);
        errdefer stream.free();
        value.stream = stream.data;

        // frame_count

        value.frameCount = try UInt.get(env, term_frame_count_value);

        // looping

        value.looping = try Boolean.get(env, term_looping_value);

        // position

        const is_position_nil = e.enif_is_identical(Atom.make(env, "nil"), term_position_value) != 0;

        if (is_position_nil) {
            value.position = null;
        } else {
            const position = try Argument(Vector3).get(env, term_position_value);
            errdefer position.free();
            value.position = position.data;
        }

        // position_state

        try Array.get_copy(Float, f32, Self.allocator, env, term_position_state_value, &value.position_state);
        errdefer Array.free_copy(Float, f32, Self.allocator, &value.position_state, null);

        // data

        const data_size: usize = get_data_size(
            value.frameCount,
            value.stream.channels,
            value.stream.sampleSize,
        );

        const data_lengths = [_]usize{@intCast(value.frameCount * value.stream.channels)};

        switch (value.stream.sampleSize) {
            8 => {
                var data = try ArgumentArrayC(Char, u8, Self.allocator).get(env, term_data_value, &data_lengths);
                errdefer data.free();
                value.data = @ptrCast(data.data);
            },
            16 => {
                var data = try ArgumentArrayC(Short, c_short, Self.allocator).get(env, term_data_value, &data_lengths);
                errdefer data.free();
                value.data = @ptrCast(data.data);
            },
            32 => {
                var data = try ArgumentArrayC(Float, f32, Self.allocator).get(env, term_data_value, &data_lengths);
                errdefer data.free();
                value.data = @ptrCast(data.data);
            },
            else => {
                const data = try ArgumentBinaryC(Binary, Self.allocator).get(env, term_data_value, data_size);
                errdefer data.free();
                value.data = @ptrCast(data.data);
            },
        }

        return value;
    }

    pub fn unload(value: rl.SoundStream) void {
        rl.UnloadSoundStreamAlias(value);
    }

    pub fn free(value: rl.SoundStream) void {
        AudioStream.free(value.stream);
        rl.MemFree(value.data);
    }

    pub fn get_data_size(frame_count: c_uint, channels: c_uint, sample_size: c_uint) usize {
        const sample_size_bytes: c_uint = @intFromFloat(@ceil(@as(f64, @floatFromInt(sample_size)) / 8));
        return @intCast(frame_count * channels * sample_size_bytes);
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
        // stream

        const term_stream_value = AudioStream.make(env, value.stream);

        // frame_count

        const term_frame_count_value = UInt.make(env, value.frameCount);

        // looping

        const term_looping_value = Boolean.make(env, value.looping);

        // ctx_type

        const term_ctx_type_value = Int.make(env, value.ctxType);

        // ctx_data

        const term_ctx_data_value = MusicContextData.make(env, value.ctxData);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_stream_value,
            term_frame_count_value,
            term_looping_value,
            term_ctx_type_value,
            term_ctx_data_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.Music {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 6) {
            return error.ArgumentError;
        }

        const term_stream_value = record[1];
        const term_frame_count_value = record[2];
        const term_looping_value = record[3];
        const term_ctx_type_value = record[4];
        const term_ctx_data_value = record[5];

        var value = rl.Music{};

        // stream

        const stream = try Argument(AudioStream).get(env, term_stream_value);
        errdefer stream.free();
        value.stream = stream.data;

        // frame_count

        value.frameCount = try UInt.get(env, term_frame_count_value);

        // looping

        value.looping = try Boolean.get(env, term_looping_value);

        // ctx_type

        value.ctxType = try Int.get(env, term_ctx_type_value);

        // ctx_data

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
        // h_resolution

        const term_h_resolution_value = Int.make(env, value.hResolution);

        // v_resolution

        const term_v_resolution_value = Int.make(env, value.vResolution);

        // h_screen_size

        const term_h_screen_size_value = Float.make(env, value.hScreenSize);

        // v_screen_size

        const term_v_screen_size_value = Float.make(env, value.vScreenSize);

        // eye_to_screen_distance

        const term_eye_to_screen_distance_value = Float.make(env, value.eyeToScreenDistance);

        // lens_separation_distance

        const term_lens_separation_distance_value = Float.make(env, value.lensSeparationDistance);

        // interpupillary_distance

        const term_interpupillary_distance_value = Float.make(env, value.interpupillaryDistance);

        // lens_distortion_values

        const term_lens_distortion_values_value = Array.make(Float, f32, env, &value.lensDistortionValues);

        // chroma_ab_correction

        const term_chroma_ab_correction_value = Array.make(Float, f32, env, &value.chromaAbCorrection);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_h_resolution_value,
            term_v_resolution_value,
            term_h_screen_size_value,
            term_v_screen_size_value,
            term_eye_to_screen_distance_value,
            term_lens_separation_distance_value,
            term_interpupillary_distance_value,
            term_lens_distortion_values_value,
            term_chroma_ab_correction_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.VrDeviceInfo {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 10) {
            return error.ArgumentError;
        }

        const term_h_resolution_value = record[1];
        const term_v_resolution_value = record[2];
        const term_h_screen_size_value = record[3];
        const term_v_screen_size_value = record[4];
        const term_eye_to_screen_distance_value = record[5];
        const term_lens_separation_distance_value = record[6];
        const term_interpupillary_distance_value = record[7];
        const term_lens_distortion_values_value = record[8];
        const term_chroma_ab_correction_value = record[9];

        var value = rl.VrDeviceInfo{};

        // h_resolution

        value.hResolution = try Int.get(env, term_h_resolution_value);

        // v_resolution

        value.vResolution = try Int.get(env, term_v_resolution_value);

        // h_screen_size

        value.hScreenSize = try Float.get(env, term_h_screen_size_value);

        // v_screen_size

        value.vScreenSize = try Float.get(env, term_v_screen_size_value);

        // eye_to_screen_distance

        value.eyeToScreenDistance = try Float.get(env, term_eye_to_screen_distance_value);

        // lens_separation_distance

        value.lensSeparationDistance = try Float.get(env, term_lens_separation_distance_value);

        // interpupillary_distance

        value.interpupillaryDistance = try Float.get(env, term_interpupillary_distance_value);

        // lens_distortion_values

        try Array.get_copy(Float, f32, Self.allocator, env, term_lens_distortion_values_value, &value.lensDistortionValues);
        errdefer Array.free_copy(Float, f32, Self.allocator, &value.lensDistortionValues, null);

        // chroma_ab_correction

        try Array.get_copy(Float, f32, Self.allocator, env, term_chroma_ab_correction_value, &value.chromaAbCorrection);
        errdefer Array.free_copy(Float, f32, Self.allocator, &value.chromaAbCorrection, null);

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
        // projection

        const term_projection_value = Array.make(Matrix, rl.Matrix, env, &value.projection);

        // view_offset

        const term_view_offset_value = Array.make(Matrix, rl.Matrix, env, &value.viewOffset);

        // left_lens_center

        const term_left_lens_center_value = Array.make(Float, f32, env, &value.leftLensCenter);

        // right_lens_center

        const term_right_lens_center_value = Array.make(Float, f32, env, &value.rightLensCenter);

        // left_screen_center

        const term_left_screen_center_value = Array.make(Float, f32, env, &value.leftScreenCenter);

        // right_screen_center

        const term_right_screen_center_value = Array.make(Float, f32, env, &value.rightScreenCenter);

        // scale

        const term_scale_value = Array.make(Float, f32, env, &value.scale);

        // scale_in

        const term_scale_in_value = Array.make(Float, f32, env, &value.scaleIn);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_projection_value,
            term_view_offset_value,
            term_left_lens_center_value,
            term_right_lens_center_value,
            term_left_screen_center_value,
            term_right_screen_center_value,
            term_scale_value,
            term_scale_in_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.VrStereoConfig {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 9) {
            return error.ArgumentError;
        }

        const term_projection_value = record[1];
        const term_view_offset_value = record[2];
        const term_left_lens_center_value = record[3];
        const term_right_lens_center_value = record[4];
        const term_left_screen_center_value = record[5];
        const term_right_screen_center_value = record[6];
        const term_scale_value = record[7];
        const term_scale_in_value = record[8];

        var value = rl.VrStereoConfig{};

        // projection

        var projection = try ArgumentArrayCopy(Matrix, Matrix.data_type, Self.allocator).get(env, term_projection_value, &value.projection);
        defer projection.free_keep();
        errdefer projection.free();

        // view_offset

        var view_offset = try ArgumentArrayCopy(Matrix, Matrix.data_type, Self.allocator).get(env, term_view_offset_value, &value.viewOffset);
        defer view_offset.free_keep();
        errdefer view_offset.free();

        // left_lens_center

        try Array.get_copy(Float, f32, Self.allocator, env, term_left_lens_center_value, &value.leftLensCenter);
        errdefer Array.free_copy(Float, f32, Self.allocator, &value.leftLensCenter, null);

        // right_lens_center

        try Array.get_copy(Float, f32, Self.allocator, env, term_right_lens_center_value, &value.rightLensCenter);
        errdefer Array.free_copy(Float, f32, Self.allocator, &value.rightLensCenter, null);

        // left_screen_center

        try Array.get_copy(Float, f32, Self.allocator, env, term_left_screen_center_value, &value.leftScreenCenter);
        errdefer Array.free_copy(Float, f32, Self.allocator, &value.leftScreenCenter, null);

        // right_screen_center

        try Array.get_copy(Float, f32, Self.allocator, env, term_right_screen_center_value, &value.rightScreenCenter);
        errdefer Array.free_copy(Float, f32, Self.allocator, &value.rightScreenCenter, null);

        // scale

        try Array.get_copy(Float, f32, Self.allocator, env, term_scale_value, &value.scale);
        errdefer Array.free_copy(Float, f32, Self.allocator, &value.scale, null);

        // scale_in

        try Array.get_copy(Float, f32, Self.allocator, env, term_scale_in_value, &value.scaleIn);
        errdefer Array.free_copy(Float, f32, Self.allocator, &value.scaleIn, null);

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
        // capacity

        const term_capacity_value = UInt.make(env, value.capacity);

        // count

        const term_count_value = UInt.make(env, value.count);

        // paths
        // = capacity , MAX_FILEPATH_LENGTH

        const paths_lengths = [_]usize{ @intCast(value.capacity), MAX_FILEPATH_LENGTH };
        const term_paths_value = Array.make_c(CString, [*c]u8, env, value.paths, &paths_lengths);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_capacity_value,
            term_count_value,
            term_paths_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.FilePathList {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 4) {
            return error.ArgumentError;
        }

        const term_capacity_value = record[1];
        const term_count_value = record[2];
        const term_paths_value = record[3];

        var value = rl.FilePathList{};

        // capacity

        value.capacity = try UInt.get(env, term_capacity_value);

        // count

        value.count = try UInt.get(env, term_count_value);

        // paths
        // = capacity , MAX_FILEPATH_LENGTH

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
        // frame

        const term_frame_value = UInt.make(env, value.frame);

        // type

        const term_type_value = UInt.make(env, value.type);

        // params

        const term_params_value = Array.make(Int, c_int, env, &value.params);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_frame_value,
            term_type_value,
            term_params_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.AutomationEvent {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 4) {
            return error.ArgumentError;
        }

        const term_frame_value = record[1];
        const term_type_value = record[2];
        const term_params_value = record[3];

        var value = rl.AutomationEvent{};

        // frame

        value.frame = try UInt.get(env, term_frame_value);

        // type

        value.type = try UInt.get(env, term_type_value);

        // params

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
        // capacity

        const term_capacity_value = UInt.make(env, value.capacity);

        // count

        const term_count_value = UInt.make(env, value.count);

        // events
        // = capacity

        const events_lengths = [_]usize{@intCast(value.capacity)};
        const term_events_value = Array.make_c(AutomationEvent, rl.AutomationEvent, env, value.events, &events_lengths);

        return Tuple.make(env, &[_]e.ErlNifTerm{
            Atom.make(env, Self.resource_name),
            term_capacity_value,
            term_count_value,
            term_events_value,
        });
    }

    pub fn get(env: ?*e.ErlNifEnv, term: e.ErlNifTerm) !rl.AutomationEventList {
        const record = try Tuple.get(env, term);

        if (record.len == 2) {
            return (try Self.Resource.get_record(env, record)).*.*;
        }

        if (record.len != 4) {
            return error.ArgumentError;
        }

        const term_capacity_value = record[1];
        const term_count_value = record[2];
        const term_events_value = record[3];

        var value = rl.AutomationEventList{};

        // capacity

        value.capacity = try UInt.get(env, term_capacity_value);

        // count

        value.count = try UInt.get(env, term_count_value);

        // events
        // = capacity

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
