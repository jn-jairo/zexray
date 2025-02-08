defmodule Zexray.Type.GlyphInfo do
  @moduledoc """
  Font characters glyphs info

  ## Fields

  |             |                                 |
  | ----------- | ------------------------------- |
  | `value`     | Character value (Unicode)       |
  | `offset_x`  | Character offset X when drawing |
  | `offset_y`  | Character offset Y when drawing |
  | `advance_x` | Character advance position X    |
  | `image`     | Character image data            |
  """

  defstruct value: nil,
            offset_x: 0,
            offset_y: 0,
            advance_x: 0,
            image: nil

  use Zexray.Type.TypeBase, prefix: "glyph_info"

  @type t ::
          %__MODULE__{
            value: integer,
            offset_x: integer,
            offset_y: integer,
            advance_x: integer,
            image: Zexray.Type.Image.t_nif()
          }

  @type t_all ::
          t
          | {
              integer,
              integer,
              integer,
              integer,
              Zexray.Type.Image.t_all()
            }
          | map
          | keyword
          | Resource.t()

  import Zexray.Guard

  @doc """
  Creates a new `t:t/0`.
  """
  def new(glyph_info)

  @spec new({
          value :: integer,
          offset_x :: integer,
          offset_y :: integer,
          advance_x :: integer,
          image :: Zexray.Type.Image.t_all()
        }) :: t()
  def new({value, offset_x, offset_y, advance_x, image})
      when is_integer(value) and
             is_integer(offset_x) and
             is_integer(offset_y) and
             is_integer(advance_x) and
             is_image_like(image) do
    new(
      value: value,
      offset_x: offset_x,
      offset_y: offset_y,
      advance_x: advance_x,
      image: image
    )
  end

  @spec new(glyph_info :: struct) :: t()
  def new(glyph_info) when is_struct(glyph_info) do
    glyph_info =
      if String.ends_with?(Atom.to_string(glyph_info.__struct__), ".Resource") do
        apply(glyph_info.__struct__, :content, [glyph_info])
      else
        glyph_info
      end

    case glyph_info do
      %__MODULE__{} = glyph_info -> glyph_info
      _ -> new(Map.from_struct(glyph_info))
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
            key == :image and is_struct(value, Zexray.Type.Image.Resource) ->
              {key, value}

            key == :image and not is_nil(value) ->
              {key, Zexray.Type.Image.new(value)}

            true ->
              {key, value}
          end
        end)
      )
    else
      raise ArgumentError, "Invalid glyph info: #{inspect(fields)}"
    end
  end
end
