defmodule Zexray.Texture do
  @moduledoc """
  Texture
  """

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
  defdelegate load(
                file_name,
                return \\ :value
              ),
              to: NIF,
              as: :load_texture

  @doc """
  Load texture from image data
  """
  @doc group: :loading
  @spec load_from_image(
          image :: Zexray.Type.Image.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Texture2D.t_nif()
  defdelegate load_from_image(
                image,
                return \\ :value
              ),
              to: NIF,
              as: :load_texture_from_image

  @doc """
  Load cubemap from image, multiple image cubemap layouts supported
  """
  @doc group: :loading
  @spec load_cubemap(
          image :: Zexray.Type.Image.t_all(),
          layout :: Zexray.Enum.CubemapLayout.t(),
          return :: :value | :resource
        ) :: Zexray.Type.Texture2D.t_nif()
  defdelegate load_cubemap(
                image,
                layout,
                return \\ :value
              ),
              to: NIF,
              as: :load_texture_cubemap

  @doc """
  Load texture for rendering (framebuffer)
  """
  @doc group: :loading
  @spec load_render_texture(
          width :: integer,
          height :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.RenderTexture2D.t_nif()
  defdelegate load_render_texture(
                width,
                height,
                return \\ :value
              ),
              to: NIF,
              as: :load_render_texture

  @doc """
  Check if a texture is valid (loaded in GPU)
  """
  @doc group: :loading
  @spec valid?(texture :: Zexray.Type.Texture2D.t_all()) :: boolean
  defdelegate valid?(texture), to: NIF, as: :is_texture_valid

  @doc """
  Check if a render texture is valid (loaded in GPU)
  """
  @doc group: :loading
  @spec render_texture_valid?(target :: Zexray.Type.RenderTexture2D.t_all()) :: boolean
  defdelegate render_texture_valid?(target), to: NIF, as: :is_render_texture_valid

  @doc """
  Update GPU texture with new data
  """
  @doc group: :loading
  @spec update(
          texture :: Zexray.Type.Texture2D.t_all(),
          pixels :: binary
        ) :: :ok
  defdelegate update(
                texture,
                pixels
              ),
              to: NIF,
              as: :update_texture

  @doc """
  Update GPU texture rectangle with new data
  """
  @doc group: :loading
  @spec update_rec(
          texture :: Zexray.Type.Texture2D.t_all(),
          rec :: Zexray.Type.Rectangle.t_all(),
          pixels :: binary
        ) :: :ok
  defdelegate update_rec(
                texture,
                rec,
                pixels
              ),
              to: NIF,
              as: :update_texture_rec

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
  defdelegate gen_mipmaps(
                texture,
                return \\ :value
              ),
              to: NIF,
              as: :gen_texture_mipmaps

  @doc """
  Set texture scaling filter mode
  """
  @doc group: :configuration
  @spec set_filter(
          texture :: Zexray.Type.Texture2D.t_all(),
          filter :: Zexray.Enum.TextureFilter.t()
        ) :: :ok
  defdelegate set_filter(
                texture,
                filter
              ),
              to: NIF,
              as: :set_texture_filter

  @doc """
  Set texture wrapping mode
  """
  @doc group: :configuration
  @spec set_wrap(
          texture :: Zexray.Type.Texture2D.t_all(),
          wrap :: Zexray.Enum.TextureWrap.t()
        ) :: :ok
  defdelegate set_wrap(
                texture,
                wrap
              ),
              to: NIF,
              as: :set_texture_wrap

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
  defdelegate draw(
                texture,
                pos_x,
                pos_y,
                tint
              ),
              to: NIF,
              as: :draw_texture

  @doc """
  Draw a Texture2D with position defined as Vector2
  """
  @doc group: :drawing
  @spec draw_v(
          texture :: Zexray.Type.Texture2D.t_all(),
          position :: Zexray.Type.Vector2.t_all(),
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_v(
                texture,
                position,
                tint
              ),
              to: NIF,
              as: :draw_texture_v

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
  defdelegate draw_ex(
                texture,
                position,
                rotation,
                scale,
                tint
              ),
              to: NIF,
              as: :draw_texture_ex

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
  defdelegate draw_rec(
                texture,
                source,
                position,
                tint
              ),
              to: NIF,
              as: :draw_texture_rec

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
  defdelegate draw_pro(
                texture,
                source,
                dest,
                origin,
                rotation,
                tint
              ),
              to: NIF,
              as: :draw_texture_pro

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
  defdelegate draw_n_patch(
                texture,
                n_patch_info,
                dest,
                origin,
                rotation,
                tint
              ),
              to: NIF,
              as: :draw_texture_n_patch
end
