const std = @import("std");
const e = @import("./erl_nif.zig");

const types = @import("./types.zig");
pub usingnamespace types;

pub const ZigNifFuncType = fn (env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) anyerror!e.ErlNifTerm;
pub const NifFuncType = fn (env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm;

pub fn nif_wrapper(comptime func: ZigNifFuncType) NifFuncType {
    return struct {
        pub fn wrapped(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
            return func(env, argc, argv) catch |err| {
                const error_name: []const u8 = @errorName(err);

                var buf = std.ArrayList(u8).init(e.allocator);
                defer buf.deinit();
                const writer = buf.writer();

                const invalid_argument = "invalid_argument_";
                const invalid_return = "invalid_return";

                var new_err: anyerror = err;

                if (std.mem.startsWith(u8, error_name, invalid_argument)) {
                    writer.print("Invalid argument '{s}'.", .{error_name[(invalid_argument.len)..(error_name.len)]}) catch unreachable;
                    new_err = error.ArgumentError;
                } else if (std.mem.startsWith(u8, error_name, invalid_return)) {
                    writer.writeAll("Failed to get return value.") catch unreachable;
                    new_err = error.ArgumentError;
                } else {
                    return raise_exception(e.allocator, env, new_err, @errorReturnTrace(), null);
                }

                const msg: []const u8 = buf.items;

                return raise_exception(e.allocator, env, new_err, @errorReturnTrace(), msg);
            };
        }
    }.wrapped;
}

pub fn raise_exception(allocator: std.mem.Allocator, env: ?*e.ErlNifEnv, err: anyerror, stack_trace: ?*std.builtin.StackTrace, message: ?[]const u8) e.ErlNifTerm {
    var term = e.enif_make_new_map(env);

    const term_struct_key = types.Atom.make(env, "__struct__");
    const term_struct_value = types.Atom.make(env, get_error_module(err));
    if (e.enif_make_map_put(env, term, term_struct_key, term_struct_value, &term) == 0) unreachable;

    const term_exception_key = types.Atom.make(env, "__exception__");
    const term_exception_value = types.Atom.make(env, "true");
    if (e.enif_make_map_put(env, term, term_exception_key, term_exception_value, &term) == 0) unreachable;

    var buf = std.ArrayList(u8).init(allocator);
    defer buf.deinit();
    const writer = buf.writer();

    if (message) |msg| {
        writer.writeAll(msg) catch unreachable;
    } else {
        writer.writeAll(@errorName(err)) catch unreachable;
    }

    if (stack_trace) |trace| {
        const debug_info = std.debug.getSelfDebugInfo() catch null;
        if (debug_info) |info| {
            writer.writeAll("\n\n") catch unreachable;
            std.debug.writeStackTrace(trace.*, writer, info, std.io.tty.detectConfig(std.io.getStdErr())) catch unreachable;
        }
    }

    const term_message_key = types.Atom.make(env, "message");
    const term_message_value = types.Binary.make(env, buf.items);
    if (e.enif_make_map_put(env, term, term_message_key, term_message_value, &term) == 0) unreachable;

    return e.enif_raise_exception(env, term);
}

fn get_error_module(err: anyerror) []u8 {
    return @ptrCast(@constCast(switch (err) {
        error.OutOfMemory => "Elixir.Zexray.OutOfMemoryError",
        error.ArgumentError => "Elixir.ArgumentError",
        else => "Elixir.RuntimeError",
    }));
}

pub fn maybe_make_struct_as_resource(comptime T: type, env: ?*e.ErlNifEnv, value: T.data_type, return_resource: bool) !e.ErlNifTerm {
    if (return_resource) {
        const resource = try T.Resource.create(value);
        defer T.Resource.release(resource);
        return T.Resource.make(env, resource);
    } else {
        return T.make(env, value);
    }
}

pub fn maybe_make_resource_as_struct(comptime T: type, env: ?*e.ErlNifEnv, term: e.ErlNifTerm, return_resource: bool) !e.ErlNifTerm {
    if (return_resource) {
        return term;
    } else {
        const resource = try T.Resource.get(env, term);
        return T.make(env, resource.*.*);
    }
}

pub fn maybe_make_struct_or_resource(comptime T: type, env: ?*e.ErlNifEnv, term: e.ErlNifTerm, value: T.data_type, return_resource: bool) !e.ErlNifTerm {
    const term_is_resource: bool = types.is_term_resource(env, term);

    if (term_is_resource) {
        try T.Resource.update(env, term, value);
        return maybe_make_resource_as_struct(T, env, term, return_resource);
    } else {
        return maybe_make_struct_as_resource(T, env, value, return_resource);
    }
}

pub fn must_return_resource(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm, index: usize) bool {
    if (argc == index + 1) {
        return e.enif_is_identical(types.Atom.make(env, "resource"), argv[index]) != 0;
    }

    return false;
}
