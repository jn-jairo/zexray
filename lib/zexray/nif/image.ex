defmodule Zexray.NIF.Image do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_image [
        # Image
        image_get_data_size: 4,

        # Image loading
        load_image: 1,
        load_image: 2,
        load_image_raw: 5,
        load_image_raw: 6,
        load_image_anim: 1,
        load_image_anim: 2,
        load_image_anim_from_memory: 2,
        load_image_anim_from_memory: 3,
        load_image_from_memory: 2,
        load_image_from_memory: 3,
        load_image_from_texture: 1,
        load_image_from_texture: 2,
        load_image_from_screen: 0,
        load_image_from_screen: 1,
        is_image_valid: 1,
        export_image: 2,
        export_image_to_memory: 2,

        # Image generation
        gen_image_color: 3,
        gen_image_color: 4,
        gen_image_gradient_linear: 5,
        gen_image_gradient_linear: 6,
        gen_image_gradient_radial: 5,
        gen_image_gradient_radial: 6,
        gen_image_gradient_square: 5,
        gen_image_gradient_square: 6,
        gen_image_checked: 6,
        gen_image_checked: 7,
        gen_image_white_noise: 3,
        gen_image_white_noise: 4,
        gen_image_perlin_noise: 5,
        gen_image_perlin_noise: 6,
        gen_image_cellular: 3,
        gen_image_cellular: 4,
        gen_image_text: 3,
        gen_image_text: 4,

        # Image manipulation
        image_copy: 1,
        image_copy: 2,
        image_from_image: 2,
        image_from_image: 3,
        image_from_channel: 2,
        image_from_channel: 3,
        image_text: 3,
        image_text: 4,
        image_text_ex: 5,
        image_text_ex: 6,
        image_format: 2,
        image_format: 3,
        image_to_pot: 2,
        image_to_pot: 3,
        image_crop: 2,
        image_crop: 3,
        image_alpha_crop: 2,
        image_alpha_crop: 3,
        image_alpha_clear: 3,
        image_alpha_clear: 4,
        image_alpha_mask: 2,
        image_alpha_mask: 3,
        image_alpha_premultiply: 1,
        image_alpha_premultiply: 2,
        image_blur_gaussian: 2,
        image_blur_gaussian: 3,
        image_kernel_convolution: 2,
        image_kernel_convolution: 3,
        image_resize: 3,
        image_resize: 4,
        image_resize_nn: 3,
        image_resize_nn: 4,
        image_resize_canvas: 6,
        image_resize_canvas: 7,
        image_mipmaps: 1,
        image_mipmaps: 2,
        image_dither: 5,
        image_dither: 6,
        image_flip_vertical: 1,
        image_flip_vertical: 2,
        image_flip_horizontal: 1,
        image_flip_horizontal: 2,
        image_rotate: 2,
        image_rotate: 3,
        image_rotate_cw: 1,
        image_rotate_cw: 2,
        image_rotate_ccw: 1,
        image_rotate_ccw: 2,
        image_color_tint: 2,
        image_color_tint: 3,
        image_color_invert: 1,
        image_color_invert: 2,
        image_color_grayscale: 1,
        image_color_grayscale: 2,
        image_color_contrast: 2,
        image_color_contrast: 3,
        image_color_brightness: 2,
        image_color_brightness: 3,
        image_color_replace: 3,
        image_color_replace: 4,
        load_image_colors: 1,
        load_image_colors: 2,
        load_image_palette: 2,
        load_image_palette: 3,
        get_image_alpha_border: 2,
        get_image_alpha_border: 3,
        get_image_color: 3,
        get_image_color: 4,

        # Image drawing
        image_clear_background: 2,
        image_clear_background: 3,
        image_draw_pixel: 4,
        image_draw_pixel: 5,
        image_draw_pixel_v: 3,
        image_draw_pixel_v: 4,
        image_draw_line: 6,
        image_draw_line: 7,
        image_draw_line_v: 4,
        image_draw_line_v: 5,
        image_draw_line_ex: 5,
        image_draw_line_ex: 6,
        image_draw_circle: 5,
        image_draw_circle: 6,
        image_draw_circle_v: 4,
        image_draw_circle_v: 5,
        image_draw_circle_lines: 5,
        image_draw_circle_lines: 6,
        image_draw_circle_lines_v: 4,
        image_draw_circle_lines_v: 5,
        image_draw_rectangle: 6,
        image_draw_rectangle: 7,
        image_draw_rectangle_v: 4,
        image_draw_rectangle_v: 5,
        image_draw_rectangle_rec: 3,
        image_draw_rectangle_rec: 4,
        image_draw_rectangle_lines: 4,
        image_draw_rectangle_lines: 5,
        image_draw_triangle: 5,
        image_draw_triangle: 6,
        image_draw_triangle_ex: 7,
        image_draw_triangle_ex: 8,
        image_draw_triangle_lines: 5,
        image_draw_triangle_lines: 6,
        image_draw_triangle_fan: 3,
        image_draw_triangle_fan: 4,
        image_draw_triangle_strip: 3,
        image_draw_triangle_strip: 4,
        image_draw: 5,
        image_draw: 6,
        image_draw_text: 6,
        image_draw_text: 7,
        image_draw_text_ex: 7,
        image_draw_text_ex: 8
      ]

      ###########
      #  Image  #
      ###########

      @doc """
      Get image data size in bytes for certain format

      ```zig
      pub fn get_data_size(width: c_int, height: c_int, format: c_int, mipmaps: c_int) usize
      ```
      """
      @doc group: :image
      @spec image_get_data_size(
              width :: integer,
              height :: integer,
              format :: integer,
              mipmaps :: integer
            ) :: non_neg_integer
      def image_get_data_size(
            _width,
            _height,
            _format,
            _mipmaps
          ),
          do: :erlang.nif_error(:undef)

      ###################
      #  Image loading  #
      ###################

      @doc """
      Load image from file into CPU memory (RAM)

      ```c
      // raylib.h
      RLAPI Image LoadImage(const char *fileName);
      ```
      """
      @doc group: :image_loading
      @spec load_image(
              file_name :: binary,
              return :: :value | :resource
            ) :: tuple
      def load_image(
            _file_name,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load image from RAW file data

      ```c
      // raylib.h
      RLAPI Image LoadImageRaw(const char *fileName, int width, int height, int format, int headerSize);
      ```
      """
      @doc group: :image_loading
      @spec load_image_raw(
              file_name :: binary,
              width :: integer,
              height :: integer,
              format :: integer,
              header_size :: integer,
              return :: :value | :resource
            ) :: tuple
      def load_image_raw(
            _file_name,
            _width,
            _height,
            _format,
            _header_size,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load image sequence from file (frames appended to image.data)

      ```c
      // raylib.h
      RLAPI Image LoadImageAnim(const char *fileName, int *frames);
      ```
      """
      @doc group: :image_loading
      @spec load_image_anim(
              file_name :: binary,
              return :: :value | :resource
            ) :: {image :: tuple, frames :: integer}
      def load_image_anim(
            _file_name,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load image sequence from memory buffer

      ```c
      // raylib.h
      RLAPI Image LoadImageAnimFromMemory(const char *fileType, const unsigned char *fileData, int dataSize, int *frames);
      ```
      """
      @doc group: :image_loading
      @spec load_image_anim_from_memory(
              file_type :: binary,
              file_data :: binary,
              return :: :value | :resource
            ) :: {image :: tuple, frames :: integer}
      def load_image_anim_from_memory(
            _file_type,
            _file_data,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load image from memory buffer, fileType refers to extension: i.e. '.png'

      ```c
      // raylib.h
      RLAPI Image LoadImageFromMemory(const char *fileType, const unsigned char *fileData, int dataSize);
      ```
      """
      @doc group: :image_loading
      @spec load_image_from_memory(
              file_type :: binary,
              file_data :: binary,
              return :: :value | :resource
            ) :: tuple
      def load_image_from_memory(
            _file_type,
            _file_data,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load image from GPU texture data

      ```c
      // raylib.h
      RLAPI Image LoadImageFromTexture(Texture2D texture);
      ```
      """
      @doc group: :image_loading
      @spec load_image_from_texture(
              texture :: tuple,
              return :: :value | :resource
            ) :: tuple
      def load_image_from_texture(
            _texture,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load image from screen buffer and (screenshot)

      ```c
      // raylib.h
      RLAPI Image LoadImageFromScreen(void);
      ```
      """
      @doc group: :image_loading
      @spec load_image_from_screen(return :: :value | :resource) :: tuple
      def load_image_from_screen(_return \\ :value), do: :erlang.nif_error(:undef)

      @doc """
      Check if an image is valid (data and parameters)

      ```c
      // raylib.h
      RLAPI bool IsImageValid(Image image);
      ```
      """
      @doc group: :image_loading
      @spec is_image_valid(image :: tuple) :: boolean
      def is_image_valid(_image), do: :erlang.nif_error(:undef)

      @doc """
      Export image data to file, returns true on success

      ```c
      // raylib.h
      RLAPI bool ExportImage(Image image, const char *fileName);
      ```
      """
      @doc group: :image_loading
      @spec export_image(
              image :: tuple,
              file_name :: binary
            ) :: boolean
      def export_image(
            _image,
            _file_name
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Export image to memory buffer

      ```c
      // raylib.h
      RLAPI unsigned char *ExportImageToMemory(Image image, const char *fileType, int *fileSize);
      ```
      """
      @doc group: :image_loading
      @spec export_image_to_memory(
              image :: tuple,
              file_type :: binary
            ) :: binary
      def export_image_to_memory(
            _image,
            _file_type
          ),
          do: :erlang.nif_error(:undef)

      ######################
      #  Image generation  #
      ######################

      @doc """
      Generate image: plain color

      ```c
      // raylib.h
      RLAPI Image GenImageColor(int width, int height, Color color);
      ```
      """
      @doc group: :image_generation
      @spec gen_image_color(
              width :: integer,
              height :: integer,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def gen_image_color(
            _width,
            _height,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient

      ```c
      // raylib.h
      RLAPI Image GenImageGradientLinear(int width, int height, int direction, Color start, Color end);
      ```
      """
      @doc group: :image_generation
      @spec gen_image_gradient_linear(
              width :: integer,
              height :: integer,
              direction :: integer,
              color_start :: tuple,
              color_end :: tuple,
              return :: :value | :resource
            ) :: tuple
      def gen_image_gradient_linear(
            _width,
            _height,
            _direction,
            _color_start,
            _color_end,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Generate image: radial gradient

      ```c
      // raylib.h
      RLAPI Image GenImageGradientRadial(int width, int height, float density, Color inner, Color outer);
      ```
      """
      @doc group: :image_generation
      @spec gen_image_gradient_radial(
              width :: integer,
              height :: integer,
              density :: float,
              color_inner :: tuple,
              color_outer :: tuple,
              return :: :value | :resource
            ) :: tuple
      def gen_image_gradient_radial(
            _width,
            _height,
            _density,
            _color_inner,
            _color_outer,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Generate image: square gradient

      ```c
      // raylib.h
      RLAPI Image GenImageGradientSquare(int width, int height, float density, Color inner, Color outer);
      ```
      """
      @doc group: :image_generation
      @spec gen_image_gradient_square(
              width :: integer,
              height :: integer,
              density :: float,
              color_inner :: tuple,
              color_outer :: tuple,
              return :: :value | :resource
            ) :: tuple
      def gen_image_gradient_square(
            _width,
            _height,
            _density,
            _color_inner,
            _color_outer,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Generate image: checked

      ```c
      // raylib.h
      RLAPI Image GenImageChecked(int width, int height, int checksX, int checksY, Color col1, Color col2);
      ```
      """
      @doc group: :image_generation
      @spec gen_image_checked(
              width :: integer,
              height :: integer,
              checks_x :: integer,
              checks_y :: integer,
              color_1 :: tuple,
              color_2 :: tuple,
              return :: :value | :resource
            ) :: tuple
      def gen_image_checked(
            _width,
            _height,
            _checks_x,
            _checks_y,
            _color_1,
            _color_2,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Generate image: white noise

      ```c
      // raylib.h
      RLAPI Image GenImageWhiteNoise(int width, int height, float factor);
      ```
      """
      @doc group: :image_generation
      @spec gen_image_white_noise(
              width :: integer,
              height :: integer,
              factor :: float,
              return :: :value | :resource
            ) :: tuple
      def gen_image_white_noise(
            _width,
            _height,
            _factor,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Generate image: perlin noise

      ```c
      // raylib.h
      RLAPI Image GenImagePerlinNoise(int width, int height, int offsetX, int offsetY, float scale);
      ```
      """
      @doc group: :image_generation
      @spec gen_image_perlin_noise(
              width :: integer,
              height :: integer,
              offset_x :: integer,
              offset_y :: integer,
              scale :: float,
              return :: :value | :resource
            ) :: tuple
      def gen_image_perlin_noise(
            _width,
            _height,
            _offset_x,
            _offset_y,
            _scale,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Generate image: cellular algorithm, bigger tileSize means bigger cells

      ```c
      // raylib.h
      RLAPI Image GenImageCellular(int width, int height, int tileSize);
      ```
      """
      @doc group: :image_generation
      @spec gen_image_cellular(
              width :: integer,
              height :: integer,
              tile_size :: integer,
              return :: :value | :resource
            ) :: tuple
      def gen_image_cellular(
            _width,
            _height,
            _tile_size,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Generate image: grayscale image from text data

      ```c
      // raylib.h
      RLAPI Image GenImageText(int width, int height, const char *text);
      ```
      """
      @doc group: :image_generation
      @spec gen_image_text(
              width :: integer,
              height :: integer,
              text :: binary,
              return :: :value | :resource
            ) :: tuple
      def gen_image_text(
            _width,
            _height,
            _text,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      ########################
      #  Image manipulation  #
      ########################

      @doc """
      Create an image duplicate (useful for transformations)

      ```c
      // raylib.h
      RLAPI Image ImageCopy(Image image);
      ```
      """
      @doc group: :image_manipulation
      @spec image_copy(
              image :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_copy(
            _image,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Create an image from another image piece

      ```c
      // raylib.h
      RLAPI Image ImageFromImage(Image image, Rectangle rec);
      ```
      """
      @doc group: :image_manipulation
      @spec image_from_image(
              image :: tuple,
              rec :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_from_image(
            _image,
            _rec,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Create an image from a selected channel of another image (GRAYSCALE)

      ```c
      // raylib.h
      RLAPI Image ImageFromChannel(Image image, int selectedChannel);
      ```
      """
      @doc group: :image_manipulation
      @spec image_from_channel(
              image :: tuple,
              selected_channel :: integer,
              return :: :value | :resource
            ) :: tuple
      def image_from_channel(
            _image,
            _selected_channel,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Create an image from text (default font)

      ```c
      // raylib.h
      RLAPI Image ImageText(const char *text, int fontSize, Color color);
      ```
      """
      @doc group: :image_manipulation
      @spec image_text(
              text :: binary,
              font_size :: integer,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_text(
            _text,
            _font_size,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Create an image from text (custom sprite font)

      ```c
      // raylib.h
      RLAPI Image ImageTextEx(Font font, const char *text, float fontSize, float spacing, Color tint);
      ```
      """
      @doc group: :image_manipulation
      @spec image_text_ex(
              font :: tuple,
              text :: binary,
              font_size :: float,
              spacing :: float,
              tint :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_text_ex(
            _font,
            _text,
            _font_size,
            _spacing,
            _tint,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Convert image data to desired format

      ```c
      // raylib.h
      RLAPI void ImageFormat(Image *image, int newFormat);
      ```
      """
      @doc group: :image_manipulation
      @spec image_format(
              image :: tuple,
              new_format :: integer,
              return :: :value | :resource
            ) :: tuple
      def image_format(
            _image,
            _new_format,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Convert image to POT (power-of-two)

      ```c
      // raylib.h
      RLAPI void ImageToPOT(Image *image, Color fill);
      ```
      """
      @doc group: :image_manipulation
      @spec image_to_pot(
              image :: tuple,
              fill :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_to_pot(
            _image,
            _fill,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Crop an image to a defined rectangle

      ```c
      // raylib.h
      RLAPI void ImageCrop(Image *image, Rectangle crop);
      ```
      """
      @doc group: :image_manipulation
      @spec image_crop(
              image :: tuple,
              crop :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_crop(
            _image,
            _crop,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Crop image depending on alpha value

      ```c
      // raylib.h
      RLAPI void ImageAlphaCrop(Image *image, float threshold);
      ```
      """
      @doc group: :image_manipulation
      @spec image_alpha_crop(
              image :: tuple,
              threshold :: float,
              return :: :value | :resource
            ) :: tuple
      def image_alpha_crop(
            _image,
            _threshold,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Clear alpha channel to desired color

      ```c
      // raylib.h
      RLAPI void ImageAlphaClear(Image *image, Color color, float threshold);
      ```
      """
      @doc group: :image_manipulation
      @spec image_alpha_clear(
              image :: tuple,
              color :: tuple,
              threshold :: float,
              return :: :value | :resource
            ) :: tuple
      def image_alpha_clear(
            _image,
            _color,
            _threshold,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Apply alpha mask to image

      ```c
      // raylib.h
      RLAPI void ImageAlphaMask(Image *image, Image alphaMask);
      ```
      """
      @doc group: :image_manipulation
      @spec image_alpha_mask(
              image :: tuple,
              alpha_mask :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_alpha_mask(
            _image,
            _alpha_mask,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Premultiply alpha channel

      ```c
      // raylib.h
      RLAPI void ImageAlphaPremultiply(Image *image);
      ```
      """
      @doc group: :image_manipulation
      @spec image_alpha_premultiply(
              image :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_alpha_premultiply(
            _image,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Apply Gaussian blur using a box blur approximation

      ```c
      // raylib.h
      RLAPI void ImageBlurGaussian(Image *image, int blurSize);
      ```
      """
      @doc group: :image_manipulation
      @spec image_blur_gaussian(
              image :: tuple,
              blur_size :: integer,
              return :: :value | :resource
            ) :: tuple
      def image_blur_gaussian(
            _image,
            _blur_size,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Apply custom square convolution kernel to image

      ```c
      // raylib.h
      RLAPI void ImageKernelConvolution(Image *image, const float *kernel, int kernelSize);
      ```
      """
      @doc group: :image_manipulation
      @spec image_kernel_convolution(
              image :: tuple,
              kernel :: [float],
              return :: :value | :resource
            ) :: tuple
      def image_kernel_convolution(
            _image,
            _kernel,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Resize image (Bicubic scaling algorithm)

      ```c
      // raylib.h
      RLAPI void ImageResize(Image *image, int newWidth, int newHeight);
      ```
      """
      @doc group: :image_manipulation
      @spec image_resize(
              image :: tuple,
              new_width :: integer,
              new_height :: integer,
              return :: :value | :resource
            ) :: tuple
      def image_resize(
            _image,
            _new_width,
            _new_height,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Resize image (Nearest-Neighbor scaling algorithm)

      ```c
      // raylib.h
      RLAPI void ImageResizeNN(Image *image, int newWidth, int newHeight);
      ```
      """
      @doc group: :image_manipulation
      @spec image_resize_nn(
              image :: tuple,
              new_width :: integer,
              new_height :: integer,
              return :: :value | :resource
            ) :: tuple
      def image_resize_nn(
            _image,
            _new_width,
            _new_height,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Resize canvas and fill with color

      ```c
      // raylib.h
      RLAPI void ImageResizeCanvas(Image *image, int newWidth, int newHeight, int offsetX, int offsetY, Color fill);
      ```
      """
      @doc group: :image_manipulation
      @spec image_resize_canvas(
              image :: tuple,
              new_width :: integer,
              new_height :: integer,
              offset_x :: integer,
              offset_y :: integer,
              fill :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_resize_canvas(
            _image,
            _new_width,
            _new_height,
            _offset_x,
            _offset_y,
            _fill,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Compute all mipmap levels for a provided image

      ```c
      // raylib.h
      RLAPI void ImageMipmaps(Image *image);
      ```
      """
      @doc group: :image_manipulation
      @spec image_mipmaps(
              image :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_mipmaps(
            _image,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Dither image data to 16bpp or lower (Floyd-Steinberg dithering)

      ```c
      // raylib.h
      RLAPI void ImageDither(Image *image, int rBpp, int gBpp, int bBpp, int aBpp);
      ```
      """
      @doc group: :image_manipulation
      @spec image_dither(
              image :: tuple,
              r_bpp :: integer,
              g_bpp :: integer,
              b_bpp :: integer,
              a_bpp :: integer,
              return :: :value | :resource
            ) :: tuple
      def image_dither(
            _image,
            _r_bpp,
            _g_bpp,
            _b_bpp,
            _a_bpp,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Flip image vertically

      ```c
      // raylib.h
      RLAPI void ImageFlipVertical(Image *image);
      ```
      """
      @doc group: :image_manipulation
      @spec image_flip_vertical(
              image :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_flip_vertical(
            _image,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Flip image horizontally

      ```c
      // raylib.h
      RLAPI void ImageFlipHorizontal(Image *image);
      ```
      """
      @doc group: :image_manipulation
      @spec image_flip_horizontal(
              image :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_flip_horizontal(
            _image,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Rotate image by input angle in degrees (-359 to 359)

      ```c
      // raylib.h
      RLAPI void ImageRotate(Image *image, int degrees);
      ```
      """
      @doc group: :image_manipulation
      @spec image_rotate(
              image :: tuple,
              degrees :: integer,
              return :: :value | :resource
            ) :: tuple
      def image_rotate(
            _image,
            _degrees,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Rotate image clockwise 90deg

      ```c
      // raylib.h
      RLAPI void ImageRotateCW(Image *image);
      ```
      """
      @doc group: :image_manipulation
      @spec image_rotate_cw(
              image :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_rotate_cw(
            _image,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Rotate image counter-clockwise 90deg

      ```c
      // raylib.h
      RLAPI void ImageRotateCCW(Image *image);
      ```
      """
      @doc group: :image_manipulation
      @spec image_rotate_ccw(
              image :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_rotate_ccw(
            _image,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Modify image color: tint

      ```c
      // raylib.h
      RLAPI void ImageColorTint(Image *image, Color color);
      ```
      """
      @doc group: :image_manipulation
      @spec image_color_tint(
              image :: tuple,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_color_tint(
            _image,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Modify image color: invert

      ```c
      // raylib.h
      RLAPI void ImageColorInvert(Image *image);
      ```
      """
      @doc group: :image_manipulation
      @spec image_color_invert(
              image :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_color_invert(
            _image,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Modify image color: grayscale

      ```c
      // raylib.h
      RLAPI void ImageColorGrayscale(Image *image);
      ```
      """
      @doc group: :image_manipulation
      @spec image_color_grayscale(
              image :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_color_grayscale(
            _image,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Modify image color: contrast (-100 to 100)

      ```c
      // raylib.h
      RLAPI void ImageColorContrast(Image *image, float contrast);
      ```
      """
      @doc group: :image_manipulation
      @spec image_color_contrast(
              image :: tuple,
              contrast :: float,
              return :: :value | :resource
            ) :: tuple
      def image_color_contrast(
            _image,
            _contrast,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Modify image color: brightness (-255 to 255)

      ```c
      // raylib.h
      RLAPI void ImageColorBrightness(Image *image, int brightness);
      ```
      """
      @doc group: :image_manipulation
      @spec image_color_brightness(
              image :: tuple,
              brightness :: integer,
              return :: :value | :resource
            ) :: tuple
      def image_color_brightness(
            _image,
            _brightness,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Modify image color: replace color

      ```c
      // raylib.h
      RLAPI void ImageColorReplace(Image *image, Color color, Color replace);
      ```
      """
      @doc group: :image_manipulation
      @spec image_color_replace(
              image :: tuple,
              color :: tuple,
              replace :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_color_replace(
            _image,
            _color,
            _replace,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load color data from image as a Color array (RGBA - 32bit)

      ```c
      // raylib.h
      RLAPI Color *LoadImageColors(Image image);
      ```
      """
      @doc group: :image_manipulation
      @spec load_image_colors(
              image :: tuple,
              return :: :value | :resource
            ) :: [tuple]
      def load_image_colors(
            _image,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load colors palette from image as a Color array (RGBA - 32bit)

      ```c
      // raylib.h
      RLAPI Color *LoadImagePalette(Image image, int maxPaletteSize, int *colorCount);
      ```
      """
      @doc group: :image_manipulation
      @spec load_image_palette(
              image :: tuple,
              max_palette_size :: integer,
              return :: :value | :resource
            ) :: [tuple]
      def load_image_palette(
            _image,
            _max_palette_size,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get image alpha border rectangle

      ```c
      // raylib.h
      RLAPI Rectangle GetImageAlphaBorder(Image image, float threshold);
      ```
      """
      @doc group: :image_manipulation
      @spec get_image_alpha_border(
              image :: tuple,
              threshold :: float,
              return :: :value | :resource
            ) :: tuple
      def get_image_alpha_border(
            _image,
            _threshold,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get image pixel color at (x, y) position

      ```c
      // raylib.h
      RLAPI Color GetImageColor(Image image, int x, int y);
      ```
      """
      @doc group: :image_manipulation
      @spec get_image_color(
              image :: tuple,
              x :: integer,
              y :: integer,
              return :: :value | :resource
            ) :: tuple
      def get_image_color(
            _image,
            _x,
            _y,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      ###################
      #  Image drawing  #
      ###################

      @doc """
      Clear image background with given color

      ```c
      // raylib.h
      RLAPI void ImageClearBackground(Image *dst, Color color);
      ```
      """
      @doc group: :image_drawing
      @spec image_clear_background(
              dst :: tuple,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_clear_background(
            _dst,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw pixel within an image

      ```c
      // raylib.h
      RLAPI void ImageDrawPixel(Image *dst, int posX, int posY, Color color);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_pixel(
              dst :: tuple,
              pos_x :: integer,
              pos_y :: integer,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_pixel(
            _dst,
            _pos_x,
            _pos_y,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw pixel within an image (Vector version)

      ```c
      // raylib.h
      RLAPI void ImageDrawPixelV(Image *dst, Vector2 position, Color color);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_pixel_v(
              dst :: tuple,
              position :: tuple,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_pixel_v(
            _dst,
            _position,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw line within an image

      ```c
      // raylib.h
      RLAPI void ImageDrawLine(Image *dst, int startPosX, int startPosY, int endPosX, int endPosY, Color color);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_line(
              dst :: tuple,
              start_pos_x :: integer,
              start_pos_y :: integer,
              end_pos_x :: integer,
              end_pos_y :: integer,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_line(
            _dst,
            _start_pos_x,
            _start_pos_y,
            _end_pos_x,
            _end_pos_y,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw line within an image (Vector version)

      ```c
      // raylib.h
      RLAPI void ImageDrawLineV(Image *dst, Vector2 start, Vector2 end, Color color);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_line_v(
              dst :: tuple,
              start_pos :: tuple,
              end_pos :: tuple,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_line_v(
            _dst,
            _start_pos,
            _end_pos,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a line defining thickness within an image

      ```c
      // raylib.h
      RLAPI void ImageDrawLineEx(Image *dst, Vector2 start, Vector2 end, int thick, Color color);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_line_ex(
              dst :: tuple,
              start_pos :: tuple,
              end_pos :: tuple,
              thick :: integer,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_line_ex(
            _dst,
            _start_pos,
            _end_pos,
            _thick,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a filled circle within an image

      ```c
      // raylib.h
      RLAPI void ImageDrawCircle(Image *dst, int centerX, int centerY, int radius, Color color);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_circle(
              dst :: tuple,
              center_x :: integer,
              center_y :: integer,
              radius :: integer,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_circle(
            _dst,
            _center_x,
            _center_y,
            _radius,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a filled circle within an image (Vector version)

      ```c
      // raylib.h
      RLAPI void ImageDrawCircleV(Image *dst, Vector2 center, int radius, Color color);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_circle_v(
              dst :: tuple,
              center :: tuple,
              radius :: integer,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_circle_v(
            _dst,
            _center,
            _radius,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw circle outline within an image

      ```c
      // raylib.h
      RLAPI void ImageDrawCircleLines(Image *dst, int centerX, int centerY, int radius, Color color);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_circle_lines(
              dst :: tuple,
              center_x :: integer,
              center_y :: integer,
              radius :: integer,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_circle_lines(
            _dst,
            _center_x,
            _center_y,
            _radius,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw circle outline within an image (Vector version)

      ```c
      // raylib.h
      RLAPI void ImageDrawCircleLinesV(Image *dst, Vector2 center, int radius, Color color);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_circle_lines_v(
              dst :: tuple,
              center :: tuple,
              radius :: integer,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_circle_lines_v(
            _dst,
            _center,
            _radius,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw rectangle within an image

      ```c
      // raylib.h
      RLAPI void ImageDrawRectangle(Image *dst, int posX, int posY, int width, int height, Color color);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_rectangle(
              dst :: tuple,
              pos_x :: integer,
              pos_y :: integer,
              width :: integer,
              height :: integer,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_rectangle(
            _dst,
            _pos_x,
            _pos_y,
            _width,
            _height,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw rectangle within an image (Vector version)

      ```c
      // raylib.h
      RLAPI void ImageDrawRectangleV(Image *dst, Vector2 position, Vector2 size, Color color);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_rectangle_v(
              dst :: tuple,
              position :: tuple,
              size :: tuple,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_rectangle_v(
            _dst,
            _position,
            _size,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw rectangle within an image

      ```c
      // raylib.h
      RLAPI void ImageDrawRectangleRec(Image *dst, Rectangle rec, Color color);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_rectangle_rec(
              dst :: tuple,
              rec :: tuple,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_rectangle_rec(
            _dst,
            _rec,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw rectangle lines within an image

      ```c
      // raylib.h
      RLAPI void ImageDrawRectangleLines(Image *dst, Rectangle rec, int thick, Color color);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_rectangle_lines(
              dst :: tuple,
              rec :: tuple,
              thick :: integer,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_rectangle_lines(
            _dst,
            _rec,
            _thick,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw triangle within an image

      ```c
      // raylib.h
      RLAPI void ImageDrawTriangle(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color color);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_triangle(
              dst :: tuple,
              v1 :: tuple,
              v2 :: tuple,
              v3 :: tuple,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_triangle(
            _dst,
            _v1,
            _v2,
            _v3,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw triangle with interpolated colors within an image

      ```c
      // raylib.h
      RLAPI void ImageDrawTriangleEx(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color c1, Color c2, Color c3);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_triangle_ex(
              dst :: tuple,
              v1 :: tuple,
              v2 :: tuple,
              v3 :: tuple,
              c1 :: tuple,
              c2 :: tuple,
              c3 :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_triangle_ex(
            _dst,
            _v1,
            _v2,
            _v3,
            _c1,
            _c2,
            _c3,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw triangle outline within an image

      ```c
      // raylib.h
      RLAPI void ImageDrawTriangleLines(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color color);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_triangle_lines(
              dst :: tuple,
              v1 :: tuple,
              v2 :: tuple,
              v3 :: tuple,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_triangle_lines(
            _dst,
            _v1,
            _v2,
            _v3,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a triangle fan defined by points within an image (first vertex is the center)

      ```c
      // raylib.h
      RLAPI void ImageDrawTriangleFan(Image *dst, Vector2 *points, int pointCount, Color color);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_triangle_fan(
              dst :: tuple,
              points :: [tuple],
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_triangle_fan(
            _dst,
            _points,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a triangle strip defined by points within an image

      ```c
      // raylib.h
      RLAPI void ImageDrawTriangleStrip(Image *dst, Vector2 *points, int pointCount, Color color);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_triangle_strip(
              dst :: tuple,
              points :: [tuple],
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_triangle_strip(
            _dst,
            _points,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a source image within a destination image (tint applied to source)

      ```c
      // raylib.h
      RLAPI void ImageDraw(Image *dst, Image src, Rectangle srcRec, Rectangle dstRec, Color tint);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw(
              dst :: tuple,
              src :: tuple,
              src_rec :: tuple,
              dst_rec :: tuple,
              tint :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw(
            _dst,
            _src,
            _src_rec,
            _dst_rec,
            _tint,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw text (using default font) within an image (destination)

      ```c
      // raylib.h
      RLAPI void ImageDrawText(Image *dst, const char *text, int posX, int posY, int fontSize, Color color);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_text(
              dst :: tuple,
              text :: binary,
              pos_x :: integer,
              pos_y :: integer,
              font_size :: integer,
              color :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_text(
            _dst,
            _text,
            _pos_x,
            _pos_y,
            _font_size,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw text (custom sprite font) within an image (destination)

      ```c
      // raylib.h
      RLAPI void ImageDrawTextEx(Image *dst, Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint);
      ```
      """
      @doc group: :image_drawing
      @spec image_draw_text_ex(
              dst :: tuple,
              font :: tuple,
              text :: binary,
              position :: tuple,
              font_size :: float,
              spacing :: float,
              tint :: tuple,
              return :: :value | :resource
            ) :: tuple
      def image_draw_text_ex(
            _dst,
            _font,
            _text,
            _position,
            _font_size,
            _spacing,
            _tint,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)
    end
  end
end
