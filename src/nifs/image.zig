const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Image
    .{ .name = "image_get_data_size", .arity = 4, .fptr = nif_image_get_data_size, .flags = 0 },

    // Image generation
    .{ .name = "gen_image_color", .arity = 3, .fptr = nif_gen_image_color, .flags = 0 },
    .{ .name = "gen_image_color", .arity = 4, .fptr = nif_gen_image_color, .flags = 0 },

    // Image manipulation
    .{ .name = "image_crop", .arity = 2, .fptr = nif_image_crop, .flags = 0 },
    .{ .name = "image_crop", .arity = 3, .fptr = nif_image_crop, .flags = 0 },
};

/////////////
//  Image  //
/////////////

/// Get image data size in bytes for certain format
///
/// pub fn get_data_size(width: c_int, height: c_int, format: c_int, mipmaps: c_int) usize
fn nif_image_get_data_size(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 4);

    // Arguments

    const width: c_int = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'width'.");
    };

    const height: c_int = core.Int.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'height'.");
    };

    const format: c_int = core.Int.get(env, argv[2]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'format'.");
    };

    const mipmaps: c_int = core.Int.get(env, argv[3]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'mipmaps'.");
    };

    // Function

    const data_size = core.Image.get_data_size(width, height, format, mipmaps);

    // Return

    return core.UInt.make(env, @intCast(data_size));
}

////////////////////////
//  Image generation  //
////////////////////////

/// Generate image: plain color
///
/// raylib.h
/// RLAPI Image GenImageColor(int width, int height, Color color);
fn nif_gen_image_color(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Resource check

    const return_resource = if (argc == 4) e.enif_is_identical(core.Atom.make(env, "resource"), argv[3]) != 0 else false;
    const color_is_resource: bool = e.enif_is_map(env, argv[2]) == 0;

    // Arguments

    const width: c_int = core.Int.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'width'.");
    };

    const height: c_int = core.Int.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'height'.");
    };

    const color: rl.Color = core.Color.get(env, argv[2]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'color'.");
    };
    defer if (!color_is_resource) core.Color.free(color);

    // Function

    const image = rl.GenImageColor(width, height, color);
    defer if (!return_resource) core.Image.free(image);

    // Return

    return core.maybe_make_struct_as_resource(core.Image, rl.Image, env, image, return_resource) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to get return value.");
    };
}

//////////////////////////
//  Image manipulation  //
//////////////////////////

/// Crop an image to a defined rectangle
///
/// raylib.h
/// RLAPI void ImageCrop(Image *image, Rectangle crop);
fn nif_image_crop(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) callconv(.C) e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Resource check

    const return_resource = if (argc == 3) e.enif_is_identical(core.Atom.make(env, "resource"), argv[2]) != 0 else false;
    const image_is_resource: bool = e.enif_is_map(env, argv[0]) == 0;
    const crop_is_resource: bool = e.enif_is_map(env, argv[1]) == 0;

    // Arguments

    var image: rl.Image = core.Image.get(env, argv[0]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'image'.");
    };
    defer if (!image_is_resource and !return_resource) core.Image.free(image);

    const crop: rl.Rectangle = core.Rectangle.get(env, argv[1]) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Invalid argument 'crop'.");
    };
    defer if (!crop_is_resource) core.Rectangle.free(crop);

    // Function

    rl.ImageCrop(&image, crop);

    // Return

    return core.maybe_make_struct_or_resource(core.Image, rl.Image, env, argv[0], image, return_resource) catch |err| {
        return core.raise_exception(e.allocator, env, err, @errorReturnTrace(), "Failed to get return value.");
    };
}
