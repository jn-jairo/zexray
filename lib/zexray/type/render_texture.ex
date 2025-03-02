defmodule Zexray.Type.RenderTextureBase do
  @moduledoc false

  defmacro __using__(opts) do
    prefix = Keyword.fetch!(opts, :prefix)

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

      defstruct id: nil,
                texture: nil,
                depth: nil

      use Zexray.Type.TypeBase, prefix: unquote(prefix)

      @type t ::
              %__MODULE__{
                id: non_neg_integer,
                texture: Zexray.Type.Texture.t_nif(),
                depth: Zexray.Type.Texture.t_nif()
              }

      @type t_all ::
              Zexray.Type.RenderTexture.t()
              | Zexray.Type.RenderTexture2D.t()
              | {
                  non_neg_integer,
                  Zexray.Type.Texture.t_all(),
                  Zexray.Type.Texture.t_all()
                }
              | map
              | keyword
              | Zexray.Type.RenderTexture.Resource.t()
              | Zexray.Type.RenderTexture2D.Resource.t()

      import Zexray.Guard

      @doc """
      Creates a new `t:t/0`.
      """
      def new(render_texture)

      @spec new({
              id :: non_neg_integer,
              texture :: Zexray.Type.Texture.t_all(),
              depth :: Zexray.Type.Texture.t_all()
            }) :: t()
      def new({
            id,
            texture,
            depth
          })
          when is_integer(id) and
                 is_like_texture(texture) and
                 is_like_texture(depth) do
        new(
          id: id,
          texture: texture,
          depth: depth
        )
      end

      @spec new(render_texture :: struct) :: t()
      def new(render_texture) when is_struct(render_texture) do
        render_texture =
          if String.ends_with?(Atom.to_string(render_texture.__struct__), ".Resource") do
            apply(render_texture.__struct__, :content, [render_texture])
          else
            render_texture
          end

        case render_texture do
          %__MODULE__{} = render_texture -> render_texture
          _ -> new(Map.from_struct(render_texture))
        end
      end

      @spec new(fields :: Enumerable.t()) :: t()
      def new(fields) do
        if Enumerable.impl_for(fields) != nil do
          struct!(
            __MODULE__,
            fields
            |> Enum.map(fn {key, value} ->
              value =
                cond do
                  is_nil(value) ->
                    value

                  key in [:texture, :depth] ->
                    cond do
                      is_struct(value, Zexray.Type.Texture.Resource) -> value
                      is_reference(value) -> Zexray.Type.Texture.Resource.new(value)
                      true -> Zexray.Type.Texture.new(value)
                    end

                  true ->
                    value
                end

              {key, value}
            end)
          )
        else
          raise_argument_error(fields)
        end
      end
    end
  end
end

defmodule Zexray.Type.RenderTexture do
  use Zexray.Type.RenderTextureBase, prefix: "render_texture"
end
