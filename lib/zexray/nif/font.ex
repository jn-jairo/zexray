defmodule Zexray.NIF.Font do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_font [
        # Font loading
        get_font_default: 0,
        get_font_default: 1,
        load_font: 1,
        load_font: 2,
        load_font_ex: 4,
        load_font_ex: 5,
        load_font_from_image: 3,
        load_font_from_image: 4,
        load_font_from_memory: 5,
        load_font_from_memory: 6,
        is_font_valid: 1
      ]

      ##################
      #  Font loading  #
      ##################

      @doc """
      Get the default Font

      ```c
      // raylib.h
      RLAPI Font GetFontDefault(void);
      ```
      """
      @doc group: :font_loading
      @spec get_font_default(return :: :auto | :value | :resource) :: tuple
      def get_font_default(_return \\ :auto), do: :erlang.nif_error(:undef)

      @doc """
      Load font from file into GPU memory (VRAM)

      ```c
      // raylib.h
      RLAPI Font LoadFont(const char *fileName);
      ```
      """
      @doc group: :font_loading
      @spec load_font(
              file_name :: binary,
              return :: :auto | :value | :resource
            ) :: tuple
      def load_font(
            _file_name,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set, font size is provided in pixels height

      ```c
      // raylib.h
      RLAPI Font LoadFontEx(const char *fileName, int fontSize, int *codepoints, int codepointCount);
      ```
      """
      @doc group: :font_loading
      @spec load_font_ex(
              file_name :: binary,
              font_size :: integer,
              codepoints :: [integer],
              font_type :: integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def load_font_ex(
            _file_name,
            _font_size,
            _codepoints,
            _font_type,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load font from Image (XNA style)

      ```c
      // raylib.h
      RLAPI Font LoadFontFromImage(Image image, Color key, int firstChar);
      ```
      """
      @doc group: :font_loading
      @spec load_font_from_image(
              image :: tuple,
              key :: tuple,
              first_char :: integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def load_font_from_image(
            _image,
            _key,
            _first_char,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load font from memory buffer, fileType refers to extension: i.e. '.ttf'

      ```c
      // raylib.h
      RLAPI Font LoadFontFromMemory(const char *fileType, const unsigned char *fileData, int dataSize, int fontSize, int *codepoints, int codepointCount);
      ```
      """
      @doc group: :font_loading
      @spec load_font_from_memory(
              file_type :: binary,
              file_data :: binary,
              font_size :: integer,
              codepoints :: [integer],
              font_type :: integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def load_font_from_memory(
            _file_type,
            _file_data,
            _font_size,
            _codepoints,
            _font_type,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check if a font is valid (font data loaded, WARNING: GPU texture not checked)

      ```c
      // raylib.h
      RLAPI bool IsFontValid(Font font);
      ```
      """
      @doc group: :font_loading
      @spec is_font_valid(font :: tuple) :: boolean
      def is_font_valid(_font), do: :erlang.nif_error(:undef)
    end
  end
end
