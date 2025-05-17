const std = @import("std");
const assert = std.debug.assert;
const e = @import("../erl_nif.zig");
const rl = @import("../raylib.zig");

const core = @import("../core.zig");

pub const exported_nifs = [_]e.ErlNifFunc{
    // Wave
    .{ .name = "get_wave_data_size", .arity = 3, .fptr = core.nif_wrapper(nif_get_wave_data_size), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Audio device management
    .{ .name = "init_audio_device", .arity = 0, .fptr = core.nif_wrapper(nif_init_audio_device), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "close_audio_device", .arity = 0, .fptr = core.nif_wrapper(nif_close_audio_device), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_audio_device_ready", .arity = 0, .fptr = core.nif_wrapper(nif_is_audio_device_ready), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_master_volume", .arity = 1, .fptr = core.nif_wrapper(nif_set_master_volume), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_master_volume", .arity = 0, .fptr = core.nif_wrapper(nif_get_master_volume), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Sound loading
    .{ .name = "load_wave", .arity = 1, .fptr = core.nif_wrapper(nif_load_wave), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_wave", .arity = 2, .fptr = core.nif_wrapper(nif_load_wave), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_wave_from_memory", .arity = 2, .fptr = core.nif_wrapper(nif_load_wave_from_memory), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_wave_from_memory", .arity = 3, .fptr = core.nif_wrapper(nif_load_wave_from_memory), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_wave_valid", .arity = 1, .fptr = core.nif_wrapper(nif_is_wave_valid), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_sound", .arity = 1, .fptr = core.nif_wrapper(nif_load_sound), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_sound", .arity = 2, .fptr = core.nif_wrapper(nif_load_sound), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_sound_from_wave", .arity = 1, .fptr = core.nif_wrapper(nif_load_sound_from_wave), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_sound_from_wave", .arity = 2, .fptr = core.nif_wrapper(nif_load_sound_from_wave), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_sound_alias", .arity = 1, .fptr = core.nif_wrapper(nif_load_sound_alias), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_sound_alias", .arity = 2, .fptr = core.nif_wrapper(nif_load_sound_alias), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_sound_valid", .arity = 1, .fptr = core.nif_wrapper(nif_is_sound_valid), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "update_sound", .arity = 2, .fptr = core.nif_wrapper(nif_update_sound), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "update_sound", .arity = 3, .fptr = core.nif_wrapper(nif_update_sound), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_sound_processed", .arity = 1, .fptr = core.nif_wrapper(nif_is_sound_processed), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "export_wave", .arity = 2, .fptr = core.nif_wrapper(nif_export_wave), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Sound management
    .{ .name = "play_sound", .arity = 1, .fptr = core.nif_wrapper(nif_play_sound), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "play_sound", .arity = 2, .fptr = core.nif_wrapper(nif_play_sound), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "stop_sound", .arity = 1, .fptr = core.nif_wrapper(nif_stop_sound), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "stop_sound", .arity = 2, .fptr = core.nif_wrapper(nif_stop_sound), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "pause_sound", .arity = 1, .fptr = core.nif_wrapper(nif_pause_sound), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "pause_sound", .arity = 2, .fptr = core.nif_wrapper(nif_pause_sound), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "resume_sound", .arity = 1, .fptr = core.nif_wrapper(nif_resume_sound), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "resume_sound", .arity = 2, .fptr = core.nif_wrapper(nif_resume_sound), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_sound_playing", .arity = 1, .fptr = core.nif_wrapper(nif_is_sound_playing), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_sound_volume", .arity = 2, .fptr = core.nif_wrapper(nif_set_sound_volume), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_sound_volume", .arity = 3, .fptr = core.nif_wrapper(nif_set_sound_volume), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_sound_pitch", .arity = 2, .fptr = core.nif_wrapper(nif_set_sound_pitch), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_sound_pitch", .arity = 3, .fptr = core.nif_wrapper(nif_set_sound_pitch), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_sound_pan", .arity = 2, .fptr = core.nif_wrapper(nif_set_sound_pan), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_sound_pan", .arity = 3, .fptr = core.nif_wrapper(nif_set_sound_pan), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_sound_time_length", .arity = 1, .fptr = core.nif_wrapper(nif_get_sound_time_length), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "wave_copy", .arity = 1, .fptr = core.nif_wrapper(nif_wave_copy), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "wave_copy", .arity = 2, .fptr = core.nif_wrapper(nif_wave_copy), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "wave_crop", .arity = 3, .fptr = core.nif_wrapper(nif_wave_crop), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "wave_crop", .arity = 4, .fptr = core.nif_wrapper(nif_wave_crop), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "wave_format", .arity = 4, .fptr = core.nif_wrapper(nif_wave_format), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "wave_format", .arity = 5, .fptr = core.nif_wrapper(nif_wave_format), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_wave_samples", .arity = 1, .fptr = core.nif_wrapper(nif_load_wave_samples), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_wave_samples_raw", .arity = 1, .fptr = core.nif_wrapper(nif_load_wave_samples_raw), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // Music management
    .{ .name = "load_music_stream", .arity = 1, .fptr = core.nif_wrapper(nif_load_music_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_music_stream", .arity = 2, .fptr = core.nif_wrapper(nif_load_music_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_music_stream_from_memory", .arity = 2, .fptr = core.nif_wrapper(nif_load_music_stream_from_memory), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_music_stream_from_memory", .arity = 3, .fptr = core.nif_wrapper(nif_load_music_stream_from_memory), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_music_valid", .arity = 1, .fptr = core.nif_wrapper(nif_is_music_valid), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "play_music_stream", .arity = 1, .fptr = core.nif_wrapper(nif_play_music_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "play_music_stream", .arity = 2, .fptr = core.nif_wrapper(nif_play_music_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_music_stream_playing", .arity = 1, .fptr = core.nif_wrapper(nif_is_music_stream_playing), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "update_music_stream", .arity = 1, .fptr = core.nif_wrapper(nif_update_music_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "update_music_stream", .arity = 2, .fptr = core.nif_wrapper(nif_update_music_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_music_stream_processed", .arity = 1, .fptr = core.nif_wrapper(nif_is_music_stream_processed), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "stop_music_stream", .arity = 1, .fptr = core.nif_wrapper(nif_stop_music_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "stop_music_stream", .arity = 2, .fptr = core.nif_wrapper(nif_stop_music_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "pause_music_stream", .arity = 1, .fptr = core.nif_wrapper(nif_pause_music_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "pause_music_stream", .arity = 2, .fptr = core.nif_wrapper(nif_pause_music_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "resume_music_stream", .arity = 1, .fptr = core.nif_wrapper(nif_resume_music_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "resume_music_stream", .arity = 2, .fptr = core.nif_wrapper(nif_resume_music_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "seek_music_stream", .arity = 2, .fptr = core.nif_wrapper(nif_seek_music_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "seek_music_stream", .arity = 3, .fptr = core.nif_wrapper(nif_seek_music_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_music_volume", .arity = 2, .fptr = core.nif_wrapper(nif_set_music_volume), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_music_volume", .arity = 3, .fptr = core.nif_wrapper(nif_set_music_volume), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_music_pitch", .arity = 2, .fptr = core.nif_wrapper(nif_set_music_pitch), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_music_pitch", .arity = 3, .fptr = core.nif_wrapper(nif_set_music_pitch), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_music_pan", .arity = 2, .fptr = core.nif_wrapper(nif_set_music_pan), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_music_pan", .arity = 3, .fptr = core.nif_wrapper(nif_set_music_pan), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_music_looping", .arity = 2, .fptr = core.nif_wrapper(nif_set_music_looping), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_music_looping", .arity = 3, .fptr = core.nif_wrapper(nif_set_music_looping), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_music_time_length", .arity = 1, .fptr = core.nif_wrapper(nif_get_music_time_length), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "get_music_time_played", .arity = 1, .fptr = core.nif_wrapper(nif_get_music_time_played), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },

    // AudioStream management
    .{ .name = "load_audio_stream", .arity = 3, .fptr = core.nif_wrapper(nif_load_audio_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "load_audio_stream", .arity = 4, .fptr = core.nif_wrapper(nif_load_audio_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_audio_stream_valid", .arity = 1, .fptr = core.nif_wrapper(nif_is_audio_stream_valid), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "update_audio_stream", .arity = 2, .fptr = core.nif_wrapper(nif_update_audio_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "update_audio_stream", .arity = 3, .fptr = core.nif_wrapper(nif_update_audio_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_audio_stream_processed", .arity = 1, .fptr = core.nif_wrapper(nif_is_audio_stream_processed), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "play_audio_stream", .arity = 1, .fptr = core.nif_wrapper(nif_play_audio_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "play_audio_stream", .arity = 2, .fptr = core.nif_wrapper(nif_play_audio_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "pause_audio_stream", .arity = 1, .fptr = core.nif_wrapper(nif_pause_audio_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "pause_audio_stream", .arity = 2, .fptr = core.nif_wrapper(nif_pause_audio_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "resume_audio_stream", .arity = 1, .fptr = core.nif_wrapper(nif_resume_audio_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "resume_audio_stream", .arity = 2, .fptr = core.nif_wrapper(nif_resume_audio_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "is_audio_stream_playing", .arity = 1, .fptr = core.nif_wrapper(nif_is_audio_stream_playing), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "stop_audio_stream", .arity = 1, .fptr = core.nif_wrapper(nif_stop_audio_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "stop_audio_stream", .arity = 2, .fptr = core.nif_wrapper(nif_stop_audio_stream), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_audio_stream_volume", .arity = 2, .fptr = core.nif_wrapper(nif_set_audio_stream_volume), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_audio_stream_volume", .arity = 3, .fptr = core.nif_wrapper(nif_set_audio_stream_volume), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_audio_stream_pitch", .arity = 2, .fptr = core.nif_wrapper(nif_set_audio_stream_pitch), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_audio_stream_pitch", .arity = 3, .fptr = core.nif_wrapper(nif_set_audio_stream_pitch), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_audio_stream_pan", .arity = 2, .fptr = core.nif_wrapper(nif_set_audio_stream_pan), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_audio_stream_pan", .arity = 3, .fptr = core.nif_wrapper(nif_set_audio_stream_pan), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
    .{ .name = "set_audio_stream_buffer_size_default", .arity = 1, .fptr = core.nif_wrapper(nif_set_audio_stream_buffer_size_default), .flags = e.ERL_NIF_DIRTY_JOB_CPU_BOUND },
};

////////////
//  Wave  //
////////////

/// Get wave data size in bytes
///
/// pub fn get_data_size(frame_count: c_uint, channels: c_uint, sample_size: c_uint) usize
fn nif_get_wave_data_size(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3);

    // Arguments

    const frame_count: c_uint = core.UInt.get(env, argv[0]) catch {
        return error.invalid_argument_frame_count;
    };

    const channels: c_uint = core.UInt.get(env, argv[1]) catch {
        return error.invalid_argument_channels;
    };

    const sample_size: c_uint = core.UInt.get(env, argv[2]) catch {
        return error.invalid_argument_sample_size;
    };

    // Function

    const data_size = core.Wave.get_data_size(frame_count, channels, sample_size);

    // Return

    return core.UInt.make(env, @intCast(data_size));
}

///////////////////////////////
//  Audio device management  //
///////////////////////////////

/// Initialize audio device and context
///
/// raylib.h
/// RLAPI void InitAudioDevice(void);
fn nif_init_audio_device(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.InitAudioDevice();

    // Return

    return core.Atom.make(env, "ok");
}

/// Close the audio device and context
///
/// raylib.h
/// RLAPI void CloseAudioDevice(void);
fn nif_close_audio_device(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    rl.CloseAudioDevice();

    // Return

    return core.Atom.make(env, "ok");
}

/// Check if audio device has been initialized successfully
///
/// raylib.h
/// RLAPI bool IsAudioDeviceReady(void);
fn nif_is_audio_device_ready(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const is_audio_device_ready = rl.IsAudioDeviceReady();

    // Return

    return core.Boolean.make(env, is_audio_device_ready);
}

/// Set master volume (listener)
///
/// raylib.h
/// RLAPI void SetMasterVolume(float volume);
fn nif_set_master_volume(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const volume = core.Double.get(env, argv[0]) catch {
        return error.invalid_argument_volume;
    };

    // Function

    rl.SetMasterVolume(@floatCast(volume));

    // Return

    return core.Atom.make(env, "ok");
}

/// Get master volume (listener)
///
/// raylib.h
/// RLAPI float GetMasterVolume(void);
fn nif_get_master_volume(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 0);
    _ = argv;

    // Function

    const master_volume = rl.GetMasterVolume();

    // Return

    return core.Double.make(env, @floatCast(master_volume));
}

/////////////////////
//  Sound loading  //
/////////////////////

/// Load wave data from file
///
/// raylib.h
/// RLAPI Wave LoadWave(const char *fileName);
fn nif_load_wave(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
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

    const wave = rl.LoadWave(file_name);
    defer if (!return_resource) core.Wave.unload(wave);
    errdefer if (return_resource) core.Wave.unload(wave);

    // Return

    return core.maybe_make_struct_as_resource(core.Wave, env, wave, return_resource) catch {
        return error.invalid_return;
    };
}

/// Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
///
/// raylib.h
/// RLAPI Wave LoadWaveFromMemory(const char *fileType, const unsigned char *fileData, int dataSize);
fn nif_load_wave_from_memory(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
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

    const wave = rl.LoadWaveFromMemory(file_type, @ptrCast(file_data), @intCast(data_size));
    defer if (!return_resource) core.Wave.unload(wave);
    errdefer if (return_resource) core.Wave.unload(wave);

    // Return

    return core.maybe_make_struct_as_resource(core.Wave, env, wave, return_resource) catch {
        return error.invalid_return;
    };
}

/// Checks if wave data is valid (data loaded and parameters)
///
/// raylib.h
/// RLAPI bool IsWaveValid(Wave wave);
fn nif_is_wave_valid(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_wave = core.Argument(core.Wave).get(env, argv[0]) catch {
        return error.invalid_argument_wave;
    };
    defer arg_wave.free();
    const wave = arg_wave.data;

    // Function

    const is_wave_valid = rl.IsWaveValid(wave);

    // Return

    return core.Boolean.make(env, is_wave_valid);
}

/// Load sound from file
///
/// raylib.h
/// RLAPI Sound LoadSound(const char *fileName);
fn nif_load_sound(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
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

    const sound = rl.LoadSound(file_name);
    defer if (!return_resource) core.Sound.unload(sound);
    errdefer if (return_resource) core.Sound.unload(sound);

    // Return

    return core.maybe_make_struct_as_resource(core.Sound, env, sound, return_resource) catch {
        return error.invalid_return;
    };
}

/// Load sound from wave data
///
/// raylib.h
/// RLAPI Sound LoadSoundFromWave(Wave wave);
fn nif_load_sound_from_wave(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_wave = core.Argument(core.Wave).get(env, argv[0]) catch {
        return error.invalid_argument_wave;
    };
    defer arg_wave.free();
    const wave = arg_wave.data;

    // Function

    const sound = rl.LoadSoundFromWave(wave);
    defer if (!return_resource) core.Sound.unload(sound);
    errdefer if (return_resource) core.Sound.unload(sound);

    // Return

    return core.maybe_make_struct_as_resource(core.Sound, env, sound, return_resource) catch {
        return error.invalid_return;
    };
}

/// Create a new sound that shares the same sample data as the source sound, does not own the sound data
///
/// raylib.h
/// RLAPI Sound LoadSoundAlias(Sound source);
fn nif_load_sound_alias(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_source = core.Argument(core.Sound).get(env, argv[0]) catch {
        return error.invalid_argument_source;
    };
    defer arg_source.free();
    const source = arg_source.data;

    // Function

    const sound_alias = rl.LoadSoundAlias(source);
    defer if (!return_resource) core.SoundAlias.unload(sound_alias);
    errdefer if (return_resource) core.SoundAlias.unload(sound_alias);

    // Return

    return core.maybe_make_struct_as_resource(core.SoundAlias, env, sound_alias, return_resource) catch {
        return error.invalid_return;
    };
}

/// Checks if a sound is valid (data loaded and buffers initialized)
///
/// raylib.h
/// RLAPI bool IsSoundValid(Sound sound);
fn nif_is_sound_valid(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_sound = core.Argument(core.Sound).get(env, argv[0]) catch {
        return error.invalid_argument_sound;
    };
    defer arg_sound.free();
    const sound = arg_sound.data;

    // Function

    const is_sound_valid = rl.IsSoundValid(sound);

    // Return

    return core.Boolean.make(env, is_sound_valid);
}

/// Update sound buffer with new data
///
/// raylib.h
/// RLAPI void UpdateSound(Sound sound, const void *data, int sampleCount);
fn nif_update_sound(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    var arg_sound = core.Argument(core.Sound).get(env, argv[0]) catch {
        return error.invalid_argument_sound;
    };
    defer if (!return_resource) arg_sound.free();
    errdefer if (return_resource) arg_sound.free();
    const sound = &arg_sound.data;

    // Function

    switch (sound.stream.sampleSize) {
        8 => {
            var arg_data = core.ArgumentArray(core.UInt, u8, rl.allocator).get(env, argv[1]) catch {
                return error.invalid_argument_data;
            };
            defer arg_data.free();
            const data = arg_data.data;
            const data_size : c_uint = @intCast(arg_data.length);

            rl.UpdateSound(sound.*, @ptrCast(data), @intCast(@divTrunc(data_size, sound.stream.channels)));
        },
        16 => {
            var arg_data = core.ArgumentArray(core.Int, c_short, rl.allocator).get(env, argv[1]) catch {
                return error.invalid_argument_data;
            };
            defer arg_data.free();
            const data = arg_data.data;
            const data_size : c_uint = @intCast(arg_data.length);

            rl.UpdateSound(sound.*, @ptrCast(data), @intCast(@divTrunc(data_size, sound.stream.channels)));
        },
        32 => {
            var arg_data = core.ArgumentArray(core.Double, f32, rl.allocator).get(env, argv[1]) catch {
                return error.invalid_argument_data;
            };
            defer arg_data.free();
            const data = arg_data.data;
            const data_size : c_uint = @intCast(arg_data.length);

            rl.UpdateSound(sound.*, @ptrCast(data), @intCast(@divTrunc(data_size, sound.stream.channels)));
        },
        else => {
            const arg_data = core.ArgumentBinary(core.Binary, rl.allocator).get(env, argv[1]) catch {
                return error.invalid_argument_data;
            };
            defer arg_data.free();
            const data = arg_data.data;
            const data_size : c_uint = @intCast(arg_data.length);

            rl.UpdateSound(sound.*, @ptrCast(data), @intCast(@divTrunc(data_size, sound.stream.channels * sound.stream.sampleSize)));
        },
    }

    // Return

    return core.maybe_make_struct_or_resource(core.Sound, env, argv[0], sound.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Check if any audio stream buffers requires refill
///
/// raylib.h
/// RLAPI bool IsAudioStreamProcessed(AudioStream stream);
fn nif_is_sound_processed(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_sound = core.Argument(core.Sound).get(env, argv[0]) catch {
        return error.invalid_argument_sound;
    };
    defer arg_sound.free();
    const sound = arg_sound.data;

    // Function

    const is_sound_processed = rl.IsAudioStreamProcessed(sound.stream);

    // Return

    return core.Boolean.make(env, is_sound_processed);
}

/// Export wave data to file, returns true on success
///
/// raylib.h
/// RLAPI bool ExportWave(Wave wave, const char *fileName);
fn nif_export_wave(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2);

    // Arguments

    const arg_wave = core.Argument(core.Wave).get(env, argv[0]) catch {
        return error.invalid_argument_wave;
    };
    defer arg_wave.free();
    const wave = arg_wave.data;

    const arg_file_name = core.ArgumentBinaryCUnknown(core.CString, rl.allocator).get(env, argv[1]) catch {
        return error.invalid_argument_file_name;
    };
    defer arg_file_name.free();
    const file_name = arg_file_name.data;

    // Function

    const ok = rl.ExportWave(wave, file_name);

    // Return

    return core.Boolean.make(env, ok);
}

////////////////////////
//  Sound management  //
////////////////////////

/// Play a sound
///
/// raylib.h
/// RLAPI void PlaySound(Sound sound);
fn nif_play_sound(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    var arg_sound = core.Argument(core.Sound).get(env, argv[0]) catch {
        return error.invalid_argument_sound;
    };
    defer if (!return_resource) arg_sound.free();
    errdefer if (return_resource) arg_sound.free();
    const sound = &arg_sound.data;

    // Function

    rl.PlaySound(sound.*);

    // Return

    return core.maybe_make_struct_or_resource(core.Sound, env, argv[0], sound.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Stop playing a sound
///
/// raylib.h
/// RLAPI void StopSound(Sound sound);
fn nif_stop_sound(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    var arg_sound = core.Argument(core.Sound).get(env, argv[0]) catch {
        return error.invalid_argument_sound;
    };
    defer if (!return_resource) arg_sound.free();
    errdefer if (return_resource) arg_sound.free();
    const sound = &arg_sound.data;

    // Function

    rl.StopSound(sound.*);

    // Return

    return core.maybe_make_struct_or_resource(core.Sound, env, argv[0], sound.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Pause a sound
///
/// raylib.h
/// RLAPI void PauseSound(Sound sound);
fn nif_pause_sound(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    var arg_sound = core.Argument(core.Sound).get(env, argv[0]) catch {
        return error.invalid_argument_sound;
    };
    defer if (!return_resource) arg_sound.free();
    errdefer if (return_resource) arg_sound.free();
    const sound = &arg_sound.data;

    // Function

    rl.PauseSound(sound.*);

    // Return

    return core.maybe_make_struct_or_resource(core.Sound, env, argv[0], sound.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Resume a paused sound
///
/// raylib.h
/// RLAPI void ResumeSound(Sound sound);
fn nif_resume_sound(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    var arg_sound = core.Argument(core.Sound).get(env, argv[0]) catch {
        return error.invalid_argument_sound;
    };
    defer if (!return_resource) arg_sound.free();
    errdefer if (return_resource) arg_sound.free();
    const sound = &arg_sound.data;

    // Function

    rl.ResumeSound(sound.*);

    // Return

    return core.maybe_make_struct_or_resource(core.Sound, env, argv[0], sound.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Check if a sound is currently playing
///
/// raylib.h
/// RLAPI bool IsSoundPlaying(Sound sound);
fn nif_is_sound_playing(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_sound = core.Argument(core.Sound).get(env, argv[0]) catch {
        return error.invalid_argument_sound;
    };
    defer arg_sound.free();
    const sound = arg_sound.data;

    // Function

    const is_sound_playing = rl.IsSoundPlaying(sound);

    // Return

    return core.Boolean.make(env, is_sound_playing);
}

/// Set volume for a sound (1.0 is max level)
///
/// raylib.h
/// RLAPI void SetSoundVolume(Sound sound, float volume);
fn nif_set_sound_volume(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    var arg_sound = core.Argument(core.Sound).get(env, argv[0]) catch {
        return error.invalid_argument_sound;
    };
    defer if (!return_resource) arg_sound.free();
    errdefer if (return_resource) arg_sound.free();
    const sound = &arg_sound.data;

    const volume = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_volume;
    };

    // Function

    rl.SetSoundVolume(sound.*, @floatCast(volume));

    // Return

    return core.maybe_make_struct_or_resource(core.Sound, env, argv[0], sound.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Set pitch for a sound (1.0 is base level)
///
/// raylib.h
/// RLAPI void SetSoundPitch(Sound sound, float pitch);
fn nif_set_sound_pitch(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    var arg_sound = core.Argument(core.Sound).get(env, argv[0]) catch {
        return error.invalid_argument_sound;
    };
    defer if (!return_resource) arg_sound.free();
    errdefer if (return_resource) arg_sound.free();
    const sound = &arg_sound.data;

    const pitch = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_pitch;
    };

    // Function

    rl.SetSoundPitch(sound.*, @floatCast(pitch));

    // Return

    return core.maybe_make_struct_or_resource(core.Sound, env, argv[0], sound.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Set pan for a sound (0.5 is center)
///
/// raylib.h
/// RLAPI void SetSoundPan(Sound sound, float pan);
fn nif_set_sound_pan(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    var arg_sound = core.Argument(core.Sound).get(env, argv[0]) catch {
        return error.invalid_argument_sound;
    };
    defer if (!return_resource) arg_sound.free();
    errdefer if (return_resource) arg_sound.free();
    const sound = &arg_sound.data;

    const pan = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_pan;
    };

    // Function

    rl.SetSoundPan(sound.*, @floatCast(pan));

    // Return

    return core.maybe_make_struct_or_resource(core.Sound, env, argv[0], sound.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get sound time length (in seconds)
///
/// raylib.h
/// RLAPI float GetSoundTimeLength(Sound sound);
fn nif_get_sound_time_length(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_sound = core.Argument(core.Sound).get(env, argv[0]) catch {
        return error.invalid_argument_sound;
    };
    defer arg_sound.free();
    const sound = arg_sound.data;

    // Function

    const sound_time_length = rl.GetSoundTimeLength(sound);

    // Return

    return core.Double.make(env, @floatCast(sound_time_length));
}

/// Copy a wave to a new wave
///
/// raylib.h
/// RLAPI Wave WaveCopy(Wave wave);
fn nif_wave_copy(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    const arg_wave = core.Argument(core.Wave).get(env, argv[0]) catch {
        return error.invalid_argument_wave;
    };
    defer arg_wave.free();
    const wave = arg_wave.data;

    // Function

    const wave_copy = rl.WaveCopy(wave);
    defer if (!return_resource) core.Wave.unload(wave_copy);
    errdefer if (return_resource) core.Wave.unload(wave_copy);

    // Return

    return core.maybe_make_struct_as_resource(core.Wave, env, wave_copy, return_resource) catch {
        return error.invalid_return;
    };
}

/// Crop a wave to defined frames range
///
/// raylib.h
/// RLAPI void WaveCrop(Wave *wave, int initFrame, int finalFrame);
fn nif_wave_crop(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    var arg_wave = core.Argument(core.Wave).get(env, argv[0]) catch {
        return error.invalid_argument_wave;
    };
    defer if (!return_resource) arg_wave.free();
    errdefer if (return_resource) arg_wave.free();
    const wave = &arg_wave.data;

    const init_frame = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_init_frame;
    };

    const final_frame = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_final_frame;
    };

    // Function

    rl.WaveCrop(@ptrCast(wave), init_frame, final_frame);

    // Return

    return core.maybe_make_struct_or_resource(core.Wave, env, argv[0], wave.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Convert wave data to desired format
///
/// raylib.h
/// RLAPI void WaveFormat(Wave *wave, int sampleRate, int sampleSize, int channels);
fn nif_wave_format(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 4 or argc == 5);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 4);

    // Arguments

    var arg_wave = core.Argument(core.Wave).get(env, argv[0]) catch {
        return error.invalid_argument_wave;
    };
    defer if (!return_resource) arg_wave.free();
    errdefer if (return_resource) arg_wave.free();
    const wave = &arg_wave.data;

    const sample_rate = core.Int.get(env, argv[1]) catch {
        return error.invalid_argument_sample_rate;
    };

    const sample_size = core.Int.get(env, argv[2]) catch {
        return error.invalid_argument_sample_size;
    };

    const channels = core.Int.get(env, argv[3]) catch {
        return error.invalid_argument_channels;
    };

    // Function

    rl.WaveFormat(@ptrCast(wave), sample_rate, sample_size, channels);

    // Return

    return core.maybe_make_struct_or_resource(core.Wave, env, argv[0], wave.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Load samples data from wave as a 32bit float data array
///
/// raylib.h
/// RLAPI float *LoadWaveSamples(Wave wave);
fn nif_load_wave_samples(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_wave = core.Argument(core.Wave).get(env, argv[0]) catch {
        return error.invalid_argument_wave;
    };
    defer arg_wave.free();
    const wave = arg_wave.data;

    // Function

    const samples_c = rl.LoadWaveSamples(wave);
    defer rl.UnloadWaveSamples(samples_c);

    // Return

    const samples_lengths = [_]usize{@intCast(wave.frameCount * wave.channels)};

    return core.Array.make_c(core.Double, f32, env, samples_c, &samples_lengths);
}

/// Load samples data from wave
fn nif_load_wave_samples_raw(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_wave = core.Argument(core.Wave).get(env, argv[0]) catch {
        return error.invalid_argument_wave;
    };
    defer arg_wave.free();
    const wave = arg_wave.data;

    // Return

    const samples_lengths = [_]usize{@intCast(wave.frameCount * wave.channels)};

    return switch (wave.sampleSize) {
        8 => core.Array.make_c(core.UInt, u8, env, @ptrCast(@alignCast(wave.data)), &samples_lengths),
        16 => core.Array.make_c(core.Int, c_short, env, @ptrCast(@alignCast(wave.data)), &samples_lengths),
        32 => core.Array.make_c(core.Double, f32, env, @ptrCast(@alignCast(wave.data)), &samples_lengths),
        else => core.Binary.make_c(env, @ptrCast(@alignCast(wave.data)), @intCast(wave.frameCount * wave.channels * @divTrunc(wave.sampleSize, 8))),
    };
}

////////////////////////
//  Music management  //
////////////////////////

/// Load music stream from file
///
/// raylib.h
/// RLAPI Music LoadMusicStream(const char *fileName);
fn nif_load_music_stream(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
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

    const music = rl.LoadMusicStream(file_name);
    defer if (!return_resource) core.Music.unload(music);
    errdefer if (return_resource) core.Music.unload(music);

    // Return

    return core.maybe_make_struct_as_resource(core.Music, env, music, return_resource) catch {
        return error.invalid_return;
    };
}

/// Load music stream from data
///
/// raylib.h
/// RLAPI Music LoadMusicStreamFromMemory(const char *fileType, const unsigned char *data, int dataSize);
fn nif_load_music_stream_from_memory(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
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

    const music = rl.LoadMusicStreamFromMemory(file_type, @ptrCast(file_data), @intCast(data_size));
    defer if (!return_resource) core.Music.unload(music);
    errdefer if (return_resource) core.Music.unload(music);

    // Return

    return core.maybe_make_struct_as_resource(core.Music, env, music, return_resource) catch {
        return error.invalid_return;
    };
}

/// Checks if a music stream is valid (context and buffers initialized)
///
/// raylib.h
/// RLAPI bool IsMusicValid(Music music);
fn nif_is_music_valid(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_music = core.Argument(core.Music).get(env, argv[0]) catch {
        return error.invalid_argument_music;
    };
    defer arg_music.free();
    const music = arg_music.data;

    // Function

    const is_music_valid = rl.IsMusicValid(music);

    // Return

    return core.Boolean.make(env, is_music_valid);
}

/// Start music playing
///
/// raylib.h
/// RLAPI void PlayMusicStream(Music music);
fn nif_play_music_stream(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    var arg_music = core.Argument(core.Music).get(env, argv[0]) catch {
        return error.invalid_argument_music;
    };
    defer if (!return_resource) arg_music.free();
    errdefer if (return_resource) arg_music.free();
    const music = &arg_music.data;

    // Function

    rl.PlayMusicStream(music.*);

    // Return

    return core.maybe_make_struct_or_resource(core.Music, env, argv[0], music.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Check if music is playing
///
/// raylib.h
/// RLAPI bool IsMusicStreamPlaying(Music music);
fn nif_is_music_stream_playing(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_music = core.Argument(core.Music).get(env, argv[0]) catch {
        return error.invalid_argument_music;
    };
    defer arg_music.free();
    const music = arg_music.data;

    // Function

    const is_music_stream_playing = rl.IsMusicStreamPlaying(music);

    // Return

    return core.Boolean.make(env, is_music_stream_playing);
}

/// Updates buffers for music streaming
///
/// raylib.h
/// RLAPI void UpdateMusicStream(Music music);
fn nif_update_music_stream(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    var arg_music = core.Argument(core.Music).get(env, argv[0]) catch {
        return error.invalid_argument_music;
    };
    defer if (!return_resource) arg_music.free();
    errdefer if (return_resource) arg_music.free();
    const music = &arg_music.data;

    // Function

    rl.UpdateMusicStream(music.*);

    // Return

    return core.maybe_make_struct_or_resource(core.Music, env, argv[0], music.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Check if any audio stream buffers requires refill
///
/// raylib.h
/// RLAPI bool IsAudioStreamProcessed(AudioStream stream);
fn nif_is_music_stream_processed(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_music = core.Argument(core.Music).get(env, argv[0]) catch {
        return error.invalid_argument_music;
    };
    defer arg_music.free();
    const music = arg_music.data;

    // Function

    const is_music_processed = rl.IsAudioStreamProcessed(music.stream);

    // Return

    return core.Boolean.make(env, is_music_processed);
}

/// Stop music playing
///
/// raylib.h
/// RLAPI void StopMusicStream(Music music);
fn nif_stop_music_stream(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    var arg_music = core.Argument(core.Music).get(env, argv[0]) catch {
        return error.invalid_argument_music;
    };
    defer if (!return_resource) arg_music.free();
    errdefer if (return_resource) arg_music.free();
    const music = &arg_music.data;

    // Function

    rl.StopMusicStream(music.*);

    // Return

    return core.maybe_make_struct_or_resource(core.Music, env, argv[0], music.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Pause music playing
///
/// raylib.h
/// RLAPI void PauseMusicStream(Music music);
fn nif_pause_music_stream(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    var arg_music = core.Argument(core.Music).get(env, argv[0]) catch {
        return error.invalid_argument_music;
    };
    defer if (!return_resource) arg_music.free();
    errdefer if (return_resource) arg_music.free();
    const music = &arg_music.data;

    // Function

    rl.PauseMusicStream(music.*);

    // Return

    return core.maybe_make_struct_or_resource(core.Music, env, argv[0], music.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Resume playing paused music
///
/// raylib.h
/// RLAPI void ResumeMusicStream(Music music);
fn nif_resume_music_stream(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    var arg_music = core.Argument(core.Music).get(env, argv[0]) catch {
        return error.invalid_argument_music;
    };
    defer if (!return_resource) arg_music.free();
    errdefer if (return_resource) arg_music.free();
    const music = &arg_music.data;

    // Function

    rl.ResumeMusicStream(music.*);

    // Return

    return core.maybe_make_struct_or_resource(core.Music, env, argv[0], music.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Seek music to a position (in seconds)
///
/// raylib.h
/// RLAPI void SeekMusicStream(Music music, float position);
fn nif_seek_music_stream(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    var arg_music = core.Argument(core.Music).get(env, argv[0]) catch {
        return error.invalid_argument_music;
    };
    defer if (!return_resource) arg_music.free();
    errdefer if (return_resource) arg_music.free();
    const music = &arg_music.data;

    const position = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_position;
    };

    // Function

    rl.SeekMusicStream(music.*, @floatCast(position));

    // Return

    return core.maybe_make_struct_or_resource(core.Music, env, argv[0], music.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Set volume for music (1.0 is max level)
///
/// raylib.h
/// RLAPI void SetMusicVolume(Music music, float volume);
fn nif_set_music_volume(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    var arg_music = core.Argument(core.Music).get(env, argv[0]) catch {
        return error.invalid_argument_music;
    };
    defer if (!return_resource) arg_music.free();
    errdefer if (return_resource) arg_music.free();
    const music = &arg_music.data;

    const volume = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_volume;
    };

    // Function

    rl.SetMusicVolume(music.*, @floatCast(volume));

    // Return

    return core.maybe_make_struct_or_resource(core.Music, env, argv[0], music.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Set pitch for a music (1.0 is base level)
///
/// raylib.h
/// RLAPI void SetMusicPitch(Music music, float pitch);
fn nif_set_music_pitch(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    var arg_music = core.Argument(core.Music).get(env, argv[0]) catch {
        return error.invalid_argument_music;
    };
    defer if (!return_resource) arg_music.free();
    errdefer if (return_resource) arg_music.free();
    const music = &arg_music.data;

    const pitch = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_pitch;
    };

    // Function

    rl.SetMusicPitch(music.*, @floatCast(pitch));

    // Return

    return core.maybe_make_struct_or_resource(core.Music, env, argv[0], music.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Set pan for a music (0.5 is center)
///
/// raylib.h
/// RLAPI void SetMusicPan(Music music, float pan);
fn nif_set_music_pan(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    var arg_music = core.Argument(core.Music).get(env, argv[0]) catch {
        return error.invalid_argument_music;
    };
    defer if (!return_resource) arg_music.free();
    errdefer if (return_resource) arg_music.free();
    const music = &arg_music.data;

    const pan = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_pan;
    };

    // Function

    rl.SetMusicPan(music.*, @floatCast(pan));

    // Return

    return core.maybe_make_struct_or_resource(core.Music, env, argv[0], music.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Set looping for a music
fn nif_set_music_looping(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    var arg_music = core.Argument(core.Music).get(env, argv[0]) catch {
        return error.invalid_argument_music;
    };
    defer if (!return_resource) arg_music.free();
    errdefer if (return_resource) arg_music.free();
    const music = &arg_music.data;

    const looping = core.Boolean.get(env, argv[1]) catch {
        return error.invalid_argument_looping;
    };

    // Function

    music.looping = looping;

    // Return

    return core.maybe_make_struct_or_resource(core.Music, env, argv[0], music.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Get music time length (in seconds)
///
/// raylib.h
/// RLAPI float GetMusicTimeLength(Music music);
fn nif_get_music_time_length(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_music = core.Argument(core.Music).get(env, argv[0]) catch {
        return error.invalid_argument_music;
    };
    defer arg_music.free();
    const music = arg_music.data;

    // Function

    const music_time_length = rl.GetMusicTimeLength(music);

    // Return

    return core.Double.make(env, @floatCast(music_time_length));
}

/// Get current music time played (in seconds)
///
/// raylib.h
/// RLAPI float GetMusicTimePlayed(Music music);
fn nif_get_music_time_played(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_music = core.Argument(core.Music).get(env, argv[0]) catch {
        return error.invalid_argument_music;
    };
    defer arg_music.free();
    const music = arg_music.data;

    // Function

    const music_time_played = rl.GetMusicTimePlayed(music);

    // Return

    return core.Double.make(env, @floatCast(music_time_played));
}

//////////////////////////////
//  AudioStream management  //
//////////////////////////////

/// Load audio stream (to stream raw audio pcm data)
///
/// raylib.h
/// RLAPI AudioStream LoadAudioStream(unsigned int sampleRate, unsigned int sampleSize, unsigned int channels);
fn nif_load_audio_stream(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 3 or argc == 4);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 3);

    // Arguments

    const sample_rate = core.UInt.get(env, argv[0]) catch {
        return error.invalid_argument_sample_rate;
    };

    const sample_size = core.UInt.get(env, argv[1]) catch {
        return error.invalid_argument_sample_size;
    };

    const channels = core.UInt.get(env, argv[2]) catch {
        return error.invalid_argument_channels;
    };

    // Function

    const audio_stream = rl.LoadAudioStream(sample_rate, sample_size, channels);
    defer if (!return_resource) core.AudioStream.unload(audio_stream);
    errdefer if (return_resource) core.AudioStream.unload(audio_stream);

    // Return

    return core.maybe_make_struct_as_resource(core.AudioStream, env, audio_stream, return_resource) catch {
        return error.invalid_return;
    };
}

/// Checks if an audio stream is valid (buffers initialized)
///
/// raylib.h
/// RLAPI bool IsAudioStreamValid(AudioStream stream);
fn nif_is_audio_stream_valid(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_stream = core.Argument(core.AudioStream).get(env, argv[0]) catch {
        return error.invalid_argument_stream;
    };
    defer arg_stream.free();
    const stream = arg_stream.data;

    // Function

    const is_audio_stream_valid = rl.IsAudioStreamValid(stream);

    // Return

    return core.Boolean.make(env, is_audio_stream_valid);
}

/// Update audio stream buffers with data
///
/// raylib.h
/// RLAPI void UpdateAudioStream(AudioStream stream, const void *data, int frameCount);
fn nif_update_audio_stream(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    var arg_stream = core.Argument(core.AudioStream).get(env, argv[0]) catch {
        return error.invalid_argument_stream;
    };
    defer if (!return_resource) arg_stream.free();
    errdefer if (return_resource) arg_stream.free();
    const stream = &arg_stream.data;

    // Function

    switch (stream.sampleSize) {
        8 => {
            var arg_data = core.ArgumentArray(core.UInt, u8, rl.allocator).get(env, argv[1]) catch {
                return error.invalid_argument_data;
            };
            defer arg_data.free();
            const data = arg_data.data;
            const data_size : c_uint = @intCast(arg_data.length);

            rl.UpdateAudioStream(stream.*, @ptrCast(data), @intCast(@divTrunc(data_size, stream.channels)));
        },
        16 => {
            var arg_data = core.ArgumentArray(core.Int, c_short, rl.allocator).get(env, argv[1]) catch {
                return error.invalid_argument_data;
            };
            defer arg_data.free();
            const data = arg_data.data;
            const data_size : c_uint = @intCast(arg_data.length);

            rl.UpdateAudioStream(stream.*, @ptrCast(data), @intCast(@divTrunc(data_size, stream.channels)));
        },
        32 => {
            var arg_data = core.ArgumentArray(core.Double, f32, rl.allocator).get(env, argv[1]) catch {
                return error.invalid_argument_data;
            };
            defer arg_data.free();
            const data = arg_data.data;
            const data_size : c_uint = @intCast(arg_data.length);

            rl.UpdateAudioStream(stream.*, @ptrCast(data), @intCast(@divTrunc(data_size, stream.channels)));
        },
        else => {
            const arg_data = core.ArgumentBinary(core.Binary, rl.allocator).get(env, argv[1]) catch {
                return error.invalid_argument_data;
            };
            defer arg_data.free();
            const data = arg_data.data;
            const data_size : c_uint = @intCast(arg_data.length);

            rl.UpdateAudioStream(stream.*, @ptrCast(data), @intCast(@divTrunc(data_size, stream.channels * stream.sampleSize)));
        },
    }

    // Return

    return core.maybe_make_struct_or_resource(core.AudioStream, env, argv[0], stream.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Check if any audio stream buffers requires refill
///
/// raylib.h
/// RLAPI bool IsAudioStreamProcessed(AudioStream stream);
fn nif_is_audio_stream_processed(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_stream = core.Argument(core.AudioStream).get(env, argv[0]) catch {
        return error.invalid_argument_stream;
    };
    defer arg_stream.free();
    const stream = arg_stream.data;

    // Function

    const is_audio_stream_processed = rl.IsAudioStreamProcessed(stream);

    // Return

    return core.Boolean.make(env, is_audio_stream_processed);
}

/// Play audio stream
///
/// raylib.h
/// RLAPI void PlayAudioStream(AudioStream stream);
fn nif_play_audio_stream(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    var arg_stream = core.Argument(core.AudioStream).get(env, argv[0]) catch {
        return error.invalid_argument_stream;
    };
    defer if (!return_resource) arg_stream.free();
    errdefer if (return_resource) arg_stream.free();
    const stream = &arg_stream.data;

    // Function

    rl.PlayAudioStream(stream.*);

    // Return

    return core.maybe_make_struct_or_resource(core.AudioStream, env, argv[0], stream.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Pause audio stream
///
/// raylib.h
/// RLAPI void PauseAudioStream(AudioStream stream);
fn nif_pause_audio_stream(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    var arg_stream = core.Argument(core.AudioStream).get(env, argv[0]) catch {
        return error.invalid_argument_stream;
    };
    defer if (!return_resource) arg_stream.free();
    errdefer if (return_resource) arg_stream.free();
    const stream = &arg_stream.data;

    // Function

    rl.PauseAudioStream(stream.*);

    // Return

    return core.maybe_make_struct_or_resource(core.AudioStream, env, argv[0], stream.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Resume audio stream
///
/// raylib.h
/// RLAPI void ResumeAudioStream(AudioStream stream);
fn nif_resume_audio_stream(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    var arg_stream = core.Argument(core.AudioStream).get(env, argv[0]) catch {
        return error.invalid_argument_stream;
    };
    defer if (!return_resource) arg_stream.free();
    errdefer if (return_resource) arg_stream.free();
    const stream = &arg_stream.data;

    // Function

    rl.ResumeAudioStream(stream.*);

    // Return

    return core.maybe_make_struct_or_resource(core.AudioStream, env, argv[0], stream.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Check if audio stream is playing
///
/// raylib.h
/// RLAPI bool IsAudioStreamPlaying(AudioStream stream);
fn nif_is_audio_stream_playing(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const arg_stream = core.Argument(core.AudioStream).get(env, argv[0]) catch {
        return error.invalid_argument_stream;
    };
    defer arg_stream.free();
    const stream = arg_stream.data;

    // Function

    const is_audio_stream_playing = rl.IsAudioStreamPlaying(stream);

    // Return

    return core.Boolean.make(env, is_audio_stream_playing);
}

/// Stop audio stream
///
/// raylib.h
/// RLAPI void StopAudioStream(AudioStream stream);
fn nif_stop_audio_stream(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1 or argc == 2);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 1);

    // Arguments

    var arg_stream = core.Argument(core.AudioStream).get(env, argv[0]) catch {
        return error.invalid_argument_stream;
    };
    defer if (!return_resource) arg_stream.free();
    errdefer if (return_resource) arg_stream.free();
    const stream = &arg_stream.data;

    // Function

    rl.StopAudioStream(stream.*);

    // Return

    return core.maybe_make_struct_or_resource(core.AudioStream, env, argv[0], stream.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Set volume for audio stream (1.0 is max level)
///
/// raylib.h
/// RLAPI void SetAudioStreamVolume(AudioStream stream, float volume);
fn nif_set_audio_stream_volume(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    var arg_stream = core.Argument(core.AudioStream).get(env, argv[0]) catch {
        return error.invalid_argument_stream;
    };
    defer if (!return_resource) arg_stream.free();
    errdefer if (return_resource) arg_stream.free();
    const stream = &arg_stream.data;

    const volume = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_volume;
    };

    // Function

    rl.SetAudioStreamVolume(stream.*, @floatCast(volume));

    // Return

    return core.maybe_make_struct_or_resource(core.AudioStream, env, argv[0], stream.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Set pitch for audio stream (1.0 is base level)
///
/// raylib.h
/// RLAPI void SetAudioStreamPitch(AudioStream stream, float pitch);
fn nif_set_audio_stream_pitch(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    var arg_stream = core.Argument(core.AudioStream).get(env, argv[0]) catch {
        return error.invalid_argument_stream;
    };
    defer if (!return_resource) arg_stream.free();
    errdefer if (return_resource) arg_stream.free();
    const stream = &arg_stream.data;

    const pitch = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_pitch;
    };

    // Function

    rl.SetAudioStreamPitch(stream.*, @floatCast(pitch));

    // Return

    return core.maybe_make_struct_or_resource(core.AudioStream, env, argv[0], stream.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Set pan for audio stream (0.5 is centered)
///
/// raylib.h
/// RLAPI void SetAudioStreamPan(AudioStream stream, float pan);
fn nif_set_audio_stream_pan(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 2 or argc == 3);

    // Return type

    const return_resource = core.must_return_resource(env, argc, argv, 2);

    // Arguments

    var arg_stream = core.Argument(core.AudioStream).get(env, argv[0]) catch {
        return error.invalid_argument_stream;
    };
    defer if (!return_resource) arg_stream.free();
    errdefer if (return_resource) arg_stream.free();
    const stream = &arg_stream.data;

    const pan = core.Double.get(env, argv[1]) catch {
        return error.invalid_argument_pan;
    };

    // Function

    rl.SetAudioStreamPan(stream.*, @floatCast(pan));

    // Return

    return core.maybe_make_struct_or_resource(core.AudioStream, env, argv[0], stream.*, return_resource) catch {
        return error.invalid_return;
    };
}

/// Default size for new audio streams
///
/// raylib.h
/// RLAPI void SetAudioStreamBufferSizeDefault(int size);
fn nif_set_audio_stream_buffer_size_default(env: ?*e.ErlNifEnv, argc: c_int, argv: [*c]const e.ErlNifTerm) !e.ErlNifTerm {
    assert(argc == 1);

    // Arguments

    const size = core.Int.get(env, argv[0]) catch {
        return error.invalid_argument_size;
    };

    // Function

    rl.SetAudioStreamBufferSizeDefault(size);

    // Return

    return core.Atom.make(env, "ok");
}
