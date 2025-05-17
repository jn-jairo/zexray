defmodule Zexray.NIF.Audio do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_audio [
        # Wave
        get_wave_data_size: 3,

        # Audio device management
        init_audio_device: 0,
        close_audio_device: 0,
        is_audio_device_ready: 0,
        set_master_volume: 1,
        get_master_volume: 0,

        # Sound loading
        load_wave: 1,
        load_wave: 2,
        load_wave_from_memory: 2,
        load_wave_from_memory: 3,
        is_wave_valid: 1,
        load_sound: 1,
        load_sound: 2,
        load_sound_from_wave: 1,
        load_sound_from_wave: 2,
        load_sound_alias: 1,
        load_sound_alias: 2,
        is_sound_valid: 1,
        update_sound: 2,
        update_sound: 3,
        is_sound_processed: 1,
        export_wave: 2,

        # Sound management
        play_sound: 1,
        play_sound: 2,
        stop_sound: 1,
        stop_sound: 2,
        pause_sound: 1,
        pause_sound: 2,
        resume_sound: 1,
        resume_sound: 2,
        is_sound_playing: 1,
        set_sound_volume: 2,
        set_sound_volume: 3,
        set_sound_pitch: 2,
        set_sound_pitch: 3,
        set_sound_pan: 2,
        set_sound_pan: 3,
        get_sound_time_length: 1,
        wave_copy: 1,
        wave_copy: 2,
        wave_crop: 3,
        wave_crop: 4,
        wave_format: 4,
        wave_format: 5,
        load_wave_samples: 1,
        load_wave_samples_raw: 1,

        # Music management
        load_music_stream: 1,
        load_music_stream: 2,
        load_music_stream_from_memory: 2,
        load_music_stream_from_memory: 3,
        is_music_valid: 1,
        play_music_stream: 1,
        play_music_stream: 2,
        is_music_stream_playing: 1,
        update_music_stream: 1,
        update_music_stream: 2,
        is_music_stream_processed: 1,
        stop_music_stream: 1,
        stop_music_stream: 2,
        pause_music_stream: 1,
        pause_music_stream: 2,
        resume_music_stream: 1,
        resume_music_stream: 2,
        seek_music_stream: 2,
        seek_music_stream: 3,
        set_music_volume: 2,
        set_music_volume: 3,
        set_music_pitch: 2,
        set_music_pitch: 3,
        set_music_pan: 2,
        set_music_pan: 3,
        set_music_looping: 2,
        set_music_looping: 3,
        get_music_time_length: 1,
        get_music_time_played: 1,

        # AudioStream management
        load_audio_stream: 3,
        load_audio_stream: 4,
        is_audio_stream_valid: 1,
        update_audio_stream: 2,
        update_audio_stream: 3,
        is_audio_stream_processed: 1,
        play_audio_stream: 1,
        play_audio_stream: 2,
        pause_audio_stream: 1,
        pause_audio_stream: 2,
        resume_audio_stream: 1,
        resume_audio_stream: 2,
        is_audio_stream_playing: 1,
        stop_audio_stream: 1,
        stop_audio_stream: 2,
        set_audio_stream_volume: 2,
        set_audio_stream_volume: 3,
        set_audio_stream_pitch: 2,
        set_audio_stream_pitch: 3,
        set_audio_stream_pan: 2,
        set_audio_stream_pan: 3,
        set_audio_stream_buffer_size_default: 1
      ]

      ##########
      #  Wave  #
      ##########

      @doc """
      Get wave data size in bytes

      ```zig
      pub fn get_data_size(frame_count: c_uint, channels: c_uint, sample_size: c_uint) usize
      ```
      """
      @doc group: :wave
      @spec get_wave_data_size(
              frame_count :: non_neg_integer,
              channels :: non_neg_integer,
              sample_size :: non_neg_integer
            ) :: non_neg_integer
      def get_wave_data_size(
            _frame_count,
            _channels,
            _sample_size
          ),
          do: :erlang.nif_error(:undef)

      #############################
      #  Audio device management  #
      #############################

      @doc """
      Initialize audio device and context

      ```c
      // raylib.h
      RLAPI void InitAudioDevice(void);
      ```
      """
      @doc group: :audio_device_management
      @spec init_audio_device() :: :ok
      def init_audio_device(), do: :erlang.nif_error(:undef)

      @doc """
      Close the audio device and context

      ```c
      // raylib.h
      RLAPI void CloseAudioDevice(void);
      ```
      """
      @doc group: :audio_device_management
      @spec close_audio_device() :: :ok
      def close_audio_device(), do: :erlang.nif_error(:undef)

      @doc """
      Check if audio device has been initialized successfully

      ```c
      // raylib.h
      RLAPI bool IsAudioDeviceReady(void);
      ```
      """
      @doc group: :audio_device_management
      @spec is_audio_device_ready() :: boolean
      def is_audio_device_ready(), do: :erlang.nif_error(:undef)

      @doc """
      Set master volume (listener)

      ```c
      // raylib.h
      RLAPI void SetMasterVolume(float volume);
      ```
      """
      @doc group: :audio_device_management
      @spec set_master_volume(volume :: float) :: :ok
      def set_master_volume(_volume), do: :erlang.nif_error(:undef)

      @doc """
      Get master volume (listener)

      ```c
      // raylib.h
      RLAPI float GetMasterVolume(void);
      ```
      """
      @doc group: :audio_device_management
      @spec get_master_volume() :: float
      def get_master_volume(), do: :erlang.nif_error(:undef)

      ###################
      #  Sound loading  #
      ###################

      @doc """
      Load wave data from file

      ```c
      // raylib.h
      RLAPI Wave LoadWave(const char *fileName);
      ```
      """
      @doc group: :sound_loading
      @spec load_wave(
              file_name :: binary,
              return :: :value | :resource
            ) :: map | reference
      def load_wave(
            _file_name,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load wave from memory buffer, fileType refers to extension: i.e. '.wav'

      ```c
      // raylib.h
      RLAPI Wave LoadWaveFromMemory(const char *fileType, const unsigned char *fileData, int dataSize);
      ```
      """
      @doc group: :sound_loading
      @spec load_wave_from_memory(
              file_type :: binary,
              file_data :: binary,
              return :: :value | :resource
            ) :: {image :: map | reference, frames :: integer}
      def load_wave_from_memory(
            _file_type,
            _file_data,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Checks if wave data is valid (data loaded and parameters)

      ```c
      // raylib.h
      RLAPI bool IsWaveValid(Wave wave);
      ```
      """
      @doc group: :sound_loading
      @spec is_wave_valid(wave :: map | reference) :: boolean
      def is_wave_valid(_wave), do: :erlang.nif_error(:undef)

      @doc """
      Load sound from file

      ```c
      // raylib.h
      RLAPI Sound LoadSound(const char *fileName);
      ```
      """
      @doc group: :sound_loading
      @spec load_sound(
              file_name :: binary,
              return :: :value | :resource
            ) :: map | reference
      def load_sound(
            _file_name,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load sound from wave data

      ```c
      // raylib.h
      RLAPI Sound LoadSoundFromWave(Wave wave);
      ```
      """
      @doc group: :sound_loading
      @spec load_sound_from_wave(
              wave :: map | reference,
              return :: :value | :resource
            ) :: map | reference
      def load_sound_from_wave(
            _wave,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Create a new sound that shares the same sample data as the source sound, does not own the sound data

      ```c
      // raylib.h
      RLAPI Sound LoadSoundAlias(Sound source);
      ```
      """
      @doc group: :sound_loading
      @spec load_sound_alias(
              source :: map | reference,
              return :: :value | :resource
            ) :: map | reference
      def load_sound_alias(
            _source,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Checks if a sound is valid (data loaded and buffers initialized)

      ```c
      // raylib.h
      RLAPI bool IsSoundValid(Sound sound);
      ```
      """
      @doc group: :sound_loading
      @spec is_sound_valid(sound :: map | reference) :: boolean
      def is_sound_valid(_sound), do: :erlang.nif_error(:undef)

      @doc """
      Update sound buffer with new data

      ```c
      // raylib.h
      RLAPI void UpdateSound(Sound sound, const void *data, int sampleCount);
      ```
      """
      @doc group: :sound_loading
      @spec update_sound(
              sound :: map | reference,
              data :: binary | [byte] | [integer] | [float],
              return :: :value | :resource
            ) :: map | reference
      def update_sound(
            _sound,
            _data,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check if any audio stream buffers requires refill

      ```c
      // raylib.h
      RLAPI bool IsAudioStreamProcessed(AudioStream stream);
      ```
      """
      @doc group: :music_management
      @spec is_sound_processed(sound :: map | reference) :: boolean
      def is_sound_processed(_sound), do: :erlang.nif_error(:undef)

      @doc """
      Export wave data to file, returns true on success

      ```c
      // raylib.h
      RLAPI bool ExportWave(Wave wave, const char *fileName);
      ```
      """
      @doc group: :sound_loading
      @spec export_wave(
              wave :: map | reference,
              file_name :: binary
            ) :: boolean
      def export_wave(
            _wave,
            _file_name
          ),
          do: :erlang.nif_error(:undef)

      ######################
      #  Sound management  #
      ######################

      @doc """
      Play a sound

      ```c
      // raylib.h
      RLAPI void PlaySound(Sound sound);
      ```
      """
      @doc group: :sound_management
      @spec play_sound(
              sound :: map | reference,
              return :: :value | :resource
            ) :: map | reference
      def play_sound(
            _sound,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Stop playing a sound

      ```c
      // raylib.h
      RLAPI void StopSound(Sound sound);
      ```
      """
      @doc group: :sound_management
      @spec stop_sound(
              sound :: map | reference,
              return :: :value | :resource
            ) :: map | reference
      def stop_sound(
            _sound,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Pause a sound

      ```c
      // raylib.h
      RLAPI void PauseSound(Sound sound);
      ```
      """
      @doc group: :sound_management
      @spec pause_sound(
              sound :: map | reference,
              return :: :value | :resource
            ) :: map | reference
      def pause_sound(
            _sound,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Resume a paused sound

      ```c
      // raylib.h
      RLAPI void ResumeSound(Sound sound);
      ```
      """
      @doc group: :sound_management
      @spec resume_sound(
              sound :: map | reference,
              return :: :value | :resource
            ) :: map | reference
      def resume_sound(
            _sound,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check if a sound is currently playing

      ```c
      // raylib.h
      RLAPI bool IsSoundPlaying(Sound sound);
      ```
      """
      @doc group: :sound_management
      @spec is_sound_playing(sound :: map | reference) :: boolean
      def is_sound_playing(_sound), do: :erlang.nif_error(:undef)

      @doc """
      Set volume for a sound (1.0 is max level)

      ```c
      // raylib.h
      RLAPI void SetSoundVolume(Sound sound, float volume);
      ```
      """
      @doc group: :sound_management
      @spec set_sound_volume(
              sound :: map | reference,
              volume :: float,
              return :: :value | :resource
            ) :: map | reference
      def set_sound_volume(
            _sound,
            _volume,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set pitch for a sound (1.0 is base level)

      ```c
      // raylib.h
      RLAPI void SetSoundPitch(Sound sound, float pitch);
      ```
      """
      @doc group: :sound_management
      @spec set_sound_pitch(
              sound :: map | reference,
              pitch :: float,
              return :: :value | :resource
            ) :: map | reference
      def set_sound_pitch(
            _sound,
            _pitch,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set pan for a sound (0.5 is center)

      ```c
      // raylib.h
      RLAPI void SetSoundPan(Sound sound, float pan);
      ```
      """
      @doc group: :sound_management
      @spec set_sound_pan(
              sound :: map | reference,
              pan :: float,
              return :: :value | :resource
            ) :: map | reference
      def set_sound_pan(
            _sound,
            _pan,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get sound time length (in seconds)

      ```c
      // raylib.h
      RLAPI float GetSoundTimeLength(Sound sound);
      ```
      """
      @doc group: :sound_management
      @spec get_sound_time_length(sound :: map | reference) :: float
      def get_sound_time_length(_sound), do: :erlang.nif_error(:undef)

      @doc """
      Copy a wave to a new wave

      ```c
      // raylib.h
      RLAPI Wave WaveCopy(Wave wave);
      ```
      """
      @doc group: :sound_management
      @spec wave_copy(
              wave :: map | reference,
              return :: :value | :resource
            ) :: map | reference
      def wave_copy(
            _wave,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Crop a wave to defined frames range

      ```c
      // raylib.h
      RLAPI void WaveCrop(Wave *wave, int initFrame, int finalFrame);
      ```
      """
      @doc group: :sound_management
      @spec wave_crop(
              wave :: map | reference,
              init_frame :: integer,
              final_frame :: integer,
              return :: :value | :resource
            ) :: map | reference
      def wave_crop(
            _wave,
            _init_frame,
            _final_frame,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Convert wave data to desired format

      ```c
      // raylib.h
      RLAPI void WaveFormat(Wave *wave, int sampleRate, int sampleSize, int channels);
      ```
      """
      @doc group: :sound_management
      @spec wave_format(
              wave :: map | reference,
              sample_rate :: integer,
              sample_size :: integer,
              channels :: integer,
              return :: :value | :resource
            ) :: map | reference
      def wave_format(
            _wave,
            _sample_rate,
            _sample_size,
            _channels,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load samples data from wave as a 32bit float data array

      ```c
      // raylib.h
      RLAPI float *LoadWaveSamples(Wave wave);
      ```
      """
      @doc group: :sound_management
      @spec load_wave_samples(wave :: map | reference) :: [float]
      def load_wave_samples(_wave), do: :erlang.nif_error(:undef)

      @doc """
      Load samples data from wave
      """
      @doc group: :sound_management
      @spec load_wave_samples_raw(wave :: map | reference) ::
              binary | [byte] | [integer] | [float]
      def load_wave_samples_raw(_wave), do: :erlang.nif_error(:undef)

      ######################
      #  Music management  #
      ######################

      @doc """
      Load music stream from file

      ```c
      // raylib.h
      RLAPI Music LoadMusicStream(const char *fileName);
      ```
      """
      @doc group: :music_management
      @spec load_music_stream(
              file_name :: binary,
              return :: :value | :resource
            ) :: map | reference
      def load_music_stream(
            _file_name,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load music stream from data

      ```c
      // raylib.h
      RLAPI Music LoadMusicStreamFromMemory(const char *fileType, const unsigned char *data, int dataSize);
      ```
      """
      @doc group: :music_management
      @spec load_music_stream_from_memory(
              file_type :: binary,
              file_data :: binary,
              return :: :value | :resource
            ) :: {image :: map | reference, frames :: integer}
      def load_music_stream_from_memory(
            _file_type,
            _file_data,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Checks if a music stream is valid (context and buffers initialized)

      ```c
      // raylib.h
      RLAPI bool IsMusicValid(Music music);
      ```
      """
      @doc group: :music_management
      @spec is_music_valid(music :: map | reference) :: boolean
      def is_music_valid(_music), do: :erlang.nif_error(:undef)

      @doc """
      Start music playing

      ```c
      // raylib.h
      RLAPI void PlayMusicStream(Music music);
      ```
      """
      @doc group: :music_management
      @spec play_music_stream(
              music :: map | reference,
              return :: :value | :resource
            ) :: map | reference
      def play_music_stream(
            _music,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check if music is playing

      ```c
      // raylib.h
      RLAPI bool IsMusicStreamPlaying(Music music);
      ```
      """
      @doc group: :music_management
      @spec is_music_stream_playing(music :: map | reference) :: boolean
      def is_music_stream_playing(_music), do: :erlang.nif_error(:undef)

      @doc """
      Updates buffers for music streaming

      ```c
      // raylib.h
      RLAPI void UpdateMusicStream(Music music);
      ```
      """
      @doc group: :music_management
      @spec update_music_stream(
              music :: map | reference,
              return :: :value | :resource
            ) :: map | reference
      def update_music_stream(
            _music,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check if any audio stream buffers requires refill

      ```c
      // raylib.h
      RLAPI bool IsAudioStreamProcessed(AudioStream stream);
      ```
      """
      @doc group: :music_management
      @spec is_music_stream_processed(music :: map | reference) :: boolean
      def is_music_stream_processed(_music), do: :erlang.nif_error(:undef)

      @doc """
      Stop music playing

      ```c
      // raylib.h
      RLAPI void StopMusicStream(Music music);
      ```
      """
      @doc group: :music_management
      @spec stop_music_stream(
              music :: map | reference,
              return :: :value | :resource
            ) :: map | reference
      def stop_music_stream(
            _music,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Pause music playing

      ```c
      // raylib.h
      RLAPI void PauseMusicStream(Music music);
      ```
      """
      @doc group: :music_management
      @spec pause_music_stream(
              music :: map | reference,
              return :: :value | :resource
            ) :: map | reference
      def pause_music_stream(
            _music,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Resume playing paused music

      ```c
      // raylib.h
      RLAPI void ResumeMusicStream(Music music);
      ```
      """
      @doc group: :music_management
      @spec resume_music_stream(
              music :: map | reference,
              return :: :value | :resource
            ) :: map | reference
      def resume_music_stream(
            _music,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Seek music to a position (in seconds)

      ```c
      // raylib.h
      RLAPI void SeekMusicStream(Music music, float position);
      ```
      """
      @doc group: :music_management
      @spec seek_music_stream(
              music :: map | reference,
              position :: float,
              return :: :value | :resource
            ) :: map | reference
      def seek_music_stream(
            _music,
            _position,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set volume for music (1.0 is max level)

      ```c
      // raylib.h
      RLAPI void SetMusicVolume(Music music, float volume);
      ```
      """
      @doc group: :music_management
      @spec set_music_volume(
              music :: map | reference,
              volume :: float,
              return :: :value | :resource
            ) :: map | reference
      def set_music_volume(
            _music,
            _volume,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set pitch for a music (1.0 is base level)

      ```c
      // raylib.h
      RLAPI void SetMusicPitch(Music music, float pitch);
      ```
      """
      @doc group: :music_management
      @spec set_music_pitch(
              music :: map | reference,
              pitch :: float,
              return :: :value | :resource
            ) :: map | reference
      def set_music_pitch(
            _music,
            _pitch,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set pan for a music (0.5 is center)

      ```c
      // raylib.h
      RLAPI void SetMusicPan(Music music, float pan);
      ```
      """
      @doc group: :music_management
      @spec set_music_pan(
              music :: map | reference,
              pan :: float,
              return :: :value | :resource
            ) :: map | reference
      def set_music_pan(
            _music,
            _pan,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set looping for a music
      """
      @doc group: :music_management
      @spec set_music_looping(
              music :: map | reference,
              looping :: boolean,
              return :: :value | :resource
            ) :: map | reference
      def set_music_looping(
            _music,
            _looping,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get music time length (in seconds)

      ```c
      // raylib.h
      RLAPI float GetMusicTimeLength(Music music);
      ```
      """
      @doc group: :music_management
      @spec get_music_time_length(music :: map | reference) :: float
      def get_music_time_length(_music), do: :erlang.nif_error(:undef)

      @doc """
      Get current music time played (in seconds)

      ```c
      // raylib.h
      RLAPI float GetMusicTimePlayed(Music music);
      ```
      """
      @doc group: :music_management
      @spec get_music_time_played(music :: map | reference) :: float
      def get_music_time_played(_music), do: :erlang.nif_error(:undef)

      ############################
      #  AudioStream management  #
      ############################

      @doc """
      Load audio stream (to stream raw audio pcm data)

      ```c
      // raylib.h
      RLAPI AudioStream LoadAudioStream(unsigned int sampleRate, unsigned int sampleSize, unsigned int channels);
      ```
      """
      @doc group: :audio_stream_management
      @spec load_audio_stream(
              sample_rate :: non_neg_integer,
              sample_size :: non_neg_integer,
              channels :: non_neg_integer,
              return :: :value | :resource
            ) :: map | reference
      def load_audio_stream(
            _sample_rate,
            _sample_size,
            _channels,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Checks if an audio stream is valid (buffers initialized)

      ```c
      // raylib.h
      RLAPI bool IsAudioStreamValid(AudioStream stream);
      ```
      """
      @doc group: :audio_stream_management
      @spec is_audio_stream_valid(stream :: map | reference) :: boolean
      def is_audio_stream_valid(_stream), do: :erlang.nif_error(:undef)

      @doc """
      Update audio stream buffers with data

      ```c
      // raylib.h
      RLAPI void UpdateAudioStream(AudioStream stream, const void *data, int frameCount);
      ```
      """
      @doc group: :audio_stream_management
      @spec update_audio_stream(
              sound :: map | reference,
              data :: binary | [byte] | [integer] | [float],
              return :: :value | :resource
            ) :: map | reference
      def update_audio_stream(
            _sound,
            _data,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check if any audio stream buffers requires refill

      ```c
      // raylib.h
      RLAPI bool IsAudioStreamProcessed(AudioStream stream);
      ```
      """
      @doc group: :audio_stream_management
      @spec is_audio_stream_processed(stream :: map | reference) :: boolean
      def is_audio_stream_processed(_stream), do: :erlang.nif_error(:undef)

      @doc """
      Play audio stream

      ```c
      // raylib.h
      RLAPI void PlayAudioStream(AudioStream stream);
      ```
      """
      @doc group: :audio_stream_management
      @spec play_audio_stream(
              stream :: map | reference,
              return :: :value | :resource
            ) :: map | reference
      def play_audio_stream(
            _stream,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Pause audio stream

      ```c
      // raylib.h
      RLAPI void PauseAudioStream(AudioStream stream);
      ```
      """
      @doc group: :audio_stream_management
      @spec pause_audio_stream(
              stream :: map | reference,
              return :: :value | :resource
            ) :: map | reference
      def pause_audio_stream(
            _stream,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Resume audio stream

      ```c
      // raylib.h
      RLAPI void ResumeAudioStream(AudioStream stream);
      ```
      """
      @doc group: :audio_stream_management
      @spec resume_audio_stream(
              stream :: map | reference,
              return :: :value | :resource
            ) :: map | reference
      def resume_audio_stream(
            _stream,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check if audio stream is playing

      ```c
      // raylib.h
      RLAPI bool IsAudioStreamPlaying(AudioStream stream);
      ```
      """
      @doc group: :audio_stream_management
      @spec is_audio_stream_playing(stream :: map | reference) :: boolean
      def is_audio_stream_playing(_stream), do: :erlang.nif_error(:undef)

      @doc """
      Stop audio stream

      ```c
      // raylib.h
      RLAPI void StopAudioStream(AudioStream stream);
      ```
      """
      @doc group: :audio_stream_management
      @spec stop_audio_stream(
              stream :: map | reference,
              return :: :value | :resource
            ) :: map | reference
      def stop_audio_stream(
            _stream,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set volume for audio stream (1.0 is max level)

      ```c
      // raylib.h
      RLAPI void SetAudioStreamVolume(AudioStream stream, float volume);
      ```
      """
      @doc group: :audio_stream_management
      @spec set_audio_stream_volume(
              stream :: map | reference,
              volume :: float,
              return :: :value | :resource
            ) :: map | reference
      def set_audio_stream_volume(
            _stream,
            _volume,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set pitch for audio stream (1.0 is base level)

      ```c
      // raylib.h
      RLAPI void SetAudioStreamPitch(AudioStream stream, float pitch);
      ```
      """
      @doc group: :audio_stream_management
      @spec set_audio_stream_pitch(
              stream :: map | reference,
              pitch :: float,
              return :: :value | :resource
            ) :: map | reference
      def set_audio_stream_pitch(
            _stream,
            _pitch,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set pan for audio stream (0.5 is centered)

      ```c
      // raylib.h
      RLAPI void SetAudioStreamPan(AudioStream stream, float pan);
      ```
      """
      @doc group: :audio_stream_management
      @spec set_audio_stream_pan(
              stream :: map | reference,
              pan :: float,
              return :: :value | :resource
            ) :: map | reference
      def set_audio_stream_pan(
            _stream,
            _pan,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Default size for new audio streams

      ```c
      // raylib.h
      RLAPI void SetAudioStreamBufferSizeDefault(int size);
      ```
      """
      @doc group: :audio_stream_management
      @spec set_audio_stream_buffer_size_default(size :: integer) :: :ok
      def set_audio_stream_buffer_size_default(_size), do: :erlang.nif_error(:undef)
    end
  end
end
