defmodule Zexray.NIF.Image do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_image [
        # Image
        image_get_data_size: 4,

        # Image generation
        gen_image_color: 3,
        gen_image_color: 4,

        # Image manipulation
        image_crop: 2,
        image_crop: 3
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
              color :: map | reference,
              return :: :value | :resource
            ) :: map | reference
      def gen_image_color(
            _width,
            _height,
            _color,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      ########################
      #  Image manipulation  #
      ########################

      @doc """
      Crop an image to a defined rectangle

      ```c
      // raylib.h
      RLAPI void ImageCrop(Image *image, Rectangle crop);
      ```
      """
      @doc group: :image_manipulation
      @spec image_crop(
              image :: map | reference,
              crop :: map | reference,
              return :: :value | :resource
            ) :: map | reference
      def image_crop(
            _image,
            _crop,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)
    end
  end
end
