const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Matrix operations
    .{ .name = "rl_matrix_mode", .arity = 1, .fptr = core.nif_wrapper(nif_rl_matrix_mode), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_push_matrix", .arity = 0, .fptr = core.nif_wrapper(nif_rl_push_matrix), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_pop_matrix", .arity = 0, .fptr = core.nif_wrapper(nif_rl_pop_matrix), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_load_identity", .arity = 0, .fptr = core.nif_wrapper(nif_rl_load_identity), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_translate", .arity = 3, .fptr = core.nif_wrapper(nif_rl_translate), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_rotate", .arity = 4, .fptr = core.nif_wrapper(nif_rl_rotate), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_scale", .arity = 3, .fptr = core.nif_wrapper(nif_rl_scale), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_mult_matrix", .arity = 1, .fptr = core.nif_wrapper(nif_rl_mult_matrix), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_frustum", .arity = 6, .fptr = core.nif_wrapper(nif_rl_frustum), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_ortho", .arity = 6, .fptr = core.nif_wrapper(nif_rl_ortho), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_viewport", .arity = 4, .fptr = core.nif_wrapper(nif_rl_viewport), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_set_clip_planes", .arity = 2, .fptr = core.nif_wrapper(nif_rl_set_clip_planes), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_get_cull_distance_near", .arity = 0, .fptr = core.nif_wrapper(nif_rl_get_cull_distance_near), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_get_cull_distance_far", .arity = 0, .fptr = core.nif_wrapper(nif_rl_get_cull_distance_far), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Vertex level operations
    .{ .name = "rl_begin", .arity = 1, .fptr = core.nif_wrapper(nif_rl_begin), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_end", .arity = 0, .fptr = core.nif_wrapper(nif_rl_end), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_vertex2", .arity = 2, .fptr = core.nif_wrapper(nif_rl_vertex2), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_vertex3", .arity = 3, .fptr = core.nif_wrapper(nif_rl_vertex3), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_tex_coord2", .arity = 2, .fptr = core.nif_wrapper(nif_rl_tex_coord2), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_normal3", .arity = 3, .fptr = core.nif_wrapper(nif_rl_normal3), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_color4_byte", .arity = 4, .fptr = core.nif_wrapper(nif_rl_color4_byte), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_color3", .arity = 3, .fptr = core.nif_wrapper(nif_rl_color3), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "rl_color4", .arity = 4, .fptr = core.nif_wrapper(nif_rl_color4), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Render management
    .{ .name = "rl_set_texture", .arity = 1, .fptr = core.nif_wrapper(nif_rl_set_texture), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

/////////////////////////
//  Matrix operations  //
/////////////////////////

/// Choose the current matrix to be transformed
///
/// rlgl.h
/// RLAPI void rlMatrixMode(int mode);
fn nif_rl_matrix_mode(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const mode = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_mode;
    };

    // Function

    rl.rlMatrixMode(mode);

    // Return

    return core.Atom.make(env, "ok");
}

/// Push the current matrix to stack
///
/// rlgl.h
/// RLAPI void rlPushMatrix(void);
fn nif_rl_push_matrix(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.rlPushMatrix();

    // Return

    return core.Atom.make(env, "ok");
}

/// Pop latest inserted matrix from stack
///
/// rlgl.h
/// RLAPI void rlPopMatrix(void);
fn nif_rl_pop_matrix(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.rlPopMatrix();

    // Return

    return core.Atom.make(env, "ok");
}

/// Reset current matrix to identity matrix
///
/// rlgl.h
/// RLAPI void rlLoadIdentity(void);
fn nif_rl_load_identity(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.rlLoadIdentity();

    // Return

    return core.Atom.make(env, "ok");
}

/// Multiply the current matrix by a translation matrix
///
/// rlgl.h
/// RLAPI void rlTranslatef(float x, float y, float z);
fn nif_rl_translate(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const x = core.Float.get(env, argv[0]) catch {
        return error.invalid_argument_x;
    };

    const y = core.Float.get(env, argv[1]) catch {
        return error.invalid_argument_y;
    };

    const z = core.Float.get(env, argv[2]) catch {
        return error.invalid_argument_z;
    };

    // Function

    rl.rlTranslatef(x, y, z);

    // Return

    return core.Atom.make(env, "ok");
}

/// Multiply the current matrix by a rotation matrix
///
/// rlgl.h
/// RLAPI void rlRotatef(float angle, float x, float y, float z);
fn nif_rl_rotate(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const angle = core.Float.get(env, argv[0]) catch {
        return error.invalid_argument_angle;
    };

    const x = core.Float.get(env, argv[1]) catch {
        return error.invalid_argument_x;
    };

    const y = core.Float.get(env, argv[2]) catch {
        return error.invalid_argument_y;
    };

    const z = core.Float.get(env, argv[3]) catch {
        return error.invalid_argument_z;
    };

    // Function

    rl.rlRotatef(angle, x, y, z);

    // Return

    return core.Atom.make(env, "ok");
}

/// Multiply the current matrix by a scaling matrix
///
/// rlgl.h
/// RLAPI void rlScalef(float x, float y, float z);
fn nif_rl_scale(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const x = core.Float.get(env, argv[0]) catch {
        return error.invalid_argument_x;
    };

    const y = core.Float.get(env, argv[1]) catch {
        return error.invalid_argument_y;
    };

    const z = core.Float.get(env, argv[2]) catch {
        return error.invalid_argument_z;
    };

    // Function

    rl.rlScalef(x, y, z);

    // Return

    return core.Atom.make(env, "ok");
}

/// Multiply the current matrix by another matrix
///
/// rlgl.h
/// RLAPI void rlMultMatrixf(const float *matf);
fn nif_rl_mult_matrix(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_mat = core.Argument(core.Matrix).get(env, argv[0]) catch {
        return error.invalid_argument_mat;
    };
    defer arg_mat.free();
    const mat = arg_mat.data;
    const matf = rl.MatrixToFloat(mat);

    // Function

    rl.rlMultMatrixf(&matf);

    // Return

    return core.Atom.make(env, "ok");
}

/// Multiply the current matrix by a perspective matrix generated by parameters
///
/// rlgl.h
/// RLAPI void rlFrustum(double left, double right, double bottom, double top, double znear, double zfar);
fn nif_rl_frustum(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const left = core.Double.get(env, argv[0]) catch {
        return error.invalid_argument_left;
    };

    const right = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_right;
    };

    const bottom = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_bottom;
    };

    const top = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_top;
    };

    const znear = core.Double.get(env, argv[4]) catch {
        return error.invalid_argument_znear;
    };

    const zfar = core.Double.get(env, argv[5]) catch {
        return error.invalid_argument_zfar;
    };

    // Function

    rl.rlFrustum(left, right, bottom, top, znear, zfar);

    // Return

    return core.Atom.make(env, "ok");
}

/// Multiply the current matrix by an orthographic matrix generated by parameters
///
/// rlgl.h
/// RLAPI void rlOrtho(double left, double right, double bottom, double top, double znear, double zfar);
fn nif_rl_ortho(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const left = core.Double.get(env, argv[0]) catch {
        return error.invalid_argument_left;
    };

    const right = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_right;
    };

    const bottom = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_bottom;
    };

    const top = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_top;
    };

    const znear = core.Double.get(env, argv[4]) catch {
        return error.invalid_argument_znear;
    };

    const zfar = core.Double.get(env, argv[5]) catch {
        return error.invalid_argument_zfar;
    };

    // Function

    rl.rlOrtho(left, right, bottom, top, znear, zfar);

    // Return

    return core.Atom.make(env, "ok");
}

/// Set the viewport area
///
/// rlgl.h
/// RLAPI void rlViewport(int x, int y, int width, int height);
fn nif_rl_viewport(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const x = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_x;
    };

    const y = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_y;
    };

    const width = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_height;
    };

    // Function

    rl.rlViewport(x, y, width, height);

    // Return

    return core.Atom.make(env, "ok");
}

/// Set clip planes distances
///
/// rlgl.h
/// RLAPI void rlSetClipPlanes(double nearPlane, double farPlane);
fn nif_rl_set_clip_planes(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const near_plane = core.Double.get(env, argv[0]) catch {
        return error.invalid_argument_near_plane;
    };

    const far_plane = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_far_plane;
    };

    // Function

    rl.rlSetClipPlanes(near_plane, far_plane);

    // Return

    return core.Atom.make(env, "ok");
}

/// Get cull plane distance near
///
/// rlgl.h
/// RLAPI double rlGetCullDistanceNear(void);
fn nif_rl_get_cull_distance_near(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const cull_distance_near = rl.rlGetCullDistanceNear();

    // Return

    return core.Double.make(env, cull_distance_near);
}

/// Get cull plane distance far
///
/// rlgl.h
/// RLAPI double rlGetCullDistanceFar(void);
fn nif_rl_get_cull_distance_far(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const cull_distance_far = rl.rlGetCullDistanceFar();

    // Return

    return core.Double.make(env, cull_distance_far);
}

///////////////////////////////
//  Vertex level operations  //
///////////////////////////////

/// Initialize drawing mode (how to organize vertex)
///
/// rlgl.h
/// RLAPI void rlBegin(int mode);
fn nif_rl_begin(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const mode = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_mode;
    };

    // Function

    rl.rlBegin(mode);

    // Return

    return core.Atom.make(env, "ok");
}

/// Finish vertex providing
///
/// rlgl.h
/// RLAPI void rlEnd(void);
fn nif_rl_end(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.rlEnd();

    // Return

    return core.Atom.make(env, "ok");
}

/// Define one vertex (position) - 2 float
///
/// rlgl.h
/// RLAPI void rlVertex2f(float x, float y);
fn nif_rl_vertex2(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const x = core.Float.get(env, argv[0]) catch {
        return error.invalid_argument_x;
    };

    const y = core.Float.get(env, argv[1]) catch {
        return error.invalid_argument_y;
    };

    // Function

    rl.rlVertex2f(x, y);

    // Return

    return core.Atom.make(env, "ok");
}

/// Define one vertex (position) - 3 float
///
/// rlgl.h
/// RLAPI void rlVertex3f(float x, float y, float z);
fn nif_rl_vertex3(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const x = core.Float.get(env, argv[0]) catch {
        return error.invalid_argument_x;
    };

    const y = core.Float.get(env, argv[1]) catch {
        return error.invalid_argument_y;
    };

    const z = core.Float.get(env, argv[2]) catch {
        return error.invalid_argument_z;
    };

    // Function

    rl.rlVertex3f(x, y, z);

    // Return

    return core.Atom.make(env, "ok");
}

/// Define one vertex (texture coordinate) - 2 float
///
/// rlgl.h
/// RLAPI void rlTexCoord2f(float x, float y);
fn nif_rl_tex_coord2(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const x = core.Float.get(env, argv[0]) catch {
        return error.invalid_argument_x;
    };

    const y = core.Float.get(env, argv[1]) catch {
        return error.invalid_argument_y;
    };

    // Function

    rl.rlTexCoord2f(x, y);

    // Return

    return core.Atom.make(env, "ok");
}

/// Define one vertex (normal) - 3 float
///
/// rlgl.h
/// RLAPI void rlNormal3f(float x, float y, float z);
fn nif_rl_normal3(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const x = core.Float.get(env, argv[0]) catch {
        return error.invalid_argument_x;
    };

    const y = core.Float.get(env, argv[1]) catch {
        return error.invalid_argument_y;
    };

    const z = core.Float.get(env, argv[2]) catch {
        return error.invalid_argument_z;
    };

    // Function

    rl.rlNormal3f(x, y, z);

    // Return

    return core.Atom.make(env, "ok");
}

/// Define one vertex (color) - 4 byte
///
/// rlgl.h
/// RLAPI void rlColor4ub(unsigned char r, unsigned char g, unsigned char b, unsigned char a);
fn nif_rl_color4_byte(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const r = core.Char.get(env, argv[0]) catch {
        return error.invalid_argument_r;
    };

    const g = core.Char.get(env, argv[1]) catch {
        return error.invalid_argument_g;
    };

    const b = core.Char.get(env, argv[2]) catch {
        return error.invalid_argument_b;
    };

    const a = core.Char.get(env, argv[3]) catch {
        return error.invalid_argument_a;
    };

    // Function

    rl.rlColor4ub(r, g, b, a);

    // Return

    return core.Atom.make(env, "ok");
}

/// Define one vertex (color) - 3 float
///
/// rlgl.h
/// RLAPI void rlColor3f(float x, float y, float z);
fn nif_rl_color3(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const x = core.Float.get(env, argv[0]) catch {
        return error.invalid_argument_x;
    };

    const y = core.Float.get(env, argv[1]) catch {
        return error.invalid_argument_y;
    };

    const z = core.Float.get(env, argv[2]) catch {
        return error.invalid_argument_z;
    };

    // Function

    rl.rlColor3f(x, y, z);

    // Return

    return core.Atom.make(env, "ok");
}

/// Define one vertex (color) - 4 float
///
/// rlgl.h
/// RLAPI void rlColor4f(float x, float y, float z, float w);
fn nif_rl_color4(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const x = core.Float.get(env, argv[0]) catch {
        return error.invalid_argument_x;
    };

    const y = core.Float.get(env, argv[1]) catch {
        return error.invalid_argument_y;
    };

    const z = core.Float.get(env, argv[2]) catch {
        return error.invalid_argument_z;
    };

    const w = core.Float.get(env, argv[3]) catch {
        return error.invalid_argument_w;
    };

    // Function

    rl.rlColor4f(x, y, z, w);

    // Return

    return core.Atom.make(env, "ok");
}

/////////////////////////
//  Render management  //
/////////////////////////

/// Set current texture for render batch and check buffers limits
///
/// rlgl.h
/// RLAPI void rlSetTexture(unsigned int id);
fn nif_rl_set_texture(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    const id_type = e.enif_term_type(env, argv[0]);

    if (id_type == e.ERL_NIF_TERM_TYPE_FLOAT or id_type == e.ERL_NIF_TERM_TYPE_INTEGER) {
        // Arguments

        const texture = core.UInt.get(env, argv[0]) catch {
            return error.invalid_argument_texture;
        };

        // Function

        rl.rlSetTexture(texture);
    } else {
        // Arguments

        const arg_texture = core.Argument(core.Texture).get(env, argv[0]) catch {
            return error.invalid_argument_texture;
        };
        defer arg_texture.free();
        const texture = arg_texture.data;

        // Function

        rl.rlSetTexture(texture.id);
    }

    // Return

    return core.Atom.make(env, "ok");
}
