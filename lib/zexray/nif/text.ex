defmodule Zexray.NIF.Text do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_text [
        # Text drawing
        draw_fps: 2,
        draw_text: 5,
        draw_text_ex: 6,
        draw_text_pro: 8,
        draw_text_codepoint: 5,
        draw_text_codepoints: 6,

        # Text font info
        set_text_line_spacing: 1,
        measure_text: 2,
        measure_text_ex: 4,
        measure_text_ex: 5,
        get_glyph_index: 2,
        get_glyph_info: 2,
        get_glyph_info: 3,
        get_glyph_atlas_rec: 2,
        get_glyph_atlas_rec: 3
      ]

      ##################
      #  Text drawing  #
      ##################

      @doc """
      Draw current FPS

      ```c
      // raylib.h
      RLAPI void DrawFPS(int posX, int posY);
      ```
      """
      @doc group: :text_drawing
      @spec draw_fps(
              pos_x :: integer,
              pos_y :: integer
            ) :: :ok
      def draw_fps(
            _pos_x,
            _pos_y
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw text (using default font)

      ```c
      // raylib.h
      RLAPI void DrawText(const char *text, int posX, int posY, int fontSize, Color color);
      ```
      """
      @doc group: :text_drawing
      @spec draw_text(
              text :: binary,
              pos_x :: integer,
              pos_y :: integer,
              font_size :: integer,
              color :: map | reference
            ) :: :ok
      def draw_text(
            _text,
            _pos_x,
            _pos_y,
            _font_size,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw text using font and additional parameters

      ```c
      // raylib.h
      RLAPI void DrawTextEx(Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint);
      ```
      """
      @doc group: :text_drawing
      @spec draw_text_ex(
              font :: map | reference,
              text :: binary,
              position :: map | reference,
              font_size :: float,
              spacing :: float,
              tint :: map | reference
            ) :: :ok
      def draw_text_ex(
            _font,
            _text,
            _position,
            _font_size,
            _spacing,
            _tint
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw text using Font and pro parameters (rotation)

      ```c
      // raylib.h
      RLAPI void DrawTextPro(Font font, const char *text, Vector2 position, Vector2 origin, float rotation, float fontSize, float spacing, Color tint);
      ```
      """
      @doc group: :text_drawing
      @spec draw_text_pro(
              font :: map | reference,
              text :: binary,
              position :: map | reference,
              origin :: map | reference,
              rotation :: float,
              font_size :: float,
              spacing :: float,
              tint :: map | reference
            ) :: :ok
      def draw_text_pro(
            _font,
            _text,
            _position,
            _origin,
            _rotation,
            _font_size,
            _spacing,
            _tint
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw one character (codepoint)

      ```c
      // raylib.h
      RLAPI void DrawTextCodepoint(Font font, int codepoint, Vector2 position, float fontSize, Color tint);
      ```
      """
      @doc group: :text_drawing
      @spec draw_text_codepoint(
              font :: map | reference,
              codepoint :: integer,
              position :: map | reference,
              font_size :: float,
              tint :: map | reference
            ) :: :ok
      def draw_text_codepoint(
            _font,
            _codepoint,
            _position,
            _font_size,
            _tint
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw multiple character (codepoint)

      ```c
      // raylib.h
      RLAPI void DrawTextCodepoints(Font font, const int *codepoints, int codepointCount, Vector2 position, float fontSize, float spacing, Color tint);
      ```
      """
      @doc group: :text_drawing
      @spec draw_text_codepoints(
              font :: map | reference,
              codepoints :: [integer],
              position :: map | reference,
              font_size :: float,
              spacing :: float,
              tint :: map | reference
            ) :: :ok
      def draw_text_codepoints(
            _font,
            _codepoints,
            _position,
            _font_size,
            _spacing,
            _tint
          ),
          do: :erlang.nif_error(:undef)

      ####################
      #  Text font info  #
      ####################

      @doc """
      Set vertical line spacing when drawing with line-breaks

      ```c
      // raylib.h
      RLAPI void SetTextLineSpacing(int spacing);
      ```
      """
      @doc group: :text_font_info
      @spec set_text_line_spacing(spacing :: integer) :: :ok
      def set_text_line_spacing(_spacing), do: :erlang.nif_error(:undef)

      @doc """
      Measure string width for default font

      ```c
      // raylib.h
      RLAPI int MeasureText(const char *text, int fontSize);
      ```
      """
      @doc group: :text_font_info
      @spec measure_text(
              text :: binary,
              font_size :: integer
            ) :: integer
      def measure_text(
            _text,
            _font_size
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Measure string size for Font

      ```c
      // raylib.h
      RLAPI Vector2 MeasureTextEx(Font font, const char *text, float fontSize, float spacing);
      ```
      """
      @doc group: :text_font_info
      @spec measure_text_ex(
              font :: map | reference,
              text :: binary,
              font_size :: float,
              spacing :: float,
              return :: :value | :resource
            ) :: map | reference
      def measure_text_ex(
            _font,
            _text,
            _font_size,
            _spacing,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found

      ```c
      // raylib.h
      RLAPI int GetGlyphIndex(Font font, int codepoint);
      ```
      """
      @doc group: :text_font_info
      @spec get_glyph_index(
              font :: map | reference,
              codepoint :: integer
            ) :: integer
      def get_glyph_index(
            _font,
            _codepoint
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found

      ```c
      // raylib.h
      RLAPI GlyphInfo GetGlyphInfo(Font font, int codepoint);
      ```
      """
      @doc group: :text_font_info
      @spec get_glyph_info(
              font :: map | reference,
              codepoint :: integer,
              return :: :value | :resource
            ) :: map | reference
      def get_glyph_info(
            _font,
            _codepoint,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found

      ```c
      // raylib.h
      RLAPI Rectangle GetGlyphAtlasRec(Font font, int codepoint);
      ```
      """
      @doc group: :text_font_info
      @spec get_glyph_atlas_rec(
              font :: map | reference,
              codepoint :: integer,
              return :: :value | :resource
            ) :: map | reference
      def get_glyph_atlas_rec(
            _font,
            _codepoint,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)
    end
  end
end
