defmodule Zexray.NIF do
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

    lib = ~c"#{:code.priv_dir(:zexray)}/lib/libzexray"
    :erlang.load_nif(lib, 0)

    Application.get_env(:zexray, :trace_log_level, :info)
    |> Zexray.Enum.TraceLogLevel.value()
    |> set_trace_log_level()

    set_trace_log_callback()
  end

  use Zexray.NIF.Resource
  use Zexray.NIF.Audio
  use Zexray.NIF.AutomationEvent
  use Zexray.NIF.Cursor
  use Zexray.NIF.Drawing
  use Zexray.NIF.FileSystem
  use Zexray.NIF.Font
  use Zexray.NIF.FrameControl
  use Zexray.NIF.Image
  use Zexray.NIF.Material
  use Zexray.NIF.Mesh
  use Zexray.NIF.Model
  use Zexray.NIF.ScreenSpace
  use Zexray.NIF.Shader
  use Zexray.NIF.Timing
  use Zexray.NIF.Util
  use Zexray.NIF.Vr
  use Zexray.NIF.Window

  @nifs @nifs_resource ++
          @nifs_audio ++
          @nifs_automation_event ++
          @nifs_cursor ++
          @nifs_drawing ++
          @nifs_file_system ++
          @nifs_font ++
          @nifs_frame_control ++
          @nifs_image ++
          @nifs_material ++
          @nifs_mesh ++
          @nifs_model ++
          @nifs_screen_space ++
          @nifs_shader ++
          @nifs_timing ++
          @nifs_util ++
          @nifs_vr ++
          @nifs_window
end
