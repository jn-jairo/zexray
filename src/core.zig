const std = @import("std");
const e = @import("./erl_nif.zig");

const types = @import("./types.zig");
pub usingnamespace types;

// pub fn make_ok_result(env: ?*e.ErlNifEnv, result: e.ErlNifTerm) e.ErlNifTerm {
//     return e.enif_make_tuple2(env, types.Atom.make(env, "ok"), result);
// }
//
// pub fn make_error_result(env: ?*e.ErlNifEnv, result: e.ErlNifTerm) e.ErlNifTerm {
//     return e.enif_make_tuple2(env, types.Atom.make(env, "error"), result);
// }
//
// pub fn make_error_atom_result(env: ?*e.ErlNifEnv, err: anyerror) e.ErlNifTerm {
//     return make_error_result(env, make_error_atom(env, err));
// }
//
// fn make_error_atom(env: ?*e.ErlNifEnv, err: anyerror) e.ErlNifTerm {
//     const error_name = @errorName(err);
//     var buf: [256]u8 = undefined;
//
//     var index: usize = 0;
//     for (error_name) |char| {
//         if (index > 256) unreachable;
//         if (std.ascii.isUpper(char)) {
//             if (index > 0) {
//                 buf[index] = '_';
//                 index += 1;
//             }
//             buf[index] = std.ascii.toLower(char);
//         } else {
//             buf[index] = char;
//         }
//         index += 1;
//     }
//
//     return types.Atom.make(env, buf[0..index]);
// }

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
