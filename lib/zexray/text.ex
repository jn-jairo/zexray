defmodule Zexray.Text do
  alias Zexray.NIF

  import Zexray.Guard

  ##################
  #  Text drawing  #
  ##################

  @doc """
  Draw current FPS
  """
  @doc group: :drawing
  @spec draw_fps(
          pos_x :: integer,
          pos_y :: integer
        ) :: :ok
  def draw_fps(
        pos_x,
        pos_y
      )
      when is_integer(pos_x) and
             is_integer(pos_y) do
    NIF.draw_fps(
      pos_x,
      pos_y
    )
  end

  @doc """
  Draw text (using default font)
  """
  @doc group: :drawing
  @spec draw(
          text :: binary,
          pos_x :: integer,
          pos_y :: integer,
          font_size :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw(
        text,
        pos_x,
        pos_y,
        font_size,
        color
      )
      when is_binary(text) and
             is_integer(pos_x) and
             is_integer(pos_y) and
             is_integer(font_size) and
             is_like_color(color) do
    NIF.draw_text(
      text,
      pos_x,
      pos_y,
      font_size,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw text using font and additional parameters
  """
  @doc group: :drawing
  @spec draw_ex(
          font :: Zexray.Type.Font.t_all(),
          text :: binary,
          position :: Zexray.Type.Vector2.t_all(),
          font_size :: float,
          spacing :: float,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_ex(
        font,
        text,
        position,
        font_size,
        spacing,
        tint
      )
      when is_like_font(font) and
             is_binary(text) and
             is_like_vector2(position) and
             is_float(font_size) and
             is_float(spacing) and
             is_like_color(tint) do
    NIF.draw_text_ex(
      font |> Zexray.Type.Font.to_nif(),
      text,
      position |> Zexray.Type.Vector2.to_nif(),
      font_size,
      spacing,
      tint |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw text using Font and pro parameters (rotation)
  """
  @doc group: :drawing
  @spec draw_pro(
          font :: Zexray.Type.Font.t_all(),
          text :: binary,
          position :: Zexray.Type.Vector2.t_all(),
          origin :: Zexray.Type.Vector2.t_all(),
          rotation :: float,
          font_size :: float,
          spacing :: float,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_pro(
        font,
        text,
        position,
        origin,
        rotation,
        font_size,
        spacing,
        tint
      )
      when is_like_font(font) and
             is_binary(text) and
             is_like_vector2(position) and
             is_like_vector2(origin) and
             is_float(rotation) and
             is_float(font_size) and
             is_float(spacing) and
             is_like_color(tint) do
    NIF.draw_text_pro(
      font |> Zexray.Type.Font.to_nif(),
      text,
      position |> Zexray.Type.Vector2.to_nif(),
      origin |> Zexray.Type.Vector2.to_nif(),
      rotation,
      font_size,
      spacing,
      tint |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw one character (codepoint)
  """
  @doc group: :drawing
  @spec draw_codepoint(
          font :: Zexray.Type.Font.t_all(),
          codepoint :: integer,
          position :: Zexray.Type.Vector2.t_all(),
          font_size :: float,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_codepoint(
        font,
        codepoint,
        position,
        font_size,
        tint
      )
      when is_like_font(font) and
             is_integer(codepoint) and
             is_like_vector2(position) and
             is_float(font_size) and
             is_like_color(tint) do
    NIF.draw_text_codepoint(
      font |> Zexray.Type.Font.to_nif(),
      codepoint,
      position |> Zexray.Type.Vector2.to_nif(),
      font_size,
      tint |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw multiple character (codepoint)
  """
  @doc group: :drawing
  @spec draw_codepoints(
          font :: Zexray.Type.Font.t_all(),
          codepoints :: [integer],
          position :: Zexray.Type.Vector2.t_all(),
          font_size :: float,
          spacing :: float,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_codepoints(
        font,
        codepoints,
        position,
        font_size,
        spacing,
        tint
      )
      when is_like_font(font) and
             is_list(codepoints) and (codepoints == [] or is_integer(hd(codepoints))) and
             is_like_vector2(position) and
             is_float(font_size) and
             is_float(spacing) and
             is_like_color(tint) do
    NIF.draw_text_codepoints(
      font |> Zexray.Type.Font.to_nif(),
      codepoints,
      position |> Zexray.Type.Vector2.to_nif(),
      font_size,
      spacing,
      tint |> Zexray.Type.Color.to_nif()
    )
  end

  ####################
  #  Text font info  #
  ####################

  @doc """
  Set vertical line spacing when drawing with line-breaks
  """
  @doc group: :font_info
  @spec set_line_spacing(spacing :: integer) :: :ok
  def set_line_spacing(spacing)
      when is_integer(spacing) do
    NIF.set_text_line_spacing(spacing)
  end

  @doc """
  Measure string width for default font
  """
  @doc group: :font_info
  @spec measure(
          text :: binary,
          font_size :: integer
        ) :: integer
  def measure(
        text,
        font_size
      )
      when is_binary(text) and
             is_integer(font_size) do
    NIF.measure_text(
      text,
      font_size
    )
  end

  @doc """
  Measure string size for Font
  """
  @doc group: :font_info
  @spec measure_ex(
          font :: Zexray.Type.Font.t_all(),
          text :: binary,
          font_size :: float,
          spacing :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  def measure_ex(
        font,
        text,
        font_size,
        spacing,
        return \\ :value
      )
      when is_like_font(font) and
             is_binary(text) and
             is_float(font_size) and
             is_float(spacing) and
             is_nif_return(return) do
    NIF.measure_text_ex(
      font |> Zexray.Type.Font.to_nif(),
      text,
      font_size,
      spacing,
      return
    )
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
  """
  @doc group: :font_info
  @spec get_glyph_index(
          font :: Zexray.Type.Font.t_all(),
          codepoint :: integer
        ) :: integer
  def get_glyph_index(
        font,
        codepoint
      )
      when is_like_font(font) and
             is_integer(codepoint) do
    NIF.get_glyph_index(
      font |> Zexray.Type.Font.to_nif(),
      codepoint
    )
  end

  @doc """
  Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
  """
  @doc group: :font_info
  @spec get_glyph_info(
          font :: Zexray.Type.Font.t_all(),
          codepoint :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.GlyphInfo.t_nif()
  def get_glyph_info(
        font,
        codepoint,
        return \\ :value
      )
      when is_like_font(font) and
             is_integer(codepoint) and
             is_nif_return(return) do
    NIF.get_glyph_info(
      font |> Zexray.Type.Font.to_nif(),
      codepoint,
      return
    )
    |> Zexray.Type.GlyphInfo.from_nif()
  end

  @doc """
  Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
  """
  @doc group: :font_info
  @spec get_glyph_atlas_rec(
          font :: Zexray.Type.Font.t_all(),
          codepoint :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Rectangle.t_nif()
  def get_glyph_atlas_rec(
        font,
        codepoint,
        return \\ :value
      )
      when is_like_font(font) and
             is_integer(codepoint) and
             is_nif_return(return) do
    NIF.get_glyph_atlas_rec(
      font |> Zexray.Type.Font.to_nif(),
      codepoint,
      return
    )
    |> Zexray.Type.Rectangle.from_nif()
  end
end
