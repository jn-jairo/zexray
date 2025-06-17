const assert = std.debug.assert;

const raylib = @cImport({
    @cInclude("raylib.h");
    @cInclude("config.h");
    @cInclude("rcamera.h");
    @cInclude("raygui.h");
    @cInclude("raymath.h");
    @cInclude("stdio.h");
});
pub usingnamespace raylib;

const miniaudio = @cImport({
    @cInclude("miniaudio.h");
});

var audio_lock: miniaudio.ma_mutex = undefined;

pub var mode_3d_listener: ?raylib.Camera3D = null;
pub var mode_3d_listener_max_distance: ?f32 = null;

const config = @import("config.zig");
pub usingnamespace config;

const std = @import("std");
const build_config = @import("config");

const e = @import("./erl_nif.zig");

pub const allocator = e.allocator;

/// Size of icons in pixels (squared)
pub const RAYGUI_ICON_SIZE: usize = 16;

/// Maximum number of icons
pub const RAYGUI_ICON_MAX_ICONS: usize = 256;

// /// Maximum length of icon name id
// const RAYGUI_ICON_MAX_NAME_LENGTH: usize = 32;

/// Icons data is defined by bit array (every bit represents one pixel)
/// Those arrays are stored as unsigned int data arrays, so,
/// every array element defines 32 pixels (bits) of information
/// One icon is defined by 8 int, (8 int * 32 bit = 256 bit = 16*16 pixels)
/// NOTE: Number of elemens depend on RAYGUI_ICON_SIZE (by default 16x16 pixels)
pub const RAYGUI_ICON_DATA_ELEMENTS: usize = (RAYGUI_ICON_SIZE * RAYGUI_ICON_SIZE / 32);

/// Icons data for all gui possible icons (allocated on data segment by default)
///
/// NOTE 1: Every icon is codified in binary form, using 1 bit per pixel, so,
/// every 16x16 icon requires 8 integers (16*16/32) to be stored
///
/// NOTE 2: A different icon set could be loaded over this array using GuiLoadIcons(),
/// but loaded icons set must be same RAYGUI_ICON_SIZE and no more than RAYGUI_ICON_MAX_ICONS
///
/// guiIcons size is by default: 256*(16*16/32) = 2048*4 = 8192 bytes = 8 KB
pub const RAYGUI_VALUEBOX_MAX_CHARS: usize = 32;

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

pub const AudioInfo = struct {
    frameCount: c_uint = @import("std").mem.zeroes(c_uint),
    sampleRate: c_uint = @import("std").mem.zeroes(c_uint),
    sampleSize: c_uint = @import("std").mem.zeroes(c_uint),
    channels: c_uint = @import("std").mem.zeroes(c_uint),
};

pub const SoundStream = struct {
    stream: raylib.AudioStream = @import("std").mem.zeroes(raylib.AudioStream),
    frameCount: c_uint = @import("std").mem.zeroes(c_uint),
    looping: bool = @import("std").mem.zeroes(bool),
    position: ?raylib.Vector3 = null,
    position_state: [8]f32 = @import("std").mem.zeroes([8]f32),
    data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};

/// Audio processor struct
/// NOTE: Useful to apply effects to an AudioBuffer
pub const AudioProcessor = extern struct {
    process: raylib.AudioCallback = std.mem.zeroes(raylib.AudioCallback), // Processor callback function
    next: ?*AudioProcessor = std.mem.zeroes(?*AudioProcessor), // Next audio processor on the list
    prev: ?*AudioProcessor = std.mem.zeroes(?*AudioProcessor), // Previous audio processor on the list
};

/// Audio buffer struct
pub const AudioBuffer = extern struct {
    converter: miniaudio.ma_data_converter = std.mem.zeroes(miniaudio.ma_data_converter), // Audio data converter

    callback: raylib.AudioCallback = std.mem.zeroes(raylib.AudioCallback), // Audio buffer callback for buffer filling on audio threads
    processor: ?*AudioProcessor = std.mem.zeroes(?*AudioProcessor), // Audio processor

    volume: f32 = std.mem.zeroes(f32), // Audio buffer volume
    pitch: f32 = std.mem.zeroes(f32), // Audio buffer pitch
    pan: f32 = std.mem.zeroes(f32), // Audio buffer pan (0.0f to 1.0f)

    playing: bool = std.mem.zeroes(bool), // Audio buffer state: AUDIO_PLAYING
    paused: bool = std.mem.zeroes(bool), // Audio buffer state: AUDIO_PAUSED
    looping: bool = std.mem.zeroes(bool), // Audio buffer looping, default to true for AudioStreams
    usage: c_int = std.mem.zeroes(c_int), // Audio buffer usage mode: STATIC or STREAM

    isSubBufferProcessed: [2]bool = std.mem.zeroes([2]bool), // SubBuffer processed (virtual double buffer)
    sizeInFrames: c_uint = std.mem.zeroes(c_uint), // Total buffer size in frames
    frameCursorPos: c_uint = std.mem.zeroes(c_uint), // Frame cursor position
    framesProcessed: c_uint = std.mem.zeroes(c_uint), // Total frames processed in this buffer (required for play timing)

    data: ?*anyopaque = std.mem.zeroes(?*anyopaque), // Data buffer, on music stream keeps filling

    next: ?*AudioBuffer = std.mem.zeroes(?*AudioBuffer), // Next audio buffer on the list
    prev: ?*AudioBuffer = std.mem.zeroes(?*AudioBuffer), // Previous audio buffer on the list
};

/// Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
pub fn TRACELOG(logLevel: c_int, text: [*c]const u8, args: anytype) void {
    if (build_config.trace_log) {
        @call(.auto, raylib.TraceLog, .{ logLevel, text } ++ args);
    }
}

/// Show trace log messages (LOG_DEBUG)
pub fn TRACELOGD(text: [*c]const u8, args: anytype) void {
    if (build_config.trace_log and build_config.trace_log_debug) {
        @call(.auto, raylib.TraceLog, .{ raylib.LOG_DEBUG, text } ++ args);
    }
}

/// Takes a screenshot of current screen
pub fn Screenshot() raylib.Image {
    return raylib.LoadImageFromScreen();
}

/// Takes a screenshot of current screen (filename extension defines format)
pub fn TakeScreenshot2(fileName: [*c]const u8) bool {
    const image = raylib.LoadImageFromScreen();
    defer raylib.UnloadImage(image);

    const ok = raylib.ExportImage(image, fileName);

    if (ok) {
        TRACELOG(raylib.LOG_INFO, "SYSTEM: [%s] Screenshot taken successfully", .{fileName});
    } else {
        TRACELOG(raylib.LOG_WARNING, "SYSTEM: [%s] Screenshot could not be saved", .{fileName});
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

        TRACELOG(raylib.LOG_INFO, "FONT: Data loaded successfully (%i pixel size | %i glyphs)", .{ font.baseSize, font.glyphCount });
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

/// Get sound time length (in seconds)
pub fn GetSoundTimeLength(sound: raylib.Sound) f32 {
    return @as(f32, @floatFromInt(sound.frameCount)) / @as(f32, @floatFromInt(sound.stream.sampleRate));
}

/// Get current sound time played (in seconds)
pub fn GetSoundTimePlayed(sound: raylib.Sound) f32 {
    var secondsPlayed: f32 = 0.0;

    const stream_buffer: ?*AudioBuffer = @ptrCast(@alignCast(sound.stream.buffer));

    if (stream_buffer) |buffer| {
        miniaudio.ma_mutex_lock(&audio_lock);
        const framesProcessed: c_int = @intCast(buffer.framesProcessed);
        const subBufferSize: c_int = @intCast(buffer.sizeInFrames / 2);
        const framesInFirstBuffer: c_int = if (buffer.isSubBufferProcessed[0]) 0 else subBufferSize;
        const framesInSecondBuffer: c_int = if (buffer.isSubBufferProcessed[1]) 0 else subBufferSize;
        const framesSentToMix: c_int = @mod(@as(c_int, @intCast(buffer.frameCursorPos)), subBufferSize);
        var framesPlayed: c_int = @mod((framesProcessed - framesInFirstBuffer - framesInSecondBuffer + framesSentToMix), @as(c_int, @intCast(sound.frameCount)));
        if (framesPlayed < 0) framesPlayed += @as(c_int, @intCast(sound.frameCount));
        secondsPlayed = @as(f32, @floatFromInt(framesPlayed)) / @as(f32, @floatFromInt(sound.stream.sampleRate));
        miniaudio.ma_mutex_unlock(&audio_lock);
    }

    return secondsPlayed;
}

/// Get audio stream time length (in seconds)
pub fn GetAudioStreamTimeLength(stream: raylib.AudioStream, frameCount: c_uint) f32 {
    return @as(f32, @floatFromInt(frameCount)) / @as(f32, @floatFromInt(stream.sampleRate));
}

/// Get current audio stream time played (in seconds)
pub fn GetAudioStreamTimePlayed(stream: raylib.AudioStream, frameCount: c_uint) f32 {
    var secondsPlayed: f32 = 0.0;

    const stream_buffer: ?*AudioBuffer = @ptrCast(@alignCast(stream.buffer));

    if (stream_buffer) |buffer| {
        miniaudio.ma_mutex_lock(&audio_lock);
        const framesProcessed: c_int = @intCast(buffer.framesProcessed);
        const subBufferSize: c_int = @intCast(buffer.sizeInFrames / 2);
        const framesInFirstBuffer: c_int = if (buffer.isSubBufferProcessed[0]) 0 else subBufferSize;
        const framesInSecondBuffer: c_int = if (buffer.isSubBufferProcessed[1]) 0 else subBufferSize;
        const framesSentToMix: c_int = @mod(@as(c_int, @intCast(buffer.frameCursorPos)), subBufferSize);
        var framesPlayed: c_int = @mod((framesProcessed - framesInFirstBuffer - framesInSecondBuffer + framesSentToMix), @as(c_int, @intCast(frameCount)));
        if (framesPlayed < 0) framesPlayed += @as(c_int, @intCast(frameCount));
        secondsPlayed = @as(f32, @floatFromInt(framesPlayed)) / @as(f32, @floatFromInt(stream.sampleRate));
        miniaudio.ma_mutex_unlock(&audio_lock);
    }

    return secondsPlayed;
}

/// Load audio stream from audio info
pub fn LoadAudioStreamFromAudioInfo(info: AudioInfo) raylib.AudioStream {
    return raylib.LoadAudioStream(info.sampleRate, info.sampleSize, info.channels);
}

/// Get sound info
pub fn GetSoundInfo(sound: raylib.Sound) AudioInfo {
    var info = AudioInfo{};

    info.frameCount = sound.frameCount;
    info.sampleRate = sound.stream.sampleRate;
    info.sampleSize = sound.stream.sampleSize;
    info.channels = sound.stream.channels;

    return info;
}

/// Get wave info
pub fn GetWaveInfo(wave: raylib.Wave) AudioInfo {
    var info = AudioInfo{};

    info.frameCount = wave.frameCount;
    info.sampleRate = wave.sampleRate;
    info.sampleSize = wave.sampleSize;
    info.channels = wave.channels;

    return info;
}

/// Set looping for a music
pub fn SetMusicLooping(music: *raylib.Music, looping: bool) void {
    music.looping = looping;
}

/// Get music info
pub fn GetMusicInfo(music: raylib.Music) AudioInfo {
    var info = AudioInfo{};

    info.frameCount = music.frameCount;
    info.sampleRate = music.stream.sampleRate;
    info.sampleSize = music.stream.sampleSize;
    info.channels = music.stream.channels;

    return info;
}

/// Get audio stream info
pub fn GetAudioStreamInfo(stream: raylib.AudioStream) AudioInfo {
    var info = AudioInfo{};

    info.frameCount = 0;
    info.sampleRate = stream.sampleRate;
    info.sampleSize = stream.sampleSize;
    info.channels = stream.channels;

    return info;
}

/// Load sound stream from file
pub fn LoadSoundStream(fileName: [*c]const u8) SoundStream {
    const wave = raylib.LoadWave(fileName);
    defer raylib.UnloadWave(wave);
    return LoadSoundStreamFromWave(wave);
}

/// Load sound stream from wave data
pub fn LoadSoundStreamFromWave(wave: raylib.Wave) SoundStream {
    var sound_stream = SoundStream{};

    const wave_copy = raylib.WaveCopy(wave);

    sound_stream.stream = raylib.LoadAudioStream(wave_copy.sampleRate, wave_copy.sampleSize, wave_copy.channels);
    sound_stream.frameCount = wave_copy.frameCount;
    sound_stream.looping = false;
    sound_stream.data = wave_copy.data;

    return sound_stream;
}

/// Create a new sound stream that shares the same sample data as the source sound, does not own the sound stream data
pub fn LoadSoundStreamAlias(source: SoundStream) SoundStream {
    var sound_stream = SoundStream{};

    sound_stream.stream = raylib.LoadAudioStream(source.stream.sampleRate, source.stream.sampleSize, source.stream.channels);
    sound_stream.frameCount = source.frameCount;
    sound_stream.looping = source.looping;
    sound_stream.data = source.data;

    return sound_stream;
}

/// Checks if a sound stream is valid (data loaded and buffers initialized)
pub fn IsSoundStreamValid(sound_stream: SoundStream) bool {
    var result = false;

    if ((sound_stream.data != null) and // Validate wave data available
        (sound_stream.frameCount > 0) and // Validate frame count
        (sound_stream.stream.buffer != null) and // Validate stream buffer
        (sound_stream.stream.sampleRate > 0) and // Validate sample rate is supported
        (sound_stream.stream.sampleSize > 0) and // Validate sample size is supported
        (sound_stream.stream.channels > 0)) result = true; // Validate number of channels supported

    return result;
}

/// Update sound stream buffer with new data
pub fn UpdateSoundStream(sound_stream: SoundStream, data: ?*const anyopaque, sampleCount: c_int) void {
    raylib.UpdateAudioStream(sound_stream.stream, data, sampleCount);
}

/// Unload sound stream
pub fn UnloadSoundStream(sound_stream: SoundStream) void {
    raylib.UnloadAudioStream(sound_stream.stream);
    raylib.MemFree(sound_stream.data);
}

/// Unload a sound stream alias (does not deallocate sample data)
pub fn UnloadSoundStreamAlias(alias: SoundStream) void {
    raylib.UnloadAudioStream(alias.stream);
}

/// Play a sound stream
pub fn PlaySoundStream(sound_stream: SoundStream) void {
    raylib.PlayAudioStream(sound_stream.stream);
}

/// Stop playing a sound stream
pub fn StopSoundStream(sound_stream: SoundStream) void {
    raylib.StopAudioStream(sound_stream.stream);
}

/// Pause a sound stream
pub fn PauseSoundStream(sound_stream: SoundStream) void {
    raylib.PauseAudioStream(sound_stream.stream);
}

/// Resume a paused sound stream
pub fn ResumeSoundStream(sound_stream: SoundStream) void {
    raylib.ResumeAudioStream(sound_stream.stream);
}

/// Check if a sound stream is currently playing
pub fn IsSoundStreamPlaying(sound_stream: SoundStream) bool {
    return raylib.IsAudioStreamPlaying(sound_stream.stream);
}

/// Set volume for a sound stream (1.0 is max level)
pub fn SetSoundStreamVolume(sound_stream: SoundStream, volume: f32) void {
    raylib.SetAudioStreamVolume(sound_stream.stream, volume);
}

/// Set pitch for a sound stream (1.0 is base level)
pub fn SetSoundStreamPitch(sound_stream: SoundStream, pitch: f32) void {
    raylib.SetAudioStreamPitch(sound_stream.stream, pitch);
}

/// Set pan for a sound stream (0.5 is center)
pub fn SetSoundStreamPan(sound_stream: SoundStream, pan: f32) void {
    raylib.SetAudioStreamPan(sound_stream.stream, pan);
}

/// Set looping for a sound stream
pub fn SetSoundStreamLooping(sound_stream: *SoundStream, looping: bool) void {
    sound_stream.looping = looping;
}

/// Get sound stream time length (in seconds)
pub fn GetSoundStreamTimeLength(sound_stream: SoundStream) f32 {
    return @as(f32, @floatFromInt(sound_stream.frameCount)) / @as(f32, @floatFromInt(sound_stream.stream.sampleRate));
}

/// Get current sound stream time played (in seconds)
pub fn GetSoundStreamTimePlayed(sound_stream: SoundStream) f32 {
    var secondsPlayed: f32 = 0.0;

    const stream_buffer: ?*AudioBuffer = @ptrCast(@alignCast(sound_stream.stream.buffer));

    if (stream_buffer) |buffer| {
        miniaudio.ma_mutex_lock(&audio_lock);
        const framesProcessed: c_int = @intCast(buffer.framesProcessed);
        const subBufferSize: c_int = @intCast(buffer.sizeInFrames / 2);
        const framesInFirstBuffer: c_int = if (buffer.isSubBufferProcessed[0]) 0 else subBufferSize;
        const framesInSecondBuffer: c_int = if (buffer.isSubBufferProcessed[1]) 0 else subBufferSize;
        const framesSentToMix: c_int = @mod(@as(c_int, @intCast(buffer.frameCursorPos)), subBufferSize);
        var framesPlayed: c_int = @mod((framesProcessed - framesInFirstBuffer - framesInSecondBuffer + framesSentToMix), @as(c_int, @intCast(sound_stream.frameCount)));
        if (framesPlayed < 0) framesPlayed += @as(c_int, @intCast(sound_stream.frameCount));
        secondsPlayed = @as(f32, @floatFromInt(framesPlayed)) / @as(f32, @floatFromInt(sound_stream.stream.sampleRate));
        miniaudio.ma_mutex_unlock(&audio_lock);
    }

    return secondsPlayed;
}

/// Get current sound stream frames processed
pub fn GetSoundStreamFramesProcessed(sound_stream: SoundStream) c_uint {
    var framesProcessed: c_uint = 0;

    const stream_buffer: ?*AudioBuffer = @ptrCast(@alignCast(sound_stream.stream.buffer));
    if (stream_buffer) |buffer| {
        miniaudio.ma_mutex_lock(&audio_lock);
        framesProcessed = buffer.framesProcessed;
        miniaudio.ma_mutex_unlock(&audio_lock);
    }

    return framesProcessed;
}

/// Get current sound stream sub buffer size
pub fn GetSoundStreamSubBufferSize(sound_stream: SoundStream) c_uint {
    var subBufferSize: c_uint = 0;

    const stream_buffer: ?*AudioBuffer = @ptrCast(@alignCast(sound_stream.stream.buffer));
    if (stream_buffer) |buffer| {
        miniaudio.ma_mutex_lock(&audio_lock);
        subBufferSize = buffer.sizeInFrames / 2;
        miniaudio.ma_mutex_unlock(&audio_lock);
    }

    return subBufferSize;
}

/// Get sound stream info
pub fn GetSoundStreamInfo(sound_stream: SoundStream) AudioInfo {
    var info = AudioInfo{};

    info.frameCount = sound_stream.frameCount;
    info.sampleRate = sound_stream.stream.sampleRate;
    info.sampleSize = sound_stream.stream.sampleSize;
    info.channels = sound_stream.stream.channels;

    return info;
}

/// Set position for a sound
pub fn SetSoundPosition(sound: *raylib.Sound, position: ?raylib.Vector3) void {
    const computed_position = ComputeAudioPositionMode3D(position);

    raylib.SetSoundVolume(sound.*, computed_position.volume);
    raylib.SetSoundPan(sound.*, computed_position.pan);
}

/// Set position for a music
pub fn SetMusicPosition(music: *raylib.Music, position: ?raylib.Vector3) void {
    const computed_position = ComputeAudioPositionMode3D(position);

    raylib.SetMusicVolume(music.*, computed_position.volume);
    raylib.SetMusicPan(music.*, computed_position.pan);
}

/// Set position for a audio stream
pub fn SetAudioStreamPosition(audio_stream: *raylib.AudioStream, position: ?raylib.Vector3) void {
    const computed_position = ComputeAudioPositionMode3D(position);

    raylib.SetAudioStreamVolume(audio_stream.*, computed_position.volume);
    raylib.SetAudioStreamPan(audio_stream.*, computed_position.pan);
}

/// Set position for a sound stream
pub fn SetSoundStreamPosition(sound_stream: *SoundStream, position: ?raylib.Vector3) void {
    sound_stream.position = position;

    const computed_position = ComputeAudioPositionMode3D(position);

    SetSoundStreamVolume(sound_stream.*, computed_position.volume);
    SetSoundStreamPan(sound_stream.*, computed_position.pan);
}

pub fn ComputeAudioPositionMode3D(position: ?raylib.Vector3) @typeInfo(@TypeOf(ComputeAudioPosition3D)).@"fn".return_type.? {
    return ComputeAudioPosition3D(mode_3d_listener, mode_3d_listener_max_distance, position);
}

pub fn ComputeAudioPosition3D(listener: ?raylib.Camera3D, max_distance: ?f32, position: ?raylib.Vector3) struct { volume: f32, pan: f32, forward: f32, right: f32, up: f32 } {
    if (listener != null and max_distance != null and position != null) {
        // Calculate direction vector and distance between listener and sound source
        const direction: raylib.Vector3 = raylib.Vector3Subtract(position.?, listener.?.position);
        const distance: f32 = raylib.Vector3Length(direction);

        // Apply logarithmic distance gain and clamp between 0-1
        var gain: f32 = 1.0 / (1.0 + (distance / max_distance.?));
        gain = raylib.Clamp(gain, 0.0, 1.0);

        // Calculate normalized vectors for spatial positioning
        const normalized_direction = raylib.Vector3Normalize(direction);
        const forward = raylib.Vector3Normalize(raylib.Vector3Subtract(listener.?.target, listener.?.position));
        const right = raylib.Vector3Normalize(raylib.Vector3CrossProduct(listener.?.up, forward));
        const up = raylib.Vector3Normalize(listener.?.up);

        // Calculate local directions
        const forward_ratio: f32 = raylib.Vector3DotProduct(forward, normalized_direction);
        const right_ratio: f32 = raylib.Vector3DotProduct(right, normalized_direction);
        const up_ratio: f32 = raylib.Vector3DotProduct(up, normalized_direction);

        // Reduce volume for sounds behind the listener
        if (forward_ratio < 0.0) gain *= (1.0 + forward_ratio * 0.5);

        // Set stereo panning based on sound position relative to listener
        const pan: f32 = 0.5 + 0.5 * right_ratio;

        return .{
            .volume = gain,
            .pan = pan,
            .forward = forward_ratio,
            .right = right_ratio,
            .up = up_ratio,
        };
    } else {
        return .{
            .volume = 1.0,
            .pan = 0.5,
            .forward = 1.0,
            .right = 0.0,
            .up = 0.0,
        };
    }
}

/// Compute biquad peaking equalizer b,a 2nd order coefficients
///
/// q = how narrow or wide the filter affects the frequencies around the target frequency
/// high q = very narrow, affets only frequencies very close to the target frequency
/// low q = wider, affects a bigger range of frequencies around the target frequency
///
/// q ~ 0.3 = very wide
/// q ~ 1.0 = moderate
/// q ~ 5.0 = narrow
/// q > 10  = very narrow
///
/// gain_db <= 6.0 for good effects, bigger gains may cause distortions
pub fn BiquadPeakingEqualizer(sample_rate: c_uint, frequency: c_uint, q: f32, gain_db: f32) struct { b: [3]f32, a: [3]f32 } {
    const a: f32 = std.math.pow(f32, 10, gain_db / 20);
    const w0: f32 = 2 * std.math.pi * @as(f32, @floatFromInt(frequency)) / @as(f32, @floatFromInt(sample_rate));
    const alpha: f32 = std.math.sin(w0) / (2 * q);

    const b0: f32 = 1 + alpha * a;
    const b1: f32 = -2 * std.math.cos(w0);
    const b2: f32 = 1 - alpha * a;

    const a0: f32 = 1 + alpha / a;
    const a1: f32 = -2 * std.math.cos(w0);
    const a2: f32 = 1 - alpha / a;

    return .{
        .b = [3]f32{ b0 / a0, b1 / a0, b2 / a0 },
        .a = [3]f32{ 1.0, a1 / a0, a2 / a0 },
    };
}

pub fn ApplyBiquadFilterMono(samples: []f32, b: [3]f32, a: [3]f32, hist: []f32) void {
    assert(hist.len >= 4);

    var x1: f32 = hist[0];
    var x2: f32 = hist[1];
    var y1: f32 = hist[2];
    var y2: f32 = hist[3];

    var y: f32 = 0;

    for (0..samples.len) |i| {
        y = b[0] * samples[i] + b[1] * x1 + b[2] * x2 - a[1] * y1 - a[2] * y2;
        x2 = x1;
        x1 = samples[i];
        y2 = y1;
        y1 = y;

        samples[i] = y;
    }

    hist[0] = x1;
    hist[1] = x2;
    hist[2] = y1;
    hist[3] = y2;
}

pub fn ApplyBiquadFilterStereo(samples: []f32, b: [3]f32, a: [3]f32, hist: []f32) void {
    assert(hist.len >= 8);

    // LEFT

    var x1: f32 = hist[0];
    var x2: f32 = hist[1];
    var y1: f32 = hist[2];
    var y2: f32 = hist[3];

    var y: f32 = 0;

    var i: usize = 0;
    while (i < samples.len) {
        y = b[0] * samples[i] + b[1] * x1 + b[2] * x2 - a[1] * y1 - a[2] * y2;

        x2 = x1;
        x1 = samples[i];
        y2 = y1;
        y1 = y;

        samples[i] = y;

        i += 2;
    }

    hist[0] = x1;
    hist[1] = x2;
    hist[2] = y1;
    hist[3] = y2;

    // RIGHT

    x1 = hist[4];
    x2 = hist[5];
    y1 = hist[6];
    y2 = hist[7];

    y = 0;

    i = 1;
    while (i < samples.len) {
        y = b[0] * samples[i] + b[1] * x1 + b[2] * x2 - a[1] * y1 - a[2] * y2;

        x2 = x1;
        x1 = samples[i];
        y2 = y1;
        y1 = y;

        samples[i] = y;

        i += 2;
    }

    hist[4] = x1;
    hist[5] = x2;
    hist[6] = y1;
    hist[7] = y2;
}

pub fn ApplyBiquadFilter(channels: c_uint, samples: []f32, b: [3]f32, a: [3]f32, hist: []f32) void {
    switch (channels) {
        2 => ApplyBiquadFilterStereo(samples, b, a, hist),
        1 => ApplyBiquadFilterMono(samples, b, a, hist),
        else => unreachable,
    }
}

pub fn ApplyFilterBehind(sample_rate: c_uint, channels: c_uint, samples: []f32, gain: f32, hist: []f32) void {
    assert(hist.len >= 4 * channels);

    const ba = BiquadPeakingEqualizer(sample_rate, 1_000, 1.0, 6.0 * gain);
    ApplyBiquadFilter(channels, samples, ba.b, ba.a, hist[0 .. 4 * channels]);
}

pub fn ApplyFilterFront(sample_rate: c_uint, channels: c_uint, samples: []f32, gain: f32, hist: []f32) void {
    assert(hist.len >= 3 * 4 * channels);

    const ba_1 = BiquadPeakingEqualizer(sample_rate, 1_000, 1.0, -10.0 * gain);
    const ba_2 = BiquadPeakingEqualizer(sample_rate, 3_000, 1.0, 6.0 * gain);
    const ba_3 = BiquadPeakingEqualizer(sample_rate, 400, 1.0, 4.0 * gain);

    // mono
    // 0..4
    // 4..8
    // 8..12
    //
    // stereo
    // 0..8
    // 8..16
    // 16..24

    ApplyBiquadFilter(channels, samples, ba_1.b, ba_1.a, hist[0 .. 4 * channels]);
    ApplyBiquadFilter(channels, samples, ba_2.b, ba_2.a, hist[4 * channels .. 2 * 4 * channels]);
    ApplyBiquadFilter(channels, samples, ba_3.b, ba_3.a, hist[2 * 4 * channels .. 3 * 4 * channels]);
}
