defmodule Zexray.Image do
  @moduledoc """
  Image
  """

  alias Zexray.NIF

  @doc """
  Get image data size in bytes for certain format
  """
  @spec data_size(
          width :: integer,
          height :: integer,
          format :: Zexray.Enum.PixelFormat.t(),
          mipmaps :: integer
        ) :: non_neg_integer
  defdelegate data_size(
                width,
                height,
                format,
                mipmaps \\ 1
              ),
              to: NIF,
              as: :image_get_data_size

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
  defdelegate load(
                file_name,
                return \\ :value
              ),
              to: NIF,
              as: :load_image

  @doc """
  Load image from RAW file data
  """
  @doc group: :loading
  @spec load_raw(
          file_name :: binary,
          width :: integer,
          height :: integer,
          format :: Zexray.Enum.PixelFormat.t(),
          header_size :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate load_raw(
                file_name,
                width,
                height,
                format,
                header_size,
                return \\ :value
              ),
              to: NIF,
              as: :load_image_raw

  @doc """
  Load image sequence from file (frames appended to image.data)
  """
  @doc group: :loading
  @spec load_anim(
          file_name :: binary,
          return :: :value | :resource
        ) :: {image :: Zexray.Type.Image.t_nif(), frames :: integer}
  defdelegate load_anim(
                file_name,
                return \\ :value
              ),
              to: NIF,
              as: :load_image_anim

  @doc """
  Load image sequence from memory buffer
  """
  @doc group: :loading
  @spec load_anim_from_memory(
          file_type :: binary,
          file_data :: binary,
          return :: :value | :resource
        ) :: {image :: Zexray.Type.Image.t_nif(), frames :: integer}
  defdelegate load_anim_from_memory(
                file_type,
                file_data,
                return \\ :value
              ),
              to: NIF,
              as: :load_image_anim_from_memory

  @doc """
  Load image from memory buffer, fileType refers to extension: i.e. '.png'
  """
  @doc group: :loading
  @spec load_from_memory(
          file_type :: binary,
          file_data :: binary,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate load_from_memory(
                file_type,
                file_data,
                return \\ :value
              ),
              to: NIF,
              as: :load_image_from_memory

  @doc """
  Load image from GPU texture data
  """
  @doc group: :loading
  @spec load_from_texture(
          texture :: Zexray.Type.Texture2D.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate load_from_texture(
                texture,
                return \\ :value
              ),
              to: NIF,
              as: :load_image_from_texture

  @doc """
  Load image from screen buffer and (screenshot)
  """
  @doc group: :loading
  @spec load_from_screen(return :: :value | :resource) :: Zexray.Type.Image.t_nif()
  defdelegate load_from_screen(return \\ :value), to: NIF, as: :load_image_from_screen

  @doc """
  Check if an image is valid (data and parameters)
  """
  @doc group: :loading
  @spec valid?(image :: Zexray.Type.Image.t_all()) :: boolean
  defdelegate valid?(image), to: NIF, as: :is_image_valid

  @doc """
  Export image data to file, returns true on success
  """
  @doc group: :loading
  @spec export(
          image :: Zexray.Type.Image.t_all(),
          file_name :: binary
        ) :: boolean
  defdelegate export(
                image,
                file_name
              ),
              to: NIF,
              as: :export_image

  @doc """
  Export image to memory buffer
  """
  @doc group: :loading
  @spec export_to_memory(
          image :: Zexray.Type.Image.t_all(),
          file_type :: binary
        ) :: binary
  defdelegate export_to_memory(
                image,
                file_type
              ),
              to: NIF,
              as: :export_image_to_memory

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
  defdelegate gen_color(
                width,
                height,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :gen_image_color

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
  defdelegate gen_gradient_linear(
                width,
                height,
                direction,
                color_start,
                color_end,
                return \\ :value
              ),
              to: NIF,
              as: :gen_image_gradient_linear

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
  defdelegate gen_gradient_radial(
                width,
                height,
                density,
                color_inner,
                color_outer,
                return \\ :value
              ),
              to: NIF,
              as: :gen_image_gradient_radial

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
  defdelegate gen_gradient_square(
                width,
                height,
                density,
                color_inner,
                color_outer,
                return \\ :value
              ),
              to: NIF,
              as: :gen_image_gradient_square

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
  defdelegate gen_checked(
                width,
                height,
                checks_x,
                checks_y,
                color_1,
                color_2,
                return \\ :value
              ),
              to: NIF,
              as: :gen_image_checked

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
  defdelegate gen_white_noise(
                width,
                height,
                factor,
                return \\ :value
              ),
              to: NIF,
              as: :gen_image_white_noise

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
  defdelegate gen_perlin_noise(
                width,
                height,
                offset_x,
                offset_y,
                scale,
                return \\ :value
              ),
              to: NIF,
              as: :gen_image_perlin_noise

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
  defdelegate gen_cellular(
                width,
                height,
                tile_size,
                return \\ :value
              ),
              to: NIF,
              as: :gen_image_cellular

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
  defdelegate gen_text(
                width,
                height,
                text,
                return \\ :value
              ),
              to: NIF,
              as: :gen_image_text

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
  defdelegate copy(
                image,
                return \\ :value
              ),
              to: NIF,
              as: :image_copy

  @doc """
  Create an image from another image piece
  """
  @doc group: :manipulation
  @spec from_image(
          image :: Zexray.Type.Image.t_all(),
          rec :: Zexray.Type.Rectangle.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate from_image(
                image,
                rec,
                return \\ :value
              ),
              to: NIF,
              as: :image_from_image

  @doc """
  Create an image from a selected channel of another image (GRAYSCALE)
  """
  @doc group: :manipulation
  @spec from_channel(
          image :: Zexray.Type.Image.t_all(),
          selected_channel :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate from_channel(
                image,
                selected_channel,
                return \\ :value
              ),
              to: NIF,
              as: :image_from_channel

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
  defdelegate text(
                text,
                font_size,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_text

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
  defdelegate text_ex(
                font,
                text,
                font_size,
                spacing,
                tint,
                return \\ :value
              ),
              to: NIF,
              as: :image_text_ex

  @doc """
  Convert image data to desired format
  """
  @doc group: :manipulation
  @spec format(
          image :: Zexray.Type.Image.t_all(),
          new_format :: Zexray.Enum.PixelFormat.t(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate format(
                image,
                new_format,
                return \\ :value
              ),
              to: NIF,
              as: :image_format

  @doc """
  Convert image to POT (power-of-two)
  """
  @doc group: :manipulation
  @spec to_pot(
          image :: Zexray.Type.Image.t_all(),
          fill :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate to_pot(
                image,
                fill,
                return \\ :value
              ),
              to: NIF,
              as: :image_to_pot

  @doc """
  Crop an image to a defined rectangle
  """
  @doc group: :manipulation
  @spec crop(
          image :: Zexray.Type.Image.t_all(),
          crop :: Zexray.Type.Rectangle.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate crop(
                image,
                crop,
                return \\ :value
              ),
              to: NIF,
              as: :image_crop

  @doc """
  Crop image depending on alpha value
  """
  @doc group: :manipulation
  @spec alpha_crop(
          image :: Zexray.Type.Image.t_all(),
          threshold :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate alpha_crop(
                image,
                threshold,
                return \\ :value
              ),
              to: NIF,
              as: :image_alpha_crop

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
  defdelegate alpha_clear(
                image,
                color,
                threshold,
                return \\ :value
              ),
              to: NIF,
              as: :image_alpha_clear

  @doc """
  Apply alpha mask to image
  """
  @doc group: :manipulation
  @spec alpha_mask(
          image :: Zexray.Type.Image.t_all(),
          alpha_mask :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate alpha_mask(
                image,
                alpha_mask,
                return \\ :value
              ),
              to: NIF,
              as: :image_alpha_mask

  @doc """
  Premultiply alpha channel
  """
  @doc group: :manipulation
  @spec alpha_premultiply(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate alpha_premultiply(
                image,
                return \\ :value
              ),
              to: NIF,
              as: :image_alpha_premultiply

  @doc """
  Apply Gaussian blur using a box blur approximation
  """
  @doc group: :manipulation
  @spec blur_gaussian(
          image :: Zexray.Type.Image.t_all(),
          blur_size :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate blur_gaussian(
                image,
                blur_size,
                return \\ :value
              ),
              to: NIF,
              as: :image_blur_gaussian

  @doc """
  Apply custom square convolution kernel to image
  """
  @doc group: :manipulation
  @spec kernel_convolution(
          image :: Zexray.Type.Image.t_all(),
          kernel :: [float],
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate kernel_convolution(
                image,
                kernel,
                return \\ :value
              ),
              to: NIF,
              as: :image_kernel_convolution

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
  defdelegate resize(
                image,
                new_width,
                new_height,
                return \\ :value
              ),
              to: NIF,
              as: :image_resize

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
  defdelegate resize_nn(
                image,
                new_width,
                new_height,
                return \\ :value
              ),
              to: NIF,
              as: :image_resize_nn

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
  defdelegate resize_canvas(
                image,
                new_width,
                new_height,
                offset_x,
                offset_y,
                fill,
                return \\ :value
              ),
              to: NIF,
              as: :image_resize_canvas

  @doc """
  Compute all mipmap levels for a provided image
  """
  @doc group: :manipulation
  @spec mipmaps(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate mipmaps(
                image,
                return \\ :value
              ),
              to: NIF,
              as: :image_mipmaps

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
  defdelegate dither(
                image,
                r_bpp,
                g_bpp,
                b_bpp,
                a_bpp,
                return \\ :value
              ),
              to: NIF,
              as: :image_dither

  @doc """
  Flip image vertically
  """
  @doc group: :manipulation
  @spec flip_vertical(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate flip_vertical(
                image,
                return \\ :value
              ),
              to: NIF,
              as: :image_flip_vertical

  @doc """
  Flip image horizontally
  """
  @doc group: :manipulation
  @spec flip_horizontal(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate flip_horizontal(
                image,
                return \\ :value
              ),
              to: NIF,
              as: :image_flip_horizontal

  @doc """
  Rotate image by input angle in degrees (-359 to 359)
  """
  @doc group: :manipulation
  @spec rotate(
          image :: Zexray.Type.Image.t_all(),
          degrees :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate rotate(
                image,
                degrees,
                return \\ :value
              ),
              to: NIF,
              as: :image_rotate

  @doc """
  Rotate image clockwise 90deg
  """
  @doc group: :manipulation
  @spec rotate_cw(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate rotate_cw(
                image,
                return \\ :value
              ),
              to: NIF,
              as: :image_rotate_cw

  @doc """
  Rotate image counter-clockwise 90deg
  """
  @doc group: :manipulation
  @spec rotate_ccw(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate rotate_ccw(
                image,
                return \\ :value
              ),
              to: NIF,
              as: :image_rotate_ccw

  @doc """
  Modify image color: tint
  """
  @doc group: :manipulation
  @spec color_tint(
          image :: Zexray.Type.Image.t_all(),
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate color_tint(
                image,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_color_tint

  @doc """
  Modify image color: invert
  """
  @doc group: :manipulation
  @spec color_invert(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate color_invert(
                image,
                return \\ :value
              ),
              to: NIF,
              as: :image_color_invert

  @doc """
  Modify image color: grayscale
  """
  @doc group: :manipulation
  @spec color_grayscale(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate color_grayscale(
                image,
                return \\ :value
              ),
              to: NIF,
              as: :image_color_grayscale

  @doc """
  Modify image color: contrast (-100 to 100)
  """
  @doc group: :manipulation
  @spec color_contrast(
          image :: Zexray.Type.Image.t_all(),
          contrast :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate color_contrast(
                image,
                contrast,
                return \\ :value
              ),
              to: NIF,
              as: :image_color_contrast

  @doc """
  Modify image color: brightness (-255 to 255)
  """
  @doc group: :manipulation
  @spec color_brightness(
          image :: Zexray.Type.Image.t_all(),
          brightness :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate color_brightness(
                image,
                brightness,
                return \\ :value
              ),
              to: NIF,
              as: :image_color_brightness

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
  defdelegate color_replace(
                image,
                color,
                replace,
                return \\ :value
              ),
              to: NIF,
              as: :image_color_replace

  @doc """
  Load color data from image as a Color array (RGBA - 32bit)
  """
  @doc group: :manipulation
  @spec load_colors(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: [Zexray.Type.Color.t_nif()]
  defdelegate load_colors(
                image,
                return \\ :value
              ),
              to: NIF,
              as: :load_image_colors

  @doc """
  Load colors palette from image as a Color array (RGBA - 32bit)
  """
  @doc group: :manipulation
  @spec load_palette(
          image :: Zexray.Type.Image.t_all(),
          max_palette_size :: integer,
          return :: :value | :resource
        ) :: [Zexray.Type.Color.t_nif()]
  defdelegate load_palette(
                image,
                max_palette_size,
                return \\ :value
              ),
              to: NIF,
              as: :load_image_palette

  @doc """
  Get image alpha border rectangle
  """
  @doc group: :manipulation
  @spec get_alpha_border(
          image :: Zexray.Type.Image.t_all(),
          threshold :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Rectangle.t_nif()
  defdelegate get_alpha_border(
                image,
                threshold,
                return \\ :value
              ),
              to: NIF,
              as: :get_image_alpha_border

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
  defdelegate get_color(
                image,
                x,
                y,
                return \\ :value
              ),
              to: NIF,
              as: :get_image_color

  ###################
  #  Image drawing  #
  ###################

  @doc """
  Clear image background with given color
  """
  @doc group: :drawing
  @spec clear_background(
          dst :: Zexray.Type.Image.t_all(),
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate clear_background(
                dst,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_clear_background

  @doc """
  Draw pixel within an image
  """
  @doc group: :drawing
  @spec draw_pixel(
          dst :: Zexray.Type.Image.t_all(),
          pos_x :: integer,
          pos_y :: integer,
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_pixel(
                dst,
                pos_x,
                pos_y,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_pixel

  @doc """
  Draw pixel within an image (Vector version)
  """
  @doc group: :drawing
  @spec draw_pixel_v(
          dst :: Zexray.Type.Image.t_all(),
          position :: Zexray.Type.Vector2.t_all(),
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_pixel_v(
                dst,
                position,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_pixel_v

  @doc """
  Draw line within an image
  """
  @doc group: :drawing
  @spec draw_line(
          dst :: Zexray.Type.Image.t_all(),
          start_pos_x :: integer,
          start_pos_y :: integer,
          end_pos_x :: integer,
          end_pos_y :: integer,
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_line(
                dst,
                start_pos_x,
                start_pos_y,
                end_pos_x,
                end_pos_y,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_line

  @doc """
  Draw line within an image (Vector version)
  """
  @doc group: :drawing
  @spec draw_line_v(
          dst :: Zexray.Type.Image.t_all(),
          start_pos :: Zexray.Type.Vector2.t_all(),
          end_pos :: Zexray.Type.Vector2.t_all(),
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_line_v(
                dst,
                start_pos,
                end_pos,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_line_v

  @doc """
  Draw a line defining thickness within an image
  """
  @doc group: :drawing
  @spec draw_line_ex(
          dst :: Zexray.Type.Image.t_all(),
          start_pos :: Zexray.Type.Vector2.t_all(),
          end_pos :: Zexray.Type.Vector2.t_all(),
          thick :: integer,
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_line_ex(
                dst,
                start_pos,
                end_pos,
                thick,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_line_ex

  @doc """
  Draw a filled circle within an image
  """
  @doc group: :drawing
  @spec draw_circle(
          dst :: Zexray.Type.Image.t_all(),
          center_x :: integer,
          center_y :: integer,
          radius :: integer,
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_circle(
                dst,
                center_x,
                center_y,
                radius,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_circle

  @doc """
  Draw a filled circle within an image (Vector version)
  """
  @doc group: :drawing
  @spec draw_circle_v(
          dst :: Zexray.Type.Image.t_all(),
          center :: Zexray.Type.Vector2.t_all(),
          radius :: integer,
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_circle_v(
                dst,
                center,
                radius,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_circle_v

  @doc """
  Draw circle outline within an image
  """
  @doc group: :drawing
  @spec draw_circle_lines(
          dst :: Zexray.Type.Image.t_all(),
          center_x :: integer,
          center_y :: integer,
          radius :: integer,
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_circle_lines(
                dst,
                center_x,
                center_y,
                radius,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_circle_lines

  @doc """
  Draw circle outline within an image (Vector version)
  """
  @doc group: :drawing
  @spec draw_circle_lines_v(
          dst :: Zexray.Type.Image.t_all(),
          center :: Zexray.Type.Vector2.t_all(),
          radius :: integer,
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_circle_lines_v(
                dst,
                center,
                radius,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_circle_lines_v

  @doc """
  Draw rectangle within an image
  """
  @doc group: :drawing
  @spec draw_rectangle(
          dst :: Zexray.Type.Image.t_all(),
          pos_x :: integer,
          pos_y :: integer,
          width :: integer,
          height :: integer,
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_rectangle(
                dst,
                pos_x,
                pos_y,
                width,
                height,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_rectangle

  @doc """
  Draw rectangle within an image (Vector version)
  """
  @doc group: :drawing
  @spec draw_rectangle_v(
          dst :: Zexray.Type.Image.t_all(),
          position :: Zexray.Type.Vector2.t_all(),
          size :: Zexray.Type.Vector2.t_all(),
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_rectangle_v(
                dst,
                position,
                size,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_rectangle_v

  @doc """
  Draw rectangle within an image
  """
  @doc group: :drawing
  @spec draw_rectangle_rec(
          dst :: Zexray.Type.Image.t_all(),
          rec :: Zexray.Type.Rectangle.t_all(),
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_rectangle_rec(
                dst,
                rec,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_rectangle_rec

  @doc """
  Draw rectangle lines within an image
  """
  @doc group: :drawing
  @spec draw_rectangle_lines(
          dst :: Zexray.Type.Image.t_all(),
          rec :: Zexray.Type.Rectangle.t_all(),
          thick :: integer,
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_rectangle_lines(
                dst,
                rec,
                thick,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_rectangle_lines

  @doc """
  Draw triangle within an image
  """
  @doc group: :drawing
  @spec draw_triangle(
          dst :: Zexray.Type.Image.t_all(),
          v1 :: Zexray.Type.Vector2.t_all(),
          v2 :: Zexray.Type.Vector2.t_all(),
          v3 :: Zexray.Type.Vector2.t_all(),
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_triangle(
                dst,
                v1,
                v2,
                v3,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_triangle

  @doc """
  Draw triangle with interpolated colors within an image
  """
  @doc group: :drawing
  @spec draw_triangle_ex(
          dst :: Zexray.Type.Image.t_all(),
          v1 :: Zexray.Type.Vector2.t_all(),
          v2 :: Zexray.Type.Vector2.t_all(),
          v3 :: Zexray.Type.Vector2.t_all(),
          c1 :: Zexray.Type.Color.t_all(),
          c2 :: Zexray.Type.Color.t_all(),
          c3 :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_triangle_ex(
                dst,
                v1,
                v2,
                v3,
                c1,
                c2,
                c3,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_triangle_ex

  @doc """
  Draw triangle outline within an image
  """
  @doc group: :drawing
  @spec draw_triangle_lines(
          dst :: Zexray.Type.Image.t_all(),
          v1 :: Zexray.Type.Vector2.t_all(),
          v2 :: Zexray.Type.Vector2.t_all(),
          v3 :: Zexray.Type.Vector2.t_all(),
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_triangle_lines(
                dst,
                v1,
                v2,
                v3,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_triangle_lines

  @doc """
  Draw a triangle fan defined by points within an image (first vertex is the center)
  """
  @doc group: :drawing
  @spec draw_triangle_fan(
          dst :: Zexray.Type.Image.t_all(),
          points :: [Zexray.Type.Vector2.t_all()],
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_triangle_fan(
                dst,
                points,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_triangle_fan

  @doc """
  Draw a triangle strip defined by points within an image
  """
  @doc group: :drawing
  @spec draw_triangle_strip(
          dst :: Zexray.Type.Image.t_all(),
          points :: [Zexray.Type.Vector2.t_all()],
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_triangle_strip(
                dst,
                points,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_triangle_strip

  @doc """
  Draw a source image within a destination image (tint applied to source)
  """
  @doc group: :drawing
  @spec draw(
          dst :: Zexray.Type.Image.t_all(),
          src :: Zexray.Type.Image.t_all(),
          src_rec :: Zexray.Type.Rectangle.t_all(),
          dst_rec :: Zexray.Type.Rectangle.t_all(),
          tint :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw(
                dst,
                src,
                src_rec,
                dst_rec,
                tint,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw

  @doc """
  Draw text (using default font) within an image (destination)
  """
  @doc group: :drawing
  @spec draw_text(
          dst :: Zexray.Type.Image.t_all(),
          text :: binary,
          pos_x :: integer,
          pos_y :: integer,
          font_size :: integer,
          color :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_text(
                dst,
                text,
                pos_x,
                pos_y,
                font_size,
                color,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_text

  @doc """
  Draw text (custom sprite font) within an image (destination)
  """
  @doc group: :drawing
  @spec draw_text_ex(
          dst :: Zexray.Type.Image.t_all(),
          font :: Zexray.Type.Font.t_all(),
          text :: binary,
          position :: Zexray.Type.Vector2.t_all(),
          font_size :: float,
          spacing :: float,
          tint :: Zexray.Type.Color.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Image.t_nif()
  defdelegate draw_text_ex(
                dst,
                font,
                text,
                position,
                font_size,
                spacing,
                tint,
                return \\ :value
              ),
              to: NIF,
              as: :image_draw_text_ex
end
