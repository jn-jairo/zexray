const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Image
    .{ .name = "image_get_data_size", .arity = 4, .fptr = core.nif_wrapper(nif_image_get_data_size), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Image loading
    .{ .name = "load_image", .arity = 1, .fptr = core.nif_wrapper(nif_load_image), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_image", .arity = 2, .fptr = core.nif_wrapper(nif_load_image), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_image_raw", .arity = 5, .fptr = core.nif_wrapper(nif_load_image_raw), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_image_raw", .arity = 6, .fptr = core.nif_wrapper(nif_load_image_raw), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_image_anim", .arity = 1, .fptr = core.nif_wrapper(nif_load_image_anim), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_image_anim", .arity = 2, .fptr = core.nif_wrapper(nif_load_image_anim), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_image_anim_from_memory", .arity = 2, .fptr = core.nif_wrapper(nif_load_image_anim_from_memory), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_image_anim_from_memory", .arity = 3, .fptr = core.nif_wrapper(nif_load_image_anim_from_memory), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_image_from_memory", .arity = 2, .fptr = core.nif_wrapper(nif_load_image_from_memory), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_image_from_memory", .arity = 3, .fptr = core.nif_wrapper(nif_load_image_from_memory), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_image_from_texture", .arity = 1, .fptr = core.nif_wrapper(nif_load_image_from_texture), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_image_from_texture", .arity = 2, .fptr = core.nif_wrapper(nif_load_image_from_texture), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_image_from_screen", .arity = 0, .fptr = core.nif_wrapper(nif_load_image_from_screen), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_image_from_screen", .arity = 1, .fptr = core.nif_wrapper(nif_load_image_from_screen), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_image_valid", .arity = 1, .fptr = core.nif_wrapper(nif_is_image_valid), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "export_image", .arity = 2, .fptr = core.nif_wrapper(nif_export_image), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "export_image_to_memory", .arity = 2, .fptr = core.nif_wrapper(nif_export_image_to_memory), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Image generation
    .{ .name = "gen_image_color", .arity = 3, .fptr = core.nif_wrapper(nif_gen_image_color), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_image_color", .arity = 4, .fptr = core.nif_wrapper(nif_gen_image_color), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_image_gradient_linear", .arity = 5, .fptr = core.nif_wrapper(nif_gen_image_gradient_linear), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_image_gradient_linear", .arity = 6, .fptr = core.nif_wrapper(nif_gen_image_gradient_linear), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_image_gradient_radial", .arity = 5, .fptr = core.nif_wrapper(nif_gen_image_gradient_radial), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_image_gradient_radial", .arity = 6, .fptr = core.nif_wrapper(nif_gen_image_gradient_radial), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_image_gradient_square", .arity = 5, .fptr = core.nif_wrapper(nif_gen_image_gradient_square), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_image_gradient_square", .arity = 6, .fptr = core.nif_wrapper(nif_gen_image_gradient_square), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_image_checked", .arity = 6, .fptr = core.nif_wrapper(nif_gen_image_checked), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_image_checked", .arity = 7, .fptr = core.nif_wrapper(nif_gen_image_checked), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_image_white_noise", .arity = 3, .fptr = core.nif_wrapper(nif_gen_image_white_noise), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_image_white_noise", .arity = 4, .fptr = core.nif_wrapper(nif_gen_image_white_noise), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_image_perlin_noise", .arity = 5, .fptr = core.nif_wrapper(nif_gen_image_perlin_noise), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_image_perlin_noise", .arity = 6, .fptr = core.nif_wrapper(nif_gen_image_perlin_noise), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_image_cellular", .arity = 3, .fptr = core.nif_wrapper(nif_gen_image_cellular), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_image_cellular", .arity = 4, .fptr = core.nif_wrapper(nif_gen_image_cellular), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_image_text", .arity = 3, .fptr = core.nif_wrapper(nif_gen_image_text), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "gen_image_text", .arity = 4, .fptr = core.nif_wrapper(nif_gen_image_text), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Image manipulation
    .{ .name = "image_copy", .arity = 1, .fptr = core.nif_wrapper(nif_image_copy), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_copy", .arity = 2, .fptr = core.nif_wrapper(nif_image_copy), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_from_image", .arity = 2, .fptr = core.nif_wrapper(nif_image_from_image), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_from_image", .arity = 3, .fptr = core.nif_wrapper(nif_image_from_image), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_from_channel", .arity = 2, .fptr = core.nif_wrapper(nif_image_from_channel), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_from_channel", .arity = 3, .fptr = core.nif_wrapper(nif_image_from_channel), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_text", .arity = 3, .fptr = core.nif_wrapper(nif_image_text), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_text", .arity = 4, .fptr = core.nif_wrapper(nif_image_text), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_text_ex", .arity = 5, .fptr = core.nif_wrapper(nif_image_text_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_text_ex", .arity = 6, .fptr = core.nif_wrapper(nif_image_text_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_format", .arity = 2, .fptr = core.nif_wrapper(nif_image_format), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_format", .arity = 3, .fptr = core.nif_wrapper(nif_image_format), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_to_pot", .arity = 2, .fptr = core.nif_wrapper(nif_image_to_pot), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_to_pot", .arity = 3, .fptr = core.nif_wrapper(nif_image_to_pot), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_crop", .arity = 2, .fptr = core.nif_wrapper(nif_image_crop), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_crop", .arity = 3, .fptr = core.nif_wrapper(nif_image_crop), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_alpha_crop", .arity = 2, .fptr = core.nif_wrapper(nif_image_alpha_crop), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_alpha_crop", .arity = 3, .fptr = core.nif_wrapper(nif_image_alpha_crop), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_alpha_clear", .arity = 3, .fptr = core.nif_wrapper(nif_image_alpha_clear), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_alpha_clear", .arity = 4, .fptr = core.nif_wrapper(nif_image_alpha_clear), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_alpha_mask", .arity = 2, .fptr = core.nif_wrapper(nif_image_alpha_mask), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_alpha_mask", .arity = 3, .fptr = core.nif_wrapper(nif_image_alpha_mask), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_alpha_premultiply", .arity = 1, .fptr = core.nif_wrapper(nif_image_alpha_premultiply), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_alpha_premultiply", .arity = 2, .fptr = core.nif_wrapper(nif_image_alpha_premultiply), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_blur_gaussian", .arity = 2, .fptr = core.nif_wrapper(nif_image_blur_gaussian), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_blur_gaussian", .arity = 3, .fptr = core.nif_wrapper(nif_image_blur_gaussian), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_kernel_convolution", .arity = 2, .fptr = core.nif_wrapper(nif_image_kernel_convolution), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_kernel_convolution", .arity = 3, .fptr = core.nif_wrapper(nif_image_kernel_convolution), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_resize", .arity = 3, .fptr = core.nif_wrapper(nif_image_resize), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_resize", .arity = 4, .fptr = core.nif_wrapper(nif_image_resize), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_resize_nn", .arity = 3, .fptr = core.nif_wrapper(nif_image_resize_nn), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_resize_nn", .arity = 4, .fptr = core.nif_wrapper(nif_image_resize_nn), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_resize_canvas", .arity = 6, .fptr = core.nif_wrapper(nif_image_resize_canvas), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_resize_canvas", .arity = 7, .fptr = core.nif_wrapper(nif_image_resize_canvas), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_mipmaps", .arity = 1, .fptr = core.nif_wrapper(nif_image_mipmaps), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_mipmaps", .arity = 2, .fptr = core.nif_wrapper(nif_image_mipmaps), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_dither", .arity = 5, .fptr = core.nif_wrapper(nif_image_dither), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_dither", .arity = 6, .fptr = core.nif_wrapper(nif_image_dither), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_flip_vertical", .arity = 1, .fptr = core.nif_wrapper(nif_image_flip_vertical), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_flip_vertical", .arity = 2, .fptr = core.nif_wrapper(nif_image_flip_vertical), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_flip_horizontal", .arity = 1, .fptr = core.nif_wrapper(nif_image_flip_horizontal), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_flip_horizontal", .arity = 2, .fptr = core.nif_wrapper(nif_image_flip_horizontal), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_rotate", .arity = 2, .fptr = core.nif_wrapper(nif_image_rotate), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_rotate", .arity = 3, .fptr = core.nif_wrapper(nif_image_rotate), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_rotate_cw", .arity = 1, .fptr = core.nif_wrapper(nif_image_rotate_cw), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_rotate_cw", .arity = 2, .fptr = core.nif_wrapper(nif_image_rotate_cw), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_rotate_ccw", .arity = 1, .fptr = core.nif_wrapper(nif_image_rotate_ccw), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_rotate_ccw", .arity = 2, .fptr = core.nif_wrapper(nif_image_rotate_ccw), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_color_tint", .arity = 2, .fptr = core.nif_wrapper(nif_image_color_tint), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_color_tint", .arity = 3, .fptr = core.nif_wrapper(nif_image_color_tint), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_color_invert", .arity = 1, .fptr = core.nif_wrapper(nif_image_color_invert), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_color_invert", .arity = 2, .fptr = core.nif_wrapper(nif_image_color_invert), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_color_grayscale", .arity = 1, .fptr = core.nif_wrapper(nif_image_color_grayscale), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_color_grayscale", .arity = 2, .fptr = core.nif_wrapper(nif_image_color_grayscale), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_color_contrast", .arity = 2, .fptr = core.nif_wrapper(nif_image_color_contrast), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_color_contrast", .arity = 3, .fptr = core.nif_wrapper(nif_image_color_contrast), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_color_brightness", .arity = 2, .fptr = core.nif_wrapper(nif_image_color_brightness), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_color_brightness", .arity = 3, .fptr = core.nif_wrapper(nif_image_color_brightness), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_color_replace", .arity = 3, .fptr = core.nif_wrapper(nif_image_color_replace), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_color_replace", .arity = 4, .fptr = core.nif_wrapper(nif_image_color_replace), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_image_colors", .arity = 1, .fptr = core.nif_wrapper(nif_load_image_colors), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_image_colors", .arity = 2, .fptr = core.nif_wrapper(nif_load_image_colors), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_image_palette", .arity = 2, .fptr = core.nif_wrapper(nif_load_image_palette), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_image_palette", .arity = 3, .fptr = core.nif_wrapper(nif_load_image_palette), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_image_alpha_border", .arity = 2, .fptr = core.nif_wrapper(nif_get_image_alpha_border), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_image_alpha_border", .arity = 3, .fptr = core.nif_wrapper(nif_get_image_alpha_border), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_image_color", .arity = 3, .fptr = core.nif_wrapper(nif_get_image_color), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_image_color", .arity = 4, .fptr = core.nif_wrapper(nif_get_image_color), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Image drawing
    .{ .name = "image_clear_background", .arity = 2, .fptr = core.nif_wrapper(nif_image_clear_background), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_clear_background", .arity = 3, .fptr = core.nif_wrapper(nif_image_clear_background), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_pixel", .arity = 4, .fptr = core.nif_wrapper(nif_image_draw_pixel), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_pixel", .arity = 5, .fptr = core.nif_wrapper(nif_image_draw_pixel), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_pixel_v", .arity = 3, .fptr = core.nif_wrapper(nif_image_draw_pixel_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_pixel_v", .arity = 4, .fptr = core.nif_wrapper(nif_image_draw_pixel_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_line", .arity = 6, .fptr = core.nif_wrapper(nif_image_draw_line), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_line", .arity = 7, .fptr = core.nif_wrapper(nif_image_draw_line), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_line_v", .arity = 4, .fptr = core.nif_wrapper(nif_image_draw_line_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_line_v", .arity = 5, .fptr = core.nif_wrapper(nif_image_draw_line_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_line_ex", .arity = 5, .fptr = core.nif_wrapper(nif_image_draw_line_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_line_ex", .arity = 6, .fptr = core.nif_wrapper(nif_image_draw_line_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_circle", .arity = 5, .fptr = core.nif_wrapper(nif_image_draw_circle), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_circle", .arity = 6, .fptr = core.nif_wrapper(nif_image_draw_circle), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_circle_v", .arity = 4, .fptr = core.nif_wrapper(nif_image_draw_circle_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_circle_v", .arity = 5, .fptr = core.nif_wrapper(nif_image_draw_circle_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_circle_lines", .arity = 5, .fptr = core.nif_wrapper(nif_image_draw_circle_lines), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_circle_lines", .arity = 6, .fptr = core.nif_wrapper(nif_image_draw_circle_lines), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_circle_lines_v", .arity = 4, .fptr = core.nif_wrapper(nif_image_draw_circle_lines_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_circle_lines_v", .arity = 5, .fptr = core.nif_wrapper(nif_image_draw_circle_lines_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_rectangle", .arity = 6, .fptr = core.nif_wrapper(nif_image_draw_rectangle), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_rectangle", .arity = 7, .fptr = core.nif_wrapper(nif_image_draw_rectangle), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_rectangle_v", .arity = 4, .fptr = core.nif_wrapper(nif_image_draw_rectangle_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_rectangle_v", .arity = 5, .fptr = core.nif_wrapper(nif_image_draw_rectangle_v), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_rectangle_rec", .arity = 3, .fptr = core.nif_wrapper(nif_image_draw_rectangle_rec), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_rectangle_rec", .arity = 4, .fptr = core.nif_wrapper(nif_image_draw_rectangle_rec), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_rectangle_lines", .arity = 4, .fptr = core.nif_wrapper(nif_image_draw_rectangle_lines), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_rectangle_lines", .arity = 5, .fptr = core.nif_wrapper(nif_image_draw_rectangle_lines), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_triangle", .arity = 5, .fptr = core.nif_wrapper(nif_image_draw_triangle), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_triangle", .arity = 6, .fptr = core.nif_wrapper(nif_image_draw_triangle), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_triangle_ex", .arity = 7, .fptr = core.nif_wrapper(nif_image_draw_triangle_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_triangle_ex", .arity = 8, .fptr = core.nif_wrapper(nif_image_draw_triangle_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_triangle_lines", .arity = 5, .fptr = core.nif_wrapper(nif_image_draw_triangle_lines), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_triangle_lines", .arity = 6, .fptr = core.nif_wrapper(nif_image_draw_triangle_lines), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_triangle_fan", .arity = 3, .fptr = core.nif_wrapper(nif_image_draw_triangle_fan), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_triangle_fan", .arity = 4, .fptr = core.nif_wrapper(nif_image_draw_triangle_fan), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_triangle_strip", .arity = 3, .fptr = core.nif_wrapper(nif_image_draw_triangle_strip), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_triangle_strip", .arity = 4, .fptr = core.nif_wrapper(nif_image_draw_triangle_strip), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw", .arity = 5, .fptr = core.nif_wrapper(nif_image_draw), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw", .arity = 6, .fptr = core.nif_wrapper(nif_image_draw), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_text", .arity = 6, .fptr = core.nif_wrapper(nif_image_draw_text), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_text", .arity = 7, .fptr = core.nif_wrapper(nif_image_draw_text), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_text_ex", .arity = 7, .fptr = core.nif_wrapper(nif_image_draw_text_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "image_draw_text_ex", .arity = 8, .fptr = core.nif_wrapper(nif_image_draw_text_ex), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

/////////////
//  Image  //
/////////////

/// Get image data size in bytes for certain format
///
/// pub fn get_data_size(width: c_int, height: c_int, format: c_int, mipmaps: c_int) usize
fn nif_image_get_data_size(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const width = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_height;
    };

    const format = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_format;
    };

    const mipmaps = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_mipmaps;
    };

    // Function

    const data_size = core.Image.get_data_size(width, height, format, mipmaps);

    // Return

    return core.UInt.make(env, @intCast(data_size));
}

/////////////////////
//  Image loading  //
/////////////////////

/// Load image from file into CPU memory (RAM)
///
/// raylib.h
/// RLAPI Image LoadImage(const char *fileName);
fn nif_load_image(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_file_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_file_name;
    };
    defer arg_file_name.free();
    const file_name = arg_file_name.data;

    // Function

    const image = rl.LoadImage(file_name);
    defer if (!return_resource) core.Image.unload(image);
    errdefer if (return_resource) core.Image.unload(image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image, return_resource) catch {
        return error.invalid_return;
    };
}

/// Load image from RAW file data
///
/// raylib.h
/// RLAPI Image LoadImageRaw(const char *fileName, int width, int height, int format, int headerSize);
fn nif_load_image_raw(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 5);

    // Arguments

    const arg_file_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_file_name;
    };
    defer arg_file_name.free();
    const file_name = arg_file_name.data;

    const width = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_height;
    };

    const format = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_format;
    };

    const header_size = core.Int.get(env, argv[4]) catch {
        return error.invalid_argument_header_size;
    };

    // Function

    const image = rl.LoadImageRaw(file_name, width, height, format, header_size);
    defer if (!return_resource) core.Image.unload(image);
    errdefer if (return_resource) core.Image.unload(image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image, return_resource) catch {
        return error.invalid_return;
    };
}

/// Load image sequence from file (frames appended to image.data)
///
/// raylib.h
/// RLAPI Image LoadImageAnim(const char *fileName, int *frames);
fn nif_load_image_anim(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_file_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_file_name;
    };
    defer arg_file_name.free();
    const file_name = arg_file_name.data;

    // Function

    var frames: c_int = undefined;
    const image = rl.LoadImageAnim(file_name, &frames);
    defer if (!return_resource) core.Image.unload(image);
    errdefer if (return_resource) core.Image.unload(image);

    // Return

    const term_image = core.maybe_make_struct_as_resource(core.Image, env, image, return_resource) catch {
        return error.invalid_return;
    };

    const term_frames = core.Int.make(env, frames);

    return core.Tuple.make(env, &[_]e.ErlNifTerm{
        term_image,
        term_frames,
    });
}

/// Load image sequence from memory buffer
///
/// raylib.h
/// RLAPI Image LoadImageAnimFromMemory(const char *fileType, const unsigned char *fileData, int dataSize, int *frames);
fn nif_load_image_anim_from_memory(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_file_type = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_file_type;
    };
    defer arg_file_type.free();
    const file_type = arg_file_type.data;

    const arg_file_data = core.ArgumentBinary(core.Binary, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_file_data;
    };
    defer arg_file_data.free();
    const file_data = arg_file_data.data;
    const data_size = arg_file_data.length;

    // Function

    var frames: c_int = undefined;
    const image = rl.LoadImageAnimFromMemory(file_type, @ptrCast(file_data), @intCast(data_size), &frames);
    defer if (!return_resource) core.Image.unload(image);
    errdefer if (return_resource) core.Image.unload(image);

    // Return

    const term_image = core.maybe_make_struct_as_resource(core.Image, env, image, return_resource) catch {
        return error.invalid_return;
    };

    const term_frames = core.Int.make(env, frames);

    return core.Tuple.make(env, &[_]e.ErlNifTerm{
        term_image,
        term_frames,
    });
}

/// Load image from memory buffer, fileType refers to extension: i.e. '.png'
///
/// raylib.h
/// RLAPI Image LoadImageFromMemory(const char *fileType, const unsigned char *fileData, int dataSize);
fn nif_load_image_from_memory(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_file_type = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_file_type;
    };
    defer arg_file_type.free();
    const file_type = arg_file_type.data;

    const arg_file_data = core.ArgumentBinary(core.Binary, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_file_data;
    };
    defer arg_file_data.free();
    const file_data = arg_file_data.data;
    const data_size = arg_file_data.length;

    // Function

    const image = rl.LoadImageFromMemory(file_type, @ptrCast(file_data), @intCast(data_size));
    defer if (!return_resource) core.Image.unload(image);
    errdefer if (return_resource) core.Image.unload(image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image, return_resource) catch {
        return error.invalid_return;
    };
}

/// Load image from GPU texture data
///
/// raylib.h
/// RLAPI Image LoadImageFromTexture(Texture2D texture);
fn nif_load_image_from_texture(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_texture = core.Argument(core.Texture2D).get(env, argv[0]) catch {
        return error.invalid_argument_texture;
    };
    defer arg_texture.free();
    const texture = arg_texture.data;

    // Function

    const image = rl.LoadImageFromTexture(texture);
    defer if (!return_resource) core.Image.unload(image);
    errdefer if (return_resource) core.Image.unload(image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image, return_resource) catch {
        return error.invalid_return;
    };
}

/// Load image from screen buffer and (screenshot)
///
/// raylib.h
/// RLAPI Image LoadImageFromScreen(void);
fn nif_load_image_from_screen(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0 or argc == 1);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 0);

    // Function

    const image = rl.LoadImageFromScreen();
    defer if (!return_resource) core.Image.unload(image);
    errdefer if (return_resource) core.Image.unload(image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image, return_resource) catch {
        return error.invalid_return;
    };
}

/// Check if an image is valid (data and parameters)
///
/// raylib.h
/// RLAPI bool IsImageValid(Image image);
fn nif_is_image_valid(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_image.free();
    const image = arg_image.data;

    // Function

    const is_image_valid = rl.IsImageValid(image);

    // Return

    return core.Boolean.make(env, is_image_valid);
}

/// Export image data to file, returns true on success
///
/// raylib.h
/// RLAPI bool ExportImage(Image image, const char *fileName);
fn nif_export_image(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_image.free();
    const image = arg_image.data;

    const arg_file_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_file_name;
    };
    defer arg_file_name.free();
    const file_name = arg_file_name.data;

    // Function

    const ok = rl.ExportImage(image, file_name);

    // Return

    return core.Boolean.make(env, ok);
}

/// Export image to memory buffer
///
/// raylib.h
/// RLAPI unsigned char *ExportImageToMemory(Image image, const char *fileType, int *fileSize);
fn nif_export_image_to_memory(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_image.free();
    const image = arg_image.data;

    const arg_file_type = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_file_type;
    };
    defer arg_file_type.free();
    const file_type = arg_file_type.data;

    // Function

    var data_size: c_int = undefined;
    const file_data = rl.ExportImageToMemory(image, file_type, &data_size);

    // Return

    return core.Binary.make_c(env, file_data, @intCast(data_size));
}

////////////////////////
//  Image generation  //
////////////////////////

/// Generate image: plain color
///
/// raylib.h
/// RLAPI Image GenImageColor(int width, int height, Color color);
fn nif_gen_image_color(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const width = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_height;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    const image = rl.GenImageColor(width, height, color);
    defer if (!return_resource) core.Image.unload(image);
    errdefer if (return_resource) core.Image.unload(image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image, return_resource) catch {
        return error.invalid_return;
    };
}

/// Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient
///
/// raylib.h
/// RLAPI Image GenImageGradientLinear(int width, int height, int direction, Color start, Color end);
fn nif_gen_image_gradient_linear(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 5);

    // Arguments

    const width = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_height;
    };

    const direction = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_direction;
    };

    const arg_color_start = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color_start;
    };
    defer arg_color_start.free();
    const color_start = arg_color_start.data;

    const arg_color_end = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color_end;
    };
    defer arg_color_end.free();
    const color_end = arg_color_end.data;

    // Function

    const image = rl.GenImageGradientLinear(width, height, direction, color_start, color_end);
    defer if (!return_resource) core.Image.unload(image);
    errdefer if (return_resource) core.Image.unload(image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image, return_resource) catch {
        return error.invalid_return;
    };
}

/// Generate image: radial gradient
///
/// raylib.h
/// RLAPI Image GenImageGradientRadial(int width, int height, float density, Color inner, Color outer);
fn nif_gen_image_gradient_radial(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 5);

    // Arguments

    const width = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_height;
    };

    const density = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_density;
    };

    const arg_color_inner = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color_inner;
    };
    defer arg_color_inner.free();
    const color_inner = arg_color_inner.data;

    const arg_color_outer = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color_outer;
    };
    defer arg_color_outer.free();
    const color_outer = arg_color_outer.data;

    // Function

    const image = rl.GenImageGradientRadial(width, height, @floatCast(density), color_inner, color_outer);
    defer if (!return_resource) core.Image.unload(image);
    errdefer if (return_resource) core.Image.unload(image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image, return_resource) catch {
        return error.invalid_return;
    };
}

/// Generate image: square gradient
///
/// raylib.h
/// RLAPI Image GenImageGradientSquare(int width, int height, float density, Color inner, Color outer);
fn nif_gen_image_gradient_square(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 5);

    // Arguments

    const width = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_height;
    };

    const density = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_density;
    };

    const arg_color_inner = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color_inner;
    };
    defer arg_color_inner.free();
    const color_inner = arg_color_inner.data;

    const arg_color_outer = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color_outer;
    };
    defer arg_color_outer.free();
    const color_outer = arg_color_outer.data;

    // Function

    const image = rl.GenImageGradientSquare(width, height, @floatCast(density), color_inner, color_outer);
    defer if (!return_resource) core.Image.unload(image);
    errdefer if (return_resource) core.Image.unload(image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image, return_resource) catch {
        return error.invalid_return;
    };
}

/// Generate image: checked
///
/// raylib.h
/// RLAPI Image GenImageChecked(int width, int height, int checksX, int checksY, Color col1, Color col2);
fn nif_gen_image_checked(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6 or argc == 7);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 5);

    // Arguments

    const width = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_height;
    };

    const checks_x = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_checks_x;
    };

    const checks_y = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_checks_y;
    };

    const arg_color_1 = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color_1;
    };
    defer arg_color_1.free();
    const color_1 = arg_color_1.data;

    const arg_color_2 = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_color_2;
    };
    defer arg_color_2.free();
    const color_2 = arg_color_2.data;

    // Function

    const image = rl.GenImageChecked(width, height, checks_x, checks_y, color_1, color_2);
    defer if (!return_resource) core.Image.unload(image);
    errdefer if (return_resource) core.Image.unload(image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image, return_resource) catch {
        return error.invalid_return;
    };
}

/// Generate image: white noise
///
/// raylib.h
/// RLAPI Image GenImageWhiteNoise(int width, int height, float factor);
fn nif_gen_image_white_noise(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const width = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_height;
    };

    const factor = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_factor;
    };

    // Function

    const image = rl.GenImageWhiteNoise(width, height, @floatCast(factor));
    defer if (!return_resource) core.Image.unload(image);
    errdefer if (return_resource) core.Image.unload(image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image, return_resource) catch {
        return error.invalid_return;
    };
}

/// Generate image: perlin noise
///
/// raylib.h
/// RLAPI Image GenImagePerlinNoise(int width, int height, int offsetX, int offsetY, float scale);
fn nif_gen_image_perlin_noise(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 5);

    // Arguments

    const width = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_height;
    };

    const offset_x = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_offset_x;
    };

    const offset_y = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_offset_y;
    };

    const scale = core.Double.get(env, argv[4]) catch {
        return error.invalid_argument_scale;
    };

    // Function

    const image = rl.GenImagePerlinNoise(width, height, offset_x, offset_y, @floatCast(scale));
    defer if (!return_resource) core.Image.unload(image);
    errdefer if (return_resource) core.Image.unload(image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image, return_resource) catch {
        return error.invalid_return;
    };
}

/// Generate image: cellular algorithm, bigger tileSize means bigger cells
///
/// raylib.h
/// RLAPI Image GenImageCellular(int width, int height, int tileSize);
fn nif_gen_image_cellular(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const width = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_height;
    };

    const tile_size = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_tile_size;
    };

    // Function

    const image = rl.GenImageCellular(width, height, tile_size);
    defer if (!return_resource) core.Image.unload(image);
    errdefer if (return_resource) core.Image.unload(image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image, return_resource) catch {
        return error.invalid_return;
    };
}

/// Generate image: grayscale image from text data
///
/// raylib.h
/// RLAPI Image GenImageText(int width, int height, const char *text);
fn nif_gen_image_text(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const width = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_height;
    };

    const arg_text = core.ArgumentBinary(core.Binary, rl.allocator).get(env, argv[2]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;
    const text_size = arg_text.length;

    // Function

    const image = rl.GenImageTextEx(width, height, @ptrCast(text), @intCast(text_size));
    defer if (!return_resource) core.Image.unload(image);
    errdefer if (return_resource) core.Image.unload(image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image, return_resource) catch {
        return error.invalid_return;
    };
}

//////////////////////////
//  Image manipulation  //
//////////////////////////

/// Create an image duplicate (useful for transformations)
///
/// raylib.h
/// RLAPI Image ImageCopy(Image image);
fn nif_image_copy(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_image.free();
    const image = arg_image.data;

    // Function

    const image_copy = rl.ImageCopy(image);
    defer if (!return_resource) core.Image.unload(image_copy);
    errdefer if (return_resource) core.Image.unload(image_copy);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image_copy, return_resource) catch {
        return error.invalid_return;
    };
}

/// Create an image from another image piece
///
/// raylib.h
/// RLAPI Image ImageFromImage(Image image, Rectangle rec);
fn nif_image_from_image(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_image.free();
    const image = arg_image.data;

    const arg_rec = core.Argument(core.Rectangle).get(env, argv[1]) catch {
        return error.invalid_argument_rec;
    };
    defer arg_rec.free();
    const rec = arg_rec.data;

    // Function

    const image_from_image = rl.ImageFromImage(image, rec);
    defer if (!return_resource) core.Image.unload(image_from_image);
    errdefer if (return_resource) core.Image.unload(image_from_image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image_from_image, return_resource) catch {
        return error.invalid_return;
    };
}

/// Create an image from a selected channel of another image (GRAYSCALE)
///
/// raylib.h
/// RLAPI Image ImageFromChannel(Image image, int selectedChannel);
fn nif_image_from_channel(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_image.free();
    const image = arg_image.data;

    const selected_channel = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_selected_channel;
    };

    // Function

    const image_from_channel = rl.ImageFromChannel(image, selected_channel);
    defer if (!return_resource) core.Image.unload(image_from_channel);
    errdefer if (return_resource) core.Image.unload(image_from_channel);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image_from_channel, return_resource) catch {
        return error.invalid_return;
    };
}

/// Create an image from text (default font)
///
/// raylib.h
/// RLAPI Image ImageText(const char *text, int fontSize, Color color);
fn nif_image_text(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[0]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    const font_size = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_font_size;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    const image = rl.ImageText(text, font_size, color);
    defer if (!return_resource) core.Image.unload(image);
    errdefer if (return_resource) core.Image.unload(image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image, return_resource) catch {
        return error.invalid_return;
    };
}

/// Create an image from text (custom sprite font)
///
/// raylib.h
/// RLAPI Image ImageTextEx(Font font, const char *text, float fontSize, float spacing, Color tint);
fn nif_image_text_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 5);

    // Arguments

    const arg_font = core.Argument(core.Font).get(env, argv[0]) catch {
        return error.invalid_argument_font;
    };
    defer arg_font.free();
    const font = arg_font.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    const font_size = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_font_size;
    };

    const spacing = core.Double.get(env, argv[3]) catch {
        return error.invalid_argument_spacing;
    };

    const arg_tint = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    const image = rl.ImageTextEx(font, text, @floatCast(font_size), @floatCast(spacing), tint);
    defer if (!return_resource) core.Image.unload(image);
    errdefer if (return_resource) core.Image.unload(image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, env, image, return_resource) catch {
        return error.invalid_return;
    };
}

/// Convert image data to desired format
///
/// raylib.h
/// RLAPI void ImageFormat(Image *image, int newFormat);
fn nif_image_format(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 2, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    const new_format = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_new_format;
    };

    // Function

    rl.ImageFormat(@ptrCast(image), new_format);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Convert image to POT (power-of-two)
///
/// raylib.h
/// RLAPI void ImageToPOT(Image *image, Color fill);
fn nif_image_to_pot(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 2, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    const arg_fill = core.Argument(core.Color).get(env, argv[1]) catch {
        return error.invalid_argument_fill;
    };
    defer arg_fill.free();
    const fill = arg_fill.data;

    // Function

    rl.ImageToPOT(@ptrCast(image), fill);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Crop an image to a defined rectangle
///
/// raylib.h
/// RLAPI void ImageCrop(Image *image, Rectangle crop);
fn nif_image_crop(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 2, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    const arg_crop = core.Argument(core.Rectangle).get(env, argv[1]) catch {
        return error.invalid_argument_crop;
    };
    defer arg_crop.free();
    const crop = arg_crop.data;

    // Function

    rl.ImageCrop(@ptrCast(image), crop);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Crop image depending on alpha value
///
/// raylib.h
/// RLAPI void ImageAlphaCrop(Image *image, float threshold);
fn nif_image_alpha_crop(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 2, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    const threshold = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_threshold;
    };

    // Function

    rl.ImageAlphaCrop(@ptrCast(image), @floatCast(threshold));

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Clear alpha channel to desired color
///
/// raylib.h
/// RLAPI void ImageAlphaClear(Image *image, Color color, float threshold);
fn nif_image_alpha_clear(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 3, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    const arg_color = core.Argument(core.Color).get(env, argv[1]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    const threshold = core.Double.get(env, argv[2]) catch {
        return error.invalid_argument_threshold;
    };

    // Function

    rl.ImageAlphaClear(@ptrCast(image), color, @floatCast(threshold));

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Apply alpha mask to image
///
/// raylib.h
/// RLAPI void ImageAlphaMask(Image *image, Image alphaMask);
fn nif_image_alpha_mask(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 2, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    const arg_alpha_mask = core.Argument(core.Image).get(env, argv[1]) catch {
        return error.invalid_argument_alpha_mask;
    };
    defer arg_alpha_mask.free();
    const alpha_mask = arg_alpha_mask.data;

    // Function

    rl.ImageAlphaMask(@ptrCast(image), alpha_mask);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Premultiply alpha channel
///
/// raylib.h
/// RLAPI void ImageAlphaPremultiply(Image *image);
fn nif_image_alpha_premultiply(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 1, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    // Function

    rl.ImageAlphaPremultiply(@ptrCast(image));

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Apply Gaussian blur using a box blur approximation
///
/// raylib.h
/// RLAPI void ImageBlurGaussian(Image *image, int blurSize);
fn nif_image_blur_gaussian(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 2, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    const blur_size = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_blur_size;
    };

    // Function

    rl.ImageBlurGaussian(@ptrCast(image), blur_size);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Apply custom square convolution kernel to image
///
/// raylib.h
/// RLAPI void ImageKernelConvolution(Image *image, const float *kernel, int kernelSize);
fn nif_image_kernel_convolution(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 2, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    var arg_kernel = core.ArgumentArray(core.Double, f32, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_kernel;
    };
    defer arg_kernel.free();
    const kernel = arg_kernel.data;
    const kernel_size = arg_kernel.length;

    // Function

    rl.ImageKernelConvolution(@ptrCast(image), @ptrCast(kernel), @intCast(kernel_size));

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Resize image (Bicubic scaling algorithm)
///
/// raylib.h
/// RLAPI void ImageResize(Image *image, int newWidth, int newHeight);
fn nif_image_resize(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 3, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    const new_width = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_new_width;
    };

    const new_height = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_new_height;
    };

    // Function

    rl.ImageResize(@ptrCast(image), new_width, new_height);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Resize image (Nearest-Neighbor scaling algorithm)
///
/// raylib.h
/// RLAPI void ImageResizeNN(Image *image, int newWidth, int newHeight);
fn nif_image_resize_nn(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 3, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    const new_width = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_new_width;
    };

    const new_height = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_new_height;
    };

    // Function

    rl.ImageResizeNN(@ptrCast(image), new_width, new_height);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Resize canvas and fill with color
///
/// raylib.h
/// RLAPI void ImageResizeCanvas(Image *image, int newWidth, int newHeight, int offsetX, int offsetY, Color fill);
fn nif_image_resize_canvas(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6 or argc == 7);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 6, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    const new_width = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_new_width;
    };

    const new_height = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_new_height;
    };

    const offset_x = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_offset_x;
    };

    const offset_y = core.Int.get(env, argv[4]) catch {
        return error.invalid_argument_offset_y;
    };

    const arg_fill = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_fill;
    };
    defer arg_fill.free();
    const fill = arg_fill.data;

    // Function

    rl.ImageResizeCanvas(@ptrCast(image), new_width, new_height, offset_x, offset_y, fill);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Compute all mipmap levels for a provided image
///
/// raylib.h
/// RLAPI void ImageMipmaps(Image *image);
fn nif_image_mipmaps(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 1, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    // Function

    rl.ImageMipmaps(@ptrCast(image));

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
///
/// raylib.h
/// RLAPI void ImageDither(Image *image, int rBpp, int gBpp, int bBpp, int aBpp);
fn nif_image_dither(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 5, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    const r_bpp = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_r_bpp;
    };

    const g_bpp = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_g_bpp;
    };

    const b_bpp = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_b_bpp;
    };

    const a_bpp = core.Int.get(env, argv[4]) catch {
        return error.invalid_argument_a_bpp;
    };

    // Function

    rl.ImageDither(@ptrCast(image), r_bpp, g_bpp, b_bpp, a_bpp);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Flip image vertically
///
/// raylib.h
/// RLAPI void ImageFlipVertical(Image *image);
fn nif_image_flip_vertical(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 1, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    // Function

    rl.ImageFlipVertical(@ptrCast(image));

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Flip image horizontally
///
/// raylib.h
/// RLAPI void ImageFlipHorizontal(Image *image);
fn nif_image_flip_horizontal(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 1, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    // Function

    rl.ImageFlipHorizontal(@ptrCast(image));

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Rotate image by input angle in degrees (-359 to 359)
///
/// raylib.h
/// RLAPI void ImageRotate(Image *image, int degrees);
fn nif_image_rotate(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 2, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    const degrees = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_degrees;
    };

    // Function

    rl.ImageRotate(@ptrCast(image), degrees);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Rotate image clockwise 90deg
///
/// raylib.h
/// RLAPI void ImageRotateCW(Image *image);
fn nif_image_rotate_cw(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 1, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    // Function

    rl.ImageRotateCW(@ptrCast(image));

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Rotate image counter-clockwise 90deg
///
/// raylib.h
/// RLAPI void ImageRotateCCW(Image *image);
fn nif_image_rotate_ccw(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 1, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    // Function

    rl.ImageRotateCCW(@ptrCast(image));

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Modify image color: tint
///
/// raylib.h
/// RLAPI void ImageColorTint(Image *image, Color color);
fn nif_image_color_tint(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 2, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    const arg_color = core.Argument(core.Color).get(env, argv[1]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageColorTint(@ptrCast(image), color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Modify image color: invert
///
/// raylib.h
/// RLAPI void ImageColorInvert(Image *image);
fn nif_image_color_invert(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 1, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    // Function

    rl.ImageColorInvert(@ptrCast(image));

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Modify image color: grayscale
///
/// raylib.h
/// RLAPI void ImageColorGrayscale(Image *image);
fn nif_image_color_grayscale(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 1, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    // Function

    rl.ImageColorGrayscale(@ptrCast(image));

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Modify image color: contrast (-100 to 100)
///
/// raylib.h
/// RLAPI void ImageColorContrast(Image *image, float contrast);
fn nif_image_color_contrast(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 2, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    const contrast = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_contrast;
    };

    // Function

    rl.ImageColorContrast(@ptrCast(image), @floatCast(contrast));

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Modify image color: brightness (-255 to 255)
///
/// raylib.h
/// RLAPI void ImageColorBrightness(Image *image, int brightness);
fn nif_image_color_brightness(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 2, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    const brightness = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_brightness;
    };

    // Function

    rl.ImageColorBrightness(@ptrCast(image), brightness);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Modify image color: replace color
///
/// raylib.h
/// RLAPI void ImageColorReplace(Image *image, Color color, Color replace);
fn nif_image_color_replace(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 3, argv[0]);

    // Arguments

    var arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer if (!return_resource) arg_image.free();
    errdefer if (return_resource) arg_image.free();
    const image = &arg_image.data;

    const arg_color = core.Argument(core.Color).get(env, argv[1]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    const arg_replace = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_replace;
    };
    defer arg_replace.free();
    const replace = arg_replace.data;

    // Function

    rl.ImageColorReplace(@ptrCast(image), color, replace);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], image.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Load color data from image as a Color array (RGBA - 32bit)
///
/// raylib.h
/// RLAPI Color *LoadImageColors(Image image);
fn nif_load_image_colors(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_image.free();
    const image = arg_image.data;

    // Function

    const colors_c = rl.LoadImageColors(image);
    defer rl.UnloadImageColors(colors_c); // always free because colors are just numbers

    // Return

    const colors_size: usize = @intCast(image.width * image.height);
    const colors = @as([*]rl.Color, @ptrCast(colors_c))[0..colors_size];

    var term_colors = e.enif_make_list_from_array(env, null, 0);

    for (0..colors_size) |i| {
        const term = core.maybe_make_struct_as_resource(core.Color, env, colors[colors.len - 1 - i], return_resource) catch {
            return error.invalid_return;
        };
        term_colors = e.enif_make_list_cell(env, term, term_colors);
    }

    return term_colors;
}

/// Load colors palette from image as a Color array (RGBA - 32bit)
///
/// raylib.h
/// RLAPI Color *LoadImagePalette(Image image, int maxPaletteSize, int *colorCount);
fn nif_load_image_palette(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_image.free();
    const image = arg_image.data;

    const max_palette_size = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_max_palette_size;
    };

    // Function

    var color_count: c_int = undefined;
    const colors_c = rl.LoadImagePalette(image, max_palette_size, &color_count);
    defer rl.UnloadImagePalette(colors_c); // always free because colors are just numbers

    // Return

    const colors_size: usize = @intCast(color_count);
    const colors = @as([*]rl.Color, @ptrCast(colors_c))[0..colors_size];

    var term_colors = e.enif_make_list_from_array(env, null, 0);

    for (0..colors_size) |i| {
        const term = core.maybe_make_struct_as_resource(core.Color, env, colors[colors.len - 1 - i], return_resource) catch {
            return error.invalid_return;
        };
        term_colors = e.enif_make_list_cell(env, term, term_colors);
    }

    return term_colors;
}

/// Get image alpha border rectangle
///
/// raylib.h
/// RLAPI Rectangle GetImageAlphaBorder(Image image, float threshold);
fn nif_get_image_alpha_border(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    const arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_image.free();
    const image = arg_image.data;

    const threshold = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_threshold;
    };

    // Function

    const image_alpha_border = rl.GetImageAlphaBorder(image, @floatCast(threshold));
    defer if (!return_resource) core.Rectangle.unload(image_alpha_border);
    errdefer if (return_resource) core.Rectangle.unload(image_alpha_border);

    // Return

    return core.maybe_make_struct_as_resource(core.Rectangle, env, image_alpha_border, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get image pixel color at (x, y) position
///
/// raylib.h
/// RLAPI Color GetImageColor(Image image, int x, int y);
fn nif_get_image_color(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const arg_image = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_image;
    };
    defer arg_image.free();
    const image = arg_image.data;

    const x = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_x;
    };

    const y = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_y;
    };

    // Function

    const image_color = rl.GetImageColor(image, x, y);
    defer if (!return_resource) core.Color.unload(image_color);
    errdefer if (return_resource) core.Color.unload(image_color);

    // Return

    return core.maybe_make_struct_as_resource(core.Color, env, image_color, return_resource) catch {
        return error.invalid_return;
    };
}

/////////////////////
//  Image drawing  //
/////////////////////

/// Clear image background with given color
///
/// raylib.h
/// RLAPI void ImageClearBackground(Image *dst, Color color);
fn nif_image_clear_background(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 2, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const arg_color = core.Argument(core.Color).get(env, argv[1]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageClearBackground(@ptrCast(dst), color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw pixel within an image
///
/// raylib.h
/// RLAPI void ImageDrawPixel(Image *dst, int posX, int posY, Color color);
fn nif_image_draw_pixel(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4 or argc == 5);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 4, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const pos_x = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_pos_x;
    };

    const pos_y = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_pos_y;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageDrawPixel(@ptrCast(dst), pos_x, pos_y, color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw pixel within an image (Vector version)
///
/// raylib.h
/// RLAPI void ImageDrawPixelV(Image *dst, Vector2 position, Color color);
fn nif_image_draw_pixel_v(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 3, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const arg_position = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageDrawPixelV(@ptrCast(dst), position, color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw line within an image
///
/// raylib.h
/// RLAPI void ImageDrawLine(Image *dst, int startPosX, int startPosY, int endPosX, int endPosY, Color color);
fn nif_image_draw_line(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6 or argc == 7);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 6, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const start_pos_x = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_start_pos_x;
    };

    const start_pos_y = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_start_pos_y;
    };

    const end_pos_x = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_end_pos_x;
    };

    const end_pos_y = core.Int.get(env, argv[4]) catch {
        return error.invalid_argument_end_pos_y;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageDrawLine(@ptrCast(dst), start_pos_x, start_pos_y, end_pos_x, end_pos_y, color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw line within an image (Vector version)
///
/// raylib.h
/// RLAPI void ImageDrawLineV(Image *dst, Vector2 start, Vector2 end, Color color);
fn nif_image_draw_line_v(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4 or argc == 5);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 4, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const arg_start_pos = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_start_pos;
    };
    defer arg_start_pos.free();
    const start_pos = arg_start_pos.data;

    const arg_end_pos = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_end_pos;
    };
    defer arg_end_pos.free();
    const end_pos = arg_end_pos.data;

    const arg_color = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageDrawLineV(@ptrCast(dst), start_pos, end_pos, color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw a line defining thickness within an image
///
/// raylib.h
/// RLAPI void ImageDrawLineEx(Image *dst, Vector2 start, Vector2 end, int thick, Color color);
fn nif_image_draw_line_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 5, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const arg_start_pos = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_start_pos;
    };
    defer arg_start_pos.free();
    const start_pos = arg_start_pos.data;

    const arg_end_pos = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_end_pos;
    };
    defer arg_end_pos.free();
    const end_pos = arg_end_pos.data;

    const thick = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_thick;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageDrawLineEx(@ptrCast(dst), start_pos, end_pos, thick, color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw a filled circle within an image
///
/// raylib.h
/// RLAPI void ImageDrawCircle(Image *dst, int centerX, int centerY, int radius, Color color);
fn nif_image_draw_circle(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 5, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const center_x = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_center_x;
    };

    const center_y = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_center_y;
    };

    const radius = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_radius;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageDrawCircle(@ptrCast(dst), center_x, center_y, radius, color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw a filled circle within an image (Vector version)
///
/// raylib.h
/// RLAPI void ImageDrawCircleV(Image *dst, Vector2 center, int radius, Color color);
fn nif_image_draw_circle_v(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4 or argc == 5);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 4, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const arg_center = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_center;
    };
    defer arg_center.free();
    const center = arg_center.data;

    const radius = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_radius;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageDrawCircleV(@ptrCast(dst), center, radius, color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw circle outline within an image
///
/// raylib.h
/// RLAPI void ImageDrawCircleLines(Image *dst, int centerX, int centerY, int radius, Color color);
fn nif_image_draw_circle_lines(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 5, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const center_x = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_center_x;
    };

    const center_y = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_center_y;
    };

    const radius = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_radius;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageDrawCircleLines(@ptrCast(dst), center_x, center_y, radius, color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw circle outline within an image (Vector version)
///
/// raylib.h
/// RLAPI void ImageDrawCircleLinesV(Image *dst, Vector2 center, int radius, Color color);
fn nif_image_draw_circle_lines_v(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4 or argc == 5);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 4, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const arg_center = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_center;
    };
    defer arg_center.free();
    const center = arg_center.data;

    const radius = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_radius;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageDrawCircleLinesV(@ptrCast(dst), center, radius, color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw rectangle within an image
///
/// raylib.h
/// RLAPI void ImageDrawRectangle(Image *dst, int posX, int posY, int width, int height, Color color);
fn nif_image_draw_rectangle(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6 or argc == 7);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 6, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const pos_x = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_pos_x;
    };

    const pos_y = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_pos_y;
    };

    const width = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_width;
    };

    const height = core.Int.get(env, argv[4]) catch {
        return error.invalid_argument_height;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageDrawRectangle(@ptrCast(dst), pos_x, pos_y, width, height, color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw rectangle within an image (Vector version)
///
/// raylib.h
/// RLAPI void ImageDrawRectangleV(Image *dst, Vector2 position, Vector2 size, Color color);
fn nif_image_draw_rectangle_v(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4 or argc == 5);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 4, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const arg_position = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const arg_size = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_size;
    };
    defer arg_size.free();
    const size = arg_size.data;

    const arg_color = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageDrawRectangleV(@ptrCast(dst), position, size, color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw rectangle within an image
///
/// raylib.h
/// RLAPI void ImageDrawRectangleRec(Image *dst, Rectangle rec, Color color);
fn nif_image_draw_rectangle_rec(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 3, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const arg_rec = core.Argument(core.Rectangle).get(env, argv[1]) catch {
        return error.invalid_argument_rec;
    };
    defer arg_rec.free();
    const rec = arg_rec.data;

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageDrawRectangleRec(@ptrCast(dst), rec, color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw rectangle lines within an image
///
/// raylib.h
/// RLAPI void ImageDrawRectangleLines(Image *dst, Rectangle rec, int thick, Color color);
fn nif_image_draw_rectangle_lines(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4 or argc == 5);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 4, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const arg_rec = core.Argument(core.Rectangle).get(env, argv[1]) catch {
        return error.invalid_argument_rec;
    };
    defer arg_rec.free();
    const rec = arg_rec.data;

    const thick = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_thick;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[3]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageDrawRectangleLines(@ptrCast(dst), rec, thick, color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw triangle within an image
///
/// raylib.h
/// RLAPI void ImageDrawTriangle(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color color);
fn nif_image_draw_triangle(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 5, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const arg_v1 = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_v1;
    };
    defer arg_v1.free();
    const v1 = arg_v1.data;

    const arg_v2 = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_v2;
    };
    defer arg_v2.free();
    const v2 = arg_v2.data;

    const arg_v3 = core.Argument(core.Vector2).get(env, argv[3]) catch {
        return error.invalid_argument_v3;
    };
    defer arg_v3.free();
    const v3 = arg_v3.data;

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageDrawTriangle(@ptrCast(dst), v1, v2, v3, color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw triangle with interpolated colors within an image
///
/// raylib.h
/// RLAPI void ImageDrawTriangleEx(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color c1, Color c2, Color c3);
fn nif_image_draw_triangle_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 7 or argc == 8);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 7, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const arg_v1 = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_v1;
    };
    defer arg_v1.free();
    const v1 = arg_v1.data;

    const arg_v2 = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_v2;
    };
    defer arg_v2.free();
    const v2 = arg_v2.data;

    const arg_v3 = core.Argument(core.Vector2).get(env, argv[3]) catch {
        return error.invalid_argument_v3;
    };
    defer arg_v3.free();
    const v3 = arg_v3.data;

    const arg_c1 = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_c1;
    };
    defer arg_c1.free();
    const c1 = arg_c1.data;

    const arg_c2 = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_c2;
    };
    defer arg_c2.free();
    const c2 = arg_c2.data;

    const arg_c3 = core.Argument(core.Color).get(env, argv[6]) catch {
        return error.invalid_argument_c3;
    };
    defer arg_c3.free();
    const c3 = arg_c3.data;

    // Function

    rl.ImageDrawTriangleEx(@ptrCast(dst), v1, v2, v3, c1, c2, c3);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw triangle outline within an image
///
/// raylib.h
/// RLAPI void ImageDrawTriangleLines(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color color);
fn nif_image_draw_triangle_lines(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 5, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const arg_v1 = core.Argument(core.Vector2).get(env, argv[1]) catch {
        return error.invalid_argument_v1;
    };
    defer arg_v1.free();
    const v1 = arg_v1.data;

    const arg_v2 = core.Argument(core.Vector2).get(env, argv[2]) catch {
        return error.invalid_argument_v2;
    };
    defer arg_v2.free();
    const v2 = arg_v2.data;

    const arg_v3 = core.Argument(core.Vector2).get(env, argv[3]) catch {
        return error.invalid_argument_v3;
    };
    defer arg_v3.free();
    const v3 = arg_v3.data;

    const arg_color = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageDrawTriangleLines(@ptrCast(dst), v1, v2, v3, color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw a triangle fan defined by points within an image (first vertex is the center)
///
/// raylib.h
/// RLAPI void ImageDrawTriangleFan(Image *dst, const Vector2 *points, int pointCount, Color color);
fn nif_image_draw_triangle_fan(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 3, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    var arg_points = core.ArgumentArray(core.Vector2, core.Vector2.data_type, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_image;
    };
    defer arg_points.free();
    const points = arg_points.data;
    const point_count = arg_points.length;

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageDrawTriangleFan(@ptrCast(dst), @ptrCast(points), @intCast(point_count), color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw a triangle strip defined by points within an image
///
/// raylib.h
/// RLAPI void ImageDrawTriangleStrip(Image *dst, const Vector2 *points, int pointCount, Color color);
fn nif_image_draw_triangle_strip(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 3, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    var arg_points = core.ArgumentArray(core.Vector2, core.Vector2.data_type, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_image;
    };
    defer arg_points.free();
    const points = arg_points.data;
    const point_count = arg_points.length;

    const arg_color = core.Argument(core.Color).get(env, argv[2]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageDrawTriangleStrip(@ptrCast(dst), @ptrCast(points), @intCast(point_count), color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw a source image within a destination image (tint applied to source)
///
/// raylib.h
/// RLAPI void ImageDraw(Image *dst, Image src, Rectangle srcRec, Rectangle dstRec, Color tint);
fn nif_image_draw(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 5 or argc == 6);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 5, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const arg_src = core.Argument(core.Image).get(env, argv[1]) catch {
        return error.invalid_argument_src;
    };
    defer arg_src.free();
    const src = arg_src.data;

    const arg_src_rec = core.Argument(core.Rectangle).get(env, argv[2]) catch {
        return error.invalid_argument_src_rec;
    };
    defer arg_src_rec.free();
    const src_rec = arg_src_rec.data;

    const arg_dst_rec = core.Argument(core.Rectangle).get(env, argv[3]) catch {
        return error.invalid_argument_dst_rec;
    };
    defer arg_dst_rec.free();
    const dst_rec = arg_dst_rec.data;

    const arg_tint = core.Argument(core.Color).get(env, argv[4]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.ImageDraw(@ptrCast(dst), src, src_rec, dst_rec, tint);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw text (using default font) within an image (destination)
///
/// raylib.h
/// RLAPI void ImageDrawText(Image *dst, const char *text, int posX, int posY, int fontSize, Color color);
fn nif_image_draw_text(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 6 or argc == 7);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 6, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    const pos_x = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_pos_x;
    };

    const pos_y = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_pos_y;
    };

    const font_size = core.Int.get(env, argv[4]) catch {
        return error.invalid_argument_font_size;
    };

    const arg_color = core.Argument(core.Color).get(env, argv[5]) catch {
        return error.invalid_argument_color;
    };
    defer arg_color.free();
    const color = arg_color.data;

    // Function

    rl.ImageDrawText(@ptrCast(dst), text, pos_x, pos_y, font_size, color);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Draw text (custom sprite font) within an image (destination)
///
/// raylib.h
/// RLAPI void ImageDrawTextEx(Image *dst, Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint);
fn nif_image_draw_text_ex(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 7 or argc == 8);

    // Return type

    const return_resource = core.must_return_resource_auto(env, argc, argv, 7, argv[0]);

    // Arguments

    var arg_dst = core.Argument(core.Image).get(env, argv[0]) catch {
        return error.invalid_argument_dst;
    };
    defer if (!return_resource) arg_dst.free();
    errdefer if (return_resource) arg_dst.free();
    const dst = &arg_dst.data;

    const arg_font = core.Argument(core.Font).get(env, argv[1]) catch {
        return error.invalid_argument_font;
    };
    defer arg_font.free();
    const font = arg_font.data;

    const arg_text = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[2]) catch {
        return error.invalid_argument_text;
    };
    defer arg_text.free();
    const text = arg_text.data;

    const arg_position = core.Argument(core.Vector2).get(env, argv[3]) catch {
        return error.invalid_argument_position;
    };
    defer arg_position.free();
    const position = arg_position.data;

    const font_size = core.Double.get(env, argv[4]) catch {
        return error.invalid_argument_font_size;
    };

    const spacing = core.Double.get(env, argv[5]) catch {
        return error.invalid_argument_spacing;
    };

    const arg_tint = core.Argument(core.Color).get(env, argv[6]) catch {
        return error.invalid_argument_tint;
    };
    defer arg_tint.free();
    const tint = arg_tint.data;

    // Function

    rl.ImageDrawTextEx(@ptrCast(dst), font, text, position, @floatCast(font_size), @floatCast(spacing), tint);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, env, argv[0], dst.*, return_resource) catch {
        return error.invalid_return;
    };
}
