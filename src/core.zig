const std = @import("std");
const e = @import("./erl_nif.zig");

const types = @import("./types.zig");
pub usingnamespace types;

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
            std.debug.writeStackTrace(trace.*, writer, allocator, info, std.io.tty.detectConfig(std.io.getStdErr())) catch unreachable;
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

pub fn maybe_return_struct_as_resource(comptime T: type, comptime T_rl: type, allocator: std.mem.Allocator, env: ?*e.ErlNifEnv, value: T_rl, return_resource: bool) e.ErlNifTerm {
    if (return_resource) {
        const image_resource = T.Resource.create(value) catch |err| {
            return raise_exception(allocator, env, err, @errorReturnTrace(), "Failed to create resource for return value.");
        };
        defer T.Resource.release(image_resource);

        return T.Resource.make(env, image_resource);
    } else {
        return T.make(env, value);
    }
}

pub fn maybe_return_resource_as_struct(comptime T: type, allocator: std.mem.Allocator, env: ?*e.ErlNifEnv, term: e.ErlNifTerm, return_resource: bool) e.ErlNifTerm {
    if (return_resource) {
        return term;
    } else {
        const resource = T.Resource.get(env, term) catch |err| {
            return raise_exception(allocator, env, err, @errorReturnTrace(), "Failed to get resource for return value.");
        };

        return T.make(env, resource.*.*);
    }
}
