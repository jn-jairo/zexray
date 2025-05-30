defmodule Zexray.Type.TextureBase do
  @moduledoc false

  defmacro __using__(opts) do
    prefix = Keyword.fetch!(opts, :prefix)
    prefix_atom = String.to_atom(prefix)

    quote do
      @moduledoc """
      Texture data stored in GPU memory (VRAM)

      ## Fields

      |           |                             |
      | --------- | --------------------------- |
      | `id`      | OpenGL texture id           |
      | `width`   | Texture base width          |
      | `height`  | Texture base height         |
      | `mipmaps` | Mipmap levels, 1 by default |
      | `format`  | Data format                 |
      """

      require Record

      @type t ::
              record(:t,
                id: non_neg_integer,
                width: integer,
                height: integer,
                mipmaps: integer,
                format: Zexray.Enum.PixelFormat.t()
              )

      Record.defrecord(:t, unquote(prefix_atom),
        id: nil,
        width: 0,
        height: 0,
        mipmaps: 1,
        format: nil
      )

      use Zexray.Type.TypeBase, prefix: unquote(prefix)

      @type t_all ::
              Zexray.Type.Texture.t()
              | Zexray.Type.Texture.t_resource()
              | Zexray.Type.Texture2D.t()
              | Zexray.Type.Texture2D.t_resource()
              | Zexray.Type.TextureCubemap.t()
              | Zexray.Type.TextureCubemap.t_resource()
    end
  end
end

defmodule Zexray.Type.Texture do
  use Zexray.Type.TextureBase, prefix: "texture"
end
