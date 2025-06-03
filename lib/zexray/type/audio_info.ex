defmodule Zexray.Type.AudioInfo do
  @moduledoc """
  Audio info

  ## Fields

  |               |                                                           |
  | ------------- | --------------------------------------------------------- |
  | `frame_count` | Total number of frames (considering channels)             |
  | `sample_rate` | Frequency (samples per second)                            |
  | `sample_size` | Bit depth (bits per sample): 8, 16, 32 (24 not supported) |
  | `channels`    | Number of channels (1-mono, 2-stereo, ...)                |
  """

  require Record

  @type t ::
          record(:t,
            frame_count: non_neg_integer,
            sample_rate: non_neg_integer,
            sample_size: non_neg_integer,
            channels: non_neg_integer
          )

  Record.defrecord(:t, :audio_info,
    frame_count: 0,
    sample_rate: 0,
    sample_size: 8,
    channels: 1
  )

  use Zexray.Type.TypeBase, prefix: "audio_info"

  @type t_all :: t | t_resource
end
