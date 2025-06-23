defmodule Zexray.Type.SoundBase do
  @moduledoc false

  defmacro __using__(opts) do
    prefix = Keyword.fetch!(opts, :prefix)
    prefix_atom = String.to_atom(prefix)

    quote do
      @moduledoc """
      Sound

      ## Fields

      |               |                                               |
      | ------------- | --------------------------------------------- |
      | `stream`      | Audio stream                                  |
      | `frame_count` | Total number of frames (considering channels) |
      """

      require Record

      require Zexray.Type.AudioStream

      @type t ::
              record(:t,
                stream: Zexray.Type.AudioStream.t_nif(),
                frame_count: non_neg_integer
              )

      Record.defrecord(:t, unquote(prefix_atom),
        stream: Zexray.Type.AudioStream.t(),
        frame_count: 0
      )

      use Zexray.Type.TypeBase, prefix: unquote(prefix)

      @type t_all ::
              Zexray.Type.Sound.t()
              | Zexray.Type.Sound.t_resource()
              | Zexray.Type.SoundAlias.t()
              | Zexray.Type.SoundAlias.t_resource()
    end
  end
end

defmodule Zexray.Type.Sound do
  use Zexray.Type.SoundBase, prefix: "sound"
end
