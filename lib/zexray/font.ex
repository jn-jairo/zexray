defmodule Zexray.Font do
  import Zexray.Guard
  alias Zexray.NIF

  ##################
  #  Font loading  #
  ##################

  @doc """
  Get the default Font
  """
  @doc group: :loading
  @spec get_default(return :: :value | :resource) :: Zexray.Type.Font.t_nif()
  def get_default(return \\ :value)
      when is_nif_return(return) do
    NIF.get_font_default(return)
    |> Zexray.Type.Font.from_nif()
  end

  @doc """
  Load font from file into GPU memory (VRAM)
  """
  @doc group: :loading
  @spec load(
          file_name :: binary,
          return :: :value | :resource
        ) :: Zexray.Type.Font.t_nif()
  def load(
        file_name,
        return \\ :value
      )
      when is_binary(file_name) and
             is_nif_return(return) do
    NIF.load_font(
      file_name,
      return
    )
    |> Zexray.Type.Font.from_nif()
  end

  @doc """
  Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set, font size is provided in pixels height
  """
  @doc group: :loading
  @spec load_ex(
          file_name :: binary,
          font_size :: integer,
          codepoints :: [integer],
          font_type :: Zexray.Enum.FontType.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Font.t_nif()
  def load_ex(
        file_name,
        font_size,
        codepoints \\ [],
        font_type \\ :default,
        return \\ :value
      )
      when is_binary(file_name) and
             is_integer(font_size) and
             is_list(codepoints) and (codepoints == [] or is_integer(hd(codepoints))) and
             is_like_font_type(font_type) and
             is_nif_return(return) do
    NIF.load_font_ex(
      file_name,
      font_size,
      codepoints,
      Zexray.Enum.FontType.value(font_type),
      return
    )
    |> Zexray.Type.Font.from_nif()
  end

  @doc """
  Load font from Image (XNA style)
  """
  @doc group: :loading
  @spec load_from_image(
          image :: Zexray.Type.Image.t_all(),
          key :: Zexray.Type.Color.t_all(),
          first_char :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Font.t_nif()
  def load_from_image(
        image,
        key,
        first_char,
        return \\ :value
      )
      when is_like_image(image) and
             is_like_color(key) and
             is_integer(first_char) and
             is_nif_return(return) do
    NIF.load_font_from_image(
      image |> Zexray.Type.Image.to_nif(),
      key |> Zexray.Type.Color.to_nif(),
      first_char,
      return
    )
    |> Zexray.Type.Font.from_nif()
  end

  @doc """
  Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
  """
  @doc group: :loading
  @spec load_from_memory(
          file_type :: binary,
          file_data :: binary,
          font_size :: integer,
          codepoints :: [integer],
          font_type :: Zexray.Enum.FontType.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Font.t_nif()
  def load_from_memory(
        file_type,
        file_data,
        font_size,
        codepoints \\ [],
        font_type \\ :default,
        return \\ :value
      )
      when is_binary(file_type) and
             is_binary(file_data) and
             is_integer(font_size) and
             is_list(codepoints) and (codepoints == [] or is_integer(hd(codepoints))) and
             is_like_font_type(font_type) and
             is_nif_return(return) do
    NIF.load_font_from_memory(
      file_type,
      file_data,
      font_size,
      codepoints,
      Zexray.Enum.FontType.value(font_type),
      return
    )
    |> Zexray.Type.Font.from_nif()
  end

  @doc """
  Check if a font is valid (font data loaded, WARNING: GPU texture not checked)
  """
  @doc group: :loading
  @spec valid?(font :: Zexray.Type.Font.t_all()) :: boolean
  def valid?(font)
      when is_like_font(font) do
    NIF.is_font_valid(font |> Zexray.Type.Font.to_nif())
  end
end
