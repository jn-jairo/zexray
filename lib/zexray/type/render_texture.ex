defmodule Zexray.Type.RenderTextureBase do
  @moduledoc false

  defmacro __using__(opts) do
    prefix = Keyword.fetch!(opts, :prefix)
    prefix_atom = String.to_atom(prefix)

    quote do
      @moduledoc """
      fbo for texture rendering

      ## Fields

      |           |                                 |
      | --------- | ------------------------------- |
      | `id`      | OpenGL framebuffer object id    |
      | `texture` | Color buffer attachment texture |
      | `depth`   | Depth buffer attachment texture |
      """

      require Record

      @type t ::
              record(:t,
                id: non_neg_integer,
                texture: Zexray.Type.Texture.t_nif(),
                depth: Zexray.Type.Texture.t_nif()
              )

      Record.defrecord(:t, unquote(prefix_atom),
        id: nil,
        texture: nil,
        depth: nil
      )

      use Zexray.Type.TypeBase, prefix: unquote(prefix)

      @type t_all ::
              Zexray.Type.RenderTexture.t()
              | Zexray.Type.RenderTexture.t_resource()
              | Zexray.Type.RenderTexture2D.t()
              | Zexray.Type.RenderTexture2D.t_resource()
    end
  end
end

defmodule Zexray.Type.RenderTexture do
  use Zexray.Type.RenderTextureBase, prefix: "render_texture"
end
