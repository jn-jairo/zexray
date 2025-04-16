const raylib = @cImport({
    @cInclude("raylib.h");
    @cInclude("config.h");
    @cInclude("rcamera.h");
    @cInclude("stdio.h");
});
pub usingnamespace raylib;

const config = @import("config.zig");
pub usingnamespace config;

const rlgl = @import("rlgl.zig");

const std = @import("std");
const e = @import("./erl_nif.zig");

pub const allocator = e.allocator;

pub const IVector2 = struct {
    x: c_int = std.mem.zeroes(c_int),
    y: c_int = std.mem.zeroes(c_int),
};

pub const IVector3 = struct {
    x: c_int = std.mem.zeroes(c_int),
    y: c_int = std.mem.zeroes(c_int),
    z: c_int = std.mem.zeroes(c_int),
};

pub const IVector4 = struct {
    x: c_int = std.mem.zeroes(c_int),
    y: c_int = std.mem.zeroes(c_int),
    z: c_int = std.mem.zeroes(c_int),
    w: c_int = std.mem.zeroes(c_int),
};

pub const UIVector2 = struct {
    x: c_uint = std.mem.zeroes(c_uint),
    y: c_uint = std.mem.zeroes(c_uint),
};

pub const UIVector3 = struct {
    x: c_uint = std.mem.zeroes(c_uint),
    y: c_uint = std.mem.zeroes(c_uint),
    z: c_uint = std.mem.zeroes(c_uint),
};

pub const UIVector4 = struct {
    x: c_uint = std.mem.zeroes(c_uint),
    y: c_uint = std.mem.zeroes(c_uint),
    z: c_uint = std.mem.zeroes(c_uint),
    w: c_uint = std.mem.zeroes(c_uint),
};

/// Takes a screenshot of current screen
pub fn Screenshot() raylib.Image {
    return raylib.LoadImageFromScreen();
}

pub fn TakeScreenshot2(fileName: [*c]const u8) bool {
    const image = raylib.LoadImageFromScreen();
    defer raylib.UnloadImage(image);

    const ok = raylib.ExportImage(image, fileName);

    if (ok) {
        raylib.TraceLog(raylib.LOG_INFO, "SYSTEM: [%s] Screenshot taken successfully", fileName);
    } else {
        raylib.TraceLog(raylib.LOG_WARNING, "SYSTEM: [%s] Screenshot could not be saved", fileName);
    }

    return ok;
}

/// Load font from memory buffer, fileType refers to extension: i.e. ".ttf"
pub fn LoadFontFromMemoryEx(fileType: [*c]const u8, fileData: [*c]const u8, dataSize: c_int, fontSize: c_int, codepoints: [*c]c_int, codepointCount: c_int, fontType: c_int) raylib.Font {
    var font = raylib.Font{};

    const fileExtLower = raylib.TextToLower(fileType);

    font.baseSize = fontSize;
    font.glyphCount = codepointCount;
    font.glyphPadding = 0;

    if (raylib.TextIsEqual(fileExtLower, ".ttf") or raylib.TextIsEqual(fileExtLower, ".otf")) {
        font.glyphs = raylib.LoadFontData(fileData, dataSize, font.baseSize, codepoints, font.glyphCount, fontType);
    } else {
        font.glyphs = null;
    }

    if (font.glyphs != null) {
        font.glyphPadding = config.FONT_TTF_DEFAULT_CHARS_PADDING;

        const atlas = raylib.GenImageFontAtlas(font.glyphs, &font.recs, font.glyphCount, font.baseSize, font.glyphPadding, 0);
        defer raylib.UnloadImage(atlas);

        if (raylib.IsWindowReady()) font.texture = raylib.LoadTextureFromImage(atlas);

        // Update glyphs[i].image to use alpha, required to be used on ImageDrawText()
        for (0..@intCast(font.glyphCount)) |i| {
            raylib.UnloadImage(font.glyphs[i].image);
            font.glyphs[i].image = raylib.ImageFromImage(atlas, font.recs[i]);
        }

        raylib.TraceLog(raylib.LOG_INFO, "FONT: Data loaded successfully (%i pixel size | %i glyphs)", font.baseSize, font.glyphCount);
    } else {
        font = raylib.GetFontDefault();
    }

    return font;
}

/// Load Font from TTF or BDF font file with generation parameters
/// NOTE: You can pass an array with desired characters, those characters should be available in the font
/// if array is NULL, default char set is selected 32..255
pub fn LoadFontEx2(fileName: [*c]const u8, fontSize: c_int, codepoints: [*c]c_int, codepointCount: c_int, fontType: c_int) raylib.Font {
    var font = raylib.Font{};

    // Loading file to memory
    var dataSize: c_int = 0;
    const fileData = raylib.LoadFileData(fileName, &dataSize);
    defer raylib.UnloadFileData(fileData);

    if (fileData != null) {
        // Loading font from memory data
        font = LoadFontFromMemoryEx(raylib.GetFileExtension(fileName), fileData, dataSize, fontSize, codepoints, codepointCount, fontType);
    }

    return font;
}

/// Generate image: grayscale image from text data
pub fn GenImageTextEx(width: c_int, height: c_int, text: [*c]const u8, textLength: c_int) raylib.Image {
    var image = raylib.Image{};

    const imageViewSize = width * height;

    const data = allocator.alloc(u8, @intCast(imageViewSize)) catch null;
    errdefer allocator.free(data);

    image.width = width;
    image.height = height;
    image.format = raylib.PIXELFORMAT_UNCOMPRESSED_GRAYSCALE;
    image.data = @ptrCast(data);
    image.mipmaps = 1;

    if (data) |d| {
        const length = if (textLength > imageViewSize) imageViewSize else textLength;
        std.mem.copyForwards(u8, d, @as([*]const u8, @ptrCast(text))[0..@intCast(length)]);
    }

    return image;
}
