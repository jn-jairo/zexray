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

  require Record

  @type t ::
          record(:t,
            frame_count: non_neg_integer,
            sample_rate: non_neg_integer,
            sample_size: non_neg_integer,
            channels: non_neg_integer,
            data: binary
          )

  Record.defrecord(:t, :wave,
    frame_count: 0,
    sample_rate: 0,
    sample_size: 8,
    channels: 1,
    data: <<>>
  )

  use Zexray.Type.TypeBase, prefix: "wave"

  @type t_all :: t | t_resource
end
