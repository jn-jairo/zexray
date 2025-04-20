defmodule Zexray.Color do
  @moduledoc """
  Color
  """

  import Zexray.Guard
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
  def equal?(
        col1,
        col2
      )
      when is_like_color(col1) and
             is_like_color(col2) do
    NIF.color_is_equal(
      col1 |> Zexray.Type.Color.to_nif(),
      col2 |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Get color with alpha applied, alpha goes from 0.0f to 1.0f
  """
  @spec fade(
          color :: Zexray.Type.Color.t_all(),
          alpha :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  def fade(
        color,
        alpha,
        return \\ :value
      )
      when is_like_color(color) and
             is_float(alpha) and
             is_nif_return(return) do
    NIF.fade(
      color |> Zexray.Type.Color.to_nif(),
      alpha,
      return
    )
    |> Zexray.Type.Color.from_nif()
  end

  @doc """
  Get hexadecimal value for a Color (0xRRGGBBAA)
  """
  @spec to_int(color :: Zexray.Type.Color.t_all()) :: non_neg_integer
  def to_int(color)
      when is_like_color(color) do
    NIF.color_to_int(color |> Zexray.Type.Color.to_nif())
  end

  @doc """
  Get Color structure from hexadecimal value
  """
  @spec from_int(
          hex_value :: non_neg_integer,
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  def from_int(
        hex_value,
        return \\ :value
      )
      when is_non_neg_integer(hex_value) and
             is_nif_return(return) do
    NIF.get_color(
      hex_value,
      return
    )
    |> Zexray.Type.Color.from_nif()
  end

  @doc """
  Get Color normalized as float [0..1]
  """
  @spec normalize(
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Vector4.t_nif()
  def normalize(
        color,
        return \\ :value
      )
      when is_like_color(color) and
             is_nif_return(return) do
    NIF.color_normalize(
      color |> Zexray.Type.Color.to_nif(),
      return
    )
    |> Zexray.Type.Vector4.from_nif()
  end

  @doc """
  Get Color from normalized values [0..1]
  """
  @spec from_normalized(
          normalized :: Zexray.Type.Vector4.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  def from_normalized(
        normalized,
        return \\ :value
      )
      when is_like_vector4(normalized) and
             is_nif_return(return) do
    NIF.color_from_normalized(
      normalized |> Zexray.Type.Vector4.to_nif(),
      return
    )
    |> Zexray.Type.Color.from_nif()
  end

  @doc """
  Get HSV values for a Color, hue [0..360], saturation/value [0..1]
  """
  @spec to_hsv(
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Vector3.t_nif()
  def to_hsv(
        color,
        return \\ :value
      )
      when is_like_color(color) and
             is_nif_return(return) do
    NIF.color_to_hsv(
      color |> Zexray.Type.Color.to_nif(),
      return
    )
    |> Zexray.Type.Vector3.from_nif()
  end

  @doc """
  Get a Color from HSV values, hue [0..360], saturation/value [0..1]
  """
  @spec from_hsv(
          hue :: float,
          saturation :: float,
          value :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  def from_hsv(
        hue,
        saturation,
        value,
        return \\ :value
      )
      when is_float(hue) and
             is_float(saturation) and
             is_float(value) and
             is_nif_return(return) do
    NIF.color_from_hsv(
      hue,
      saturation,
      value,
      return
    )
    |> Zexray.Type.Color.from_nif()
  end

  @doc """
  Get color multiplied with another color
  """
  @spec tint(
          color :: Zexray.Type.Color.t_all(),
          tint :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  def tint(
        color,
        tint,
        return \\ :value
      )
      when is_like_color(color) and
             is_like_color(tint) and
             is_nif_return(return) do
    NIF.color_tint(
      color |> Zexray.Type.Color.to_nif(),
      tint |> Zexray.Type.Color.to_nif(),
      return
    )
    |> Zexray.Type.Color.from_nif()
  end

  @doc """
  Get color with brightness correction, brightness factor goes from -1.0f to 1.0f
  """
  @spec brightness(
          color :: Zexray.Type.Color.t_all(),
          factor :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  def brightness(
        color,
        factor,
        return \\ :value
      )
      when is_like_color(color) and
             is_float(factor) and
             is_nif_return(return) do
    NIF.color_brightness(
      color |> Zexray.Type.Color.to_nif(),
      factor,
      return
    )
    |> Zexray.Type.Color.from_nif()
  end

  @doc """
  Get color with contrast correction, contrast values between -1.0f and 1.0f
  """
  @spec contrast(
          color :: Zexray.Type.Color.t_all(),
          contrast :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  def contrast(
        color,
        contrast,
        return \\ :value
      )
      when is_like_color(color) and
             is_float(contrast) and
             is_nif_return(return) do
    NIF.color_contrast(
      color |> Zexray.Type.Color.to_nif(),
      contrast,
      return
    )
    |> Zexray.Type.Color.from_nif()
  end

  @doc """
  Get color with alpha applied, alpha goes from 0.0f to 1.0f
  """
  @spec alpha(
          color :: Zexray.Type.Color.t_all(),
          alpha :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  def alpha(
        color,
        alpha,
        return \\ :value
      )
      when is_like_color(color) and
             is_float(alpha) and
             is_nif_return(return) do
    NIF.color_alpha(
      color |> Zexray.Type.Color.to_nif(),
      alpha,
      return
    )
    |> Zexray.Type.Color.from_nif()
  end

  @doc """
  Get src alpha-blended into dst color with tint
  """
  @spec alpha_blend(
          dst :: Zexray.Type.Color.t_all(),
          src :: Zexray.Type.Color.t_all(),
          tint :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  def alpha_blend(
        dst,
        src,
        tint,
        return \\ :value
      )
      when is_like_color(dst) and
             is_like_color(src) and
             is_like_color(tint) and
             is_nif_return(return) do
    NIF.color_alpha_blend(
      dst |> Zexray.Type.Color.to_nif(),
      src |> Zexray.Type.Color.to_nif(),
      tint |> Zexray.Type.Color.to_nif(),
      return
    )
    |> Zexray.Type.Color.from_nif()
  end

  @doc """
  Get color lerp interpolation between two colors, factor [0.0f..1.0f]
  """
  @spec lerp(
          color1 :: Zexray.Type.Color.t_all(),
          color2 :: Zexray.Type.Color.t_all(),
          factor :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  def lerp(
        color1,
        color2,
        factor,
        return \\ :value
      )
      when is_like_color(color1) and
             is_like_color(color2) and
             is_float(factor) and
             is_nif_return(return) do
    NIF.color_lerp(
      color1 |> Zexray.Type.Color.to_nif(),
      color2 |> Zexray.Type.Color.to_nif(),
      factor,
      return
    )
    |> Zexray.Type.Color.from_nif()
  end

  @doc """
  Get Color from a source pixel pointer of certain format
  """
  @spec from_pixel_data(
          data :: binary,
          format :: Zexray.Enum.PixelFormat.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  def from_pixel_data(
        data,
        format,
        return \\ :value
      )
      when is_binary(data) and
             is_like_pixel_format(format) and
             is_nif_return(return) do
    NIF.get_pixel_color(
      data,
      Zexray.Enum.PixelFormat.value(format),
      return
    )
    |> Zexray.Type.Color.from_nif()
  end

  @doc """
  Set color formatted into destination pixel pointer
  """
  @spec to_pixel_data(
          color :: Zexray.Type.Color.t_all(),
          format :: Zexray.Enum.PixelFormat.t_all()
        ) :: binary
  def to_pixel_data(
        color,
        format
      )
      when is_like_color(color) and
             is_like_pixel_format(format) do
    NIF.set_pixel_color(
      color |> Zexray.Type.Color.to_nif(),
      Zexray.Enum.PixelFormat.value(format)
    )
  end

  @doc """
  Get pixel data size in bytes for certain format
  """
  @spec get_pixel_data_size(
          width :: integer,
          height :: integer,
          format :: Zexray.Enum.PixelFormat.t_all()
        ) :: non_neg_integer
  def get_pixel_data_size(
        width,
        height,
        format
      )
      when is_integer(width) and
             is_integer(height) and
             is_like_pixel_format(format) do
    NIF.get_pixel_data_size(
      width,
      height,
      Zexray.Enum.PixelFormat.value(format)
    )
  end
end
