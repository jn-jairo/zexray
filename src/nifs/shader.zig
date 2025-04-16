const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");
const rlgl = @import("../rlgl.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Shader
    .{ .name = "shader_get_max_locations", .arity = 0, .fptr = core.nif_wrapper(nif_shader_get_max_locations), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_shader", .arity = 2, .fptr = core.nif_wrapper(nif_load_shader), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_shader", .arity = 3, .fptr = core.nif_wrapper(nif_load_shader), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_shader_from_memory", .arity = 2, .fptr = core.nif_wrapper(nif_load_shader_from_memory), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_shader_from_memory", .arity = 3, .fptr = core.nif_wrapper(nif_load_shader_from_memory), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_shader_valid", .arity = 1, .fptr = core.nif_wrapper(nif_is_shader_valid), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_shader_location", .arity = 2, .fptr = core.nif_wrapper(nif_get_shader_location), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_shader_location_attrib", .arity = 2, .fptr = core.nif_wrapper(nif_get_shader_location_attrib), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_shader_value", .arity = 4, .fptr = core.nif_wrapper(nif_set_shader_value), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_shader_value_v", .arity = 4, .fptr = core.nif_wrapper(nif_set_shader_value_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_shader_value_matrix", .arity = 3, .fptr = core.nif_wrapper(nif_set_shader_value_matrix), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_shader_value_texture", .arity = 3, .fptr = core.nif_wrapper(nif_set_shader_value_texture), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

//////////////
//  Shader  //
//////////////

/// Get shader max locations for Shader.locs
///
/// config.h
/// RL_MAX_SHADER_LOCATIONS
fn nif_shader_get_max_locations(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Return

    return core.UInt.make(env, @intCast(core.Shader.MAX_LOCATIONS));
}

/// Load shader from files and bind default locations
///
/// raylib.h
/// RLAPI Shader LoadShader(const char *vsFileName, const char *fsFileName);
fn nif_load_shader(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_vs_file_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_vs_file_name;
    };
    defer arg_vs_file_name.free();
    const vs_file_name = arg_vs_file_name.data;

    const arg_fs_file_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_fs_file_name;
    };
    defer arg_fs_file_name.free();
    const fs_file_name = arg_fs_file_name.data;

    // Function

    const shader = rl.LoadShader(vs_file_name, fs_file_name);
    defer if (!return_resource) core.Shader.free(shader);

    // Return

    return core.maybe_make_struct_as_resource(core.Shader, env, shader, return_resource) catch {
        return error.invalid_return;
    };
}

/// Load shader from code strings and bind default locations
///
/// raylib.h
/// RLAPI Shader LoadShaderFromMemory(const char *vsCode, const char *fsCode);
fn nif_load_shader_from_memory(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_vs_code = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_vs_code;
    };
    defer arg_vs_code.free();
    const vs_code = arg_vs_code.data;

    const arg_fs_code = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_fs_code;
    };
    defer arg_fs_code.free();
    const fs_code = arg_fs_code.data;

    // Function

    const shader = rl.LoadShaderFromMemory(vs_code, fs_code);
    defer if (!return_resource) core.Shader.free(shader);

    // Return

    return core.maybe_make_struct_as_resource(core.Shader, env, shader, return_resource) catch {
        return error.invalid_return;
    };
}

/// Check if a shader is valid (loaded on GPU)
///
/// raylib.h
/// RLAPI bool IsShaderValid(Shader shader);
fn nif_is_shader_valid(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_shader = core.Argument(core.Shader).get(env, argv[0]) catch {
        return error.invalid_argument_shader;
    };
    defer arg_shader.free();
    const shader = arg_shader.data;

    // Function

    const is_shader_valid = rl.IsShaderValid(shader);

    // Return

    return core.Boolean.make(env, is_shader_valid);
}

/// Get shader uniform location
///
/// raylib.h
/// RLAPI int GetShaderLocation(Shader shader, const char *uniformName);
fn nif_get_shader_location(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_shader = core.Argument(core.Shader).get(env, argv[0]) catch {
        return error.invalid_argument_shader;
    };
    defer arg_shader.free();
    const shader = arg_shader.data;

    const arg_uniform_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_uniform_name;
    };
    defer arg_uniform_name.free();
    const uniform_name = arg_uniform_name.data;

    // Function

    const shader_location = rl.GetShaderLocation(shader, uniform_name);

    // Return

    return core.Int.make(env, shader_location);
}

/// Get shader attribute location
///
/// raylib.h
/// RLAPI int GetShaderLocationAttrib(Shader shader, const char *attribName);
fn nif_get_shader_location_attrib(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_shader = core.Argument(core.Shader).get(env, argv[0]) catch {
        return error.invalid_argument_shader;
    };
    defer arg_shader.free();
    const shader = arg_shader.data;

    const arg_attrib_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_attrib_name;
    };
    defer arg_attrib_name.free();
    const attrib_name = arg_attrib_name.data;

    // Function

    const shader_location = rl.GetShaderLocationAttrib(shader, attrib_name);

    // Return

    return core.Int.make(env, shader_location);
}

/// Set shader uniform value
///
/// raylib.h
/// RLAPI void SetShaderValue(Shader shader, int locIndex, const void *value, int uniformType);
fn nif_set_shader_value(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_shader = core.Argument(core.Shader).get(env, argv[0]) catch {
        return error.invalid_argument_shader;
    };
    defer arg_shader.free();
    const shader = arg_shader.data;

    const loc_index = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_loc_index;
    };

    const uniform_type = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_uniform_type;
    };

    // Function

    switch (uniform_type) {
        rlgl.RL_SHADER_UNIFORM_FLOAT => {
            const value: f32 = @floatCast(core.Double.get(env, argv[2]) catch {
                return error.invalid_argument_value;
            });
            rl.SetShaderValue(shader, loc_index, &value, uniform_type);
        },
        rlgl.RL_SHADER_UNIFORM_VEC2 => {
            const arg_value = core.Argument(core.Vector2).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            rl.SetShaderValue(shader, loc_index, &value, uniform_type);
        },
        rlgl.RL_SHADER_UNIFORM_VEC3 => {
            const arg_value = core.Argument(core.Vector3).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            rl.SetShaderValue(shader, loc_index, &value, uniform_type);
        },
        rlgl.RL_SHADER_UNIFORM_VEC4 => {
            const arg_value = core.Argument(core.Vector4).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            rl.SetShaderValue(shader, loc_index, &value, uniform_type);
        },
        rlgl.RL_SHADER_UNIFORM_INT => {
            const value = core.Int.get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            rl.SetShaderValue(shader, loc_index, &value, uniform_type);
        },
        rlgl.RL_SHADER_UNIFORM_IVEC2 => {
            const arg_value = core.Argument(core.IVector2).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            rl.SetShaderValue(shader, loc_index, &value, uniform_type);
        },
        rlgl.RL_SHADER_UNIFORM_IVEC3 => {
            const arg_value = core.Argument(core.IVector3).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            rl.SetShaderValue(shader, loc_index, &value, uniform_type);
        },
        rlgl.RL_SHADER_UNIFORM_IVEC4 => {
            const arg_value = core.Argument(core.IVector4).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            rl.SetShaderValue(shader, loc_index, &value, uniform_type);
        },
        rlgl.RL_SHADER_UNIFORM_UINT => {
            const value = core.UInt.get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            rl.SetShaderValue(shader, loc_index, &value, uniform_type);
        },
        rlgl.RL_SHADER_UNIFORM_UIVEC2 => {
            const arg_value = core.Argument(core.UIVector2).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            rl.SetShaderValue(shader, loc_index, &value, uniform_type);
        },
        rlgl.RL_SHADER_UNIFORM_UIVEC3 => {
            const arg_value = core.Argument(core.UIVector3).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            rl.SetShaderValue(shader, loc_index, &value, uniform_type);
        },
        rlgl.RL_SHADER_UNIFORM_UIVEC4 => {
            const arg_value = core.Argument(core.UIVector4).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            rl.SetShaderValue(shader, loc_index, &value, uniform_type);
        },
        rlgl.RL_SHADER_UNIFORM_SAMPLER2D => {
            const value = core.Int.get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            rl.SetShaderValue(shader, loc_index, &value, uniform_type);
        },
        else => {
            return core.raise_exception(e.allocator, env, error.ArgumentError, @errorReturnTrace(), "Invalid argument 'uniform_type'.");
        },
    }

    // Return

    return core.Atom.make(env, "ok");
}

/// Set shader uniform value vector
///
/// raylib.h
/// RLAPI void SetShaderValueV(Shader shader, int locIndex, const void *value, int uniformType, int count);
fn nif_set_shader_value_v(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_shader = core.Argument(core.Shader).get(env, argv[0]) catch {
        return error.invalid_argument_shader;
    };
    defer arg_shader.free();
    const shader = arg_shader.data;

    const loc_index = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_loc_index;
    };

    const uniform_type = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_uniform_type;
    };

    // Function

    switch (uniform_type) {
        rlgl.RL_SHADER_UNIFORM_FLOAT => {
            var arg_value = core.ArgumentArray(core.Double, f32, rl.allocator).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            const count = arg_value.length;
            rl.SetShaderValueV(shader, loc_index, @ptrCast(value), uniform_type, @intCast(count));
        },
        rlgl.RL_SHADER_UNIFORM_VEC2 => {
            var arg_value = core.ArgumentArray(core.Vector2, core.Vector2.data_type, rl.allocator).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            const count = arg_value.length;
            rl.SetShaderValueV(shader, loc_index, @ptrCast(value), uniform_type, @intCast(count));
        },
        rlgl.RL_SHADER_UNIFORM_VEC3 => {
            var arg_value = core.ArgumentArray(core.Vector3, core.Vector3.data_type, rl.allocator).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            const count = arg_value.length;
            rl.SetShaderValueV(shader, loc_index, @ptrCast(value), uniform_type, @intCast(count));
        },
        rlgl.RL_SHADER_UNIFORM_VEC4 => {
            var arg_value = core.ArgumentArray(core.Vector4, core.Vector4.data_type, rl.allocator).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            const count = arg_value.length;
            rl.SetShaderValueV(shader, loc_index, @ptrCast(value), uniform_type, @intCast(count));
        },
        rlgl.RL_SHADER_UNIFORM_INT => {
            var arg_value = core.ArgumentArray(core.Int, core.Int.data_type, rl.allocator).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            const count = arg_value.length;
            rl.SetShaderValueV(shader, loc_index, @ptrCast(value), uniform_type, @intCast(count));
        },
        rlgl.RL_SHADER_UNIFORM_IVEC2 => {
            var arg_value = core.ArgumentArray(core.IVector2, core.IVector2.data_type, rl.allocator).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            const count = arg_value.length;
            rl.SetShaderValueV(shader, loc_index, @ptrCast(value), uniform_type, @intCast(count));
        },
        rlgl.RL_SHADER_UNIFORM_IVEC3 => {
            var arg_value = core.ArgumentArray(core.IVector3, core.IVector3.data_type, rl.allocator).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            const count = arg_value.length;
            rl.SetShaderValueV(shader, loc_index, @ptrCast(value), uniform_type, @intCast(count));
        },
        rlgl.RL_SHADER_UNIFORM_IVEC4 => {
            var arg_value = core.ArgumentArray(core.IVector4, core.IVector4.data_type, rl.allocator).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            const count = arg_value.length;
            rl.SetShaderValueV(shader, loc_index, @ptrCast(value), uniform_type, @intCast(count));
        },
        rlgl.RL_SHADER_UNIFORM_UINT => {
            var arg_value = core.ArgumentArray(core.UInt, core.UInt.data_type, rl.allocator).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            const count = arg_value.length;
            rl.SetShaderValueV(shader, loc_index, @ptrCast(value), uniform_type, @intCast(count));
        },
        rlgl.RL_SHADER_UNIFORM_UIVEC2 => {
            var arg_value = core.ArgumentArray(core.UIVector2, core.UIVector2.data_type, rl.allocator).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            const count = arg_value.length;
            rl.SetShaderValueV(shader, loc_index, @ptrCast(value), uniform_type, @intCast(count));
        },
        rlgl.RL_SHADER_UNIFORM_UIVEC3 => {
            var arg_value = core.ArgumentArray(core.UIVector3, core.UIVector3.data_type, rl.allocator).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            const count = arg_value.length;
            rl.SetShaderValueV(shader, loc_index, @ptrCast(value), uniform_type, @intCast(count));
        },
        rlgl.RL_SHADER_UNIFORM_UIVEC4 => {
            var arg_value = core.ArgumentArray(core.UIVector4, core.UIVector4.data_type, rl.allocator).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            const count = arg_value.length;
            rl.SetShaderValueV(shader, loc_index, @ptrCast(value), uniform_type, @intCast(count));
        },
        rlgl.RL_SHADER_UNIFORM_SAMPLER2D => {
            var arg_value = core.ArgumentArray(core.Int, core.Int.data_type, rl.allocator).get(env, argv[2]) catch {
                return error.invalid_argument_value;
            };
            defer arg_value.free();
            const value = arg_value.data;
            const count = arg_value.length;
            rl.SetShaderValueV(shader, loc_index, @ptrCast(value), uniform_type, @intCast(count));
        },
        else => {
            return core.raise_exception(e.allocator, env, error.ArgumentError, @errorReturnTrace(), "Invalid argument 'uniform_type'.");
        },
    }

    // Return

    return core.Atom.make(env, "ok");
}

/// Set shader uniform value (matrix 4x4)
///
/// raylib.h
/// RLAPI void SetShaderValueMatrix(Shader shader, int locIndex, Matrix mat);
fn nif_set_shader_value_matrix(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_shader = core.Argument(core.Shader).get(env, argv[0]) catch {
        return error.invalid_argument_shader;
    };
    defer arg_shader.free();
    const shader = arg_shader.data;

    const loc_index = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_loc_index;
    };

    const arg_mat = core.Argument(core.Matrix).get(env, argv[2]) catch {
        return error.invalid_argument_mat;
    };
    defer arg_mat.free();
    const mat = arg_mat.data;

    // Function

    rl.SetShaderValueMatrix(shader, loc_index, mat);

    // Return

    return core.Atom.make(env, "ok");
}

/// Set shader uniform value and bind the texture (sampler2d)
///
/// raylib.h
/// RLAPI void SetShaderValueTexture(Shader shader, int locIndex, Texture2D texture);
fn nif_set_shader_value_texture(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_shader = core.Argument(core.Shader).get(env, argv[0]) catch {
        return error.invalid_argument_shader;
    };
    defer arg_shader.free();
    const shader = arg_shader.data;

    const loc_index = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_loc_index;
    };

    const arg_texture = core.Argument(core.Texture).get(env, argv[2]) catch {
        return error.invalid_argument_texture;
    };
    defer arg_texture.free();
    const texture = arg_texture.data;

    // Function

    rl.SetShaderValueTexture(shader, loc_index, texture);

    // Return

    return core.Atom.make(env, "ok");
}
