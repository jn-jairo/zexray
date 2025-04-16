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

  ###################
  #  Image loading  #
  ###################

  @doc """
  Load image from file into CPU memory (RAM)
  """
  @doc group: :loading
  @spec load(
          file_name :: binary,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def load(
        file_name,
        return \\ :value
      )
      when is_binary(file_name) and
             is_nif_return(return) do
    NIF.load_image(
      file_name,
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Load image from RAW file data
  """
  @doc group: :loading
  @spec load_raw(
          file_name :: binary,
          width :: integer,
          height :: integer,
          format :: Zexray.Enum.PixelFormat.t_all(),
          header_size :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def load_raw(
        file_name,
        width,
        height,
        format,
        header_size,
        return \\ :value
      )
      when is_binary(file_name) and
             is_integer(width) and
             is_integer(height) and
             is_like_pixel_format(format) and
             is_integer(header_size) and
             is_nif_return(return) do
    NIF.load_image_raw(
      file_name,
      width,
      height,
      Zexray.Enum.PixelFormat.value(format),
      header_size,
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Load image sequence from file (frames appended to image.data)
  """
  @doc group: :loading
  @spec load_anim(
          file_name :: binary,
          return :: :value | :resource
        ) :: {image :: Zexray.Type.Image.t_nif(), frames :: integer}
  def load_anim(
        file_name,
        return \\ :value
      )
      when is_binary(file_name) and
             is_nif_return(return) do
    {image, frames} =
      NIF.load_image_anim(
        file_name,
        return
      )

    {image |> Zexray.Type.Image.from_nif(), frames}
  end

  @doc """
  Load image sequence from memory buffer
  """
  @doc group: :loading
  @spec load_anim_from_memory(
          file_type :: binary,
          file_data :: binary,
          return :: :value | :resource
        ) :: {image :: Zexray.Type.Image.t_nif(), frames :: integer}
  def load_anim_from_memory(
        file_type,
        file_data,
        return \\ :value
      )
      when is_binary(file_type) and
             is_binary(file_data) and
             is_nif_return(return) do
    {image, frames} =
      NIF.load_image_anim_from_memory(
        file_type,
        file_data,
        return
      )

    {image |> Zexray.Type.Image.from_nif(), frames}
  end

  @doc """
  Load image from memory buffer, fileType refers to extension: i.e. '.png'
  """
  @doc group: :loading
  @spec load_from_memory(
          file_type :: binary,
          file_data :: binary,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def load_from_memory(
        file_type,
        file_data,
        return \\ :value
      )
      when is_binary(file_type) and
             is_binary(file_data) and
             is_nif_return(return) do
    NIF.load_image_from_memory(
      file_type,
      file_data,
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Load image from GPU texture data
  """
  @doc group: :loading
  @spec load_from_texture(
          texture :: Zexray.Type.Texture2D.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def load_from_texture(
        texture,
        return \\ :value
      )
      when is_like_texture_2d(texture) and
             is_nif_return(return) do
    NIF.load_image_from_texture(
      texture |> Zexray.Type.Texture2D.to_nif() |> IO.inspect(label: :texture),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Load image from screen buffer and (screenshot)
  """
  @doc group: :loading
  @spec load_from_screen(return :: :value | :resource) :: Zexray.Type.Image.t_nif()
  def load_from_screen(return \\ :value)
      when is_nif_return(return) do
    NIF.load_image_from_screen(return)
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Check if an image is valid (data and parameters)
  """
  @doc group: :loading
  @spec valid?(image :: Zexray.Type.Image.t_all()) :: boolean
  def valid?(image)
      when is_like_image(image) do
    NIF.is_image_valid(image |> Zexray.Type.Image.to_nif())
  end

  @doc """
  Export image data to file, returns true on success
  """
  @doc group: :loading
  @spec export(
          image :: Zexray.Type.Image.t_all(),
          file_name :: binary
        ) :: boolean
  def export(
        image,
        file_name
      )
      when is_like_image(image) and
             is_binary(file_name) do
    NIF.export_image(
      image |> Zexray.Type.Image.to_nif(),
      file_name
    )
  end

  @doc """
  Export image to memory buffer
  """
  @doc group: :loading
  @spec export_to_memory(
          image :: Zexray.Type.Image.t_all(),
          file_type :: binary
        ) :: binary
  def export_to_memory(
        image,
        file_type
      )
      when is_like_image(image) and
             is_binary(file_type) do
    NIF.export_image_to_memory(
      image |> Zexray.Type.Image.to_nif(),
      file_type
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

  @doc """
  Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient
  """
  @doc group: :generation
  @spec gen_gradient_linear(
          width :: integer,
          height :: integer,
          direction :: integer,
          color_start :: Zexray.Type.Color.t_all(),
          color_end :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def gen_gradient_linear(
        width,
        height,
        direction,
        color_start,
        color_end,
        return \\ :value
      )
      when is_integer(width) and
             is_integer(height) and
             is_integer(direction) and
             is_like_color(color_start) and
             is_like_color(color_end) and
             is_nif_return(return) do
    NIF.gen_image_gradient_linear(
      width,
      height,
      direction,
      color_start |> Zexray.Type.Color.to_nif(),
      color_end |> Zexray.Type.Color.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Generate image: radial gradient
  """
  @doc group: :generation
  @spec gen_gradient_radial(
          width :: integer,
          height :: integer,
          density :: float,
          color_inner :: Zexray.Type.Color.t_all(),
          color_outer :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def gen_gradient_radial(
        width,
        height,
        density,
        color_inner,
        color_outer,
        return \\ :value
      )
      when is_integer(width) and
             is_integer(height) and
             is_float(density) and
             is_like_color(color_inner) and
             is_like_color(color_outer) and
             is_nif_return(return) do
    NIF.gen_image_gradient_radial(
      width,
      height,
      density,
      color_inner |> Zexray.Type.Color.to_nif(),
      color_outer |> Zexray.Type.Color.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Generate image: square gradient
  """
  @doc group: :generation
  @spec gen_gradient_square(
          width :: integer,
          height :: integer,
          density :: float,
          color_inner :: Zexray.Type.Color.t_all(),
          color_outer :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def gen_gradient_square(
        width,
        height,
        density,
        color_inner,
        color_outer,
        return \\ :value
      )
      when is_integer(width) and
             is_integer(height) and
             is_float(density) and
             is_like_color(color_inner) and
             is_like_color(color_outer) and
             is_nif_return(return) do
    NIF.gen_image_gradient_square(
      width,
      height,
      density,
      color_inner |> Zexray.Type.Color.to_nif(),
      color_outer |> Zexray.Type.Color.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Generate image: checked
  """
  @doc group: :generation
  @spec gen_checked(
          width :: integer,
          height :: integer,
          checks_x :: integer,
          checks_y :: integer,
          color_1 :: Zexray.Type.Color.t_all(),
          color_2 :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def gen_checked(
        width,
        height,
        checks_x,
        checks_y,
        color_1,
        color_2,
        return \\ :value
      )
      when is_integer(width) and
             is_integer(height) and
             is_integer(checks_x) and
             is_integer(checks_y) and
             is_like_color(color_1) and
             is_like_color(color_2) and
             is_nif_return(return) do
    NIF.gen_image_checked(
      width,
      height,
      checks_x,
      checks_y,
      color_1 |> Zexray.Type.Color.to_nif(),
      color_2 |> Zexray.Type.Color.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Generate image: white noise
  """
  @doc group: :generation
  @spec gen_white_noise(
          width :: integer,
          height :: integer,
          factor :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def gen_white_noise(
        width,
        height,
        factor,
        return \\ :value
      )
      when is_integer(width) and
             is_integer(height) and
             is_float(factor) and
             is_nif_return(return) do
    NIF.gen_image_white_noise(
      width,
      height,
      factor,
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Generate image: perlin noise
  """
  @doc group: :generation
  @spec gen_perlin_noise(
          width :: integer,
          height :: integer,
          offset_x :: integer,
          offset_y :: integer,
          scale :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def gen_perlin_noise(
        width,
        height,
        offset_x,
        offset_y,
        scale,
        return \\ :value
      )
      when is_integer(width) and
             is_integer(height) and
             is_integer(offset_x) and
             is_integer(offset_y) and
             is_float(scale) and
             is_nif_return(return) do
    NIF.gen_image_perlin_noise(
      width,
      height,
      offset_x,
      offset_y,
      scale,
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Generate image: cellular algorithm, bigger tileSize means bigger cells
  """
  @doc group: :generation
  @spec gen_cellular(
          width :: integer,
          height :: integer,
          tile_size :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def gen_cellular(
        width,
        height,
        tile_size,
        return \\ :value
      )
      when is_integer(width) and
             is_integer(height) and
             is_integer(tile_size) and
             is_nif_return(return) do
    NIF.gen_image_cellular(
      width,
      height,
      tile_size,
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Generate image: grayscale image from text data
  """
  @doc group: :generation
  @spec gen_text(
          width :: integer,
          height :: integer,
          text :: binary,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def gen_text(
        width,
        height,
        text,
        return \\ :value
      )
      when is_integer(width) and
             is_integer(height) and
             is_binary(text) and
             is_nif_return(return) do
    NIF.gen_image_text(
      width,
      height,
      text,
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  ########################
  #  Image manipulation  #
  ########################

  @doc """
  Create an image duplicate (useful for transformations)
  """
  @doc group: :manipulation
  @spec copy(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def copy(
        image,
        return \\ :value
      )
      when is_like_image(image) and
             is_nif_return(return) do
    NIF.image_copy(
      image |> Zexray.Type.Image.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Create an image from another image piece
  """
  @doc group: :manipulation
  @spec from_image(
          image :: Zexray.Type.Image.t_all(),
          rec :: Zexray.Type.Rectangle.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def from_image(
        image,
        rec,
        return \\ :value
      )
      when is_like_image(image) and
             is_like_rectangle(rec) and
             is_nif_return(return) do
    NIF.image_from_image(
      image |> Zexray.Type.Image.to_nif(),
      rec |> Zexray.Type.Rectangle.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Create an image from a selected channel of another image (GRAYSCALE)
  """
  @doc group: :manipulation
  @spec from_channel(
          image :: Zexray.Type.Image.t_all(),
          selected_channel :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def from_channel(
        image,
        selected_channel,
        return \\ :value
      )
      when is_like_image(image) and
             is_integer(selected_channel) and
             is_nif_return(return) do
    NIF.image_from_channel(
      image |> Zexray.Type.Image.to_nif(),
      selected_channel,
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Create an image from text (default font)
  """
  @doc group: :manipulation
  @spec text(
          text :: binary,
          font_size :: integer,
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def text(
        text,
        font_size,
        color,
        return \\ :value
      )
      when is_binary(text) and
             is_integer(font_size) and
             is_like_color(color) and
             is_nif_return(return) do
    NIF.image_text(
      text,
      font_size,
      color |> Zexray.Type.Color.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Create an image from text (custom sprite font)
  """
  @doc group: :manipulation
  @spec text_ex(
          font :: Zexray.Type.Font.t_all(),
          text :: binary,
          font_size :: float,
          spacing :: float,
          tint :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def text_ex(
        font,
        text,
        font_size,
        spacing,
        tint,
        return \\ :value
      )
      when is_like_font(font) and
             is_binary(text) and
             is_float(font_size) and
             is_float(spacing) and
             is_like_color(tint) and
             is_nif_return(return) do
    NIF.image_text_ex(
      font |> Zexray.Type.Font.to_nif(),
      text,
      font_size,
      spacing,
      tint |> Zexray.Type.Color.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Convert image data to desired format
  """
  @doc group: :manipulation
  @spec format(
          image :: Zexray.Type.Image.t_all(),
          new_format :: Zexray.Enum.PixelFormat.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def format(
        image,
        new_format,
        return \\ :value
      )
      when is_like_image(image) and
             is_like_pixel_format(new_format) and
             is_nif_return(return) do
    NIF.image_format(
      image |> Zexray.Type.Image.to_nif(),
      Zexray.Enum.PixelFormat.value(new_format),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Convert image to POT (power-of-two)
  """
  @doc group: :manipulation
  @spec to_pot(
          image :: Zexray.Type.Image.t_all(),
          fill :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def to_pot(
        image,
        fill,
        return \\ :value
      )
      when is_like_image(image) and
             is_like_color(fill) and
             is_nif_return(return) do
    NIF.image_to_pot(
      image |> Zexray.Type.Image.to_nif(),
      fill |> Zexray.Type.Color.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

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

  @doc """
  Crop image depending on alpha value
  """
  @doc group: :manipulation
  @spec alpha_crop(
          image :: Zexray.Type.Image.t_all(),
          threshold :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def alpha_crop(
        image,
        threshold,
        return \\ :value
      )
      when is_like_image(image) and
             is_float(threshold) and
             is_nif_return(return) do
    NIF.image_alpha_crop(
      image |> Zexray.Type.Image.to_nif(),
      threshold,
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Clear alpha channel to desired color
  """
  @doc group: :manipulation
  @spec alpha_clear(
          image :: Zexray.Type.Image.t_all(),
          color :: Zexray.Type.Color.t_all(),
          threshold :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def alpha_clear(
        image,
        color,
        threshold,
        return \\ :value
      )
      when is_like_image(image) and
             is_like_color(color) and
             is_float(threshold) and
             is_nif_return(return) do
    NIF.image_alpha_clear(
      image |> Zexray.Type.Image.to_nif(),
      color |> Zexray.Type.Color.to_nif(),
      threshold,
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Apply alpha mask to image
  """
  @doc group: :manipulation
  @spec alpha_mask(
          image :: Zexray.Type.Image.t_all(),
          alpha_mask :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def alpha_mask(
        image,
        alpha_mask,
        return \\ :value
      )
      when is_like_image(image) and
             is_like_image(alpha_mask) and
             is_nif_return(return) do
    NIF.image_alpha_mask(
      image |> Zexray.Type.Image.to_nif(),
      alpha_mask |> Zexray.Type.Image.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Premultiply alpha channel
  """
  @doc group: :manipulation
  @spec alpha_premultiply(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def alpha_premultiply(
        image,
        return \\ :value
      )
      when is_like_image(image) and
             is_nif_return(return) do
    NIF.image_alpha_premultiply(
      image |> Zexray.Type.Image.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Apply Gaussian blur using a box blur approximation
  """
  @doc group: :manipulation
  @spec blur_gaussian(
          image :: Zexray.Type.Image.t_all(),
          blur_size :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def blur_gaussian(
        image,
        blur_size,
        return \\ :value
      )
      when is_like_image(image) and
             is_integer(blur_size) and
             is_nif_return(return) do
    NIF.image_blur_gaussian(
      image |> Zexray.Type.Image.to_nif(),
      blur_size,
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Apply custom square convolution kernel to image
  """
  @doc group: :manipulation
  @spec kernel_convolution(
          image :: Zexray.Type.Image.t_all(),
          kernel :: [float],
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def kernel_convolution(
        image,
        kernel,
        return \\ :value
      )
      when is_like_image(image) and
             is_list(kernel) and (kernel == [] or is_float(hd(kernel))) and
             is_nif_return(return) do
    NIF.image_kernel_convolution(
      image |> Zexray.Type.Image.to_nif(),
      kernel,
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Resize image (Bicubic scaling algorithm)
  """
  @doc group: :manipulation
  @spec resize(
          image :: Zexray.Type.Image.t_all(),
          new_width :: integer,
          new_height :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def resize(
        image,
        new_width,
        new_height,
        return \\ :value
      )
      when is_like_image(image) and
             is_integer(new_width) and
             is_integer(new_height) and
             is_nif_return(return) do
    NIF.image_resize(
      image |> Zexray.Type.Image.to_nif(),
      new_width,
      new_height,
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Resize image (Nearest-Neighbor scaling algorithm)
  """
  @doc group: :manipulation
  @spec resize_nn(
          image :: Zexray.Type.Image.t_all(),
          new_width :: integer,
          new_height :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def resize_nn(
        image,
        new_width,
        new_height,
        return \\ :value
      )
      when is_like_image(image) and
             is_integer(new_width) and
             is_integer(new_height) and
             is_nif_return(return) do
    NIF.image_resize_nn(
      image |> Zexray.Type.Image.to_nif(),
      new_width,
      new_height,
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Resize canvas and fill with color
  """
  @doc group: :manipulation
  @spec resize_canvas(
          image :: Zexray.Type.Image.t_all(),
          new_width :: integer,
          new_height :: integer,
          offset_x :: integer,
          offset_y :: integer,
          fill :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def resize_canvas(
        image,
        new_width,
        new_height,
        offset_x,
        offset_y,
        fill,
        return \\ :value
      )
      when is_like_image(image) and
             is_integer(new_width) and
             is_integer(new_height) and
             is_integer(offset_x) and
             is_integer(offset_y) and
             is_like_color(fill) and
             is_nif_return(return) do
    NIF.image_resize_canvas(
      image |> Zexray.Type.Image.to_nif(),
      new_width,
      new_height,
      offset_x,
      offset_y,
      fill |> Zexray.Type.Color.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Compute all mipmap levels for a provided image
  """
  @doc group: :manipulation
  @spec mipmaps(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def mipmaps(
        image,
        return \\ :value
      )
      when is_like_image(image) and
             is_nif_return(return) do
    NIF.image_mipmaps(
      image |> Zexray.Type.Image.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
  """
  @doc group: :manipulation
  @spec dither(
          image :: Zexray.Type.Image.t_all(),
          r_bpp :: integer,
          g_bpp :: integer,
          b_bpp :: integer,
          a_bpp :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def dither(
        image,
        r_bpp,
        g_bpp,
        b_bpp,
        a_bpp,
        return \\ :value
      )
      when is_like_image(image) and
             is_integer(r_bpp) and
             is_integer(g_bpp) and
             is_integer(b_bpp) and
             is_integer(a_bpp) and
             is_nif_return(return) do
    NIF.image_dither(
      image |> Zexray.Type.Image.to_nif(),
      r_bpp,
      g_bpp,
      b_bpp,
      a_bpp,
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Flip image vertically
  """
  @doc group: :manipulation
  @spec flip_vertical(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def flip_vertical(
        image,
        return \\ :value
      )
      when is_like_image(image) and
             is_nif_return(return) do
    NIF.image_flip_vertical(
      image |> Zexray.Type.Image.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Flip image horizontally
  """
  @doc group: :manipulation
  @spec flip_horizontal(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def flip_horizontal(
        image,
        return \\ :value
      )
      when is_like_image(image) and
             is_nif_return(return) do
    NIF.image_flip_horizontal(
      image |> Zexray.Type.Image.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Rotate image by input angle in degrees (-359 to 359)
  """
  @doc group: :manipulation
  @spec rotate(
          image :: Zexray.Type.Image.t_all(),
          degrees :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def rotate(
        image,
        degrees,
        return \\ :value
      )
      when is_like_image(image) and
             is_integer(degrees) and
             is_nif_return(return) do
    NIF.image_rotate(
      image |> Zexray.Type.Image.to_nif(),
      degrees,
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Rotate image clockwise 90deg
  """
  @doc group: :manipulation
  @spec rotate_cw(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def rotate_cw(
        image,
        return \\ :value
      )
      when is_like_image(image) and
             is_nif_return(return) do
    NIF.image_rotate_cw(
      image |> Zexray.Type.Image.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Rotate image counter-clockwise 90deg
  """
  @doc group: :manipulation
  @spec rotate_ccw(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def rotate_ccw(
        image,
        return \\ :value
      )
      when is_like_image(image) and
             is_nif_return(return) do
    NIF.image_rotate_ccw(
      image |> Zexray.Type.Image.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Modify image color: tint
  """
  @doc group: :manipulation
  @spec color_tint(
          image :: Zexray.Type.Image.t_all(),
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def color_tint(
        image,
        color,
        return \\ :value
      )
      when is_like_image(image) and
             is_like_color(color) and
             is_nif_return(return) do
    NIF.image_color_tint(
      image |> Zexray.Type.Image.to_nif(),
      color |> Zexray.Type.Color.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Modify image color: invert
  """
  @doc group: :manipulation
  @spec color_invert(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def color_invert(
        image,
        return \\ :value
      )
      when is_like_image(image) and
             is_nif_return(return) do
    NIF.image_color_invert(
      image |> Zexray.Type.Image.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Modify image color: grayscale
  """
  @doc group: :manipulation
  @spec color_grayscale(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def color_grayscale(
        image,
        return \\ :value
      )
      when is_like_image(image) and
             is_nif_return(return) do
    NIF.image_color_grayscale(
      image |> Zexray.Type.Image.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Modify image color: contrast (-100 to 100)
  """
  @doc group: :manipulation
  @spec color_contrast(
          image :: Zexray.Type.Image.t_all(),
          contrast :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def color_contrast(
        image,
        contrast,
        return \\ :value
      )
      when is_like_image(image) and
             is_float(contrast) and
             is_nif_return(return) do
    NIF.image_color_contrast(
      image |> Zexray.Type.Image.to_nif(),
      contrast,
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Modify image color: brightness (-255 to 255)
  """
  @doc group: :manipulation
  @spec color_brightness(
          image :: Zexray.Type.Image.t_all(),
          brightness :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def color_brightness(
        image,
        brightness,
        return \\ :value
      )
      when is_like_image(image) and
             is_integer(brightness) and
             is_nif_return(return) do
    NIF.image_color_brightness(
      image |> Zexray.Type.Image.to_nif(),
      brightness,
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Modify image color: replace color
  """
  @doc group: :manipulation
  @spec color_replace(
          image :: Zexray.Type.Image.t_all(),
          color :: Zexray.Type.Color.t_all(),
          replace :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  def color_replace(
        image,
        color,
        replace,
        return \\ :value
      )
      when is_like_image(image) and
             is_like_color(color) and
             is_like_color(replace) and
             is_nif_return(return) do
    NIF.image_color_replace(
      image |> Zexray.Type.Image.to_nif(),
      color |> Zexray.Type.Color.to_nif(),
      replace |> Zexray.Type.Color.to_nif(),
      return
    )
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Load color data from image as a Color array (RGBA - 32bit)
  """
  @doc group: :manipulation
  @spec load_colors(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: [Zexray.Type.Color.t_nif()]
  def load_colors(
        image,
        return \\ :value
      )
      when is_like_image(image) and
             is_nif_return(return) do
    NIF.load_image_colors(
      image |> Zexray.Type.Image.to_nif(),
      return
    )
    |> Zexray.Type.Color.from_nif()
  end

  @doc """
  Load colors palette from image as a Color array (RGBA - 32bit)
  """
  @doc group: :manipulation
  @spec load_palette(
          image :: Zexray.Type.Image.t_all(),
          max_palette_size :: integer,
          return :: :value | :resource
        ) :: [Zexray.Type.Color.t_nif()]
  def load_palette(
        image,
        max_palette_size,
        return \\ :value
      )
      when is_like_image(image) and
             is_integer(max_palette_size) and
             is_nif_return(return) do
    NIF.load_image_palette(
      image |> Zexray.Type.Image.to_nif(),
      max_palette_size,
      return
    )
    |> Zexray.Type.Color.from_nif()
  end

  @doc """
  Get image alpha border rectangle
  """
  @doc group: :manipulation
  @spec get_alpha_border(
          image :: Zexray.Type.Image.t_all(),
          threshold :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Rectangle.t_nif()
  def get_alpha_border(
        image,
        threshold,
        return \\ :value
      )
      when is_like_image(image) and
             is_float(threshold) and
             is_nif_return(return) do
    NIF.get_image_alpha_border(
      image |> Zexray.Type.Image.to_nif(),
      threshold,
      return
    )
    |> Zexray.Type.Rectangle.from_nif()
  end

  @doc """
  Get image pixel color at (x, y) position
  """
  @doc group: :manipulation
  @spec get_color(
          image :: Zexray.Type.Image.t_all(),
          x :: integer,
          y :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Rectangle.t_nif()
  def get_color(
        image,
        x,
        y,
        return \\ :value
      )
      when is_like_image(image) and
             is_integer(x) and
             is_integer(y) and
             is_nif_return(return) do
    NIF.get_image_color(
      image |> Zexray.Type.Image.to_nif(),
      x,
      y,
      return
    )
    |> Zexray.Type.Rectangle.from_nif()
  end
end
