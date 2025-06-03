defmodule Zexray.Font do
  @moduledoc """
  Font
  """

  use Zexray.Enum

  alias Zexray.NIF

  ##################
  #  Font loading  #
  ##################

  @doc """
  Get the default Font
  """
  @doc group: :loading
  @spec get_default(return :: :auto | :value | :resource) :: Zexray.Type.Font.t_nif()
  defdelegate get_default(return \\ :auto), to: NIF, as: :get_font_default

  @doc """
  Load font from file into GPU memory (VRAM)
  """
  @doc group: :loading
  @spec load(
          file_name :: binary,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Font.t_nif()
  defdelegate load(
                file_name,
                return \\ :auto
              ),
              to: NIF,
              as: :load_font

  @doc """
  Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set, font size is provided in pixels height
  """
  @doc group: :loading
  @spec load_ex(
          file_name :: binary,
          font_size :: integer,
          codepoints :: [integer],
          font_type :: Zexray.Enum.FontType.t(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Font.t_nif()
  defdelegate load_ex(
                file_name,
                font_size,
                codepoints \\ [],
                font_type \\ enum_font_type(:default),
                return \\ :auto
              ),
              to: NIF,
              as: :load_font_ex

  @doc """
  Load font from Image (XNA style)
  """
  @doc group: :loading
  @spec load_from_image(
          image :: Zexray.Type.Image.t_all(),
          key :: Zexray.Type.Color.t_all(),
          first_char :: integer,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Font.t_nif()
  defdelegate load_from_image(
                image,
                key,
                first_char,
                return \\ :auto
              ),
              to: NIF,
              as: :load_font_from_image

  @doc """
  Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
  """
  @doc group: :loading
  @spec load_from_memory(
          file_type :: binary,
          file_data :: binary,
          font_size :: integer,
          codepoints :: [integer],
          font_type :: Zexray.Enum.FontType.t(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Font.t_nif()
  defdelegate load_from_memory(
                file_type,
                file_data,
                font_size,
                codepoints \\ [],
                font_type \\ enum_font_type(:default),
                return \\ :auto
              ),
              to: NIF,
              as: :load_font_from_memory

  @doc """
  Check if a font is valid (font data loaded, WARNING: GPU texture not checked)
  """
  @doc group: :loading
  @spec valid?(font :: Zexray.Type.Font.t_all()) :: boolean
  defdelegate valid?(font), to: NIF, as: :is_font_valid
end
