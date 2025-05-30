defmodule Zexray.Color do
  @moduledoc """
  Color
  """

  alias Zexray.NIF

  ###########
  #  Color  #
  ###########

  @doc """
  Check if two colors are equal
  """
  @spec equal?(
          col1 :: Zexray.Type.Color.t_all(),
          col2 :: Zexray.Type.Color.t_all()
        ) :: boolean
  defdelegate equal?(
                col1,
                col2
              ),
              to: NIF,
              as: :color_is_equal

  @doc """
  Get color with alpha applied, alpha goes from 0.0f to 1.0f
  """
  @spec fade(
          color :: Zexray.Type.Color.t_all(),
          alpha :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  defdelegate fade(
                color,
                alpha,
                return \\ :value
              ),
              to: NIF,
              as: :fade

  @doc """
  Get hexadecimal value for a Color (0xRRGGBBAA)
  """
  @spec to_int(color :: Zexray.Type.Color.t_all()) :: non_neg_integer
  defdelegate to_int(color), to: NIF, as: :color_to_int

  @doc """
  Get Color structure from hexadecimal value
  """
  @spec from_int(
          hex_value :: non_neg_integer,
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  defdelegate from_int(
                hex_value,
                return \\ :value
              ),
              to: NIF,
              as: :get_color

  @doc """
  Get Color normalized as float [0..1]
  """
  @spec normalize(
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Vector4.t_nif()
  defdelegate normalize(
                color,
                return \\ :value
              ),
              to: NIF,
              as: :color_normalize

  @doc """
  Get Color from normalized values [0..1]
  """
  @spec from_normalized(
          normalized :: Zexray.Type.Vector4.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  defdelegate from_normalized(
                normalized,
                return \\ :value
              ),
              to: NIF,
              as: :color_from_normalized

  @doc """
  Get HSV values for a Color, hue [0..360], saturation/value [0..1]
  """
  @spec to_hsv(
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Vector3.t_nif()
  defdelegate to_hsv(
                color,
                return \\ :value
              ),
              to: NIF,
              as: :color_to_hsv

  @doc """
  Get a Color from HSV values, hue [0..360], saturation/value [0..1]
  """
  @spec from_hsv(
          hue :: float,
          saturation :: float,
          value :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  defdelegate from_hsv(
                hue,
                saturation,
                value,
                return \\ :value
              ),
              to: NIF,
              as: :color_from_hsv

  @doc """
  Get color multiplied with another color
  """
  @spec tint(
          color :: Zexray.Type.Color.t_all(),
          tint :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  defdelegate tint(
                color,
                tint,
                return \\ :value
              ),
              to: NIF,
              as: :color_tint

  @doc """
  Get color with brightness correction, brightness factor goes from -1.0f to 1.0f
  """
  @spec brightness(
          color :: Zexray.Type.Color.t_all(),
          factor :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  defdelegate brightness(
                color,
                factor,
                return \\ :value
              ),
              to: NIF,
              as: :color_brightness

  @doc """
  Get color with contrast correction, contrast values between -1.0f and 1.0f
  """
  @spec contrast(
          color :: Zexray.Type.Color.t_all(),
          contrast :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  defdelegate contrast(
                color,
                contrast,
                return \\ :value
              ),
              to: NIF,
              as: :color_contrast

  @doc """
  Get color with alpha applied, alpha goes from 0.0f to 1.0f
  """
  @spec alpha(
          color :: Zexray.Type.Color.t_all(),
          alpha :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  defdelegate alpha(
                color,
                alpha,
                return \\ :value
              ),
              to: NIF,
              as: :color_alpha

  @doc """
  Get src alpha-blended into dst color with tint
  """
  @spec alpha_blend(
          dst :: Zexray.Type.Color.t_all(),
          src :: Zexray.Type.Color.t_all(),
          tint :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  defdelegate alpha_blend(
                dst,
                src,
                tint,
                return \\ :value
              ),
              to: NIF,
              as: :color_alpha_blend

  @doc """
  Get color lerp interpolation between two colors, factor [0.0f..1.0f]
  """
  @spec lerp(
          color1 :: Zexray.Type.Color.t_all(),
          color2 :: Zexray.Type.Color.t_all(),
          factor :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  defdelegate lerp(
                color1,
                color2,
                factor,
                return \\ :value
              ),
              to: NIF,
              as: :color_lerp

  @doc """
  Get Color from a source pixel pointer of certain format
  """
  @spec from_pixel_data(
          data :: binary,
          format :: Zexray.Enum.PixelFormat.t(),
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  defdelegate from_pixel_data(
                data,
                format,
                return \\ :value
              ),
              to: NIF,
              as: :get_pixel_color

  @doc """
  Set color formatted into destination pixel pointer
  """
  @spec to_pixel_data(
          color :: Zexray.Type.Color.t_all(),
          format :: Zexray.Enum.PixelFormat.t()
        ) :: binary
  defdelegate to_pixel_data(
                color,
                format
              ),
              to: NIF,
              as: :set_pixel_color

  @doc """
  Get pixel data size in bytes for certain format
  """
  @spec get_pixel_data_size(
          width :: integer,
          height :: integer,
          format :: Zexray.Enum.PixelFormat.t()
        ) :: non_neg_integer
  defdelegate get_pixel_data_size(
                width,
                height,
                format
              ),
              to: NIF,
              as: :get_pixel_data_size
end
