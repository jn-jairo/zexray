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

  require Record

  @type t ::
          record(:t,
            buffer: tuple | nil,
            processor: tuple | nil,
            sample_rate: non_neg_integer,
            sample_size: non_neg_integer,
            channels: non_neg_integer
          )

  Record.defrecord(:t, :audio_stream,
    buffer: nil,
    processor: nil,
    sample_rate: 0,
    sample_size: 8,
    channels: 1
  )

  use Zexray.Type.TypeBase, prefix: "audio_stream"

  @type t_all :: t | t_resource
end
