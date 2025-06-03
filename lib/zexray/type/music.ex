defmodule Zexray.Type.Music do
  @moduledoc """
  Audio stream, anything longer than ~10 seconds should be streamed

  ## Fields

  |               |                                               |
  | ------------- | --------------------------------------------- |
  | `stream`      | Audio stream                                  |
  | `frame_count` | Total number of frames (considering channels) |
  | `looping`     | Music looping enable                          |
  | `ctx_type`    | Type of music context (audio filetype)        |
  | `ctx_data`    | Audio context data, depends on type           |
  """

  require Record

  @type t ::
          record(:t,
            stream: Zexray.Type.AudioStream.t_nif(),
            frame_count: non_neg_integer,
            looping: boolean,
            ctx_type: integer,
            ctx_data: reference | nil
          )

  Record.defrecord(:t, :music,
    stream: nil,
    frame_count: 0,
    looping: true,
    ctx_type: 0,
    ctx_data: nil
  )

  use Zexray.Type.TypeBase, prefix: "music"

  @type t_all :: t | t_resource
end
