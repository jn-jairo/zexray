defmodule Zexray.NIF.Color do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_color [
        # Color
        color_is_equal: 2,
        fade: 2,
        fade: 3,
        color_to_int: 1,
        color_normalize: 1,
        color_normalize: 2,
        color_from_normalized: 1,
        color_from_normalized: 2,
        color_to_hsv: 1,
        color_to_hsv: 2,
        color_from_hsv: 3,
        color_from_hsv: 4,
        color_tint: 2,
        color_tint: 3,
        color_brightness: 2,
        color_brightness: 3,
        color_contrast: 2,
        color_contrast: 3,
        color_alpha: 2,
        color_alpha: 3,
        color_alpha_blend: 3,
        color_alpha_blend: 4,
        color_lerp: 3,
        color_lerp: 4,
        get_color: 1,
        get_color: 2,
        get_pixel_color: 2,
        get_pixel_color: 3,
        set_pixel_color: 2,
        get_pixel_data_size: 3
      ]

      ###########
      #  Color  #
      ###########

      @doc """
      Check if two colors are equal

      ```c
      // raylib.h
      RLAPI bool ColorIsEqual(Color col1, Color col2);
      ```
      """
      @doc group: :color
      @spec color_is_equal(
              col1 :: tuple,
              col2 :: tuple
            ) :: boolean
      def color_is_equal(
            _col1,
            _col2
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get color with alpha applied, alpha goes from 0.0f to 1.0f

      ```c
      // raylib.h
      RLAPI Color Fade(Color color, float alpha);
      ```
      """
      @doc group: :color
      @spec fade(
              color :: tuple,
              alpha :: number,
              return :: :auto | :value | :resource
            ) :: tuple
      def fade(
            _color,
            _alpha,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get hexadecimal value for a Color (0xRRGGBBAA)

      ```c
      // raylib.h
      RLAPI int ColorToInt(Color color);
      ```
      """
      @doc group: :color
      @spec color_to_int(color :: tuple) :: non_neg_integer
      def color_to_int(_color), do: :erlang.nif_error(:undef)

      @doc """
      Get Color normalized as float [0..1]

      ```c
      // raylib.h
      RLAPI Vector4 ColorNormalize(Color color);
      ```
      """
      @doc group: :color
      @spec color_normalize(
              color :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def color_normalize(
            _color,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get Color from normalized values [0..1]

      ```c
      // raylib.h
      RLAPI Color ColorFromNormalized(Vector4 normalized);
      ```
      """
      @doc group: :color
      @spec color_from_normalized(
              normalized :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def color_from_normalized(
            _normalized,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get HSV values for a Color, hue [0..360], saturation/value [0..1]

      ```c
      // raylib.h
      RLAPI Vector3 ColorToHSV(Color color);
      ```
      """
      @doc group: :color
      @spec color_to_hsv(
              color :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def color_to_hsv(
            _color,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get a Color from HSV values, hue [0..360], saturation/value [0..1]

      ```c
      // raylib.h
      RLAPI Color ColorFromHSV(float hue, float saturation, float value);
      ```
      """
      @doc group: :color
      @spec color_from_hsv(
              hue :: number,
              saturation :: number,
              value :: number,
              return :: :auto | :value | :resource
            ) :: tuple
      def color_from_hsv(
            _hue,
            _saturation,
            _value,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get color multiplied with another color

      ```c
      // raylib.h
      RLAPI Color ColorTint(Color color, Color tint);
      ```
      """
      @doc group: :color
      @spec color_tint(
              color :: tuple,
              tint :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def color_tint(
            _color,
            _tint,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get color with brightness correction, brightness factor goes from -1.0f to 1.0f

      ```c
      // raylib.h
      RLAPI Color ColorBrightness(Color color, float factor);
      ```
      """
      @doc group: :color
      @spec color_brightness(
              color :: tuple,
              factor :: number,
              return :: :auto | :value | :resource
            ) :: tuple
      def color_brightness(
            _color,
            _factor,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get color with contrast correction, contrast values between -1.0f and 1.0f

      ```c
      // raylib.h
      RLAPI Color ColorContrast(Color color, float contrast);
      ```
      """
      @doc group: :color
      @spec color_contrast(
              color :: tuple,
              contrast :: number,
              return :: :auto | :value | :resource
            ) :: tuple
      def color_contrast(
            _color,
            _contrast,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get color with alpha applied, alpha goes from 0.0f to 1.0f

      ```c
      // raylib.h
      RLAPI Color ColorAlpha(Color color, float alpha);
      ```
      """
      @doc group: :color
      @spec color_alpha(
              color :: tuple,
              alpha :: number,
              return :: :auto | :value | :resource
            ) :: tuple
      def color_alpha(
            _color,
            _alpha,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get src alpha-blended into dst color with tint

      ```c
      // raylib.h
      RLAPI Color ColorAlphaBlend(Color dst, Color src, Color tint);
      ```
      """
      @doc group: :color
      @spec color_alpha_blend(
              dst :: tuple,
              src :: tuple,
              tint :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def color_alpha_blend(
            _dst,
            _src,
            _tint,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get color lerp interpolation between two colors, factor [0.0f..1.0f]

      ```c
      // raylib.h
      RLAPI Color ColorLerp(Color color1, Color color2, float factor);
      ```
      """
      @doc group: :color
      @spec color_lerp(
              color1 :: tuple,
              color2 :: tuple,
              factor :: number,
              return :: :auto | :value | :resource
            ) :: tuple
      def color_lerp(
            _color1,
            _color2,
            _factor,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get Color structure from hexadecimal value

      ```c
      // raylib.h
      RLAPI Color GetColor(unsigned int hexValue);
      ```
      """
      @doc group: :color
      @spec get_color(
              hex_value :: non_neg_integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_color(
            _hex_value,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get Color from a source pixel pointer of certain format

      ```c
      // raylib.h
      RLAPI Color GetPixelColor(void *srcPtr, int format);
      ```
      """
      @doc group: :color
      @spec get_pixel_color(
              data :: binary,
              format :: integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_pixel_color(
            _data,
            _format,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set color formatted into destination pixel pointer

      ```c
      // raylib.h
      RLAPI void SetPixelColor(void *dstPtr, Color color, int format);
      ```
      """
      @doc group: :color
      @spec set_pixel_color(
              color :: tuple,
              format :: integer
            ) :: binary
      def set_pixel_color(
            _color,
            _format
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get pixel data size in bytes for certain format

      ```c
      // raylib.h
      RLAPI int GetPixelDataSize(int width, int height, int format);
      ```
      """
      @doc group: :color
      @spec get_pixel_data_size(
              width :: integer,
              height :: integer,
              format :: integer
            ) :: non_neg_integer
      def get_pixel_data_size(
            _width,
            _height,
            _format
          ),
          do: :erlang.nif_error(:undef)
    end
  end
end
