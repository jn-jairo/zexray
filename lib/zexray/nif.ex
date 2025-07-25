defmodule Zexray.NIF do
  Code.ensure_compiled(Zexray.Enum.TraceLogLevel)

  if Application.compile_env(:zexray, :internal_docs) do
    @moduledoc """
    Internal module, don't use it directly.
    """
  else
    @moduledoc false
  end

  @on_load :__on_load__

  def __on_load__ do
    ld_library_path = System.get_env("LD_LIBRARY_PATH")
    System.put_env("LD_LIBRARY_PATH", "#{:code.priv_dir(:zexray)}/lib/:#{ld_library_path}")

    lib = Path.join(["#{:code.priv_dir(:zexray)}", "lib", "libzexray"])

    :erlang.load_nif(~c"#{lib}", 0)
    |> case do
      :ok ->
        after_load()
        :ok

      {:error, {reason, text}} ->
        raise """
        Failed to load NIF library.

        #{inspect(reason)}
        #{text}
        """
    end
  end

  defp after_load do
    ###############
    #  Trace Log  #
    ###############

    Application.get_env(:zexray, :trace_log_level, :info)
    |> Zexray.Enum.TraceLogLevel.value()
    |> set_trace_log_level()

    set_trace_log_callback()

    #####################
    #  Gamepad Mapping  #
    #####################

    "#{:code.priv_dir(:zexray)}/gamecontrollerdb.txt"
    |> File.read!()
    |> set_gamepad_mappings()

    System.get_env("SDL_GAMECONTROLLERCONFIG", "")
    |> set_gamepad_mappings()

    :ok
  end

  use Zexray.NIF.Resource
  use Zexray.NIF.Audio
  use Zexray.NIF.Camera
  use Zexray.NIF.Color
  use Zexray.NIF.Constant
  use Zexray.NIF.Cursor
  use Zexray.NIF.Drawing
  use Zexray.NIF.FileSystem
  use Zexray.NIF.Font
  use Zexray.NIF.FrameControl
  use Zexray.NIF.Gamepad
  use Zexray.NIF.Gesture
  use Zexray.NIF.Gl
  use Zexray.NIF.Gui
  use Zexray.NIF.Image
  use Zexray.NIF.Keyboard
  use Zexray.NIF.Monitor
  use Zexray.NIF.Mouse
  use Zexray.NIF.Random
  use Zexray.NIF.ScreenSpace
  use Zexray.NIF.Shader
  use Zexray.NIF.Shape
  use Zexray.NIF.Shape3D
  use Zexray.NIF.Text
  use Zexray.NIF.Texture
  use Zexray.NIF.Timing
  use Zexray.NIF.Touch
  use Zexray.NIF.TraceLog
  use Zexray.NIF.Util
  use Zexray.NIF.Vr
  use Zexray.NIF.Window

  @nifs @nifs_resource ++
          @nifs_audio ++
          @nifs_camera ++
          @nifs_color ++
          @nifs_constant ++
          @nifs_cursor ++
          @nifs_drawing ++
          @nifs_file_system ++
          @nifs_font ++
          @nifs_frame_control ++
          @nifs_gamepad ++
          @nifs_gesture ++
          @nifs_gl ++
          @nifs_gui ++
          @nifs_image ++
          @nifs_keyboard ++
          @nifs_monitor ++
          @nifs_mouse ++
          @nifs_random ++
          @nifs_screen_space ++
          @nifs_shader ++
          @nifs_shape ++
          @nifs_shape_3d ++
          @nifs_text ++
          @nifs_texture ++
          @nifs_timing ++
          @nifs_touch ++
          @nifs_trace_log ++
          @nifs_util ++
          @nifs_vr ++
          @nifs_window
end
