defmodule Zexray.Audio do
  @moduledoc """
  Audio
  """

  import Zexray.Guard
  alias Zexray.NIF

  #######################
  #  Device management  #
  #######################

  @doc """
  Run function with audio device and close it after.
  """
  @doc group: :device_management
  @spec with_audio(func :: (-> any)) :: any
  def with_audio(func) when is_function(func) do
    try do
      init()
      func.()
    after
      close()
    end
  end

  @doc """
  Initialize audio device and context
  """
  @doc group: :device_management
  @spec init() :: :ok
  defdelegate init(), to: NIF, as: :init_audio_device

  @doc """
  Close the audio device and context
  """
  @doc group: :device_management
  @spec close() :: :ok
  defdelegate close(), to: NIF, as: :close_audio_device

  @doc """
  Check if audio device has been initialized successfully
  """
  @doc group: :device_management
  @spec ready?() :: boolean
  defdelegate ready?(), to: NIF, as: :is_audio_device_ready

  @doc """
  Set master volume (listener)
  """
  @doc group: :device_management
  @spec set_master_volume(volume :: float) :: :ok
  defdelegate set_master_volume(volume), to: NIF, as: :set_master_volume

  @doc """
  Get master volume (listener)
  """
  @doc group: :device_management
  @spec get_master_volume() :: float
  defdelegate get_master_volume(), to: NIF, as: :get_master_volume

  @doc """
  Run function with 3D mode with custom camera (3D)
  """
  @doc group: :device_management
  @spec with_mode_3d(
          listener :: Zexray.Type.Camera3D.t_all(),
          max_distance :: float,
          func :: (-> any)
        ) :: any
  def with_mode_3d(
        listener,
        max_distance,
        func
      )
      when is_function(func) do
    try do
      begin_mode_3d(listener, max_distance)
      func.()
    after
      end_mode_3d()
    end
  end

  @doc """
  Begin 3D mode with custom camera (3D)
  """
  @doc group: :device_management
  @spec begin_mode_3d(
          listener :: Zexray.Type.Camera3D.t_all(),
          max_distance :: float
        ) :: :ok
  defdelegate begin_mode_3d(
                listener,
                max_distance
              ),
              to: NIF,
              as: :audio_begin_mode_3d

  @doc """
  Ends 3D mode
  """
  @doc group: :device_management
  @spec end_mode_3d() :: :ok
  defdelegate end_mode_3d(), to: NIF, as: :audio_end_mode_3d

  ################
  #  Management  #
  ################

  @doc """
  Default size for new audio streams in frames

  NOTE: Audio streams use double buffer so the actual buffer size will be 2x this.
  """
  @doc group: :management
  @spec set_buffer_size(size :: integer) :: :ok
  defdelegate set_buffer_size(size), to: __MODULE__, as: :set_stream_buffer_size

  @doc """
  Play audio
  """
  @doc group: :management
  def play(audio, return \\ :auto)

  @spec play(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  def play(sound_stream, return)
      when is_sound_stream(sound_stream) or is_sound_stream_alias(sound_stream) do
    play_sound_stream(sound_stream, return)
  end

  @spec play(sound :: Zexray.Type.Sound.t_all(), return :: :auto | :value | :resource) ::
          Zexray.Type.Sound.t_nif()
  def play(sound, return) when is_sound(sound) or is_sound_alias(sound) do
    play_sound(sound, return)
  end

  @spec play(music :: Zexray.Type.Music.t_all(), return :: :auto | :value | :resource) ::
          Zexray.Type.Music.t_nif()
  def play(music, return) when is_music(music) do
    play_music(music, return)
  end

  @spec play(stream :: Zexray.Type.AudioStream.t_all(), return :: :auto | :value | :resource) ::
          Zexray.Type.AudioStream.t_nif()
  def play(stream, return) when is_audio_stream(stream) do
    play_stream(stream, return)
  end

  @doc """
  Stop audio
  """
  @doc group: :management
  def stop(audio, return \\ :auto)

  @spec stop(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  def stop(sound_stream, return)
      when is_sound_stream(sound_stream) or is_sound_stream_alias(sound_stream) do
    stop_sound_stream(sound_stream, return)
  end

  @spec stop(sound :: Zexray.Type.Sound.t_all(), return :: :auto | :value | :resource) ::
          Zexray.Type.Sound.t_nif()
  def stop(sound, return) when is_sound(sound) or is_sound_alias(sound) do
    stop_sound(sound, return)
  end

  @spec stop(music :: Zexray.Type.Music.t_all(), return :: :auto | :value | :resource) ::
          Zexray.Type.Music.t_nif()
  def stop(music, return) when is_music(music) do
    stop_music(music, return)
  end

  @spec stop(stream :: Zexray.Type.AudioStream.t_all(), return :: :auto | :value | :resource) ::
          Zexray.Type.AudioStream.t_nif()
  def stop(stream, return) when is_audio_stream(stream) do
    stop_stream(stream, return)
  end

  @doc """
  Pause audio
  """
  @doc group: :management
  def pause(audio, return \\ :auto)

  @spec pause(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  def pause(sound_stream, return)
      when is_sound_stream(sound_stream) or is_sound_stream_alias(sound_stream) do
    pause_sound_stream(sound_stream, return)
  end

  @spec pause(sound :: Zexray.Type.Sound.t_all(), return :: :auto | :value | :resource) ::
          Zexray.Type.Sound.t_nif()
  def pause(sound, return) when is_sound(sound) or is_sound_alias(sound) do
    pause_sound(sound, return)
  end

  @spec pause(music :: Zexray.Type.Music.t_all(), return :: :auto | :value | :resource) ::
          Zexray.Type.Music.t_nif()
  def pause(music, return) when is_music(music) do
    pause_music(music, return)
  end

  @spec pause(stream :: Zexray.Type.AudioStream.t_all(), return :: :auto | :value | :resource) ::
          Zexray.Type.AudioStream.t_nif()
  def pause(stream, return) when is_audio_stream(stream) do
    pause_stream(stream, return)
  end

  @doc """
  Resume audio
  """
  @doc group: :management
  def resume(audio, return \\ :auto)

  @spec resume(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  def resume(sound_stream, return)
      when is_sound_stream(sound_stream) or is_sound_stream_alias(sound_stream) do
    resume_sound_stream(sound_stream, return)
  end

  @spec resume(sound :: Zexray.Type.Sound.t_all(), return :: :auto | :value | :resource) ::
          Zexray.Type.Sound.t_nif()
  def resume(sound, return) when is_sound(sound) or is_sound_alias(sound) do
    resume_sound(sound, return)
  end

  @spec resume(music :: Zexray.Type.Music.t_all(), return :: :auto | :value | :resource) ::
          Zexray.Type.Music.t_nif()
  def resume(music, return) when is_music(music) do
    resume_music(music, return)
  end

  @spec resume(stream :: Zexray.Type.AudioStream.t_all(), return :: :auto | :value | :resource) ::
          Zexray.Type.AudioStream.t_nif()
  def resume(stream, return) when is_audio_stream(stream) do
    resume_stream(stream, return)
  end

  @doc """
  Check if an audio is currently playing
  """
  @doc group: :management
  def playing?(audio)

  @spec playing?(sound_stream :: Zexray.Type.SoundStream.t_all()) :: boolean
  def playing?(sound_stream)
      when is_sound_stream(sound_stream) or is_sound_stream_alias(sound_stream) do
    sound_stream_playing?(sound_stream)
  end

  @spec playing?(sound :: Zexray.Type.Sound.t_all()) :: boolean
  def playing?(sound) when is_sound(sound) or is_sound_alias(sound) do
    sound_playing?(sound)
  end

  @spec playing?(music :: Zexray.Type.Music.t_all()) :: boolean
  def playing?(music) when is_music(music) do
    music_playing?(music)
  end

  @spec playing?(stream :: Zexray.Type.AudioStream.t_all()) :: boolean
  def playing?(stream) when is_audio_stream(stream) do
    stream_playing?(stream)
  end

  @doc """
  Checks if an audio is valid
  """
  @doc group: :management
  def valid?(audio)

  @spec valid?(sound_stream :: Zexray.Type.SoundStream.t_all()) :: boolean
  def valid?(sound_stream)
      when is_sound_stream(sound_stream) or is_sound_stream_alias(sound_stream) do
    sound_stream_valid?(sound_stream)
  end

  @spec valid?(sound :: Zexray.Type.Sound.t_all()) :: boolean
  def valid?(sound) when is_sound(sound) or is_sound_alias(sound) do
    sound_valid?(sound)
  end

  @spec valid?(music :: Zexray.Type.Music.t_all()) :: boolean
  def valid?(music) when is_music(music) do
    music_valid?(music)
  end

  @spec valid?(stream :: Zexray.Type.AudioStream.t_all()) :: boolean
  def valid?(stream) when is_audio_stream(stream) do
    stream_valid?(stream)
  end

  @doc """
  Check if any audio stream buffers requires refill
  """
  @doc group: :management
  def processed?(audio)

  @spec processed?(sound_stream :: Zexray.Type.SoundStream.t_all()) :: boolean
  def processed?(sound_stream)
      when is_sound_stream(sound_stream) or is_sound_stream_alias(sound_stream) do
    sound_stream_processed?(sound_stream)
  end

  @spec processed?(sound :: Zexray.Type.Sound.t_all()) :: boolean
  def processed?(sound) when is_sound(sound) or is_sound_alias(sound) do
    sound_processed?(sound)
  end

  @spec processed?(music :: Zexray.Type.Music.t_all()) :: boolean
  def processed?(music) when is_music(music) do
    music_processed?(music)
  end

  @spec processed?(stream :: Zexray.Type.AudioStream.t_all()) :: boolean
  def processed?(stream) when is_audio_stream(stream) do
    stream_processed?(stream)
  end

  @doc """
  Set volume for an audio (1.0 is max level)
  """
  @doc group: :management
  def set_volume(audio, volume, return \\ :auto)

  @spec set_volume(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          volume :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  def set_volume(sound_stream, volume, return)
      when is_sound_stream(sound_stream) or is_sound_stream_alias(sound_stream) do
    set_sound_stream_volume(sound_stream, volume, return)
  end

  @spec set_volume(
          sound :: Zexray.Type.Sound.t_all(),
          volume :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  def set_volume(sound, volume, return) when is_sound(sound) or is_sound_alias(sound) do
    set_sound_volume(sound, volume, return)
  end

  @spec set_volume(
          music :: Zexray.Type.Music.t_all(),
          volume :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def set_volume(music, volume, return) when is_music(music) do
    set_music_volume(music, volume, return)
  end

  @spec set_volume(
          stream :: Zexray.Type.AudioStream.t_all(),
          volume :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  def set_volume(stream, volume, return) when is_audio_stream(stream) do
    set_stream_volume(stream, volume, return)
  end

  @doc """
  Set pitch for an audio (1.0 is base level)
  """
  @doc group: :management
  def set_pitch(audio, pitch, return \\ :auto)

  @spec set_pitch(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          pitch :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  def set_pitch(sound_stream, pitch, return)
      when is_sound_stream(sound_stream) or is_sound_stream_alias(sound_stream) do
    set_sound_stream_pitch(sound_stream, pitch, return)
  end

  @spec set_pitch(
          sound :: Zexray.Type.Sound.t_all(),
          pitch :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  def set_pitch(sound, pitch, return) when is_sound(sound) or is_sound_alias(sound) do
    set_sound_pitch(sound, pitch, return)
  end

  @spec set_pitch(
          music :: Zexray.Type.Music.t_all(),
          pitch :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def set_pitch(music, pitch, return) when is_music(music) do
    set_music_pitch(music, pitch, return)
  end

  @spec set_pitch(
          stream :: Zexray.Type.AudioStream.t_all(),
          pitch :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  def set_pitch(stream, pitch, return) when is_audio_stream(stream) do
    set_stream_pitch(stream, pitch, return)
  end

  @doc """
  Set pan for an audio (0.5 is center)
  """
  @doc group: :management
  def set_pan(audio, pan, return \\ :auto)

  @spec set_pan(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          pan :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  def set_pan(sound_stream, pan, return)
      when is_sound_stream(sound_stream) or is_sound_stream_alias(sound_stream) do
    set_sound_stream_pan(sound_stream, pan, return)
  end

  @spec set_pan(
          sound :: Zexray.Type.Sound.t_all(),
          pan :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  def set_pan(sound, pan, return) when is_sound(sound) or is_sound_alias(sound) do
    set_sound_pan(sound, pan, return)
  end

  @spec set_pan(
          music :: Zexray.Type.Music.t_all(),
          pan :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def set_pan(music, pan, return) when is_music(music) do
    set_music_pan(music, pan, return)
  end

  @spec set_pan(
          stream :: Zexray.Type.AudioStream.t_all(),
          pan :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  def set_pan(stream, pan, return) when is_audio_stream(stream) do
    set_stream_pan(stream, pan, return)
  end

  @doc """
  Set looping for an audio
  """
  @doc group: :management
  def set_looping(audio, looping, return \\ :auto)

  @spec set_looping(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          looping :: boolean,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  def set_looping(sound_stream, looping, return)
      when is_sound_stream(sound_stream) or is_sound_stream_alias(sound_stream) do
    set_sound_stream_looping(sound_stream, looping, return)
  end

  @spec set_looping(
          music :: Zexray.Type.Music.t_all(),
          looping :: boolean,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def set_looping(music, looping, return) when is_music(music) do
    set_music_looping(music, looping, return)
  end

  @doc """
  Set position for an audio
  """
  @doc group: :management
  def set_position(audio, position, return \\ :auto)

  @spec set_position(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          position :: nil | Zexray.Type.Vector3.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  def set_position(sound_stream, position, return)
      when is_sound_stream(sound_stream) or is_sound_stream_alias(sound_stream) do
    set_sound_stream_position(sound_stream, position, return)
  end

  @spec set_position(
          sound :: Zexray.Type.Sound.t_all(),
          position :: nil | Zexray.Type.Vector3.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  def set_position(sound, position, return)
      when is_sound(sound) or is_sound_alias(sound) do
    set_sound_position(sound, position, return)
  end

  @spec set_position(
          music :: Zexray.Type.Music.t_all(),
          position :: nil | Zexray.Type.Vector3.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def set_position(music, position, return)
      when is_music(music) do
    set_music_position(music, position, return)
  end

  @spec set_position(
          stream :: Zexray.Type.AudioStream.t_all(),
          position :: nil | Zexray.Type.Vector3.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  def set_position(stream, position, return)
      when is_audio_stream(stream) do
    set_stream_position(stream, position, return)
  end

  @doc """
  Get audio time length (in seconds)
  """
  @doc group: :management
  def get_time_length(audio)

  @spec get_time_length(sound_stream :: Zexray.Type.SoundStream.t_all()) :: float
  def get_time_length(sound_stream)
      when is_sound_stream(sound_stream) or is_sound_stream_alias(sound_stream) do
    get_sound_stream_time_length(sound_stream)
  end

  @spec get_time_length(sound :: Zexray.Type.Sound.t_all()) :: float
  def get_time_length(sound) when is_sound(sound) or is_sound_alias(sound) do
    get_sound_time_length(sound)
  end

  @spec get_time_length(music :: Zexray.Type.Music.t_all()) :: float
  def get_time_length(music) when is_music(music) do
    get_music_time_length(music)
  end

  @spec get_time_length(
          stream :: Zexray.Type.AudioStream.t_all(),
          frame_count :: non_neg_integer
        ) :: float
  def get_time_length(stream, frame_count) when is_audio_stream(stream) do
    get_stream_time_length(stream, frame_count)
  end

  @doc """
  Get current audio time played (in seconds)
  """
  @doc group: :management
  def get_time_played(audio)

  @spec get_time_played(sound_stream :: Zexray.Type.SoundStream.t_all()) :: float
  def get_time_played(sound_stream)
      when is_sound_stream(sound_stream) or is_sound_stream_alias(sound_stream) do
    get_sound_stream_time_played(sound_stream)
  end

  @spec get_time_played(sound :: Zexray.Type.Sound.t_all()) :: float
  def get_time_played(sound) when is_sound(sound) or is_sound_alias(sound) do
    get_sound_time_played(sound)
  end

  @spec get_time_played(music :: Zexray.Type.Music.t_all()) :: float
  def get_time_played(music) when is_music(music) do
    get_music_time_played(music)
  end

  @spec get_time_played(
          stream :: Zexray.Type.AudioStream.t_all(),
          frame_count :: non_neg_integer
        ) :: float
  def get_time_played(stream, frame_count) when is_audio_stream(stream) do
    get_stream_time_played(stream, frame_count)
  end

  @doc """
  Get audio info
  """
  @doc group: :management
  def get_info(audio, return \\ :auto)

  @spec get_info(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioInfo.t_nif()
  def get_info(sound_stream, return)
      when is_sound_stream(sound_stream) or is_sound_stream_alias(sound_stream) do
    get_sound_stream_info(sound_stream, return)
  end

  @spec get_info(
          sound :: Zexray.Type.Sound.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioInfo.t_nif()
  def get_info(sound, return) when is_sound(sound) or is_sound_alias(sound) do
    get_sound_info(sound, return)
  end

  @spec get_info(
          wave :: Zexray.Type.Wave.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioInfo.t_nif()
  def get_info(wave, return) when is_wave(wave) do
    get_wave_info(wave, return)
  end

  @spec get_info(
          music :: Zexray.Type.Music.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioInfo.t_nif()
  def get_info(music, return) when is_music(music) do
    get_music_info(music, return)
  end

  @spec get_info(
          stream :: Zexray.Type.AudioStream.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioInfo.t_nif()
  def get_info(stream, return) when is_audio_stream(stream) do
    get_stream_info(stream, return)
  end

  @doc """
  Update audio buffer with new data
  """
  @doc group: :management
  def update(audio, data \\ nil, return \\ :auto)

  def update(audio, return, _)
      when (is_sound_stream(audio) or is_sound_stream_alias(audio)) and is_nif_return(return) do
    update(audio, nil, return)
  end

  def update(audio, return, _) when is_music(audio) and is_nif_return(return) do
    update(audio, nil, return)
  end

  @spec update(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          data ::
            nil
            | binary
            | [byte]
            | [integer]
            | [float],
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  def update(sound_stream, data, return)
      when is_sound_stream(sound_stream) or is_sound_stream_alias(sound_stream) do
    update_sound_stream(sound_stream, data, return)
  end

  @spec update(
          sound :: Zexray.Type.Sound.t_all(),
          data ::
            binary
            | [byte]
            | [integer]
            | [float],
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  def update(sound, data, return) when is_sound(sound) or is_sound_alias(sound) do
    update_sound(sound, data, return)
  end

  @spec update(
          music :: Zexray.Type.Music.t_all(),
          data :: nil,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def update(music, nil, return) when is_music(music) do
    update_music(music, return)
  end

  @spec update(
          stream :: Zexray.Type.AudioStream.t_all(),
          data ::
            binary
            | [byte]
            | [integer]
            | [float],
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  def update(stream, data, return) when is_audio_stream(stream) do
    update_stream(stream, data, return)
  end

  @doc """
  Load next samples data from audio
  """
  @doc group: :management
  def load_next_samples(audio)

  @spec load_next_samples(sound_stream :: Zexray.Type.SoundStream.t_all()) ::
          binary | [byte] | [integer] | [float]
  def load_next_samples(sound_stream)
      when is_sound_stream(sound_stream) or is_sound_stream_alias(sound_stream) do
    load_sound_stream_next_samples(sound_stream)
  end

  ##########
  #  Sound #
  ##########

  @doc """
  Load wave data from file
  """
  @doc group: :sound
  @spec load_wave(
          file_name :: binary,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Wave.t_nif()
  defdelegate load_wave(
                file_name,
                return \\ :auto
              ),
              to: NIF,
              as: :load_wave

  @doc """
  Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
  """
  @doc group: :sound
  @spec load_wave_from_memory(
          file_type :: binary,
          file_data :: binary,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Wave.t_nif()
  defdelegate load_wave_from_memory(
                file_type,
                file_data,
                return \\ :auto
              ),
              to: NIF,
              as: :load_wave_from_memory

  @doc """
  Checks if wave data is valid (data loaded and parameters)
  """
  @doc group: :sound
  @spec wave_valid?(wave :: Zexray.Type.Wave.t_all()) :: boolean
  defdelegate wave_valid?(wave), to: NIF, as: :is_wave_valid

  @doc """
  Load sound from file
  """
  @doc group: :sound
  @spec load_sound(
          file_name :: binary,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  defdelegate load_sound(
                file_name,
                return \\ :auto
              ),
              to: NIF,
              as: :load_sound

  @doc """
  Load sound from wave data
  """
  @doc group: :sound
  @spec load_sound_from_wave(
          wave :: Zexray.Type.Wave.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  defdelegate load_sound_from_wave(
                wave,
                return \\ :auto
              ),
              to: NIF,
              as: :load_sound_from_wave

  @doc """
  Create a new sound that shares the same sample data as the source sound, does not own the sound data
  """
  @doc group: :sound
  @spec load_sound_alias(
          source :: Zexray.Type.Sound.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundAlias.t_nif()
  defdelegate load_sound_alias(
                source,
                return \\ :auto
              ),
              to: NIF,
              as: :load_sound_alias

  @doc """
  Checks if a sound is valid (data loaded and buffers initialized)
  """
  @doc group: :sound
  @spec sound_valid?(sound :: Zexray.Type.Sound.t_all()) :: boolean
  defdelegate sound_valid?(sound), to: NIF, as: :is_sound_valid

  @doc """
  Update sound buffer with new data
  """
  @doc group: :sound
  @spec update_sound(
          sound :: Zexray.Type.Sound.t_all(),
          data ::
            binary
            | [byte]
            | [integer]
            | [float],
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  defdelegate update_sound(
                sound,
                data,
                return \\ :auto
              ),
              to: NIF,
              as: :update_sound

  @doc """
  Check if any audio stream buffers requires refill
  """
  @doc group: :sound
  @spec sound_processed?(sound :: Zexray.Type.Sound.t_all()) :: boolean
  defdelegate sound_processed?(sound), to: NIF, as: :is_sound_processed

  @doc """
  Export wave data to file, returns true on success
  """
  @doc group: :sound
  @spec export_wave(
          wave :: Zexray.Type.Wave.t_all(),
          file_name :: binary
        ) :: boolean
  defdelegate export_wave(
                wave,
                file_name
              ),
              to: NIF,
              as: :export_wave

  @doc """
  Play a sound
  """
  @doc group: :sound
  @spec play_sound(
          sound :: Zexray.Type.Sound.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  defdelegate play_sound(
                sound,
                return \\ :auto
              ),
              to: NIF,
              as: :play_sound

  @doc """
  Stop playing a sound
  """
  @doc group: :sound
  @spec stop_sound(
          sound :: Zexray.Type.Sound.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  defdelegate stop_sound(
                sound,
                return \\ :auto
              ),
              to: NIF,
              as: :stop_sound

  @doc """
  Pause a sound
  """
  @doc group: :sound
  @spec pause_sound(
          sound :: Zexray.Type.Sound.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  defdelegate pause_sound(
                sound,
                return \\ :auto
              ),
              to: NIF,
              as: :pause_sound

  @doc """
  Resume a paused sound
  """
  @doc group: :sound
  @spec resume_sound(
          sound :: Zexray.Type.Sound.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  defdelegate resume_sound(
                sound,
                return \\ :auto
              ),
              to: NIF,
              as: :resume_sound

  @doc """
  Check if a sound is currently playing
  """
  @doc group: :sound
  @spec sound_playing?(sound :: Zexray.Type.Sound.t_all()) :: boolean
  defdelegate sound_playing?(sound), to: NIF, as: :is_sound_playing

  @doc """
  Set volume for a sound (1.0 is max level)
  """
  @doc group: :sound
  @spec set_sound_volume(
          sound :: Zexray.Type.Sound.t_all(),
          volume :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  defdelegate set_sound_volume(
                sound,
                volume,
                return \\ :auto
              ),
              to: NIF,
              as: :set_sound_volume

  @doc """
  Set pitch for a sound (1.0 is base level)
  """
  @doc group: :sound
  @spec set_sound_pitch(
          sound :: Zexray.Type.Sound.t_all(),
          pitch :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  defdelegate set_sound_pitch(
                sound,
                pitch,
                return \\ :auto
              ),
              to: NIF,
              as: :set_sound_pitch

  @doc """
  Set pan for a sound (0.5 is center)
  """
  @doc group: :sound
  @spec set_sound_pan(
          sound :: Zexray.Type.Sound.t_all(),
          pan :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  defdelegate set_sound_pan(
                sound,
                pan,
                return \\ :auto
              ),
              to: NIF,
              as: :set_sound_pan

  @doc """
  Set position for a sound
  """
  @doc group: :sound
  @spec set_sound_position(
          sound :: Zexray.Type.Sound.t_all(),
          position :: nil | Zexray.Type.Vector3.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  defdelegate set_sound_position(
                sound,
                position,
                return \\ :auto
              ),
              to: NIF,
              as: :set_sound_position

  @doc """
  Get sound time length (in seconds)
  """
  @doc group: :sound
  @spec get_sound_time_length(sound :: Zexray.Type.Sound.t_all()) :: float
  defdelegate get_sound_time_length(sound), to: NIF, as: :get_sound_time_length

  @doc """
  Get current sound time played (in seconds)
  """
  @doc group: :sound
  @spec get_sound_time_played(sound :: Zexray.Type.Sound.t_all()) :: float
  defdelegate get_sound_time_played(sound), to: NIF, as: :get_sound_time_played

  @doc """
  Get sound info
  """
  @doc group: :sound
  @spec get_sound_info(
          sound :: Zexray.Type.Sound.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioInfo.t_nif()
  defdelegate get_sound_info(
                sound,
                return \\ :auto
              ),
              to: NIF,
              as: :get_sound_info

  @doc """
  Copy a wave to a new wave
  """
  @doc group: :sound
  @spec wave_copy(
          wave :: Zexray.Type.Wave.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Wave.t_nif()
  defdelegate wave_copy(
                wave,
                return \\ :auto
              ),
              to: NIF,
              as: :wave_copy

  @doc """
  Crop a wave to defined frames range
  """
  @doc group: :sound
  @spec wave_crop(
          wave :: Zexray.Type.Wave.t_all(),
          init_frame :: integer,
          final_frame :: integer,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Wave.t_nif()
  defdelegate wave_crop(
                wave,
                init_frame,
                final_frame,
                return \\ :auto
              ),
              to: NIF,
              as: :wave_crop

  @doc """
  Convert wave data to desired format
  """
  @doc group: :sound
  @spec wave_format(
          wave :: Zexray.Type.Wave.t_all(),
          sample_rate :: integer,
          sample_size :: integer,
          channels :: integer,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Wave.t_nif()
  defdelegate wave_format(
                wave,
                sample_rate,
                sample_size,
                channels,
                return \\ :auto
              ),
              to: NIF,
              as: :wave_format

  @doc """
  Load samples data from wave as a 32bit float data array
  """
  @doc group: :sound
  @spec load_wave_samples_normalized(wave :: Zexray.Type.Wave.t_all()) :: [float]
  defdelegate load_wave_samples_normalized(wave), to: NIF, as: :load_wave_samples_normalized

  @doc """
  Load samples data from wave
  """
  @doc group: :sound
  @spec load_wave_samples(wave :: Zexray.Type.Wave.t_all()) ::
          binary | [byte] | [integer] | [float]
  defdelegate load_wave_samples(wave), to: NIF, as: :load_wave_samples

  @doc """
  Load samples data from wave
  """
  @doc group: :sound
  @spec load_wave_samples_ex(
          wave :: Zexray.Type.Wave.t_all(),
          frame_count :: non_neg_integer,
          frame_offset :: integer,
          looping :: boolean
        ) :: binary | [byte] | [integer] | [float]
  defdelegate load_wave_samples_ex(
                wave,
                frame_count \\ 0,
                frame_offset \\ 0,
                looping \\ true
              ),
              to: NIF,
              as: :load_wave_samples_ex

  @doc """
  Get wave info
  """
  @doc group: :sound
  @spec get_wave_info(
          wave :: Zexray.Type.Wave.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioInfo.t_nif()
  defdelegate get_wave_info(
                wave,
                return \\ :auto
              ),
              to: NIF,
              as: :get_wave_info

  @doc """
  Get wave data size in bytes
  """
  @doc group: :sound
  @spec get_wave_data_size(
          frame_count :: non_neg_integer,
          channels :: non_neg_integer,
          sample_size :: non_neg_integer
        ) :: non_neg_integer
  defdelegate get_wave_data_size(
                frame_count,
                channels,
                sample_size
              ),
              to: NIF,
              as: :get_wave_data_size

  ##################
  #  Sound stream  #
  ##################

  @doc """
  Load sound stream from file
  """
  @doc group: :sound_stream
  @spec load_sound_stream(
          file_name :: binary,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  defdelegate load_sound_stream(
                file_name,
                return \\ :auto
              ),
              to: NIF,
              as: :load_sound_stream

  @doc """
  Load sound stream from wave data
  """
  @doc group: :sound_stream
  @spec load_sound_stream_from_wave(
          wave :: Zexray.Type.Wave.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  defdelegate load_sound_stream_from_wave(
                wave,
                return \\ :auto
              ),
              to: NIF,
              as: :load_sound_stream_from_wave

  @doc """
  Create a new sound stream that shares the same sample data as the source sound, does not own the sound stream data
  """
  @doc group: :sound_stream
  @spec load_sound_stream_alias(
          source :: Zexray.Type.SoundStream.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStreamAlias.t_nif()
  defdelegate load_sound_stream_alias(
                source,
                return \\ :auto
              ),
              to: NIF,
              as: :load_sound_stream_alias

  @doc """
  Checks if a sound stream is valid (data loaded and buffers initialized)
  """
  @doc group: :sound_stream
  @spec sound_stream_valid?(sound_stream :: Zexray.Type.SoundStream.t_all()) :: boolean
  defdelegate sound_stream_valid?(sound_stream), to: NIF, as: :is_sound_stream_valid

  @doc """
  Update sound stream buffer with new data
  """
  @doc group: :sound_stream
  @spec update_sound_stream(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          data ::
            nil
            | binary
            | [byte]
            | [integer]
            | [float],
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  defdelegate update_sound_stream(
                sound_stream,
                data,
                return \\ :auto
              ),
              to: NIF,
              as: :update_sound_stream

  @doc """
  Load next samples data from sound stream
  """
  @doc group: :sound_stream
  @spec load_sound_stream_next_samples(sound_stream :: Zexray.Type.SoundStream.t_all()) ::
          binary | [byte] | [integer] | [float]
  defdelegate load_sound_stream_next_samples(sound_stream),
    to: NIF,
    as: :load_sound_stream_next_samples

  @doc """
  Check if any audio stream buffers requires refill
  """
  @doc group: :sound_stream
  @spec sound_stream_processed?(sound_stream :: Zexray.Type.SoundStream.t_all()) :: boolean
  defdelegate sound_stream_processed?(sound_stream), to: NIF, as: :is_sound_stream_processed

  @doc """
  Play a sound stream
  """
  @doc group: :sound_stream
  @spec play_sound_stream(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  defdelegate play_sound_stream(
                sound_stream,
                return \\ :auto
              ),
              to: NIF,
              as: :play_sound_stream

  @doc """
  Stop playing a sound stream
  """
  @doc group: :sound_stream
  @spec stop_sound_stream(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  defdelegate stop_sound_stream(
                sound_stream,
                return \\ :auto
              ),
              to: NIF,
              as: :stop_sound_stream

  @doc """
  Pause a sound stream
  """
  @doc group: :sound_stream
  @spec pause_sound_stream(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  defdelegate pause_sound_stream(
                sound_stream,
                return \\ :auto
              ),
              to: NIF,
              as: :pause_sound_stream

  @doc """
  Resume a paused sound stream
  """
  @doc group: :sound_stream
  @spec resume_sound_stream(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  defdelegate resume_sound_stream(
                sound_stream,
                return \\ :auto
              ),
              to: NIF,
              as: :resume_sound_stream

  @doc """
  Check if a sound stream is currently playing
  """
  @doc group: :sound_stream
  @spec sound_stream_playing?(sound_stream :: Zexray.Type.SoundStream.t_all()) :: boolean
  defdelegate sound_stream_playing?(sound_stream), to: NIF, as: :is_sound_stream_playing

  @doc """
  Set volume for a sound stream (1.0 is max level)
  """
  @doc group: :sound_stream
  @spec set_sound_stream_volume(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          volume :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  defdelegate set_sound_stream_volume(
                sound_stream,
                volume,
                return \\ :auto
              ),
              to: NIF,
              as: :set_sound_stream_volume

  @doc """
  Set pitch for a sound stream (1.0 is base level)
  """
  @doc group: :sound_stream
  @spec set_sound_stream_pitch(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          pitch :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  defdelegate set_sound_stream_pitch(
                sound_stream,
                pitch,
                return \\ :auto
              ),
              to: NIF,
              as: :set_sound_stream_pitch

  @doc """
  Set pan for a sound stream (0.5 is center)
  """
  @doc group: :sound_stream
  @spec set_sound_stream_pan(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          pan :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  defdelegate set_sound_stream_pan(
                sound_stream,
                pan,
                return \\ :auto
              ),
              to: NIF,
              as: :set_sound_stream_pan

  @doc """
  Set looping for a sound stream
  """
  @doc group: :sound_stream
  @spec set_sound_stream_looping(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          looping :: boolean,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  defdelegate set_sound_stream_looping(
                sound_stream,
                looping,
                return \\ :auto
              ),
              to: NIF,
              as: :set_sound_stream_looping

  @doc """
  Set position for a sound stream
  """
  @doc group: :sound_stream
  @spec set_sound_stream_position(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          position :: nil | Zexray.Type.Vector3.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.SoundStream.t_nif()
  defdelegate set_sound_stream_position(
                sound_stream,
                position,
                return \\ :auto
              ),
              to: NIF,
              as: :set_sound_stream_position

  @doc """
  Get sound stream time length (in seconds)
  """
  @doc group: :sound_stream
  @spec get_sound_stream_time_length(sound_stream :: Zexray.Type.SoundStream.t_all()) :: float
  defdelegate get_sound_stream_time_length(sound_stream),
    to: NIF,
    as: :get_sound_stream_time_length

  @doc """
  Get current sound stream time played (in seconds)
  """
  @doc group: :sound_stream
  @spec get_sound_stream_time_played(sound_stream :: Zexray.Type.SoundStream.t_all()) :: float
  defdelegate get_sound_stream_time_played(sound_stream),
    to: NIF,
    as: :get_sound_stream_time_played

  @doc """
  Get sound stream info
  """
  @doc group: :sound_stream
  @spec get_sound_stream_info(
          sound_stream :: Zexray.Type.SoundStream.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioInfo.t_nif()
  defdelegate get_sound_stream_info(
                sound_stream,
                return \\ :auto
              ),
              to: NIF,
              as: :get_sound_stream_info

  ###########
  #  Music  #
  ###########

  @doc """
  Load music stream from file
  """
  @doc group: :music
  @spec load_music(
          file_name :: binary,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  defdelegate load_music(
                file_name,
                return \\ :auto
              ),
              to: NIF,
              as: :load_music_stream

  @doc """
  Load music stream from data
  """
  @doc group: :music
  @spec load_music_from_memory(
          file_type :: binary,
          file_data :: binary,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Wave.t_nif()
  defdelegate load_music_from_memory(
                file_type,
                file_data,
                return \\ :auto
              ),
              to: NIF,
              as: :load_music_stream_from_memory

  @doc """
  Checks if a music stream is valid (context and buffers initialized)
  """
  @doc group: :music
  @spec music_valid?(music :: Zexray.Type.Music.t_all()) :: boolean
  defdelegate music_valid?(music), to: NIF, as: :is_music_valid

  @doc """
  Start music playing
  """
  @doc group: :music
  @spec play_music(
          music :: Zexray.Type.Music.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  defdelegate play_music(
                music,
                return \\ :auto
              ),
              to: NIF,
              as: :play_music_stream

  @doc """
  Check if music is playing
  """
  @doc group: :music
  @spec music_playing?(music :: Zexray.Type.Music.t_all()) :: boolean
  defdelegate music_playing?(music), to: NIF, as: :is_music_stream_playing

  @doc """
  Updates buffers for music streaming
  """
  @doc group: :music
  @spec update_music(
          music :: Zexray.Type.Music.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  defdelegate update_music(
                music,
                return \\ :auto
              ),
              to: NIF,
              as: :update_music_stream

  @doc """
  Check if any audio stream buffers requires refill
  """
  @doc group: :music
  @spec music_processed?(music :: Zexray.Type.Music.t_all()) :: boolean
  defdelegate music_processed?(music), to: NIF, as: :is_music_stream_processed

  @doc """
  Stop music playing
  """
  @doc group: :music
  @spec stop_music(
          music :: Zexray.Type.Music.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  defdelegate stop_music(
                music,
                return \\ :auto
              ),
              to: NIF,
              as: :stop_music_stream

  @doc """
  Pause music playing
  """
  @doc group: :music
  @spec pause_music(
          music :: Zexray.Type.Music.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  defdelegate pause_music(
                music,
                return \\ :auto
              ),
              to: NIF,
              as: :pause_music_stream

  @doc """
  Resume playing paused music
  """
  @doc group: :music
  @spec resume_music(
          music :: Zexray.Type.Music.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  defdelegate resume_music(
                music,
                return \\ :auto
              ),
              to: NIF,
              as: :resume_music_stream

  @doc """
  Seek music to a position (in seconds)
  """
  @doc group: :music
  @spec seek_music(
          music :: Zexray.Type.Music.t_all(),
          position :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  defdelegate seek_music(
                music,
                position,
                return \\ :auto
              ),
              to: NIF,
              as: :seek_music_stream

  @doc """
  Set volume for music (1.0 is max level)
  """
  @doc group: :music
  @spec set_music_volume(
          music :: Zexray.Type.Music.t_all(),
          volume :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  defdelegate set_music_volume(
                music,
                volume,
                return \\ :auto
              ),
              to: NIF,
              as: :set_music_volume

  @doc """
  Set pitch for a music (1.0 is base level)
  """
  @doc group: :music
  @spec set_music_pitch(
          music :: Zexray.Type.Music.t_all(),
          pitch :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  defdelegate set_music_pitch(
                music,
                pitch,
                return \\ :auto
              ),
              to: NIF,
              as: :set_music_pitch

  @doc """
  Set pan for a music (0.5 is center)
  """
  @doc group: :music
  @spec set_music_pan(
          music :: Zexray.Type.Music.t_all(),
          pan :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  defdelegate set_music_pan(
                music,
                pan,
                return \\ :auto
              ),
              to: NIF,
              as: :set_music_pan

  @doc """
  Set looping for a music
  """
  @doc group: :music
  @spec set_music_looping(
          music :: Zexray.Type.Music.t_all(),
          looping :: boolean,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  defdelegate set_music_looping(
                music,
                looping,
                return \\ :auto
              ),
              to: NIF,
              as: :set_music_looping

  @doc """
  Set position for a music
  """
  @doc group: :music
  @spec set_music_position(
          music :: Zexray.Type.Music.t_all(),
          position :: nil | Zexray.Type.Vector3.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  defdelegate set_music_position(
                music,
                position,
                return \\ :auto
              ),
              to: NIF,
              as: :set_music_position

  @doc """
  Get music time length (in seconds)
  """
  @doc group: :music
  @spec get_music_time_length(music :: Zexray.Type.Music.t_all()) :: float
  defdelegate get_music_time_length(music), to: NIF, as: :get_music_time_length

  @doc """
  Get current music time played (in seconds)
  """
  @doc group: :music
  @spec get_music_time_played(music :: Zexray.Type.Music.t_all()) :: float
  defdelegate get_music_time_played(music), to: NIF, as: :get_music_time_played

  @doc """
  Get music info
  """
  @doc group: :music
  @spec get_music_info(
          music :: Zexray.Type.Music.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioInfo.t_nif()
  defdelegate get_music_info(
                music,
                return \\ :auto
              ),
              to: NIF,
              as: :get_music_info

  ############
  #  Stream  #
  ############

  @doc """
  Load audio stream (to stream raw audio pcm data)
  """
  @doc group: :stream
  @spec load_stream(
          sample_rate :: non_neg_integer,
          sample_size :: non_neg_integer,
          channels :: non_neg_integer,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  defdelegate load_stream(
                sample_rate,
                sample_size,
                channels,
                return \\ :auto
              ),
              to: NIF,
              as: :load_audio_stream

  @doc """
  Load audio stream from audio info
  """
  @doc group: :stream
  @spec load_stream_from_info(
          info :: Zexray.Type.AudioInfo.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  defdelegate load_stream_from_info(
                info,
                return \\ :auto
              ),
              to: NIF,
              as: :load_audio_stream_from_audio_info

  @doc """
  Checks if an audio stream is valid (buffers initialized)
  """
  @doc group: :stream
  @spec stream_valid?(stream :: Zexray.Type.AudioStream.t_all()) :: boolean
  defdelegate stream_valid?(stream), to: NIF, as: :is_audio_stream_valid

  @doc """
  Update audio stream buffers with data
  """
  @doc group: :stream
  @spec update_stream(
          stream :: Zexray.Type.AudioStream.t_all(),
          data ::
            binary
            | [byte]
            | [integer]
            | [float],
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  defdelegate update_stream(
                stream,
                data,
                return \\ :auto
              ),
              to: NIF,
              as: :update_audio_stream

  @doc """
  Check if any audio stream buffers requires refill
  """
  @doc group: :stream
  @spec stream_processed?(stream :: Zexray.Type.AudioStream.t_all()) :: boolean
  defdelegate stream_processed?(stream), to: NIF, as: :is_audio_stream_processed

  @doc """
  Play audio stream
  """
  @doc group: :stream
  @spec play_stream(
          stream :: Zexray.Type.AudioStream.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  defdelegate play_stream(
                stream,
                return \\ :auto
              ),
              to: NIF,
              as: :play_audio_stream

  @doc """
  Pause audio stream
  """
  @doc group: :stream
  @spec pause_stream(
          stream :: Zexray.Type.AudioStream.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  defdelegate pause_stream(
                stream,
                return \\ :auto
              ),
              to: NIF,
              as: :pause_audio_stream

  @doc """
  Resume audio stream
  """
  @doc group: :stream
  @spec resume_stream(
          stream :: Zexray.Type.AudioStream.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  defdelegate resume_stream(
                stream,
                return \\ :auto
              ),
              to: NIF,
              as: :resume_audio_stream

  @doc """
  Check if audio stream is playing
  """
  @doc group: :stream
  @spec stream_playing?(stream :: Zexray.Type.AudioStream.t_all()) :: boolean
  defdelegate stream_playing?(stream), to: NIF, as: :is_audio_stream_playing

  @doc """
  Stop audio stream
  """
  @doc group: :stream
  @spec stop_stream(
          stream :: Zexray.Type.AudioStream.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  defdelegate stop_stream(
                stream,
                return \\ :auto
              ),
              to: NIF,
              as: :stop_audio_stream

  @doc """
  Set volume for audio stream (1.0 is max level)
  """
  @doc group: :stream
  @spec set_stream_volume(
          stream :: Zexray.Type.AudioStream.t_all(),
          volume :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  defdelegate set_stream_volume(
                stream,
                volume,
                return \\ :auto
              ),
              to: NIF,
              as: :set_audio_stream_volume

  @doc """
  Set pitch for audio stream (1.0 is base level)
  """
  @doc group: :stream
  @spec set_stream_pitch(
          stream :: Zexray.Type.AudioStream.t_all(),
          pitch :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  defdelegate set_stream_pitch(
                stream,
                pitch,
                return \\ :auto
              ),
              to: NIF,
              as: :set_audio_stream_pitch

  @doc """
  Set pan for audio stream (0.5 is centered)
  """
  @doc group: :stream
  @spec set_stream_pan(
          stream :: Zexray.Type.AudioStream.t_all(),
          pan :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  defdelegate set_stream_pan(
                stream,
                pan,
                return \\ :auto
              ),
              to: NIF,
              as: :set_audio_stream_pan

  @doc """
  Set position for a audio stream
  """
  @doc group: :stream
  @spec set_stream_position(
          stream :: Zexray.Type.AudioStream.t_all(),
          position :: nil | Zexray.Type.Vector3.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  defdelegate set_stream_position(
                stream,
                position,
                return \\ :auto
              ),
              to: NIF,
              as: :set_audio_stream_position

  @doc """
  Default size for new audio streams in frames

  NOTE: Audio streams use double buffer so the actual buffer size will be 2x this.
  """
  @doc group: :stream
  @spec set_stream_buffer_size(size :: integer) :: :ok
  defdelegate set_stream_buffer_size(size), to: NIF, as: :set_audio_stream_buffer_size_default

  @doc """
  Get audio stream time length (in seconds)
  """
  @doc group: :stream
  @spec get_stream_time_length(
          stream :: Zexray.Type.AudioStream.t_all(),
          frame_count :: non_neg_integer
        ) :: float
  defdelegate get_stream_time_length(
                stream,
                frame_count
              ),
              to: NIF,
              as: :get_audio_stream_time_length

  @doc """
  Get current audio stream time played (in seconds)
  """
  @doc group: :stream
  @spec get_stream_time_played(
          stream :: Zexray.Type.AudioStream.t_all(),
          frame_count :: non_neg_integer
        ) :: float
  defdelegate get_stream_time_played(
                stream,
                frame_count
              ),
              to: NIF,
              as: :get_audio_stream_time_played

  @doc """
  Get audio stream info
  """
  @doc group: :stream
  @spec get_stream_info(
          stream :: Zexray.Type.AudioStream.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.AudioInfo.t_nif()
  defdelegate get_stream_info(
                stream,
                return \\ :auto
              ),
              to: NIF,
              as: :get_audio_stream_info
end
