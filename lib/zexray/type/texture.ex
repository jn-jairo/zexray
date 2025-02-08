defmodule Zexray.Type.TextureBase do
  @moduledoc false

  defmacro __using__(opts) do
    prefix = Keyword.fetch!(opts, :prefix)
    name = String.replace(prefix, "_", " ")

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

      defstruct id: nil,
                width: 0,
                height: 0,
                mipmaps: 1,
                format: nil

      use Zexray.Type.TypeBase, prefix: unquote(prefix)

      @type t ::
              %__MODULE__{
                id: non_neg_integer,
                width: integer,
                height: integer,
                mipmaps: integer,
                format: Zexray.Enum.PixelFormat.t()
              }

      @type t_all ::
              Zexray.Type.Texture.t()
              | Zexray.Type.Texture2D.t()
              | Zexray.Type.TextureCubemap.t()
              | {
                  non_neg_integer,
                  integer,
                  integer,
                  integer,
                  Zexray.Enum.PixelFormat.t_all()
                }
              | map
              | keyword
              | Zexray.Type.Texture.Resource.t()
              | Zexray.Type.Texture2D.Resource.t()
              | Zexray.Type.TextureCubemap.Resource.t()

      import Zexray.Guard

      @doc """
      Creates a new `t:t/0`.
      """
      def new(texture)

      @spec new({
              id :: non_neg_integer,
              width :: integer,
              height :: integer,
              mipmaps :: integer,
              format :: Zexray.Enum.PixelFormat.t_all()
            }) :: t()
      def new({id, width, height, mipmaps, format})
          when is_integer(id) and
                 is_integer(width) and
                 is_integer(height) and
                 is_integer(mipmaps) and
                 is_pixel_format_like(format) do
        new(
          id: id,
          width: width,
          height: height,
          mipmaps: mipmaps,
          format: format
        )
      end

      @spec new(texture :: struct) :: t()
      def new(texture) when is_struct(texture) do
        texture =
          if String.ends_with?(Atom.to_string(texture.__struct__), ".Resource") do
            apply(texture.__struct__, :content, [texture])
          else
            texture
          end

        case texture do
          %__MODULE__{} = texture -> texture
          _ -> new(Map.from_struct(texture))
        end
      end

      @spec new(fields :: Enumerable.t()) :: t()
      def new(fields) do
        if Enumerable.impl_for(fields) != nil do
          struct!(
            __MODULE__,
            fields
            |> Enum.map(fn {key, value} ->
              cond do
                key == :format and not is_nil(value) and value != 0 ->
                  {key, Zexray.Enum.PixelFormat.value(value)}

                true ->
                  {key, value}
              end
            end)
          )
        else
          raise ArgumentError, "Invalid #{unquote(name)}: #{inspect(fields)}"
        end
      end
    end
  end
end

defmodule Zexray.Type.Texture do
  use Zexray.Type.TextureBase, prefix: "texture"
end
