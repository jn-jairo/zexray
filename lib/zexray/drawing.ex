defmodule Zexray.Drawing do
  alias Zexray.NIF

  import Zexray.Guard

  #############
  #  Drawing  #
  #############

  @doc """
  Set background color (framebuffer clear color)
  """
  @spec clear_background(color :: Zexray.Type.Color.t_all()) :: :ok
  def clear_background(color)
      when is_like_color(color) do
    NIF.clear_background(color |> Zexray.Type.Color.to_nif())
  end

  @doc """
  Setup canvas (framebuffer) to start drawing
  """
  @spec begin_drawing() :: :ok
  def begin_drawing() do
    NIF.begin_drawing()
  end

  @doc """
  End canvas drawing and swap buffers (double buffering)
  """
  @spec end_drawing() :: :ok
  def end_drawing() do
    NIF.end_drawing()
  end

  @doc """
  Begin 2D mode with custom camera (2D)
  """
  @spec begin_mode_2d(camera :: Zexray.Type.Camera2D.t_all()) :: :ok
  def begin_mode_2d(camera)
      when is_like_camera_2d(camera) do
    NIF.begin_mode_2d(camera |> Zexray.Type.Camera2D.to_nif())
  end

  @doc """
  Ends 2D mode with custom camera
  """
  @spec end_mode_2d() :: :ok
  def end_mode_2d() do
    NIF.end_mode_2d()
  end

  @doc """
  Begin 3D mode with custom camera (3D)
  """
  @spec begin_mode_3d(camera :: Zexray.Type.Camera3D.t_all()) :: :ok
  def begin_mode_3d(camera)
      when is_like_camera_3d(camera) do
    NIF.begin_mode_3d(camera |> Zexray.Type.Camera3D.to_nif())
  end

  @doc """
  Ends 3D mode and returns to default 2D orthographic mode
  """
  @spec end_mode_3d() :: :ok
  def end_mode_3d() do
    NIF.end_mode_3d()
  end

  @doc """
  Begin drawing to render texture
  """
  @spec begin_texture_mode(target :: Zexray.Type.RenderTexture2D.t_all()) :: :ok
  def begin_texture_mode(target)
      when is_like_render_texture_2d(target) do
    NIF.begin_texture_mode(target |> Zexray.Type.RenderTexture2D.to_nif())
  end

  @doc """
  Ends drawing to render texture
  """
  @spec end_texture_mode() :: :ok
  def end_texture_mode() do
    NIF.end_texture_mode()
  end

  @doc """
  Begin custom shader drawing
  """
  @spec begin_shader_mode(shader :: Zexray.Type.Shader.t_all()) :: :ok
  def begin_shader_mode(shader)
      when is_like_shader(shader) do
    NIF.begin_shader_mode(shader |> Zexray.Type.Shader.to_nif())
  end

  @doc """
  End custom shader drawing (use default shader)
  """
  @spec end_shader_mode() :: :ok
  def end_shader_mode() do
    NIF.end_shader_mode()
  end

  @doc """
  Begin blending mode (alpha, additive, multiplied, subtract, custom)
  """
  @spec begin_blend_mode(mode :: integer) :: :ok
  def begin_blend_mode(mode)
      when is_integer(mode) do
    NIF.begin_blend_mode(mode)
  end

  @doc """
  End blending mode (reset to default: alpha blending)
  """
  @spec end_blend_mode() :: :ok
  def end_blend_mode() do
    NIF.end_blend_mode()
  end

  @doc """
  Begin scissor mode (define screen area for following drawing)
  """
  @spec begin_scissor_mode(
          x :: integer,
          y :: integer,
          width :: integer,
          height :: integer
        ) :: :ok
  def begin_scissor_mode(
        x,
        y,
        width,
        height
      )
      when is_integer(x) and
             is_integer(y) and
             is_integer(width) and
             is_integer(height) do
    NIF.begin_scissor_mode(x, y, width, height)
  end

  @doc """
  End scissor mode
  """
  @spec end_scissor_mode() :: :ok
  def end_scissor_mode() do
    NIF.end_scissor_mode()
  end

  @doc """
  Begin stereo rendering (requires VR simulator)
  """
  @spec begin_vr_stereo_mode(config :: Zexray.Type.VrStereoConfig.t_all()) :: :ok
  def begin_vr_stereo_mode(config)
      when is_like_vr_stereo_config(config) do
    NIF.begin_vr_stereo_mode(config |> Zexray.Type.VrStereoConfig.to_nif())
  end

  @doc """
  End stereo rendering (requires VR simulator)
  """
  @spec end_vr_stereo_mode() :: :ok
  def end_vr_stereo_mode() do
    NIF.end_vr_stereo_mode()
  end
end
