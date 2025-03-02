defmodule Zexray.Type.Font do
  @moduledoc """
  Font texture and GlyphInfo array data

  ## Fields

  |                 |                                      |
  | --------------- | ------------------------------------ |
  | `base_size`     | Base size (default chars height)     |
  | `glyph_count`   | Number of glyph characters           |
  | `glyph_padding` | Padding around the glyph characters  |
  | `texture`       | Texture atlas containing the glyphs  |
  | `recs`          | Rectangles in texture for the glyphs |
  | `glyphs`        | Glyphs info data                     |
  """

  defstruct base_size: nil,
            glyph_count: 0,
            glyph_padding: 0,
            texture: nil,
            recs: [],
            glyphs: []

  use Zexray.Type.TypeBase, prefix: "font"

  @type t ::
          %__MODULE__{
            base_size: integer,
            glyph_count: integer,
            glyph_padding: integer,
            texture: Zexray.Type.Texture.t_nif(),
            recs: [Zexray.Type.Rectangle.t_nif()],
            glyphs: [Zexray.Type.GlyphInfo.t_nif()]
          }

  @type t_all ::
          t
          | {
              integer,
              integer,
              integer,
              Zexray.Type.Texture.t_all(),
              [Zexray.Type.Rectangle.t_all()],
              [Zexray.Type.GlyphInfo.t_all()]
            }
          | map
          | keyword
          | Resource.t()

  import Zexray.Guard

  @doc """
  Creates a new `t:t/0`.
  """
  def new(font)

  @spec new({
          base_size :: integer,
          glyph_count :: integer,
          glyph_padding :: integer,
          texture :: Zexray.Type.Texture.t_all(),
          recs :: [Zexray.Type.Rectangle.t_all()],
          glyphs :: [Zexray.Type.GlyphInfo.t_all()]
        }) :: t()
  def new({
        base_size,
        glyph_count,
        glyph_padding,
        texture,
        recs,
        glyphs
      })
      when is_integer(base_size) and
             is_integer(glyph_count) and
             is_integer(glyph_padding) and
             is_like_texture(texture) and
             is_list(recs) and (recs == [] or is_like_rectangle(hd(recs))) and
             is_list(glyphs) and (glyphs == [] or is_like_glyph_info(hd(glyphs))) do
    new(
      base_size: base_size,
      glyph_count: glyph_count,
      glyph_padding: glyph_padding,
      texture: texture,
      recs: recs,
      glyphs: glyphs
    )
  end

  @spec new(font :: struct) :: t()
  def new(font) when is_struct(font) do
    font =
      if String.ends_with?(Atom.to_string(font.__struct__), ".Resource") do
        apply(font.__struct__, :content, [font])
      else
        font
      end

    case font do
      %__MODULE__{} = font -> font
      _ -> new(Map.from_struct(font))
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

              key == :texture ->
                cond do
                  is_struct(value, Zexray.Type.Texture.Resource) -> value
                  is_reference(value) -> Zexray.Type.Texture.Resource.new(value)
                  true -> Zexray.Type.Texture.new(value)
                end

              key == :recs and is_list(value) ->
                Enum.map(value, fn v ->
                  cond do
                    is_struct(v, Zexray.Type.Rectangle.Resource) -> v
                    is_reference(v) -> Zexray.Type.Rectangle.Resource.new(v)
                    true -> Zexray.Type.Rectangle.new(v)
                  end
                end)

              key == :glyphs and is_list(value) ->
                Enum.map(value, fn v ->
                  cond do
                    is_struct(v, Zexray.Type.GlyphInfo.Resource) -> v
                    is_reference(v) -> Zexray.Type.GlyphInfo.Resource.new(v)
                    true -> Zexray.Type.GlyphInfo.new(v)
                  end
                end)

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
