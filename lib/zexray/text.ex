defmodule Zexray.Text do
  @moduledoc """
  Text
  """

  alias Zexray.NIF

  ##################
  #  Text drawing  #
  ##################

  @doc """
  Draw current FPS
  """
  @doc group: :drawing
  @spec draw_fps(
          pos_x :: number,
          pos_y :: number
        ) :: :ok
  defdelegate draw_fps(
                pos_x,
                pos_y
              ),
              to: NIF,
              as: :draw_fps

  @doc """
  Draw text (using default font)
  """
  @doc group: :drawing
  @spec draw(
          text :: binary,
          pos_x :: number,
          pos_y :: number,
          font_size :: number,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw(
                text,
                pos_x,
                pos_y,
                font_size,
                color
              ),
              to: NIF,
              as: :draw_text

  @doc """
  Draw text using font and additional parameters
  """
  @doc group: :drawing
  @spec draw_ex(
          font :: Zexray.Type.Font.t_all(),
          text :: binary,
          position :: Zexray.Type.Vector2.t_all(),
          font_size :: number,
          spacing :: number,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_ex(
                font,
                text,
                position,
                font_size,
                spacing,
                tint
              ),
              to: NIF,
              as: :draw_text_ex

  @doc """
  Draw text using Font and pro parameters (rotation)
  """
  @doc group: :drawing
  @spec draw_pro(
          font :: Zexray.Type.Font.t_all(),
          text :: binary,
          position :: Zexray.Type.Vector2.t_all(),
          origin :: Zexray.Type.Vector2.t_all(),
          rotation :: number,
          font_size :: number,
          spacing :: number,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_pro(
                font,
                text,
                position,
                origin,
                rotation,
                font_size,
                spacing,
                tint
              ),
              to: NIF,
              as: :draw_text_pro

  @doc """
  Draw one character (codepoint)
  """
  @doc group: :drawing
  @spec draw_codepoint(
          font :: Zexray.Type.Font.t_all(),
          codepoint :: integer,
          position :: Zexray.Type.Vector2.t_all(),
          font_size :: number,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_codepoint(
                font,
                codepoint,
                position,
                font_size,
                tint
              ),
              to: NIF,
              as: :draw_text_codepoint

  @doc """
  Draw multiple character (codepoint)
  """
  @doc group: :drawing
  @spec draw_codepoints(
          font :: Zexray.Type.Font.t_all(),
          codepoints :: [integer],
          position :: Zexray.Type.Vector2.t_all(),
          font_size :: number,
          spacing :: number,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_codepoints(
                font,
                codepoints,
                position,
                font_size,
                spacing,
                tint
              ),
              to: NIF,
              as: :draw_text_codepoints

  ####################
  #  Text font info  #
  ####################

  @doc """
  Set vertical line spacing when drawing with line-breaks
  """
  @doc group: :font_info
  @spec set_line_spacing(spacing :: number) :: :ok
  defdelegate set_line_spacing(spacing), to: NIF, as: :set_text_line_spacing

  @doc """
  Measure string width for default font
  """
  @doc group: :font_info
  @spec measure(
          text :: binary,
          font_size :: number
        ) :: integer
  defdelegate measure(
                text,
                font_size
              ),
              to: NIF,
              as: :measure_text

  @doc """
  Measure string size for Font
  """
  @doc group: :font_info
  @spec measure_ex(
          font :: Zexray.Type.Font.t_all(),
          text :: binary,
          font_size :: number,
          spacing :: number,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  defdelegate measure_ex(
                font,
                text,
                font_size,
                spacing,
                return \\ :auto
              ),
              to: NIF,
              as: :measure_text_ex

  @doc """
  Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
  """
  @doc group: :font_info
  @spec get_glyph_index(
          font :: Zexray.Type.Font.t_all(),
          codepoint :: integer
        ) :: integer
  defdelegate get_glyph_index(
                font,
                codepoint
              ),
              to: NIF,
              as: :get_glyph_index

  @doc """
  Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
  """
  @doc group: :font_info
  @spec get_glyph_info(
          font :: Zexray.Type.Font.t_all(),
          codepoint :: integer,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.GlyphInfo.t_nif()
  defdelegate get_glyph_info(
                font,
                codepoint,
                return \\ :auto
              ),
              to: NIF,
              as: :get_glyph_info

  @doc """
  Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
  """
  @doc group: :font_info
  @spec get_glyph_atlas_rec(
          font :: Zexray.Type.Font.t_all(),
          codepoint :: integer,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Rectangle.t_nif()
  defdelegate get_glyph_atlas_rec(
                font,
                codepoint,
                return \\ :auto
              ),
              to: NIF,
              as: :get_glyph_atlas_rec
end
