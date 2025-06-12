defmodule Zexray.Drawing do
  @moduledoc """
  Drawing
  """

  alias Zexray.NIF

  #############
  #  Drawing  #
  #############

  @doc """
  Set background color (framebuffer clear color)
  """
  @spec clear_background(color :: Zexray.Type.Color.t_all()) :: :ok
  defdelegate clear_background(color), to: NIF, as: :clear_background

  @doc """
  Run function with canvas (framebuffer) to drawing and
  end canvas drawing and swap buffers (double buffering after
  """
  @spec with_drawing(func :: (-> any)) :: any
  def with_drawing(func) when is_function(func) do
    try do
      begin_drawing()
      func.()
    after
      end_drawing()
    end
  end

  @doc """
  Setup canvas (framebuffer) to start drawing
  """
  @spec begin_drawing() :: :ok
  defdelegate begin_drawing(), to: NIF, as: :begin_drawing

  @doc """
  End canvas drawing and swap buffers (double buffering)
  """
  @spec end_drawing() :: :ok
  defdelegate end_drawing(), to: NIF, as: :end_drawing

  @doc """
  Run function with 2D mode with custom camera (2D)
  """
  @spec with_mode_2d(
          camera :: Zexray.Type.Camera2D.t_all(),
          func :: (-> any)
        ) :: any
  def with_mode_2d(camera, func) when is_function(func) do
    try do
      begin_mode_2d(camera)
      func.()
    after
      end_mode_2d()
    end
  end

  @doc """
  Begin 2D mode with custom camera (2D)
  """
  @spec begin_mode_2d(camera :: Zexray.Type.Camera2D.t_all()) :: :ok
  defdelegate begin_mode_2d(camera), to: NIF, as: :begin_mode_2d

  @doc """
  Ends 2D mode with custom camera
  """
  @spec end_mode_2d() :: :ok
  defdelegate end_mode_2d(), to: NIF, as: :end_mode_2d

  @doc """
  Run function with 3D mode with custom camera (3D)
  """
  @spec with_mode_3d(
          camera :: Zexray.Type.Camera3D.t_all(),
          func :: (-> any)
        ) :: any
  def with_mode_3d(camera, func) when is_function(func) do
    try do
      begin_mode_3d(camera)
      func.()
    after
      end_mode_3d()
    end
  end

  @doc """
  Begin 3D mode with custom camera (3D)
  """
  @spec begin_mode_3d(camera :: Zexray.Type.Camera3D.t_all()) :: :ok
  defdelegate begin_mode_3d(camera), to: NIF, as: :begin_mode_3d

  @doc """
  Ends 3D mode and returns to default 2D orthographic mode
  """
  @spec end_mode_3d() :: :ok
  defdelegate end_mode_3d(), to: NIF, as: :end_mode_3d

  @doc """
  Run function drawing to render texture
  """
  @spec with_texture_mode(
          target :: Zexray.Type.RenderTexture2D.t_all(),
          func :: (-> any)
        ) :: any
  def with_texture_mode(target, func) when is_function(func) do
    try do
      begin_texture_mode(target)
      func.()
    after
      end_texture_mode()
    end
  end

  @doc """
  Begin drawing to render texture
  """
  @spec begin_texture_mode(target :: Zexray.Type.RenderTexture2D.t_all()) :: :ok
  defdelegate begin_texture_mode(target), to: NIF, as: :begin_texture_mode

  @doc """
  Ends drawing to render texture
  """
  @spec end_texture_mode() :: :ok
  defdelegate end_texture_mode(), to: NIF, as: :end_texture_mode

  @doc """
  Run function with custom shader drawing
  """
  @spec with_shader_mode(
          shader :: Zexray.Type.Shader.t_all(),
          func :: (-> any)
        ) :: any
  def with_shader_mode(shader, func) when is_function(func) do
    try do
      begin_shader_mode(shader)
      func.()
    after
      end_shader_mode()
    end
  end

  @doc """
  Begin custom shader drawing
  """
  @spec begin_shader_mode(shader :: Zexray.Type.Shader.t_all()) :: :ok
  defdelegate begin_shader_mode(shader), to: NIF, as: :begin_shader_mode

  @doc """
  End custom shader drawing (use default shader)
  """
  @spec end_shader_mode() :: :ok
  defdelegate end_shader_mode(), to: NIF, as: :end_shader_mode

  @doc """
  Run function with blending mode (alpha, additive, multiplied, subtract, custom)
  """
  @spec with_blend_mode(
          mode :: Zexray.Enum.BlendMode.t(),
          func :: (-> any)
        ) :: any
  def with_blend_mode(mode, func) when is_function(func) do
    try do
      begin_blend_mode(mode)
      func.()
    after
      end_blend_mode()
    end
  end

  @doc """
  Begin blending mode (alpha, additive, multiplied, subtract, custom)
  """
  @spec begin_blend_mode(mode :: Zexray.Enum.BlendMode.t()) :: :ok
  defdelegate begin_blend_mode(mode), to: NIF, as: :begin_blend_mode

  @doc """
  End blending mode (reset to default: alpha blending)
  """
  @spec end_blend_mode() :: :ok
  defdelegate end_blend_mode(), to: NIF, as: :end_blend_mode

  @doc """
  Run function with scissor mode (define screen area for following drawing)
  """
  @spec with_scissor_mode(
          rec :: Zexray.Type.Rectangle.t_all(),
          func :: (-> any)
        ) :: any
  def with_scissor_mode(rec, func) when is_function(func) do
    try do
      begin_scissor_mode(rec)
      func.()
    after
      end_scissor_mode()
    end
  end

  @doc """
  Run function with scissor mode (define screen area for following drawing)
  """
  @spec with_scissor_mode(
          x :: integer,
          y :: integer,
          width :: integer,
          height :: integer,
          func :: (-> any)
        ) :: any
  def with_scissor_mode(x, y, width, height, func) when is_function(func) do
    try do
      begin_scissor_mode(x, y, width, height)
      func.()
    after
      end_scissor_mode()
    end
  end

  @doc """
  Begin scissor mode (define screen area for following drawing)
  """
  @spec begin_scissor_mode(rec :: Zexray.Type.Rectangle.t_all()) :: :ok
  defdelegate begin_scissor_mode(rec), to: NIF, as: :begin_scissor_mode

  @doc """
  Begin scissor mode (define screen area for following drawing)
  """
  @spec begin_scissor_mode(
          x :: integer,
          y :: integer,
          width :: integer,
          height :: integer
        ) :: :ok
  defdelegate begin_scissor_mode(
                x,
                y,
                width,
                height
              ),
              to: NIF,
              as: :begin_scissor_mode

  @doc """
  End scissor mode
  """
  @spec end_scissor_mode() :: :ok
  defdelegate end_scissor_mode(), to: NIF, as: :end_scissor_mode

  @doc """
  Run function with stereo rendering (requires VR simulator)
  """
  @spec with_vr_stereo_mode(
          config :: Zexray.Type.VrStereoConfig.t_all(),
          func :: (-> any)
        ) :: any
  def with_vr_stereo_mode(config, func) when is_function(func) do
    try do
      begin_vr_stereo_mode(config)
      func.()
    after
      end_vr_stereo_mode()
    end
  end

  @doc """
  Begin stereo rendering (requires VR simulator)
  """
  @spec begin_vr_stereo_mode(config :: Zexray.Type.VrStereoConfig.t_all()) :: :ok
  defdelegate begin_vr_stereo_mode(config), to: NIF, as: :begin_vr_stereo_mode

  @doc """
  End stereo rendering (requires VR simulator)
  """
  @spec end_vr_stereo_mode() :: :ok
  defdelegate end_vr_stereo_mode(), to: NIF, as: :end_vr_stereo_mode
end
