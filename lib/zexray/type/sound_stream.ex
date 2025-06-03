defmodule Zexray.Type.SoundStreamBase do
  @moduledoc false

  defmacro __using__(opts) do
    prefix = Keyword.fetch!(opts, :prefix)
    prefix_atom = String.to_atom(prefix)

    quote do
      @moduledoc """
      SoundStream

      ## Fields

      |               |                                               |
      | ------------- | --------------------------------------------- |
      | `stream`      | Audio stream                                  |
      | `frame_count` | Total number of frames (considering channels) |
      | `looping`     | Audio looping enable                          |
      | `data`        | Buffer data pointer                           |
      """

      require Record

      @type t ::
              record(:t,
                stream: Zexray.Type.AudioStream.t_nif(),
                frame_count: non_neg_integer,
                looping: boolean,
                data: binary
              )

      Record.defrecord(:t, unquote(prefix_atom),
        stream: nil,
        frame_count: 0,
        looping: false,
        data: nil
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
