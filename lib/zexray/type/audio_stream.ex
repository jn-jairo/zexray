defmodule Zexray.Type.AudioStream do
  @moduledoc """
  Custom audio stream

  ## Fields

  |               |                                                              |
  | ------------- | ------------------------------------------------------------ |
  | `buffer`      | Pointer to internal data used by the audio system            |
  | `processor`   | Pointer to internal data processor, useful for audio effects |
  | `sample_rate` | Frequency (samples per second)                               |
  | `sample_size` | Bit depth (bits per sample): 8, 16, 32 (24 not supported)    |
  | `channels`    | Number of channels (1-mono, 2-stereo, ...)                   |
  """

  defstruct buffer: nil,
            processor: nil,
            sample_rate: 0,
            sample_size: 8,
            channels: 1

  use Zexray.Type.TypeBase, prefix: "audio_stream"

  @type t ::
          %__MODULE__{
            buffer: reference | nil,
            processor: reference | nil,
            sample_rate: non_neg_integer,
            sample_size: non_neg_integer,
            channels: non_neg_integer
          }

  @type t_all ::
          t
          | {
              reference | nil,
              reference | nil,
              non_neg_integer,
              non_neg_integer,
              non_neg_integer
            }
          | map
          | keyword
          | Resource.t()

  @doc """
  Creates a new `t:t/0`.
  """
  def new(audio_stream)

  @spec new({
          buffer :: reference | nil,
          processor :: reference | nil,
          sample_rate :: non_neg_integer,
          sample_size :: non_neg_integer,
          channels :: non_neg_integer
        }) :: t()
  def new({
        buffer,
        processor,
        sample_rate,
        sample_size,
        channels
      })
      when (is_reference(buffer) or is_nil(buffer)) and
             (is_reference(processor) or is_nil(processor)) and
             is_integer(sample_rate) and
             is_integer(sample_size) and
             is_integer(channels) do
    new(
      buffer: buffer,
      processor: processor,
      sample_rate: sample_rate,
      sample_size: sample_size,
      channels: channels
    )
  end

  @spec new(audio_stream :: struct) :: t()
  def new(audio_stream) when is_struct(audio_stream) do
    audio_stream =
      if String.ends_with?(Atom.to_string(audio_stream.__struct__), ".Resource") do
        apply(audio_stream.__struct__, :content, [audio_stream])
      else
        audio_stream
      end

    case audio_stream do
      %__MODULE__{} = audio_stream -> audio_stream
      _ -> new(Map.from_struct(audio_stream))
    end
  end

  @spec new(fields :: Enumerable.t()) :: t()
  def new(fields) do
    if Enumerable.impl_for(fields) != nil do
      struct!(
        __MODULE__,
        fields
      )
    else
      raise_argument_error(fields)
    end
  end
end
