defmodule Zexray.Texture do
  import Zexray.Guard
  alias Zexray.NIF

  #####################
  #  Texture loading  #
  #####################

  @doc """
  Load texture from file into GPU memory (VRAM)
  """
  @doc group: :loading
  @spec load(
          file_name :: binary,
          return :: :value | :resource
        ) :: Zexray.Type.Texture2D.t_nif()
  def load(
        file_name,
        return \\ :value
      )
      when is_binary(file_name) and
             is_nif_return(return) do
    NIF.load_texture(
      file_name,
      return
    )
    |> Zexray.Type.Texture2D.from_nif()
  end

  @doc """
  Load texture from image data
  """
  @doc group: :loading
  @spec load_from_image(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Texture2D.t_nif()
  def load_from_image(
        image,
        return \\ :value
      )
      when is_like_image(image) and
             is_nif_return(return) do
    NIF.load_texture_from_image(
      image |> Zexray.Type.Image.to_nif(),
      return
    )
    |> Zexray.Type.Texture2D.from_nif()
  end

  @doc """
  Load cubemap from image, multiple image cubemap layouts supported
  """
  @doc group: :loading
  @spec load_cubemap(
          image :: Zexray.Type.Image.t_all(),
          layout :: Zexray.Enum.CubemapLayout.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Texture2D.t_nif()
  def load_cubemap(
        image,
        layout,
        return \\ :value
      )
      when is_like_image(image) and
             is_like_cubemap_layout(layout) and
             is_nif_return(return) do
    NIF.load_texture_cubemap(
      image |> Zexray.Type.Image.to_nif(),
      Zexray.Enum.CubemapLayout.value(layout),
      return
    )
    |> Zexray.Type.Texture2D.from_nif()
  end

  @doc """
  Load texture for rendering (framebuffer)
  """
  @doc group: :loading
  @spec load_render_texture(
          width :: integer,
          height :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.RenderTexture2D.t_nif()
  def load_render_texture(
        width,
        height,
        return \\ :value
      )
      when is_integer(width) and
             is_integer(height) and
             is_nif_return(return) do
    NIF.load_render_texture(
      width,
      height,
      return
    )
    |> Zexray.Type.RenderTexture2D.from_nif()
  end

  @doc """
  Check if a texture is valid (loaded in GPU)
  """
  @doc group: :loading
  @spec valid?(texture :: Zexray.Type.Texture2D.t_all()) :: boolean
  def valid?(texture)
      when is_like_texture_2d(texture) do
    NIF.is_texture_valid(texture |> Zexray.Type.Texture2D.to_nif())
  end

  @doc """
  Check if a render texture is valid (loaded in GPU)
  """
  @doc group: :loading
  @spec render_texture_valid?(target :: Zexray.Type.RenderTexture2D.t_all()) :: boolean
  def render_texture_valid?(target)
      when is_like_render_texture_2d(target) do
    NIF.is_render_texture_valid(target |> Zexray.Type.RenderTexture2D.to_nif())
  end

  @doc """
  Update GPU texture with new data
  """
  @doc group: :loading
  @spec update(
          texture :: Zexray.Type.Texture2D.t_all(),
          pixels :: binary
        ) :: :ok
  def update(
        texture,
        pixels
      )
      when is_like_texture_2d(texture) and
             is_binary(pixels) do
    NIF.update_texture(
      texture |> Zexray.Type.Texture2D.to_nif(),
      pixels
    )
  end

  @doc """
  Update GPU texture rectangle with new data
  """
  @doc group: :loading
  @spec update_rec(
          texture :: Zexray.Type.Texture2D.t_all(),
          rec :: Zexray.Type.Rectangle.t_all(),
          pixels :: binary
        ) :: :ok
  def update_rec(
        texture,
        rec,
        pixels
      )
      when is_like_texture_2d(texture) and
             is_like_rectangle(rec) and
             is_binary(pixels) do
    NIF.update_texture_rec(
      texture |> Zexray.Type.Texture2D.to_nif(),
      rec |> Zexray.Type.Rectangle.to_nif(),
      pixels
    )
  end

  ###########################
  #  Texture configuration  #
  ###########################

  @doc """
  Generate GPU mipmaps for a texture
  """
  @doc group: :configuration
  @spec gen_mipmaps(
          texture :: Zexray.Type.Texture2D.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Texture2D.t_nif()
  def gen_mipmaps(
        texture,
        return \\ :value
      )
      when is_like_texture_2d(texture) and
             is_nif_return(return) do
    NIF.gen_texture_mipmaps(
      texture |> Zexray.Type.Texture2D.to_nif(),
      return
    )
    |> Zexray.Type.Texture2D.from_nif()
  end

  @doc """
  Set texture scaling filter mode
  """
  @doc group: :configuration
  @spec set_filter(
          texture :: Zexray.Type.Texture2D.t_all(),
          filter :: Zexray.Enum.TextureFilter.t_all()
        ) :: :ok
  def set_filter(
        texture,
        filter
      )
      when is_like_texture_2d(texture) and
             is_like_texture_filter(filter) do
    NIF.set_texture_filter(
      texture |> Zexray.Type.Texture2D.to_nif(),
      Zexray.Enum.TextureFilter.value(filter)
    )
  end

  @doc """
  Set texture wrapping mode
  """
  @doc group: :configuration
  @spec set_wrap(
          texture :: Zexray.Type.Texture2D.t_all(),
          wrap :: Zexray.Enum.TextureWrap.t_all()
        ) :: :ok
  def set_wrap(
        texture,
        wrap
      )
      when is_like_texture_2d(texture) and
             is_like_texture_wrap(wrap) do
    NIF.set_texture_wrap(
      texture |> Zexray.Type.Texture2D.to_nif(),
      Zexray.Enum.TextureWrap.value(wrap)
    )
  end

  #####################
  #  Texture drawing  #
  #####################

  @doc """
  Draw a Texture2D
  """
  @doc group: :drawing
  @spec draw(
          texture :: Zexray.Type.Texture2D.t_all(),
          pos_x :: integer,
          pos_y :: integer,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw(
        texture,
        pos_x,
        pos_y,
        tint
      )
      when is_like_texture_2d(texture) and
             is_integer(pos_x) and
             is_integer(pos_y) and
             is_like_color(tint) do
    NIF.draw_texture(
      texture |> Zexray.Type.Texture2D.to_nif(),
      pos_x,
      pos_y,
      tint |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a Texture2D with position defined as Vector2
  """
  @doc group: :drawing
  @spec draw_v(
          texture :: Zexray.Type.Texture2D.t_all(),
          position :: Zexray.Type.Vector2.t_all(),
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_v(
        texture,
        position,
        tint
      )
      when is_like_texture_2d(texture) and
             is_like_vector2(position) and
             is_like_color(tint) do
    NIF.draw_texture_v(
      texture |> Zexray.Type.Texture2D.to_nif(),
      position |> Zexray.Type.Vector2.to_nif(),
      tint |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a Texture2D with extended parameters
  """
  @doc group: :drawing
  @spec draw_ex(
          texture :: Zexray.Type.Texture2D.t_all(),
          position :: Zexray.Type.Vector2.t_all(),
          rotation :: float,
          scale :: float,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_ex(
        texture,
        position,
        rotation,
        scale,
        tint
      )
      when is_like_texture_2d(texture) and
             is_like_vector2(position) and
             is_float(rotation) and
             is_float(scale) and
             is_like_color(tint) do
    NIF.draw_texture_ex(
      texture |> Zexray.Type.Texture2D.to_nif(),
      position |> Zexray.Type.Vector2.to_nif(),
      rotation,
      scale,
      tint |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a part of a texture defined by a rectangle
  """
  @doc group: :drawing
  @spec draw_rec(
          texture :: Zexray.Type.Texture2D.t_all(),
          source :: Zexray.Type.Rectangle.t_all(),
          position :: Zexray.Type.Vector2.t_all(),
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_rec(
        texture,
        source,
        position,
        tint
      )
      when is_like_texture_2d(texture) and
             is_like_rectangle(source) and
             is_like_vector2(position) and
             is_like_color(tint) do
    NIF.draw_texture_rec(
      texture |> Zexray.Type.Texture2D.to_nif(),
      source |> Zexray.Type.Rectangle.to_nif(),
      position |> Zexray.Type.Vector2.to_nif(),
      tint |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a part of a texture defined by a rectangle with 'pro' parameters
  """
  @doc group: :drawing
  @spec draw_pro(
          texture :: Zexray.Type.Texture2D.t_all(),
          source :: Zexray.Type.Rectangle.t_all(),
          dest :: Zexray.Type.Rectangle.t_all(),
          origin :: Zexray.Type.Vector2.t_all(),
          rotation :: float,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_pro(
        texture,
        source,
        dest,
        origin,
        rotation,
        tint
      )
      when is_like_texture_2d(texture) and
             is_like_rectangle(source) and
             is_like_rectangle(dest) and
             is_like_vector2(origin) and
             is_float(rotation) and
             is_like_color(tint) do
    NIF.draw_texture_pro(
      texture |> Zexray.Type.Texture2D.to_nif(),
      source |> Zexray.Type.Rectangle.to_nif(),
      dest |> Zexray.Type.Rectangle.to_nif(),
      origin |> Zexray.Type.Vector2.to_nif(),
      rotation,
      tint |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draws a texture (or part of it) that stretches or shrinks nicely
  """
  @doc group: :drawing
  @spec draw_n_patch(
          texture :: Zexray.Type.Texture2D.t_all(),
          n_patch_info :: Zexray.Type.NPatchInfo.t_all(),
          dest :: Zexray.Type.Rectangle.t_all(),
          origin :: Zexray.Type.Vector2.t_all(),
          rotation :: float,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_n_patch(
        texture,
        n_patch_info,
        dest,
        origin,
        rotation,
        tint
      )
      when is_like_texture_2d(texture) and
             is_like_n_patch_info(n_patch_info) and
             is_like_rectangle(dest) and
             is_like_vector2(origin) and
             is_float(rotation) and
             is_like_color(tint) do
    NIF.draw_texture_n_patch(
      texture |> Zexray.Type.Texture2D.to_nif(),
      n_patch_info |> Zexray.Type.NPatchInfo.to_nif(),
      dest |> Zexray.Type.Rectangle.to_nif(),
      origin |> Zexray.Type.Vector2.to_nif(),
      rotation,
      tint |> Zexray.Type.Color.to_nif()
    )
  end
end
