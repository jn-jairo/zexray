defmodule Zexray.Type.SoundStreamBase do
  @moduledoc false

  defmacro __using__(opts) do
    prefix = Keyword.fetch!(opts, :prefix)
    prefix_atom = String.to_atom(prefix)

    quote do
      @moduledoc """
      SoundStream

      ## Fields

      |                  |                                               |
      | ---------------- | --------------------------------------------- |
      | `stream`         | Audio stream                                  |
      | `frame_count`    | Total number of frames (considering channels) |
      | `looping`        | Audio looping enable                          |
      | `position`       | Audio 3D position                             |
      | `position_state` | Audio 3D position state                       |
      | `data`           | Buffer data pointer                           |
      """

      require Record

      require Zexray.Type.AudioStream

      @type t ::
              record(:t,
                stream: Zexray.Type.AudioStream.t_nif(),
                frame_count: non_neg_integer,
                looping: boolean,
                position: nil | Zexray.Type.Vector3.t_nif(),
                position_state: [float],
                data: binary
              )

      Record.defrecord(:t, unquote(prefix_atom),
        stream: Zexray.Type.AudioStream.t(),
        frame_count: 0,
        looping: false,
        position: nil,
        position_state: [],
        data: <<>>
      )

      use Zexray.Type.TypeBase, prefix: unquote(prefix)

      @type t_all ::
              Zexray.Type.SoundStream.t()
              | Zexray.Type.SoundStream.t_resource()
              | Zexray.Type.SoundStreamAlias.t()
              | Zexray.Type.SoundStreamAlias.t_resource()
    end
  end
end

defmodule Zexray.Type.SoundStream do
  use Zexray.Type.SoundStreamBase, prefix: "sound_stream"
end
