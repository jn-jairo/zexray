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
  def with_audio(func)
      when is_function(func) do
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
  def init() do
    NIF.init_audio_device()
  end

  @doc """
  Close the audio device and context
  """
  @doc group: :device_management
  @spec close() :: :ok
  def close() do
    NIF.close_audio_device()
  end

  @doc """
  Check if audio device has been initialized successfully
  """
  @doc group: :device_management
  @spec ready?() :: boolean
  def ready?() do
    NIF.is_audio_device_ready()
  end

  @doc """
  Set master volume (listener)
  """
  @doc group: :device_management
  @spec set_master_volume(volume :: float) :: :ok
  def set_master_volume(volume)
      when is_float(volume) do
    NIF.set_master_volume(volume)
  end

  @doc """
  Get master volume (listener)
  """
  @doc group: :device_management
  @spec get_master_volume() :: float
  def get_master_volume() do
    NIF.get_master_volume()
  end

  ################
  #  Management  #
  ################

  @doc """
  Default size for new audio streams
  """
  @doc group: :management
  @spec set_buffer_size(size :: integer) :: :ok
  def set_buffer_size(size) when is_integer(size) do
    set_stream_buffer_size(size)
  end

  @doc """
  Play audio
  """
  @doc group: :management
  def play(audio, return \\ :value)

  @spec play(sound :: Zexray.Type.Sound.t_all(), return :: :value | :resource) ::
          Zexray.Type.Sound.t_nif()
  def play(sound, return)
      when (is_sound(sound) or is_sound_alias(sound)) and is_nif_return(return) do
    play_sound(sound, return)
  end

  @spec play(music :: Zexray.Type.Music.t_all(), return :: :value | :resource) ::
          Zexray.Type.Music.t_nif()
  def play(music, return) when is_music(music) and is_nif_return(return) do
    play_music(music, return)
  end

  @spec play(stream :: Zexray.Type.AudioStream.t_all(), return :: :value | :resource) ::
          Zexray.Type.AudioStream.t_nif()
  def play(stream, return) when is_audio_stream(stream) and is_nif_return(return) do
    play_stream(stream, return)
  end

  @doc """
  Stop audio
  """
  @doc group: :management
  def stop(audio, return \\ :value)

  @spec stop(sound :: Zexray.Type.Sound.t_all(), return :: :value | :resource) ::
          Zexray.Type.Sound.t_nif()
  def stop(sound, return)
      when (is_sound(sound) or is_sound_alias(sound)) and is_nif_return(return) do
    stop_sound(sound, return)
  end

  @spec stop(music :: Zexray.Type.Music.t_all(), return :: :value | :resource) ::
          Zexray.Type.Music.t_nif()
  def stop(music, return) when is_music(music) and is_nif_return(return) do
    stop_music(music, return)
  end

  @spec stop(stream :: Zexray.Type.AudioStream.t_all(), return :: :value | :resource) ::
          Zexray.Type.AudioStream.t_nif()
  def stop(stream, return) when is_audio_stream(stream) and is_nif_return(return) do
    stop_stream(stream, return)
  end

  @doc """
  Pause audio
  """
  @doc group: :management
  def pause(audio, return \\ :value)

  @spec pause(sound :: Zexray.Type.Sound.t_all(), return :: :value | :resource) ::
          Zexray.Type.Sound.t_nif()
  def pause(sound, return)
      when (is_sound(sound) or is_sound_alias(sound)) and is_nif_return(return) do
    pause_sound(sound, return)
  end

  @spec pause(music :: Zexray.Type.Music.t_all(), return :: :value | :resource) ::
          Zexray.Type.Music.t_nif()
  def pause(music, return) when is_music(music) and is_nif_return(return) do
    pause_music(music, return)
  end

  @spec pause(stream :: Zexray.Type.AudioStream.t_all(), return :: :value | :resource) ::
          Zexray.Type.AudioStream.t_nif()
  def pause(stream, return) when is_audio_stream(stream) and is_nif_return(return) do
    pause_stream(stream, return)
  end

  @doc """
  Resume audio
  """
  @doc group: :management
  def resume(audio, return \\ :value)

  @spec resume(sound :: Zexray.Type.Sound.t_all(), return :: :value | :resource) ::
          Zexray.Type.Sound.t_nif()
  def resume(sound, return)
      when (is_sound(sound) or is_sound_alias(sound)) and is_nif_return(return) do
    resume_sound(sound, return)
  end

  @spec resume(music :: Zexray.Type.Music.t_all(), return :: :value | :resource) ::
          Zexray.Type.Music.t_nif()
  def resume(music, return) when is_music(music) and is_nif_return(return) do
    resume_music(music, return)
  end

  @spec resume(stream :: Zexray.Type.AudioStream.t_all(), return :: :value | :resource) ::
          Zexray.Type.AudioStream.t_nif()
  def resume(stream, return) when is_audio_stream(stream) and is_nif_return(return) do
    resume_stream(stream, return)
  end

  @doc """
  Check if an audio is currently playing
  """
  @doc group: :management
  def playing?(audio)

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
  def set_volume(audio, volume, return \\ :value)

  @spec set_volume(
          sound :: Zexray.Type.Sound.t_all(),
          volume :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  def set_volume(sound, volume, return)
      when (is_sound(sound) or is_sound_alias(sound)) and is_float(volume) and
             is_nif_return(return) do
    set_sound_volume(sound, volume, return)
  end

  @spec set_volume(
          music :: Zexray.Type.Music.t_all(),
          volume :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def set_volume(music, volume, return)
      when is_music(music) and is_float(volume) and is_nif_return(return) do
    set_music_volume(music, volume, return)
  end

  @spec set_volume(
          stream :: Zexray.Type.AudioStream.t_all(),
          volume :: float,
          return :: :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  def set_volume(stream, volume, return)
      when is_audio_stream(stream) and is_float(volume) and is_nif_return(return) do
    set_stream_volume(stream, volume, return)
  end

  @doc """
  Set pitch for an audio (1.0 is base level)
  """
  @doc group: :management
  def set_pitch(audio, pitch, return \\ :value)

  @spec set_pitch(
          sound :: Zexray.Type.Sound.t_all(),
          pitch :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  def set_pitch(sound, pitch, return)
      when (is_sound(sound) or is_sound_alias(sound)) and is_float(pitch) and
             is_nif_return(return) do
    set_sound_pitch(sound, pitch, return)
  end

  @spec set_pitch(
          music :: Zexray.Type.Music.t_all(),
          pitch :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def set_pitch(music, pitch, return)
      when is_music(music) and is_float(pitch) and is_nif_return(return) do
    set_music_pitch(music, pitch, return)
  end

  @spec set_pitch(
          stream :: Zexray.Type.AudioStream.t_all(),
          pitch :: float,
          return :: :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  def set_pitch(stream, pitch, return)
      when is_audio_stream(stream) and is_float(pitch) and is_nif_return(return) do
    set_stream_pitch(stream, pitch, return)
  end

  @doc """
  Set pan for an audio (0.5 is center)
  """
  @doc group: :management
  def set_pan(audio, pan, return \\ :value)

  @spec set_pan(
          sound :: Zexray.Type.Sound.t_all(),
          pan :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  def set_pan(sound, pan, return)
      when (is_sound(sound) or is_sound_alias(sound)) and is_float(pan) and is_nif_return(return) do
    set_sound_pan(sound, pan, return)
  end

  @spec set_pan(
          music :: Zexray.Type.Music.t_all(),
          pan :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def set_pan(music, pan, return)
      when is_music(music) and is_float(pan) and is_nif_return(return) do
    set_music_pan(music, pan, return)
  end

  @spec set_pan(
          stream :: Zexray.Type.AudioStream.t_all(),
          pan :: float,
          return :: :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  def set_pan(stream, pan, return)
      when is_audio_stream(stream) and is_float(pan) and is_nif_return(return) do
    set_stream_pan(stream, pan, return)
  end

  @doc """
  Set looping for an audio
  """
  @doc group: :management
  def set_looping(audio, looping, return \\ :value)

  @spec set_looping(
          music :: Zexray.Type.Music.t_all(),
          looping :: boolean,
          return :: :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def set_looping(music, looping, return)
      when is_music(music) and is_boolean(looping) and is_nif_return(return) do
    set_music_looping(music, looping, return)
  end

  @doc """
  Get audio time length (in seconds)
  """
  @doc group: :management
  def get_time_length(audio)

  @spec get_time_length(sound :: Zexray.Type.Sound.t_all()) :: float
  def get_time_length(sound) when is_sound(sound) or is_sound_alias(sound) do
    get_sound_time_length(sound)
  end

  @spec get_time_length(music :: Zexray.Type.Music.t_all()) :: float
  def get_time_length(music) when is_music(music) do
    get_music_time_length(music)
  end

  @doc """
  Get current audio time played (in seconds)
  """
  @doc group: :management
  def get_time_played(audio)

  @spec get_time_played(music :: Zexray.Type.Music.t_all()) :: float
  def get_time_played(music) when is_music(music) do
    get_music_time_played(music)
  end

  @doc """
  Update audio buffer with new data
  """
  @doc group: :management
  def update(audio, data \\ nil, return \\ :value)

  def update(audio, return, _)
      when is_music(audio) and is_nif_return(return) do
    update(audio, nil, return)
  end

  @spec update(
          sound :: Zexray.Type.Sound.t_all(),
          data ::
            binary
            | [byte]
            | [integer]
            | [float],
          return :: :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  def update(sound, data, return)
      when (is_sound(sound) or is_sound_alias(sound)) and
             (is_binary(data) or
                (is_list(data) and
                   (data == [] or
                      is_float(hd(data)) or
                      is_integer(hd(data))))) and
             is_nif_return(return) do
    update_sound(sound, data, return)
  end

  @spec update(
          music :: Zexray.Type.Music.t_all(),
          data :: nil,
          return :: :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def update(
        music,
        nil,
        return
      )
      when is_music(music) and
             is_nif_return(return) do
    update_music(music, return)
  end

  @spec update(
          stream :: Zexray.Type.AudioStream.t_all(),
          data ::
            binary
            | [byte]
            | [integer]
            | [float],
          return :: :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  def update(stream, data, return)
      when is_audio_stream(stream) and
             (is_binary(data) or
                (is_list(data) and
                   (data == [] or
                      is_float(hd(data)) or
                      is_integer(hd(data))))) and
             is_nif_return(return) do
    update_stream(stream, data, return)
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
          return :: :value | :resource
        ) :: Zexray.Type.Wave.t_nif()
  def load_wave(
        file_name,
        return \\ :value
      )
      when is_binary(file_name) and
             is_nif_return(return) do
    NIF.load_wave(
      file_name,
      return
    )
    |> Zexray.Type.Wave.from_nif()
  end

  @doc """
  Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
  """
  @doc group: :sound
  @spec load_wave_from_memory(
          file_type :: binary,
          file_data :: binary,
          return :: :value | :resource
        ) :: Zexray.Type.Wave.t_nif()
  def load_wave_from_memory(
        file_type,
        file_data,
        return \\ :value
      )
      when is_binary(file_type) and
             is_binary(file_data) and
             is_nif_return(return) do
    NIF.load_wave_from_memory(
      file_type,
      file_data,
      return
    )
    |> Zexray.Type.Wave.from_nif()
  end

  @doc """
  Checks if wave data is valid (data loaded and parameters)
  """
  @doc group: :sound
  @spec wave_valid?(wave :: Zexray.Type.Wave.t_all()) :: boolean
  def wave_valid?(wave)
      when is_like_wave(wave) do
    NIF.is_wave_valid(wave |> Zexray.Type.Wave.to_nif())
  end

  @doc """
  Load sound from file
  """
  @doc group: :sound
  @spec load_sound(
          file_name :: binary,
          return :: :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  def load_sound(
        file_name,
        return \\ :value
      )
      when is_binary(file_name) and
             is_nif_return(return) do
    NIF.load_sound(
      file_name,
      return
    )
    |> Zexray.Type.Sound.from_nif()
  end

  @doc """
  Load sound from wave data
  """
  @doc group: :sound
  @spec load_sound_from_wave(
          wave :: Zexray.Type.Wave.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  def load_sound_from_wave(
        wave,
        return \\ :value
      )
      when is_like_wave(wave) and
             is_nif_return(return) do
    NIF.load_sound_from_wave(
      wave |> Zexray.Type.Wave.to_nif(),
      return
    )
    |> Zexray.Type.Sound.from_nif()
  end

  @doc """
  Create a new sound that shares the same sample data as the source sound, does not own the sound data
  """
  @doc group: :sound
  @spec load_sound_alias(
          source :: Zexray.Type.Sound.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.SoundAlias.t_nif()
  def load_sound_alias(
        source,
        return \\ :value
      )
      when is_like_sound(source) and
             is_nif_return(return) do
    NIF.load_sound_alias(
      source |> Zexray.Type.Sound.to_nif(),
      return
    )
    |> Zexray.Type.SoundAlias.from_nif()
  end

  @doc """
  Checks if a sound is valid (data loaded and buffers initialized)
  """
  @doc group: :sound
  @spec sound_valid?(sound :: Zexray.Type.Sound.t_all()) :: boolean
  def sound_valid?(sound)
      when is_like_sound(sound) do
    NIF.is_sound_valid(sound |> Zexray.Type.Sound.to_nif())
  end

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
          return :: :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  def update_sound(
        sound,
        data,
        return \\ :value
      )
      when is_like_sound(sound) and
             (is_binary(data) or
                (is_list(data) and
                   (data == [] or
                      is_float(hd(data)) or
                      is_integer(hd(data))))) and
             is_nif_return(return) do
    NIF.update_sound(
      sound |> Zexray.Type.Sound.to_nif(),
      data,
      return
    )
    |> Zexray.Type.Sound.from_nif()
  end

  @doc """
  Check if any audio stream buffers requires refill
  """
  @doc group: :sound
  @spec sound_processed?(sound :: Zexray.Type.Sound.t_all()) :: boolean
  def sound_processed?(sound)
      when is_like_sound(sound) do
    NIF.is_sound_processed(sound |> Zexray.Type.Sound.to_nif())
  end

  @doc """
  Export wave data to file, returns true on success
  """
  @doc group: :sound
  @spec export_wave(
          wave :: Zexray.Type.Wave.t_all(),
          file_name :: binary
        ) :: boolean
  def export_wave(
        wave,
        file_name
      )
      when is_like_wave(wave) and
             is_binary(file_name) do
    NIF.export_wave(
      wave |> Zexray.Type.Wave.to_nif(),
      file_name
    )
  end

  @doc """
  Play a sound
  """
  @doc group: :sound
  @spec play_sound(
          sound :: Zexray.Type.Sound.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  def play_sound(
        sound,
        return \\ :value
      )
      when is_like_sound(sound) and
             is_nif_return(return) do
    NIF.play_sound(
      sound |> Zexray.Type.Sound.to_nif(),
      return
    )
    |> Zexray.Type.Sound.from_nif()
  end

  @doc """
  Stop playing a sound
  """
  @doc group: :sound
  @spec stop_sound(
          sound :: Zexray.Type.Sound.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  def stop_sound(
        sound,
        return \\ :value
      )
      when is_like_sound(sound) and
             is_nif_return(return) do
    NIF.stop_sound(
      sound |> Zexray.Type.Sound.to_nif(),
      return
    )
    |> Zexray.Type.Sound.from_nif()
  end

  @doc """
  Pause a sound
  """
  @doc group: :sound
  @spec pause_sound(
          sound :: Zexray.Type.Sound.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  def pause_sound(
        sound,
        return \\ :value
      )
      when is_like_sound(sound) and
             is_nif_return(return) do
    NIF.pause_sound(
      sound |> Zexray.Type.Sound.to_nif(),
      return
    )
    |> Zexray.Type.Sound.from_nif()
  end

  @doc """
  Resume a paused sound
  """
  @doc group: :sound
  @spec resume_sound(
          sound :: Zexray.Type.Sound.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  def resume_sound(
        sound,
        return \\ :value
      )
      when is_like_sound(sound) and
             is_nif_return(return) do
    NIF.resume_sound(
      sound |> Zexray.Type.Sound.to_nif(),
      return
    )
    |> Zexray.Type.Sound.from_nif()
  end

  @doc """
  Check if a sound is currently playing
  """
  @doc group: :sound
  @spec sound_playing?(sound :: Zexray.Type.Sound.t_all()) :: boolean
  def sound_playing?(sound)
      when is_like_sound(sound) do
    NIF.is_sound_playing(sound |> Zexray.Type.Sound.to_nif())
  end

  @doc """
  Set volume for a sound (1.0 is max level)
  """
  @doc group: :sound
  @spec set_sound_volume(
          sound :: Zexray.Type.Sound.t_all(),
          volume :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  def set_sound_volume(
        sound,
        volume,
        return \\ :value
      )
      when is_like_sound(sound) and
             is_float(volume) and
             is_nif_return(return) do
    NIF.set_sound_volume(
      sound |> Zexray.Type.Sound.to_nif(),
      volume,
      return
    )
    |> Zexray.Type.Sound.from_nif()
  end

  @doc """
  Set pitch for a sound (1.0 is base level)
  """
  @doc group: :sound
  @spec set_sound_pitch(
          sound :: Zexray.Type.Sound.t_all(),
          pitch :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  def set_sound_pitch(
        sound,
        pitch,
        return \\ :value
      )
      when is_like_sound(sound) and
             is_float(pitch) and
             is_nif_return(return) do
    NIF.set_sound_pitch(
      sound |> Zexray.Type.Sound.to_nif(),
      pitch,
      return
    )
    |> Zexray.Type.Sound.from_nif()
  end

  @doc """
  Set pan for a sound (0.5 is center)
  """
  @doc group: :sound
  @spec set_sound_pan(
          sound :: Zexray.Type.Sound.t_all(),
          pan :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Sound.t_nif()
  def set_sound_pan(
        sound,
        pan,
        return \\ :value
      )
      when is_like_sound(sound) and
             is_float(pan) and
             is_nif_return(return) do
    NIF.set_sound_pan(
      sound |> Zexray.Type.Sound.to_nif(),
      pan,
      return
    )
    |> Zexray.Type.Sound.from_nif()
  end

  @doc """
  Get sound time length (in seconds)
  """
  @doc group: :sound
  @spec get_sound_time_length(sound :: Zexray.Type.Sound.t_all()) :: float
  def get_sound_time_length(sound)
      when is_like_sound(sound) do
    NIF.get_sound_time_length(sound |> Zexray.Type.Sound.to_nif())
  end

  @doc """
  Copy a wave to a new wave
  """
  @doc group: :sound
  @spec wave_copy(
          wave :: Zexray.Type.Wave.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Wave.t_nif()
  def wave_copy(
        wave,
        return \\ :value
      )
      when is_like_wave(wave) and
             is_nif_return(return) do
    NIF.wave_copy(
      wave |> Zexray.Type.Wave.to_nif(),
      return
    )
    |> Zexray.Type.Wave.from_nif()
  end

  @doc """
  Crop a wave to defined frames range
  """
  @doc group: :sound
  @spec wave_crop(
          wave :: Zexray.Type.Wave.t_all(),
          init_frame :: integer,
          final_frame :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Wave.t_nif()
  def wave_crop(
        wave,
        init_frame,
        final_frame,
        return \\ :value
      )
      when is_like_wave(wave) and
             is_integer(init_frame) and
             is_integer(final_frame) and
             is_nif_return(return) do
    NIF.wave_crop(
      wave |> Zexray.Type.Wave.to_nif(),
      init_frame,
      final_frame,
      return
    )
    |> Zexray.Type.Wave.from_nif()
  end

  @doc """
  Convert wave data to desired format
  """
  @doc group: :sound
  @spec wave_format(
          wave :: Zexray.Type.Wave.t_all(),
          sample_rate :: integer,
          sample_size :: integer,
          channels :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Wave.t_nif()
  def wave_format(
        wave,
        sample_rate,
        sample_size,
        channels,
        return \\ :value
      )
      when is_like_wave(wave) and
             is_integer(sample_rate) and
             is_integer(sample_size) and
             is_integer(channels) and
             is_nif_return(return) do
    NIF.wave_format(
      wave |> Zexray.Type.Wave.to_nif(),
      sample_rate,
      sample_size,
      channels,
      return
    )
    |> Zexray.Type.Wave.from_nif()
  end

  @doc """
  Load samples data from wave as a 32bit float data array
  """
  @doc group: :sound
  @spec load_wave_samples(wave :: Zexray.Type.Wave.t_all()) :: [float]
  def load_wave_samples(wave)
      when is_like_wave(wave) do
    NIF.load_wave_samples(wave |> Zexray.Type.Wave.to_nif())
  end

  @doc """
  Load samples data from wave
  """
  @doc group: :sound
  @spec load_wave_samples_raw(wave :: Zexray.Type.Wave.t_all()) ::
          binary | [byte] | [integer] | [float]
  def load_wave_samples_raw(wave)
      when is_like_wave(wave) do
    NIF.load_wave_samples_raw(wave |> Zexray.Type.Wave.to_nif())
  end

  @doc """
  Get wave data size in bytes
  """
  @doc group: :sound
  @spec get_wave_data_size(
          frame_count :: non_neg_integer,
          channels :: non_neg_integer,
          sample_size :: non_neg_integer
        ) :: non_neg_integer
  def get_wave_data_size(
        frame_count,
        channels,
        sample_size
      )
      when is_integer(frame_count) and
             is_integer(channels) and
             is_integer(sample_size) do
    NIF.get_wave_data_size(
      frame_count,
      channels,
      sample_size
    )
  end

  ###########
  #  Music  #
  ###########

  @doc """
  Load music stream from file
  """
  @doc group: :music
  @spec load_music(
          file_name :: binary,
          return :: :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def load_music(
        file_name,
        return \\ :value
      )
      when is_binary(file_name) and
             is_nif_return(return) do
    NIF.load_music_stream(
      file_name,
      return
    )
    |> Zexray.Type.Music.from_nif()
  end

  @doc """
  Load music stream from data
  """
  @doc group: :music
  @spec load_music_from_memory(
          file_type :: binary,
          file_data :: binary,
          return :: :value | :resource
        ) :: Zexray.Type.Wave.t_nif()
  def load_music_from_memory(
        file_type,
        file_data,
        return \\ :value
      )
      when is_binary(file_type) and
             is_binary(file_data) and
             is_nif_return(return) do
    NIF.load_music_stream_from_memory(
      file_type,
      file_data,
      return
    )
    |> Zexray.Type.Wave.from_nif()
  end

  @doc """
  Checks if a music stream is valid (context and buffers initialized)
  """
  @doc group: :music
  @spec music_valid?(music :: Zexray.Type.Music.t_all()) :: boolean
  def music_valid?(music)
      when is_like_music(music) do
    NIF.is_music_valid(music |> Zexray.Type.Music.to_nif())
  end

  @doc """
  Start music playing
  """
  @doc group: :music
  @spec play_music(
          music :: Zexray.Type.Music.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def play_music(
        music,
        return \\ :value
      )
      when is_like_music(music) and
             is_nif_return(return) do
    NIF.play_music_stream(
      music |> Zexray.Type.Music.to_nif(),
      return
    )
    |> Zexray.Type.Music.from_nif()
  end

  @doc """
  Check if music is playing
  """
  @doc group: :music
  @spec music_playing?(music :: Zexray.Type.Music.t_all()) :: boolean
  def music_playing?(music)
      when is_like_music(music) do
    NIF.is_music_stream_playing(music |> Zexray.Type.Music.to_nif())
  end

  @doc """
  Updates buffers for music streaming
  """
  @doc group: :music
  @spec update_music(
          music :: Zexray.Type.Music.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def update_music(
        music,
        return \\ :value
      )
      when is_like_music(music) and
             is_nif_return(return) do
    NIF.update_music_stream(
      music |> Zexray.Type.Music.to_nif(),
      return
    )
    |> Zexray.Type.Music.from_nif()
  end

  @doc """
  Check if any audio stream buffers requires refill
  """
  @doc group: :music
  @spec music_processed?(music :: Zexray.Type.Music.t_all()) :: boolean
  def music_processed?(music)
      when is_like_music(music) do
    NIF.is_music_stream_processed(music |> Zexray.Type.Music.to_nif())
  end

  @doc """
  Stop music playing
  """
  @doc group: :music
  @spec stop_music(
          music :: Zexray.Type.Music.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def stop_music(
        music,
        return \\ :value
      )
      when is_like_music(music) and
             is_nif_return(return) do
    NIF.stop_music_stream(
      music |> Zexray.Type.Music.to_nif(),
      return
    )
    |> Zexray.Type.Music.from_nif()
  end

  @doc """
  Pause music playing
  """
  @doc group: :music
  @spec pause_music(
          music :: Zexray.Type.Music.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def pause_music(
        music,
        return \\ :value
      )
      when is_like_music(music) and
             is_nif_return(return) do
    NIF.pause_music_stream(
      music |> Zexray.Type.Music.to_nif(),
      return
    )
    |> Zexray.Type.Music.from_nif()
  end

  @doc """
  Resume playing paused music
  """
  @doc group: :music
  @spec resume_music(
          music :: Zexray.Type.Music.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def resume_music(
        music,
        return \\ :value
      )
      when is_like_music(music) and
             is_nif_return(return) do
    NIF.resume_music_stream(
      music |> Zexray.Type.Music.to_nif(),
      return
    )
    |> Zexray.Type.Music.from_nif()
  end

  @doc """
  Seek music to a position (in seconds)
  """
  @doc group: :music
  @spec seek_music(
          music :: Zexray.Type.Music.t_all(),
          position :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def seek_music(
        music,
        position,
        return \\ :value
      )
      when is_like_music(music) and
             is_float(position) and
             is_nif_return(return) do
    NIF.seek_music_stream(
      music |> Zexray.Type.Music.to_nif(),
      position,
      return
    )
    |> Zexray.Type.Music.from_nif()
  end

  @doc """
  Set volume for music (1.0 is max level)
  """
  @doc group: :music
  @spec set_music_volume(
          music :: Zexray.Type.Music.t_all(),
          volume :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def set_music_volume(
        music,
        volume,
        return \\ :value
      )
      when is_like_music(music) and
             is_float(volume) and
             is_nif_return(return) do
    NIF.set_music_volume(
      music |> Zexray.Type.Music.to_nif(),
      volume,
      return
    )
    |> Zexray.Type.Music.from_nif()
  end

  @doc """
  Set pitch for a music (1.0 is base level)
  """
  @doc group: :music
  @spec set_music_pitch(
          music :: Zexray.Type.Music.t_all(),
          pitch :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def set_music_pitch(
        music,
        pitch,
        return \\ :value
      )
      when is_like_music(music) and
             is_float(pitch) and
             is_nif_return(return) do
    NIF.set_music_pitch(
      music |> Zexray.Type.Music.to_nif(),
      pitch,
      return
    )
    |> Zexray.Type.Music.from_nif()
  end

  @doc """
  Set pan for a music (0.5 is center)
  """
  @doc group: :music
  @spec set_music_pan(
          music :: Zexray.Type.Music.t_all(),
          pan :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def set_music_pan(
        music,
        pan,
        return \\ :value
      )
      when is_like_music(music) and
             is_float(pan) and
             is_nif_return(return) do
    NIF.set_music_pan(
      music |> Zexray.Type.Music.to_nif(),
      pan,
      return
    )
    |> Zexray.Type.Music.from_nif()
  end

  @doc """
  Set looping for a music
  """
  @doc group: :music
  @spec set_music_looping(
          music :: Zexray.Type.Music.t_all(),
          looping :: boolean,
          return :: :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def set_music_looping(
        music,
        looping,
        return \\ :value
      )
      when is_like_music(music) and
             is_boolean(looping) and
             is_nif_return(return) do
    NIF.set_music_looping(
      music |> Zexray.Type.Music.to_nif(),
      looping,
      return
    )
    |> Zexray.Type.Music.from_nif()
  end

  @doc """
  Get music time length (in seconds)
  """
  @doc group: :music
  @spec get_music_time_length(music :: Zexray.Type.Music.t_all()) :: float
  def get_music_time_length(music)
      when is_like_music(music) do
    NIF.get_music_time_length(music |> Zexray.Type.Music.to_nif())
  end

  @doc """
  Get current music time played (in seconds)
  """
  @doc group: :music
  @spec get_music_time_played(music :: Zexray.Type.Music.t_all()) :: float
  def get_music_time_played(music)
      when is_like_music(music) do
    NIF.get_music_time_played(music |> Zexray.Type.Music.to_nif())
  end

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
          return :: :value | :resource
        ) :: Zexray.Type.Music.t_nif()
  def load_stream(
        sample_rate,
        sample_size,
        channels,
        return \\ :value
      )
      when is_non_neg_integer(sample_rate) and
             is_non_neg_integer(sample_size) and
             is_non_neg_integer(channels) and
             is_nif_return(return) do
    NIF.load_audio_stream(
      sample_rate,
      sample_size,
      channels,
      return
    )
    |> Zexray.Type.Music.from_nif()
  end

  @doc """
  Checks if an audio stream is valid (buffers initialized)
  """
  @doc group: :stream
  @spec stream_valid?(stream :: Zexray.Type.AudioStream.t_all()) :: boolean
  def stream_valid?(stream)
      when is_like_audio_stream(stream) do
    NIF.is_audio_stream_valid(stream |> Zexray.Type.AudioStream.to_nif())
  end

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
          return :: :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  def update_stream(
        stream,
        data,
        return \\ :value
      )
      when is_like_audio_stream(stream) and
             (is_binary(data) or
                (is_list(data) and
                   (data == [] or
                      is_float(hd(data)) or
                      is_integer(hd(data))))) and
             is_nif_return(return) do
    NIF.update_audio_stream(
      stream |> Zexray.Type.AudioStream.to_nif(),
      data,
      return
    )
    |> Zexray.Type.AudioStream.from_nif()
  end

  @doc """
  Check if any audio stream buffers requires refill
  """
  @doc group: :stream
  @spec stream_processed?(stream :: Zexray.Type.AudioStream.t_all()) :: boolean
  def stream_processed?(stream)
      when is_like_audio_stream(stream) do
    NIF.is_audio_stream_processed(stream |> Zexray.Type.AudioStream.to_nif())
  end

  @doc """
  Play audio stream
  """
  @doc group: :stream
  @spec play_stream(
          stream :: Zexray.Type.AudioStream.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  def play_stream(
        stream,
        return \\ :value
      )
      when is_like_audio_stream(stream) and
             is_nif_return(return) do
    NIF.play_audio_stream(
      stream |> Zexray.Type.AudioStream.to_nif(),
      return
    )
    |> Zexray.Type.AudioStream.from_nif()
  end

  @doc """
  Pause audio stream
  """
  @doc group: :stream
  @spec pause_stream(
          stream :: Zexray.Type.AudioStream.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  def pause_stream(
        stream,
        return \\ :value
      )
      when is_like_audio_stream(stream) and
             is_nif_return(return) do
    NIF.pause_audio_stream(
      stream |> Zexray.Type.AudioStream.to_nif(),
      return
    )
    |> Zexray.Type.AudioStream.from_nif()
  end

  @doc """
  Resume audio stream
  """
  @doc group: :stream
  @spec resume_stream(
          stream :: Zexray.Type.AudioStream.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  def resume_stream(
        stream,
        return \\ :value
      )
      when is_like_audio_stream(stream) and
             is_nif_return(return) do
    NIF.resume_audio_stream(
      stream |> Zexray.Type.AudioStream.to_nif(),
      return
    )
    |> Zexray.Type.AudioStream.from_nif()
  end

  @doc """
  Check if audio stream is playing
  """
  @doc group: :stream
  @spec stream_playing?(stream :: Zexray.Type.AudioStream.t_all()) :: boolean
  def stream_playing?(stream)
      when is_like_audio_stream(stream) do
    NIF.is_audio_stream_playing(stream |> Zexray.Type.AudioStream.to_nif())
  end

  @doc """
  Stop audio stream
  """
  @doc group: :stream
  @spec stop_stream(
          stream :: Zexray.Type.AudioStream.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  def stop_stream(
        stream,
        return \\ :value
      )
      when is_like_audio_stream(stream) and
             is_nif_return(return) do
    NIF.stop_audio_stream(
      stream |> Zexray.Type.AudioStream.to_nif(),
      return
    )
    |> Zexray.Type.AudioStream.from_nif()
  end

  @doc """
  Set volume for audio stream (1.0 is max level)
  """
  @doc group: :stream
  @spec set_stream_volume(
          stream :: Zexray.Type.AudioStream.t_all(),
          volume :: float,
          return :: :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  def set_stream_volume(
        stream,
        volume,
        return \\ :value
      )
      when is_like_audio_stream(stream) and
             is_float(volume) and
             is_nif_return(return) do
    NIF.set_audio_stream_volume(
      stream |> Zexray.Type.AudioStream.to_nif(),
      volume,
      return
    )
    |> Zexray.Type.AudioStream.from_nif()
  end

  @doc """
  Set pitch for audio stream (1.0 is base level)
  """
  @doc group: :stream
  @spec set_stream_pitch(
          stream :: Zexray.Type.AudioStream.t_all(),
          pitch :: float,
          return :: :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  def set_stream_pitch(
        stream,
        pitch,
        return \\ :value
      )
      when is_like_audio_stream(stream) and
             is_float(pitch) and
             is_nif_return(return) do
    NIF.set_audio_stream_pitch(
      stream |> Zexray.Type.AudioStream.to_nif(),
      pitch,
      return
    )
    |> Zexray.Type.AudioStream.from_nif()
  end

  @doc """
  Set pan for audio stream (0.5 is centered)
  """
  @doc group: :stream
  @spec set_stream_pan(
          stream :: Zexray.Type.AudioStream.t_all(),
          pan :: float,
          return :: :value | :resource
        ) :: Zexray.Type.AudioStream.t_nif()
  def set_stream_pan(
        stream,
        pan,
        return \\ :value
      )
      when is_like_audio_stream(stream) and
             is_float(pan) and
             is_nif_return(return) do
    NIF.set_audio_stream_pan(
      stream |> Zexray.Type.AudioStream.to_nif(),
      pan,
      return
    )
    |> Zexray.Type.AudioStream.from_nif()
  end

  @doc """
  Default size for new audio streams
  """
  @doc group: :stream
  @spec set_stream_buffer_size(size :: integer) :: :ok
  def set_stream_buffer_size(size)
      when is_integer(size) do
    NIF.set_audio_stream_buffer_size_default(size)
  end
end
