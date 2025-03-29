const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // AutomationEvent
    .{ .name = "automation_event_get_max_params", .arity = 0, .fptr = nif_automation_event_get_max_params, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // AutomationEventList
    .{ .name = "automation_event_list_get_max_automation_events", .arity = 0, .fptr = nif_automation_event_list_get_max_automation_events, .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

///////////////////////
//  AutomationEvent  //
///////////////////////

/// Get automation event max params for AutomationEvent.params
fn nif_automation_event_get_max_params(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.AutomationEvent.MAX_PARAMS));
}

///////////////////////////
//  AutomationEventList  //
///////////////////////////

/// Get automation event list max automation events for AutomationEventList.events
fn nif_automation_event_list_get_max_automation_events(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.AutomationEventList.MAX_AUTOMATION_EVENTS));
}
