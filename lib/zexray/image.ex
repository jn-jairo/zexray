defmodule Zexray.Image do
  import Zexray.Guard
  alias Zexray.NIF

  @doc """
  Get image data size in bytes for certain format
  """
  @spec data_size(
          width :: integer,
          height :: integer,
          format :: Zexray.Enum.PixelFormat.t_all(),
          mipmaps :: integer
        ) :: non_neg_integer
  def data_size(
        width,
        height,
        format,
        mipmaps \\ 1
      )
      when is_integer(width) and
             is_integer(height) and
             is_like_pixel_format(format) and
             is_integer(mipmaps) do
    NIF.image_get_data_size(
      width,
      height,
      Zexray.Enum.PixelFormat.value(format),
      mipmaps
    )
  end

  ######################
  #  Image generation  #
  ######################

  @doc """
  Generate image: plain color
  """
  @doc group: :generation
  @spec gen_color(
          width :: integer,
          height :: integer,
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def gen_color(
        width,
        height,
        color,
        return \\ :value
      )
      when is_integer(width) and
             is_integer(height) and
             is_like_color(color) and
             is_nif_return(return) do
    NIF.gen_image_color(
      width,
      height,
      color |> Zexray.Type.Color.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  ########################
  #  Image manipulation  #
  ########################

  @doc """
  Crop an image to a defined rectangle
  """
  @doc group: :manipulation
  @spec crop(
          image :: Zexray.Type.Image.t_all(),
          crop :: Zexray.Type.Rectangle.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def crop(
        image,
        crop,
        return \\ :value
      )
      when is_like_image(image) and
             is_like_rectangle(crop) and
             is_nif_return(return) do
    NIF.image_crop(
      image |> Zexray.Type.Image.to_nif(),
      crop |> Zexray.Type.Rectangle.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end
end
