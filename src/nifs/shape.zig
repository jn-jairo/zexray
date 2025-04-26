const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Shapes configuration
    .{ .name = "set_shapes_texture", .arity = 2, .fptr = core.nif_wrapper(nif_set_shapes_texture), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_shapes_texture", .arity = 0, .fptr = core.nif_wrapper(nif_get_shapes_texture), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_shapes_texture", .arity = 1, .fptr = core.nif_wrapper(nif_get_shapes_texture), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_shapes_texture_rectangle", .arity = 0, .fptr = core.nif_wrapper(nif_get_shapes_texture_rectangle), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_shapes_texture_rectangle", .arity = 1, .fptr = core.nif_wrapper(nif_get_shapes_texture_rectangle), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Basic shapes drawing
    .{ .name = "draw_pixel", .arity = 3, .fptr = core.nif_wrapper(nif_draw_pixel), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_pixel_v", .arity = 2, .fptr = core.nif_wrapper(nif_draw_pixel_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_line", .arity = 5, .fptr = core.nif_wrapper(nif_draw_line), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_line_v", .arity = 3, .fptr = core.nif_wrapper(nif_draw_line_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_line_ex", .arity = 4, .fptr = core.nif_wrapper(nif_draw_line_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_line_strip", .arity = 2, .fptr = core.nif_wrapper(nif_draw_line_strip), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_line_bezier", .arity = 4, .fptr = core.nif_wrapper(nif_draw_line_bezier), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_circle", .arity = 4, .fptr = core.nif_wrapper(nif_draw_circle), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_circle_sector", .arity = 6, .fptr = core.nif_wrapper(nif_draw_circle_sector), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_circle_sector_lines", .arity = 6, .fptr = core.nif_wrapper(nif_draw_circle_sector_lines), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_circle_gradient", .arity = 5, .fptr = core.nif_wrapper(nif_draw_circle_gradient), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_circle_v", .arity = 3, .fptr = core.nif_wrapper(nif_draw_circle_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_circle_lines", .arity = 4, .fptr = core.nif_wrapper(nif_draw_circle_lines), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_circle_lines_v", .arity = 3, .fptr = core.nif_wrapper(nif_draw_circle_lines_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_ellipse", .arity = 5, .fptr = core.nif_wrapper(nif_draw_ellipse), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_ellipse_lines", .arity = 5, .fptr = core.nif_wrapper(nif_draw_ellipse_lines), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_ring", .arity = 7, .fptr = core.nif_wrapper(nif_draw_ring), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_ring_lines", .arity = 7, .fptr = core.nif_wrapper(nif_draw_ring_lines), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_rectangle", .arity = 5, .fptr = core.nif_wrapper(nif_draw_rectangle), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_rectangle_v", .arity = 3, .fptr = core.nif_wrapper(nif_draw_rectangle_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_rectangle_rec", .arity = 2, .fptr = core.nif_wrapper(nif_draw_rectangle_rec), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_rectangle_pro", .arity = 4, .fptr = core.nif_wrapper(nif_draw_rectangle_pro), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_rectangle_gradient_v", .arity = 6, .fptr = core.nif_wrapper(nif_draw_rectangle_gradient_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_rectangle_gradient_h", .arity = 6, .fptr = core.nif_wrapper(nif_draw_rectangle_gradient_h), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_rectangle_gradient_ex", .arity = 5, .fptr = core.nif_wrapper(nif_draw_rectangle_gradient_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_rectangle_lines", .arity = 5, .fptr = core.nif_wrapper(nif_draw_rectangle_lines), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_rectangle_lines_ex", .arity = 3, .fptr = core.nif_wrapper(nif_draw_rectangle_lines_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_rectangle_rounded", .arity = 4, .fptr = core.nif_wrapper(nif_draw_rectangle_rounded), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_rectangle_rounded_lines", .arity = 4, .fptr = core.nif_wrapper(nif_draw_rectangle_rounded_lines), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_rectangle_rounded_lines_ex", .arity = 5, .fptr = core.nif_wrapper(nif_draw_rectangle_rounded_lines_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_triangle", .arity = 4, .fptr = core.nif_wrapper(nif_draw_triangle), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_triangle_lines", .arity = 4, .fptr = core.nif_wrapper(nif_draw_triangle_lines), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_triangle_fan", .arity = 2, .fptr = core.nif_wrapper(nif_draw_triangle_fan), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_triangle_strip", .arity = 2, .fptr = core.nif_wrapper(nif_draw_triangle_strip), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_poly", .arity = 5, .fptr = core.nif_wrapper(nif_draw_poly), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_poly_lines", .arity = 5, .fptr = core.nif_wrapper(nif_draw_poly_lines), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_poly_lines_ex", .arity = 6, .fptr = core.nif_wrapper(nif_draw_poly_lines_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Splines drawing
    .{ .name = "draw_spline_linear", .arity = 3, .fptr = core.nif_wrapper(nif_draw_spline_linear), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_spline_basis", .arity = 3, .fptr = core.nif_wrapper(nif_draw_spline_basis), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_spline_catmull_rom", .arity = 3, .fptr = core.nif_wrapper(nif_draw_spline_catmull_rom), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_spline_bezier_quadratic", .arity = 3, .fptr = core.nif_wrapper(nif_draw_spline_bezier_quadratic), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_spline_bezier_cubic", .arity = 3, .fptr = core.nif_wrapper(nif_draw_spline_bezier_cubic), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_spline_segment_linear", .arity = 4, .fptr = core.nif_wrapper(nif_draw_spline_segment_linear), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_spline_segment_basis", .arity = 6, .fptr = core.nif_wrapper(nif_draw_spline_segment_basis), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_spline_segment_catmull_rom", .arity = 6, .fptr = core.nif_wrapper(nif_draw_spline_segment_catmull_rom), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_spline_segment_bezier_quadratic", .arity = 5, .fptr = core.nif_wrapper(nif_draw_spline_segment_bezier_quadratic), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "draw_spline_segment_bezier_cubic", .arity = 6, .fptr = core.nif_wrapper(nif_draw_spline_segment_bezier_cubic), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Spline segment point evaluation
    .{ .name = "get_spline_point_linear", .arity = 3, .fptr = core.nif_wrapper(nif_get_spline_point_linear), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_spline_point_linear", .arity = 4, .fptr = core.nif_wrapper(nif_get_spline_point_linear), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_spline_point_basis", .arity = 5, .fptr = core.nif_wrapper(nif_get_spline_point_basis), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_spline_point_basis", .arity = 6, .fptr = core.nif_wrapper(nif_get_spline_point_basis), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_spline_point_catmull_rom", .arity = 5, .fptr = core.nif_wrapper(nif_get_spline_point_catmull_rom), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_spline_point_catmull_rom", .arity = 6, .fptr = core.nif_wrapper(nif_get_spline_point_catmull_rom), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_spline_point_bezier_quad", .arity = 4, .fptr = core.nif_wrapper(nif_get_spline_point_bezier_quad), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_spline_point_bezier_quad", .arity = 5, .fptr = core.nif_wrapper(nif_get_spline_point_bezier_quad), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_spline_point_bezier_cubic", .arity = 5, .fptr = core.nif_wrapper(nif_get_spline_point_bezier_cubic), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_spline_point_bezier_cubic", .arity = 6, .fptr = core.nif_wrapper(nif_get_spline_point_bezier_cubic), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Basic shapes collision detection
    .{ .name = "check_collision_recs", .arity = 2, .fptr = core.nif_wrapper(nif_check_collision_recs), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "check_collision_circles", .arity = 4, .fptr = core.nif_wrapper(nif_check_collision_circles), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "check_collision_circle_rec", .arity = 3, .fptr = core.nif_wrapper(nif_check_collision_circle_rec), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "check_collision_circle_line", .arity = 4, .fptr = core.nif_wrapper(nif_check_collision_circle_line), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "check_collision_point_rec", .arity = 2, .fptr = core.nif_wrapper(nif_check_collision_point_rec), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "check_collision_point_circle", .arity = 3, .fptr = core.nif_wrapper(nif_check_collision_point_circle), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "check_collision_point_triangle", .arity = 4, .fptr = core.nif_wrapper(nif_check_collision_point_triangle), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "check_collision_point_line", .arity = 4, .fptr = core.nif_wrapper(nif_check_collision_point_line), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "check_collision_point_poly", .arity = 2, .fptr = core.nif_wrapper(nif_check_collision_point_poly), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "check_collision_lines", .arity = 4, .fptr = core.nif_wrapper(nif_check_collision_lines), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "check_collision_lines", .arity = 5, .fptr = core.nif_wrapper(nif_check_collision_lines), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_collision_rec", .arity = 2, .fptr = core.nif_wrapper(nif_get_collision_rec), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_collision_rec", .arity = 3, .fptr = core.nif_wrapper(nif_get_collision_rec), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

////////////////////////////
//  Shapes configuration  //
////////////////////////////

/// Set texture and rectangle to be used on shapes drawing
///
/// raylib.h
/// RLAPI void SetShapesTexture(Texture2D texture, Rectangle source);
fn nif_set_shapes_texture(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_texture = core.Argument(core.Texture2D).get(env, argv[0]) catch {
        return error.invalid_argument_texture;
    };
    defer arg_texture.free();
    const texture = arg_texture.data;

    const arg_source = core.Argument(core.Rectangle).get(env, argv[1]) catch {
        return error.invalid_argument_source;
    };
    defer arg_source.free();
    const source = arg_source.data;

    // Function

    rl.SetShapesTexture(texture, source);

    // Return

    return core.Atom.make(env, "ok");
}

/// Get texture that is used for shapes drawing
///
/// raylib.h
/// RLAPI Texture2D GetShapesTexture(void);
fn nif_get_shapes_texture(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0 or argc == 1);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 0);

    // Function

    const texture = rl.GetShapesTexture();
    defer if (!return_resource) core.Texture2D.free(texture);
    errdefer if (return_resource) core.Texture2D.free(texture);

    // Return

    return core.maybe_make_struct_as_resource(core.Texture2D, env, texture, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get texture source rectangle that is used for shapes drawing
///
/// raylib.h
/// RLAPI Rectangle GetShapesTextureRectangle(void);
fn nif_get_shapes_texture_rectangle(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0 or argc == 1);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 0);

    // Function

    const texture_rectangle = rl.GetShapesTextureRectangle();
    defer if (!return_resource) core.Rectangle.free(texture_rectangle);
    errdefer if (return_resource) core.Rectangle.free(texture_rectangle);

    // Return

    return core.maybe_make_struct_as_resource(core.Rectangle, env, texture_rectangle, return_resource) catch {
        return error.invalid_return;
    };
}

////////////////////////////
//  Basic shapes drawing  //
////////////////////////////

/// Draw a pixel using geometry [Can be slow, use with care]
///
/// raylib.h
/// RLAPI void DrawPixel(int posX, int posY, Color color);
fn nif_draw_pixel(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const pos_x = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_pos_x;
    };

    const pos_y = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_pos_y;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawPixel(pos_x, pos_y, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a pixel using geometry (Vector version) [Can be slow, use with care]
///
/// raylib.h
/// RLAPI void DrawPixelV(Vector2 position, Color color);
fn nif_draw_pixel_v(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_position = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_color = core.Argument(core.Color).get(env, argv[1]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawPixelV(position, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a line
///
/// raylib.h
/// RLAPI void DrawLine(int startPosX, int startPosY, int endPosX, int endPosY, Color color);
fn nif_draw_line(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const start_pos_x = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_start_pos_x;
    };

    const start_pos_y = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_start_pos_y;
    };

    const end_pos_x = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_end_pos_x;
    };

    const end_pos_y = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_end_pos_y;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawLine(start_pos_x, start_pos_y, end_pos_x, end_pos_y, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a line (using gl lines)
///
/// raylib.h
/// RLAPI void DrawLineV(Vector2 startPos, Vector2 endPos, Color color);
fn nif_draw_line_v(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_start_pos = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_start_pos;
    };
    defer arg_start_pos.free();
    const start_pos = arg_start_pos.data;

    const arg_end_pos = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_end_pos;
    };
    defer arg_end_pos.free();
    const end_pos = arg_end_pos.data;

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawLineV(start_pos, end_pos, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a line (using triangles/quads)
///
/// raylib.h
/// RLAPI void DrawLineEx(Vector2 startPos, Vector2 endPos, float thick, Color color);
fn nif_draw_line_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_start_pos = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_start_pos;
    };
    defer arg_start_pos.free();
    const start_pos = arg_start_pos.data;

    const arg_end_pos = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_end_pos;
    };
    defer arg_end_pos.free();
    const end_pos = arg_end_pos.data;

    const thick = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_thick;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawLineEx(start_pos, end_pos, @floatCast(thick), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw lines sequence (using gl lines)
///
/// raylib.h
/// RLAPI void DrawLineStrip(const Vector2 *points, int pointCount, Color color);
fn nif_draw_line_strip(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    var arg_points = core.ArgumentArray(core.Vector2, core.Vector2.data_type, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_points.free();
    const points = arg_points.data;
    const point_count = arg_points.length;

    const arg_color = core.Argument(core.Color).get(env, argv[1]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawLineStrip(@ptrCast(points), @intCast(point_count), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw line segment cubic-bezier in-out interpolation
///
/// raylib.h
/// RLAPI void DrawLineBezier(Vector2 startPos, Vector2 endPos, float thick, Color color);
fn nif_draw_line_bezier(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_start_pos = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_start_pos;
    };
    defer arg_start_pos.free();
    const start_pos = arg_start_pos.data;

    const arg_end_pos = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_end_pos;
    };
    defer arg_end_pos.free();
    const end_pos = arg_end_pos.data;

    const thick = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_thick;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawLineBezier(start_pos, end_pos, @floatCast(thick), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a color-filled circle
///
/// raylib.h
/// RLAPI void DrawCircle(int centerX, int centerY, float radius, Color color);
fn nif_draw_circle(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const center_x = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_center_x;
    };

    const center_y = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_center_y;
    };

    const radius = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_radius;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawCircle(center_x, center_y, @floatCast(radius), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a piece of a circle
///
/// raylib.h
/// RLAPI void DrawCircleSector(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color);
fn nif_draw_circle_sector(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_center = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_center;
    };
    defer arg_center.free();
    const center = arg_center.data;

    const radius = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_radius;
    };

    const start_angle = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_start_angle;
    };

    const end_angle = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_end_angle;
    };

    const segments = core.Int.get(env, argv[4]) catch {
        return error.invalid_argument_segments;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawCircleSector(center, @floatCast(radius), @floatCast(start_angle), @floatCast(end_angle), segments, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw circle sector outline
///
/// raylib.h
/// RLAPI void DrawCircleSectorLines(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color);
fn nif_draw_circle_sector_lines(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_center = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_center;
    };
    defer arg_center.free();
    const center = arg_center.data;

    const radius = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_radius;
    };

    const start_angle = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_start_angle;
    };

    const end_angle = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_end_angle;
    };

    const segments = core.Int.get(env, argv[4]) catch {
        return error.invalid_argument_segments;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawCircleSectorLines(center, @floatCast(radius), @floatCast(start_angle), @floatCast(end_angle), segments, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a gradient-filled circle
///
/// raylib.h
/// RLAPI void DrawCircleGradient(int centerX, int centerY, float radius, Color inner, Color outer);
fn nif_draw_circle_gradient(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const center_x = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_center_x;
    };

    const center_y = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_center_y;
    };

    const radius = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_radius;
    };

    const arg_inner = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_inner;
    };
    defer arg_inner.free();
    const inner = arg_inner.data;

    const arg_outer = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_outer;
    };
    defer arg_outer.free();
    const outer = arg_outer.data;

    // Function

    rl.DrawCircleGradient(center_x, center_y, @floatCast(radius), inner, outer);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a color-filled circle (Vector version)
///
/// raylib.h
/// RLAPI void DrawCircleV(Vector2 center, float radius, Color color);
fn nif_draw_circle_v(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_center = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_center;
    };
    defer arg_center.free();
    const center = arg_center.data;

    const radius = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_radius;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawCircleV(center, @floatCast(radius), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw circle outline
///
/// raylib.h
/// RLAPI void DrawCircleLines(int centerX, int centerY, float radius, Color color);
fn nif_draw_circle_lines(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const center_x = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_center_x;
    };

    const center_y = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_center_y;
    };

    const radius = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_radius;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawCircleLines(center_x, center_y, @floatCast(radius), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw circle outline (Vector version)
///
/// raylib.h
/// RLAPI void DrawCircleLinesV(Vector2 center, float radius, Color color);
fn nif_draw_circle_lines_v(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_center = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_center;
    };
    defer arg_center.free();
    const center = arg_center.data;

    const radius = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_radius;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawCircleLinesV(center, @floatCast(radius), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw ellipse
///
/// raylib.h
/// RLAPI void DrawEllipse(int centerX, int centerY, float radiusH, float radiusV, Color color);
fn nif_draw_ellipse(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const center_x = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_center_x;
    };

    const center_y = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_center_y;
    };

    const radius_h = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_radius_h;
    };

    const radius_v = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_radius_v;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawEllipse(center_x, center_y, @floatCast(radius_h), @floatCast(radius_v), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw ellipse outline
///
/// raylib.h
/// RLAPI void DrawEllipseLines(int centerX, int centerY, float radiusH, float radiusV, Color color);
fn nif_draw_ellipse_lines(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const center_x = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_center_x;
    };

    const center_y = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_center_y;
    };

    const radius_h = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_radius_h;
    };

    const radius_v = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_radius_v;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawEllipseLines(center_x, center_y, @floatCast(radius_h), @floatCast(radius_v), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw ring
///
/// raylib.h
/// RLAPI void DrawRing(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color);
fn nif_draw_ring(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 7);

    // Arguments

    const arg_center = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_center;
    };
    defer arg_center.free();
    const center = arg_center.data;

    const inner_radius = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_inner_radius;
    };

    const outer_radius = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_outer_radius;
    };

    const start_angle = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_start_angle;
    };

    const end_angle = core.Double.get(env, argv[4]) catch {
        return error.invalid_argument_end_angle;
    };

    const segments = core.Int.get(env, argv[5]) catch {
        return error.invalid_argument_segments;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[6]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawRing(center, @floatCast(inner_radius), @floatCast(outer_radius), @floatCast(start_angle), @floatCast(end_angle), segments, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw ring outline
///
/// raylib.h
/// RLAPI void DrawRingLines(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color);
fn nif_draw_ring_lines(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 7);

    // Arguments

    const arg_center = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_center;
    };
    defer arg_center.free();
    const center = arg_center.data;

    const inner_radius = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_inner_radius;
    };

    const outer_radius = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_outer_radius;
    };

    const start_angle = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_start_angle;
    };

    const end_angle = core.Double.get(env, argv[4]) catch {
        return error.invalid_argument_end_angle;
    };

    const segments = core.Int.get(env, argv[5]) catch {
        return error.invalid_argument_segments;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[6]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawRingLines(center, @floatCast(inner_radius), @floatCast(outer_radius), @floatCast(start_angle), @floatCast(end_angle), segments, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a color-filled rectangle
///
/// raylib.h
/// RLAPI void DrawRectangle(int posX, int posY, int width, int height, Color color);
fn nif_draw_rectangle(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const pos_x = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_pos_x;
    };

    const pos_y = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_pos_y;
    };

    const width = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_height;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawRectangle(pos_x, pos_y, width, height, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a color-filled rectangle (Vector version)
///
/// raylib.h
/// RLAPI void DrawRectangleV(Vector2 position, Vector2 size, Color color);
fn nif_draw_rectangle_v(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_position = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_size = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_size;
    };
    defer arg_size.free();
    const size = arg_size.data;

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawRectangleV(position, size, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a color-filled rectangle
///
/// raylib.h
/// RLAPI void DrawRectangleRec(Rectangle rec, Color color);
fn nif_draw_rectangle_rec(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_rec = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_rec;
    };
    defer arg_rec.free();
    const rec = arg_rec.data;

    const arg_color = core.Argument(core.Color).get(env, argv[1]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawRectangleRec(rec, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a color-filled rectangle with pro parameters
///
/// raylib.h
/// RLAPI void DrawRectanglePro(Rectangle rec, Vector2 origin, float rotation, Color color);
fn nif_draw_rectangle_pro(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_rec = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_rec;
    };
    defer arg_rec.free();
    const rec = arg_rec.data;

    const arg_origin = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_origin;
    };
    defer arg_origin.free();
    const origin = arg_origin.data;

    const rotation = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_rotation;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawRectanglePro(rec, origin, @floatCast(rotation), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a vertical-gradient-filled rectangle
///
/// raylib.h
/// RLAPI void DrawRectangleGradientV(int posX, int posY, int width, int height, Color top, Color bottom);
fn nif_draw_rectangle_gradient_v(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const pos_x = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_pos_x;
    };

    const pos_y = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_pos_y;
    };

    const width = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_height;
    };

    const arg_top = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_top;
    };
    defer arg_top.free();
    const top = arg_top.data;

    const arg_bottom = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_bottom;
    };
    defer arg_bottom.free();
    const bottom = arg_bottom.data;

    // Function

    rl.DrawRectangleGradientV(pos_x, pos_y, width, height, top, bottom);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a horizontal-gradient-filled rectangle
///
/// raylib.h
/// RLAPI void DrawRectangleGradientH(int posX, int posY, int width, int height, Color left, Color right);
fn nif_draw_rectangle_gradient_h(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const pos_x = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_pos_x;
    };

    const pos_y = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_pos_y;
    };

    const width = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_height;
    };

    const arg_left = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_left;
    };
    defer arg_left.free();
    const left = arg_left.data;

    const arg_right = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_right;
    };
    defer arg_right.free();
    const right = arg_right.data;

    // Function

    rl.DrawRectangleGradientH(pos_x, pos_y, width, height, left, right);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a gradient-filled rectangle with custom vertex colors
///
/// raylib.h
/// RLAPI void DrawRectangleGradientEx(Rectangle rec, Color topLeft, Color bottomLeft, Color topRight, Color bottomRight);
fn nif_draw_rectangle_gradient_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const arg_rec = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_rec;
    };
    defer arg_rec.free();
    const rec = arg_rec.data;

    const arg_top_left = core.Argument(core.Color).get(env, argv[1]) catch {
        return error.invalid_argument_top_left;
    };
    defer arg_top_left.free();
    const top_left = arg_top_left.data;

    const arg_bottom_left = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_bottom_left;
    };
    defer arg_bottom_left.free();
    const bottom_left = arg_bottom_left.data;

    const arg_top_right = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_top_right;
    };
    defer arg_top_right.free();
    const top_right = arg_top_right.data;

    const arg_bottom_right = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_bottom_right;
    };
    defer arg_bottom_right.free();
    const bottom_right = arg_bottom_right.data;

    // Function

    rl.DrawRectangleGradientEx(rec, top_left, bottom_left, top_right, bottom_right);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw rectangle outline
///
/// raylib.h
/// RLAPI void DrawRectangleLines(int posX, int posY, int width, int height, Color color);
fn nif_draw_rectangle_lines(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const pos_x = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_pos_x;
    };

    const pos_y = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_pos_y;
    };

    const width = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_height;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawRectangleLines(pos_x, pos_y, width, height, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw rectangle outline with extended parameters
///
/// raylib.h
/// RLAPI void DrawRectangleLinesEx(Rectangle rec, float lineThick, Color color);
fn nif_draw_rectangle_lines_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_rec = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_rec;
    };
    defer arg_rec.free();
    const rec = arg_rec.data;

    const line_thick = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_line_thick;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawRectangleLinesEx(rec, @floatCast(line_thick), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw rectangle with rounded edges
///
/// raylib.h
/// RLAPI void DrawRectangleRounded(Rectangle rec, float roundness, int segments, Color color);
fn nif_draw_rectangle_rounded(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_rec = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_rec;
    };
    defer arg_rec.free();
    const rec = arg_rec.data;

    const roundness = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_roundness;
    };

    const segments = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_segments;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawRectangleRounded(rec, @floatCast(roundness), segments, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw rectangle lines with rounded edges
///
/// raylib.h
/// RLAPI void DrawRectangleRoundedLines(Rectangle rec, float roundness, int segments, Color color);
fn nif_draw_rectangle_rounded_lines(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_rec = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_rec;
    };
    defer arg_rec.free();
    const rec = arg_rec.data;

    const roundness = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_roundness;
    };

    const segments = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_segments;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawRectangleRoundedLines(rec, @floatCast(roundness), segments, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw rectangle with rounded edges outline
///
/// raylib.h
/// RLAPI void DrawRectangleRoundedLinesEx(Rectangle rec, float roundness, int segments, float lineThick, Color color);
fn nif_draw_rectangle_rounded_lines_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const arg_rec = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_rec;
    };
    defer arg_rec.free();
    const rec = arg_rec.data;

    const roundness = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_roundness;
    };

    const segments = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_segments;
    };

    const line_thick = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_line_thick;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawRectangleRoundedLinesEx(rec, @floatCast(roundness), segments, @floatCast(line_thick), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a color-filled triangle (vertex in counter-clockwise order!)
///
/// raylib.h
/// RLAPI void DrawTriangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color);
fn nif_draw_triangle(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_v1 = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_v1;
    };
    defer arg_v1.free();
    const v1 = arg_v1.data;

    const arg_v2 = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_v2;
    };
    defer arg_v2.free();
    const v2 = arg_v2.data;

    const arg_v3 = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_v3;
    };
    defer arg_v3.free();
    const v3 = arg_v3.data;

    const arg_color = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawTriangle(v1, v2, v3, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw triangle outline (vertex in counter-clockwise order!)
///
/// raylib.h
/// RLAPI void DrawTriangleLines(Vector2 v1, Vector2 v2, Vector2 v3, Color color);
fn nif_draw_triangle_lines(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_v1 = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_v1;
    };
    defer arg_v1.free();
    const v1 = arg_v1.data;

    const arg_v2 = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_v2;
    };
    defer arg_v2.free();
    const v2 = arg_v2.data;

    const arg_v3 = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_v3;
    };
    defer arg_v3.free();
    const v3 = arg_v3.data;

    const arg_color = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawTriangleLines(v1, v2, v3, color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a triangle fan defined by points (first vertex is the center)
///
/// raylib.h
/// RLAPI void DrawTriangleFan(const Vector2 *points, int pointCount, Color color);
fn nif_draw_triangle_fan(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    var arg_points = core.ArgumentArray(core.Vector2, core.Vector2.data_type, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_points.free();
    const points = arg_points.data;
    const point_count = arg_points.length;

    const arg_color = core.Argument(core.Color).get(env, argv[1]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawTriangleFan(@ptrCast(points), @intCast(point_count), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a triangle strip defined by points
///
/// raylib.h
/// RLAPI void DrawTriangleStrip(const Vector2 *points, int pointCount, Color color);
fn nif_draw_triangle_strip(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    var arg_points = core.ArgumentArray(core.Vector2, core.Vector2.data_type, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_points.free();
    const points = arg_points.data;
    const point_count = arg_points.length;

    const arg_color = core.Argument(core.Color).get(env, argv[1]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawTriangleStrip(@ptrCast(points), @intCast(point_count), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a regular polygon (Vector version)
///
/// raylib.h
/// RLAPI void DrawPoly(Vector2 center, int sides, float radius, float rotation, Color color);
fn nif_draw_poly(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const arg_center = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_center;
    };
    defer arg_center.free();
    const center = arg_center.data;

    const sides = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_sides;
    };

    const radius = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_radius;
    };

    const rotation = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_rotation;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawPoly(center, sides, @floatCast(radius), @floatCast(rotation), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a polygon outline of n sides
///
/// raylib.h
/// RLAPI void DrawPolyLines(Vector2 center, int sides, float radius, float rotation, Color color);
fn nif_draw_poly_lines(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const arg_center = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_center;
    };
    defer arg_center.free();
    const center = arg_center.data;

    const sides = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_sides;
    };

    const radius = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_radius;
    };

    const rotation = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_rotation;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawPolyLines(center, sides, @floatCast(radius), @floatCast(rotation), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw a polygon outline of n sides with extended parameters
///
/// raylib.h
/// RLAPI void DrawPolyLinesEx(Vector2 center, int sides, float radius, float rotation, float lineThick, Color color);
fn nif_draw_poly_lines_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_center = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_center;
    };
    defer arg_center.free();
    const center = arg_center.data;

    const sides = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_sides;
    };

    const radius = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_radius;
    };

    const rotation = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_rotation;
    };

    const line_thick = core.Double.get(env, argv[4]) catch {
        return error.invalid_argument_line_thick;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawPolyLinesEx(center, sides, @floatCast(radius), @floatCast(rotation), @floatCast(line_thick), color);

    // Return

    return core.Atom.make(env, "ok");
}

///////////////////////
//  Splines drawing  //
///////////////////////

/// Draw spline: Linear, minimum 2 points
///
/// raylib.h
/// RLAPI void DrawSplineLinear(const Vector2 *points, int pointCount, float thick, Color color);
fn nif_draw_spline_linear(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    var arg_points = core.ArgumentArray(core.Vector2, core.Vector2.data_type, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_points.free();
    const points = arg_points.data;
    const point_count = arg_points.length;

    const thick = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_thick;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawSplineLinear(@ptrCast(points), @intCast(point_count), @floatCast(thick), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw spline: B-Spline, minimum 4 points
///
/// raylib.h
/// RLAPI void DrawSplineBasis(const Vector2 *points, int pointCount, float thick, Color color);
fn nif_draw_spline_basis(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    var arg_points = core.ArgumentArray(core.Vector2, core.Vector2.data_type, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_points.free();
    const points = arg_points.data;
    const point_count = arg_points.length;

    const thick = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_thick;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawSplineBasis(@ptrCast(points), @intCast(point_count), @floatCast(thick), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw spline: Catmull-Rom, minimum 4 points
///
/// raylib.h
/// RLAPI void DrawSplineCatmullRom(const Vector2 *points, int pointCount, float thick, Color color);
fn nif_draw_spline_catmull_rom(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    var arg_points = core.ArgumentArray(core.Vector2, core.Vector2.data_type, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_points.free();
    const points = arg_points.data;
    const point_count = arg_points.length;

    const thick = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_thick;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawSplineCatmullRom(@ptrCast(points), @intCast(point_count), @floatCast(thick), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]
///
/// raylib.h
/// RLAPI void DrawSplineBezierQuadratic(const Vector2 *points, int pointCount, float thick, Color color);
fn nif_draw_spline_bezier_quadratic(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    var arg_points = core.ArgumentArray(core.Vector2, core.Vector2.data_type, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_points.free();
    const points = arg_points.data;
    const point_count = arg_points.length;

    const thick = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_thick;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawSplineBezierQuadratic(@ptrCast(points), @intCast(point_count), @floatCast(thick), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]
///
/// raylib.h
/// RLAPI void DrawSplineBezierCubic(const Vector2 *points, int pointCount, float thick, Color color);
fn nif_draw_spline_bezier_cubic(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    var arg_points = core.ArgumentArray(core.Vector2, core.Vector2.data_type, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_points.free();
    const points = arg_points.data;
    const point_count = arg_points.length;

    const thick = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_thick;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawSplineBezierCubic(@ptrCast(points), @intCast(point_count), @floatCast(thick), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw spline segment: Linear, 2 points
///
/// raylib.h
/// RLAPI void DrawSplineSegmentLinear(Vector2 p1, Vector2 p2, float thick, Color color);
fn nif_draw_spline_segment_linear(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_p1 = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_p1;
    };
    defer arg_p1.free();
    const p1 = arg_p1.data;

    const arg_p2 = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_p2;
    };
    defer arg_p2.free();
    const p2 = arg_p2.data;

    const thick = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_thick;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawSplineSegmentLinear(p1, p2, @floatCast(thick), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw spline segment: B-Spline, 4 points
///
/// raylib.h
/// RLAPI void DrawSplineSegmentBasis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color);
fn nif_draw_spline_segment_basis(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_p1 = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_p1;
    };
    defer arg_p1.free();
    const p1 = arg_p1.data;

    const arg_p2 = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_p2;
    };
    defer arg_p2.free();
    const p2 = arg_p2.data;

    const arg_p3 = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_p3;
    };
    defer arg_p3.free();
    const p3 = arg_p3.data;

    const arg_p4 = core.Argument(core.Vector2).get(env, argv[3]) catch {
        return error.invalid_argument_p4;
    };
    defer arg_p4.free();
    const p4 = arg_p4.data;

    const thick = core.Double.get(env, argv[4]) catch {
        return error.invalid_argument_thick;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawSplineSegmentBasis(p1, p2, p3, p4, @floatCast(thick), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw spline segment: Catmull-Rom, 4 points
///
/// raylib.h
/// RLAPI void DrawSplineSegmentCatmullRom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color);
fn nif_draw_spline_segment_catmull_rom(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_p1 = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_p1;
    };
    defer arg_p1.free();
    const p1 = arg_p1.data;

    const arg_p2 = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_p2;
    };
    defer arg_p2.free();
    const p2 = arg_p2.data;

    const arg_p3 = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_p3;
    };
    defer arg_p3.free();
    const p3 = arg_p3.data;

    const arg_p4 = core.Argument(core.Vector2).get(env, argv[3]) catch {
        return error.invalid_argument_p4;
    };
    defer arg_p4.free();
    const p4 = arg_p4.data;

    const thick = core.Double.get(env, argv[4]) catch {
        return error.invalid_argument_thick;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawSplineSegmentCatmullRom(p1, p2, p3, p4, @floatCast(thick), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw spline segment: Quadratic Bezier, 2 points, 1 control point
///
/// raylib.h
/// RLAPI void DrawSplineSegmentBezierQuadratic(Vector2 p1, Vector2 c2, Vector2 p3, float thick, Color color);
fn nif_draw_spline_segment_bezier_quadratic(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5);

    // Arguments

    const arg_p1 = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_p1;
    };
    defer arg_p1.free();
    const p1 = arg_p1.data;

    const arg_c2 = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_c2;
    };
    defer arg_c2.free();
    const c2 = arg_c2.data;

    const arg_p3 = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_p3;
    };
    defer arg_p3.free();
    const p3 = arg_p3.data;

    const thick = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_thick;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawSplineSegmentBezierQuadratic(p1, c2, p3, @floatCast(thick), color);

    // Return

    return core.Atom.make(env, "ok");
}

/// Draw spline segment: Cubic Bezier, 2 points, 2 control points
///
/// raylib.h
/// RLAPI void DrawSplineSegmentBezierCubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float thick, Color color);
fn nif_draw_spline_segment_bezier_cubic(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6);

    // Arguments

    const arg_p1 = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_p1;
    };
    defer arg_p1.free();
    const p1 = arg_p1.data;

    const arg_c2 = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_c2;
    };
    defer arg_c2.free();
    const c2 = arg_c2.data;

    const arg_c3 = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_c3;
    };
    defer arg_c3.free();
    const c3 = arg_c3.data;

    const arg_p4 = core.Argument(core.Vector2).get(env, argv[3]) catch {
        return error.invalid_argument_p4;
    };
    defer arg_p4.free();
    const p4 = arg_p4.data;

    const thick = core.Double.get(env, argv[4]) catch {
        return error.invalid_argument_thick;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.DrawSplineSegmentBezierCubic(p1, c2, c3, p4, @floatCast(thick), color);

    // Return

    return core.Atom.make(env, "ok");
}

///////////////////////////////////////
//  Spline segment point evaluation  //
///////////////////////////////////////

/// Get (evaluate) spline point: Linear
///
/// raylib.h
/// RLAPI Vector2 GetSplinePointLinear(Vector2 startPos, Vector2 endPos, float t);
fn nif_get_spline_point_linear(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const arg_start_pos = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_start_pos;
    };
    defer arg_start_pos.free();
    const start_pos = arg_start_pos.data;

    const arg_end_pos = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_end_pos;
    };
    defer arg_end_pos.free();
    const end_pos = arg_end_pos.data;

    const t = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_t;
    };

    // Function

    const point = rl.GetSplinePointLinear(start_pos, end_pos, @floatCast(t));
    defer if (!return_resource) core.Vector2.free(point);
    errdefer if (return_resource) core.Vector2.free(point);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector2, env, point, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get (evaluate) spline point: B-Spline
///
/// raylib.h
/// RLAPI Vector2 GetSplinePointBasis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t);
fn nif_get_spline_point_basis(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 5);

    // Arguments

    const arg_p1 = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_p1;
    };
    defer arg_p1.free();
    const p1 = arg_p1.data;

    const arg_p2 = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_p2;
    };
    defer arg_p2.free();
    const p2 = arg_p2.data;

    const arg_p3 = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_p3;
    };
    defer arg_p3.free();
    const p3 = arg_p3.data;

    const arg_p4 = core.Argument(core.Vector2).get(env, argv[3]) catch {
        return error.invalid_argument_p4;
    };
    defer arg_p4.free();
    const p4 = arg_p4.data;

    const t = core.Double.get(env, argv[4]) catch {
        return error.invalid_argument_t;
    };

    // Function

    const point = rl.GetSplinePointBasis(p1, p2, p3, p4, @floatCast(t));
    defer if (!return_resource) core.Vector2.free(point);
    errdefer if (return_resource) core.Vector2.free(point);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector2, env, point, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get (evaluate) spline point: Catmull-Rom
///
/// raylib.h
/// RLAPI Vector2 GetSplinePointCatmullRom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t);
fn nif_get_spline_point_catmull_rom(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 5);

    // Arguments

    const arg_p1 = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_p1;
    };
    defer arg_p1.free();
    const p1 = arg_p1.data;

    const arg_p2 = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_p2;
    };
    defer arg_p2.free();
    const p2 = arg_p2.data;

    const arg_p3 = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_p3;
    };
    defer arg_p3.free();
    const p3 = arg_p3.data;

    const arg_p4 = core.Argument(core.Vector2).get(env, argv[3]) catch {
        return error.invalid_argument_p4;
    };
    defer arg_p4.free();
    const p4 = arg_p4.data;

    const t = core.Double.get(env, argv[4]) catch {
        return error.invalid_argument_t;
    };

    // Function

    const point = rl.GetSplinePointCatmullRom(p1, p2, p3, p4, @floatCast(t));
    defer if (!return_resource) core.Vector2.free(point);
    errdefer if (return_resource) core.Vector2.free(point);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector2, env, point, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get (evaluate) spline point: Quadratic Bezier
///
/// raylib.h
/// RLAPI Vector2 GetSplinePointBezierQuad(Vector2 p1, Vector2 c2, Vector2 p3, float t);
fn nif_get_spline_point_bezier_quad(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4 or argc == 5);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 4);

    // Arguments

    const arg_p1 = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_p1;
    };
    defer arg_p1.free();
    const p1 = arg_p1.data;

    const arg_c2 = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_c2;
    };
    defer arg_c2.free();
    const c2 = arg_c2.data;

    const arg_p3 = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_p3;
    };
    defer arg_p3.free();
    const p3 = arg_p3.data;

    const t = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_t;
    };

    // Function

    const point = rl.GetSplinePointBezierQuad(p1, c2, p3, @floatCast(t));
    defer if (!return_resource) core.Vector2.free(point);
    errdefer if (return_resource) core.Vector2.free(point);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector2, env, point, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get (evaluate) spline point: Cubic Bezier
///
/// raylib.h
/// RLAPI Vector2 GetSplinePointBezierCubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float t);
fn nif_get_spline_point_bezier_cubic(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 5);

    // Arguments

    const arg_p1 = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_p1;
    };
    defer arg_p1.free();
    const p1 = arg_p1.data;

    const arg_c2 = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_c2;
    };
    defer arg_c2.free();
    const c2 = arg_c2.data;

    const arg_c3 = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_c3;
    };
    defer arg_c3.free();
    const c3 = arg_c3.data;

    const arg_p4 = core.Argument(core.Vector2).get(env, argv[3]) catch {
        return error.invalid_argument_p4;
    };
    defer arg_p4.free();
    const p4 = arg_p4.data;

    const t = core.Double.get(env, argv[4]) catch {
        return error.invalid_argument_t;
    };

    // Function

    const point = rl.GetSplinePointBezierCubic(p1, c2, c3, p4, @floatCast(t));
    defer if (!return_resource) core.Vector2.free(point);
    errdefer if (return_resource) core.Vector2.free(point);

    // Return

    return core.maybe_make_struct_as_resource(core.Vector2, env, point, return_resource) catch {
        return error.invalid_return;
    };
}

////////////////////////////////////////
//  Basic shapes collision detection  //
////////////////////////////////////////

/// Check collision between two rectangles
///
/// raylib.h
/// RLAPI bool CheckCollisionRecs(Rectangle rec1, Rectangle rec2);
fn nif_check_collision_recs(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_rec1 = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_rec1;
    };
    defer arg_rec1.free();
    const rec1 = arg_rec1.data;

    const arg_rec2 = core.Argument(core.Rectangle).get(env, argv[1]) catch {
        return error.invalid_argument_rec2;
    };
    defer arg_rec2.free();
    const rec2 = arg_rec2.data;

    // Function

    const collision = rl.CheckCollisionRecs(rec1, rec2);

    // Return

    return core.Boolean.make(env, collision);
}

/// Check collision between two circles
///
/// raylib.h
/// RLAPI bool CheckCollisionCircles(Vector2 center1, float radius1, Vector2 center2, float radius2);
fn nif_check_collision_circles(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_center1 = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_center1;
    };
    defer arg_center1.free();
    const center1 = arg_center1.data;

    const radius1 = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_radius1;
    };

    const arg_center2 = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_center2;
    };
    defer arg_center2.free();
    const center2 = arg_center2.data;

    const radius2 = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_radius2;
    };

    // Function

    const collision = rl.CheckCollisionCircles(center1, @floatCast(radius1), center2, @floatCast(radius2));

    // Return

    return core.Boolean.make(env, collision);
}

/// Check collision between circle and rectangle
///
/// raylib.h
/// RLAPI bool CheckCollisionCircleRec(Vector2 center, float radius, Rectangle rec);
fn nif_check_collision_circle_rec(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_center = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_center;
    };
    defer arg_center.free();
    const center = arg_center.data;

    const radius = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_radius;
    };

    const arg_rec = core.Argument(core.Rectangle).get(env, argv[2]) catch {
        return error.invalid_argument_rec;
    };
    defer arg_rec.free();
    const rec = arg_rec.data;

    // Function

    const collision = rl.CheckCollisionCircleRec(center, @floatCast(radius), rec);

    // Return

    return core.Boolean.make(env, collision);
}

/// Check if circle collides with a line created betweeen two points [p1] and [p2]
///
/// raylib.h
/// RLAPI bool CheckCollisionCircleLine(Vector2 center, float radius, Vector2 p1, Vector2 p2);
fn nif_check_collision_circle_line(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_center = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_center;
    };
    defer arg_center.free();
    const center = arg_center.data;

    const radius = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_radius;
    };

    const arg_p1 = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_p1;
    };
    defer arg_p1.free();
    const p1 = arg_p1.data;

    const arg_p2 = core.Argument(core.Vector2).get(env, argv[3]) catch {
        return error.invalid_argument_p2;
    };
    defer arg_p2.free();
    const p2 = arg_p2.data;

    // Function

    const collision = rl.CheckCollisionCircleLine(center, @floatCast(radius), p1, p2);

    // Return

    return core.Boolean.make(env, collision);
}

/// Check if point is inside rectangle
///
/// raylib.h
/// RLAPI bool CheckCollisionPointRec(Vector2 point, Rectangle rec);
fn nif_check_collision_point_rec(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_point = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_point;
    };
    defer arg_point.free();
    const point = arg_point.data;

    const arg_rec = core.Argument(core.Rectangle).get(env, argv[1]) catch {
        return error.invalid_argument_rec;
    };
    defer arg_rec.free();
    const rec = arg_rec.data;

    // Function

    const collision = rl.CheckCollisionPointRec(point, rec);

    // Return

    return core.Boolean.make(env, collision);
}

/// Check if point is inside circle
///
/// raylib.h
/// RLAPI bool CheckCollisionPointCircle(Vector2 point, Vector2 center, float radius);
fn nif_check_collision_point_circle(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const arg_point = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_point;
    };
    defer arg_point.free();
    const point = arg_point.data;

    const arg_center = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_center;
    };
    defer arg_center.free();
    const center = arg_center.data;

    const radius = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_radius;
    };

    // Function

    const collision = rl.CheckCollisionPointCircle(point, center, @floatCast(radius));

    // Return

    return core.Boolean.make(env, collision);
}

/// Check if point is inside a triangle
///
/// raylib.h
/// RLAPI bool CheckCollisionPointTriangle(Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3);
fn nif_check_collision_point_triangle(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_point = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_point;
    };
    defer arg_point.free();
    const point = arg_point.data;

    const arg_p1 = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_p1;
    };
    defer arg_p1.free();
    const p1 = arg_p1.data;

    const arg_p2 = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_p2;
    };
    defer arg_p2.free();
    const p2 = arg_p2.data;

    const arg_p3 = core.Argument(core.Vector2).get(env, argv[3]) catch {
        return error.invalid_argument_p3;
    };
    defer arg_p3.free();
    const p3 = arg_p3.data;

    // Function

    const collision = rl.CheckCollisionPointTriangle(point, p1, p2, p3);

    // Return

    return core.Boolean.make(env, collision);
}

/// Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
///
/// raylib.h
/// RLAPI bool CheckCollisionPointLine(Vector2 point, Vector2 p1, Vector2 p2, int threshold);
fn nif_check_collision_point_line(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const arg_point = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_point;
    };
    defer arg_point.free();
    const point = arg_point.data;

    const arg_p1 = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_p1;
    };
    defer arg_p1.free();
    const p1 = arg_p1.data;

    const arg_p2 = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_p2;
    };
    defer arg_p2.free();
    const p2 = arg_p2.data;

    const threshold = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_threshold;
    };

    // Function

    const collision = rl.CheckCollisionPointLine(point, p1, p2, threshold);

    // Return

    return core.Boolean.make(env, collision);
}

/// Check if point is within a polygon described by array of vertices
///
/// raylib.h
/// RLAPI bool CheckCollisionPointPoly(Vector2 point, const Vector2 *points, int pointCount);
fn nif_check_collision_point_poly(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_point = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_point;
    };
    defer arg_point.free();
    const point = arg_point.data;

    var arg_points = core.ArgumentArray(core.Vector2, core.Vector2.data_type, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_image;
    };
    defer arg_points.free();
    const points = arg_points.data;
    const point_count = arg_points.length;

    // Function

    const collision = rl.CheckCollisionPointPoly(point, @ptrCast(points), @intCast(point_count));

    // Return

    return core.Boolean.make(env, collision);
}

/// Check the collision between two lines defined by two points each, returns collision point by reference
///
/// raylib.h
/// RLAPI bool CheckCollisionLines(Vector2 startPos1, Vector2 endPos1, Vector2 startPos2, Vector2 endPos2, Vector2 *collisionPoint);
fn nif_check_collision_lines(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4 or argc == 5);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 4);

    // Arguments

    const arg_start_pos1 = core.Argument(core.Vector2).get(env, argv[0]) catch {
        return error.invalid_argument_start_pos1;
    };
    defer arg_start_pos1.free();
    const start_pos1 = arg_start_pos1.data;

    const arg_end_pos1 = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_end_pos1;
    };
    defer arg_end_pos1.free();
    const end_pos1 = arg_end_pos1.data;

    const arg_start_pos2 = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_start_pos2;
    };
    defer arg_start_pos2.free();
    const start_pos2 = arg_start_pos2.data;

    const arg_end_pos2 = core.Argument(core.Vector2).get(env, argv[3]) catch {
        return error.invalid_argument_end_pos2;
    };
    defer arg_end_pos2.free();
    const end_pos2 = arg_end_pos2.data;

    // Function

    var collision_point = rl.Vector2{};
    const collision = rl.CheckCollisionLines(start_pos1, end_pos1, start_pos2, end_pos2, &collision_point);
    defer if (!return_resource) core.Vector2.free(collision_point);
    errdefer if (return_resource) core.Vector2.free(collision_point);

    // Return

    const term_collision_point = core.maybe_make_struct_as_resource(core.Vector2, env, collision_point, return_resource) catch {
        return error.invalid_return;
    };

    const term_collision = core.Boolean.make(env, collision);

    return e.enif_make_tuple2(env, term_collision, term_collision_point);
}

/// Get collision rectangle for two rectangles collision
///
/// raylib.h
/// RLAPI Rectangle GetCollisionRec(Rectangle rec1, Rectangle rec2);
fn nif_get_collision_rec(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_rec1 = core.Argument(core.Rectangle).get(env, argv[0]) catch {
        return error.invalid_argument_rec1;
    };
    defer arg_rec1.free();
    const rec1 = arg_rec1.data;

    const arg_rec2 = core.Argument(core.Rectangle).get(env, argv[1]) catch {
        return error.invalid_argument_rec2;
    };
    defer arg_rec2.free();
    const rec2 = arg_rec2.data;

    // Function

    const collision_rec = rl.GetCollisionRec(rec1, rec2);
    defer if (!return_resource) core.Rectangle.free(collision_rec);
    errdefer if (return_resource) core.Rectangle.free(collision_rec);

    // Return

    return core.maybe_make_struct_as_resource(core.Rectangle, env, collision_rec, return_resource) catch {
        return error.invalid_return;
    };
}
