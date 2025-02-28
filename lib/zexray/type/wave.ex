defmodule Zexray.Type.Wave do
  @moduledoc """
  Audio wave data

  ## Fields

  |               |                                                           |
  | ------------- | --------------------------------------------------------- |
  | `frame_count` | Total number of frames (considering channels)             |
  | `sample_rate` | Frequency (samples per second)                            |
  | `sample_size` | Bit depth (bits per sample): 8, 16, 32 (24 not supported) |
  | `channels`    | Number of channels (1-mono, 2-stereo, ...)                |
  | `data`        | Buffer data pointer                                       |
  """

  defstruct frame_count: 0,
            sample_rate: 0,
            sample_size: 8,
            channels: 1,
            data: nil

  use Zexray.Type.TypeBase, prefix: "wave"

  @type t ::
          %__MODULE__{
            frame_count: non_neg_integer,
            sample_rate: non_neg_integer,
            sample_size: non_neg_integer,
            channels: non_neg_integer,
            data: binary
          }

  @type t_all ::
          t
          | {
              non_neg_integer,
              non_neg_integer,
              non_neg_integer,
              non_neg_integer,
              binary
            }
          | map
          | keyword
          | Resource.t()

  @doc """
  Creates a new `t:t/0`.
  """
  def new(wave)

  @spec new({
          frame_count :: non_neg_integer,
          sample_rate :: non_neg_integer,
          sample_size :: non_neg_integer,
          channels :: non_neg_integer,
          data :: binary
        }) :: t()
  def new({
        frame_count,
        sample_rate,
        sample_size,
        channels,
        data
      })
      when is_integer(frame_count) and
             is_integer(sample_rate) and
             is_integer(sample_size) and
             is_integer(channels) and
             is_binary(data) do
    new(
      frame_count: frame_count,
      sample_rate: sample_rate,
      sample_size: sample_size,
      channels: channels,
      data: data
    )
  end

  @spec new(wave :: struct) :: t()
  def new(wave) when is_struct(wave) do
    wave =
      if String.ends_with?(Atom.to_string(wave.__struct__), ".Resource") do
        apply(wave.__struct__, :content, [wave])
      else
        wave
      end

    case wave do
      %__MODULE__{} = wave -> wave
      _ -> new(Map.from_struct(wave))
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
