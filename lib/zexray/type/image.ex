defmodule Zexray.Type.Image do
  @moduledoc """
  Pixel data stored in CPU memory (RAM)

  ## Fields

  |           |                             |
  | --------- | --------------------------- |
  | `data`    | Image raw data              |
  | `width`   | Image base width            |
  | `height`  | Image base height           |
  | `mipmaps` | Mipmap levels, 1 by default |
  | `format`  | Data format                 |
  """

  defstruct data: nil,
            width: 0,
            height: 0,
            mipmaps: 1,
            format: nil

  use Zexray.Type.TypeBase, prefix: "image"

  @type t ::
          %__MODULE__{
            data: binary,
            width: integer,
            height: integer,
            mipmaps: integer,
            format: Zexray.Enum.PixelFormat.t()
          }

  @type t_all ::
          t
          | {
              binary,
              integer,
              integer,
              integer,
              Zexray.Enum.PixelFormat.t_all()
            }
          | map
          | keyword
          | Resource.t()

  import Zexray.Guard

  @doc """
  Creates a new `t:t/0`.
  """
  def new(image)

  @spec new({
          data :: binary,
          width :: integer,
          height :: integer,
          mipmaps :: integer,
          format :: Zexray.Enum.PixelFormat.t_all()
        }) :: t()
  def new({data, width, height, mipmaps, format})
      when is_binary(data) and
             is_integer(width) and
             is_integer(height) and
             is_integer(mipmaps) and
             is_pixel_format_like(format) do
    new(
      data: data,
      width: width,
      height: height,
      mipmaps: mipmaps,
      format: format
    )
  end

  @spec new(image :: struct) :: t()
  def new(image) when is_struct(image) do
    image =
      if String.ends_with?(Atom.to_string(image.__struct__), ".Resource") do
        apply(image.__struct__, :content, [image])
      else
        image
      end

    case image do
      %__MODULE__{} = image -> image
      _ -> new(Map.from_struct(image))
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
              is_nil(value) -> value
              key == :format and value != 0 -> Zexray.Enum.PixelFormat.value(value)
              true -> value
            end

          {key, value}
        end)
      )
    else
      raise_argument_error(fields)
    end
  end
end
