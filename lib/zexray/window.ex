defmodule Zexray.Window do
  alias Zexray.NIF

  import Zexray.Guard

  ############
  #  Window  #
  ############

  @doc """
  Initialize window and OpenGL context
  """
  @spec init(
          width :: integer,
          height :: integer,
          title :: binary
        ) :: :ok
  def init(
        width,
        height,
        title
      )
      when is_integer(width) and
             is_integer(height) and
             is_binary(title) do
    NIF.init_window(
      width,
      height,
      title
    )
  end

  @doc """
  Close window and unload OpenGL context
  """
  @spec close() :: :ok
  def close() do
    NIF.close_window()
  end

  @doc """
  Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
  """
  @spec should_close?() :: boolean
  def should_close?() do
    NIF.window_should_close()
  end

  @doc """
  Check if window has been initialized successfully
  """
  @spec ready?() :: boolean
  def ready?() do
    NIF.is_window_ready()
  end

  @doc """
  Check if window is currently fullscreen
  """
  @spec fullscreen?() :: boolean
  def fullscreen?() do
    NIF.is_window_fullscreen()
  end

  @doc """
  Check if window is currently hidden
  """
  @spec hidden?() :: boolean
  def hidden?() do
    NIF.is_window_hidden()
  end

  @doc """
  Check if window is currently minimized
  """
  @spec minimized?() :: boolean
  def minimized?() do
    NIF.is_window_minimized()
  end

  @doc """
  Check if window is currently maximized
  """
  @spec maximized?() :: boolean
  def maximized?() do
    NIF.is_window_maximized()
  end

  @doc """
  Check if window is currently focused
  """
  @spec focused?() :: boolean
  def focused?() do
    NIF.is_window_focused()
  end

  @doc """
  Check if window has been resized last frame
  """
  @spec resized?() :: boolean
  def resized?() do
    NIF.is_window_resized()
  end

  @doc """
  Check if one specific window flag is enabled
  """
  @spec state?(flag :: Zexray.Enum.ConfigFlag.t_all_flag()) :: boolean
  def state?(flag)
      when is_like_config_flag(flag) or
             (is_list(flag) and (flag == [] or is_like_config_flag(hd(flag)))) do
    NIF.is_window_state(Zexray.Enum.ConfigFlag.value_flag(flag))
  end

  @doc """
  Set window configuration state using flags
  """
  @spec set_state(flag :: Zexray.Enum.ConfigFlag.t_all_flag()) :: :ok
  def set_state(flag)
      when is_like_config_flag(flag) or
             (is_list(flag) and (flag == [] or is_like_config_flag(hd(flag)))) do
    NIF.set_window_state(Zexray.Enum.ConfigFlag.value_flag(flag))
  end

  @doc """
  Clear window configuration state flags
  """
  @spec clear_state(flag :: Zexray.Enum.ConfigFlag.t_all_flag()) :: :ok
  def clear_state(flag)
      when is_like_config_flag(flag) or
             (is_list(flag) and (flag == [] or is_like_config_flag(hd(flag)))) do
    NIF.clear_window_state(Zexray.Enum.ConfigFlag.value_flag(flag))
  end

  @doc """
  Toggle window state: fullscreen/windowed, resizes monitor to match window resolution
  """
  @spec toggle_fullscreen() :: :ok
  def toggle_fullscreen() do
    NIF.toggle_fullscreen()
  end

  @doc """
  Toggle window state: borderless windowed, resizes window to match monitor resolution
  """
  @spec toggle_borderless() :: :ok
  def toggle_borderless() do
    NIF.toggle_borderless_windowed()
  end

  @doc """
  Set window state: maximized, if resizable
  """
  @spec maximize() :: :ok
  def maximize() do
    NIF.maximize_window()
  end

  @doc """
  Set window state: minimized, if resizable
  """
  @spec minimize() :: :ok
  def minimize() do
    NIF.minimize_window()
  end

  @doc """
  Set window state: not minimized/maximized
  """
  @spec restore() :: :ok
  def restore() do
    NIF.restore_window()
  end

  @doc """
  Clear window configuration state flags
  """
  @spec set_icon(image :: Zexray.Type.Image.t_all()) :: :ok
  def set_icon(image)
      when is_like_image(image) do
    NIF.set_window_icon(image |> Zexray.Type.Image.to_nif())
  end

  @doc """
  Set icon for window (multiple images, RGBA 32bit)
  """
  @spec set_icons(images :: [Zexray.Type.Image.t_all()]) :: :ok
  def set_icons(images)
      when is_list(images) and (images == [] or is_like_image(hd(images))) do
    NIF.set_window_icons(images |> Zexray.Type.Image.to_nif())
  end

  @doc """
  Set title for window
  """
  @spec set_title(title :: binary) :: :ok
  def set_title(title)
      when is_binary(title) do
    NIF.set_window_title(title)
  end

  @doc """
  Set window position on screen
  """
  @spec set_position(
          x :: integer,
          y :: integer
        ) :: :ok
  def set_position(
        x,
        y
      )
      when is_integer(x) and
             is_integer(y) do
    NIF.set_window_position(
      x,
      y
    )
  end

  @doc """
  Set monitor for the current window
  """
  @spec set_monitor(monitor :: integer) :: :ok
  def set_monitor(monitor)
      when is_integer(monitor) do
    NIF.set_window_monitor(monitor)
  end

  @doc """
  Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
  """
  @spec set_min_size(
          width :: integer,
          height :: integer
        ) :: :ok
  def set_min_size(
        width,
        height
      )
      when is_integer(width) and
             is_integer(height) do
    NIF.set_window_min_size(
      width,
      height
    )
  end

  @doc """
  Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)
  """
  @spec set_max_size(
          width :: integer,
          height :: integer
        ) :: :ok
  def set_max_size(
        width,
        height
      )
      when is_integer(width) and
             is_integer(height) do
    NIF.set_window_max_size(
      width,
      height
    )
  end

  @doc """
  Set window dimensions
  """
  @spec set_size(
          width :: integer,
          height :: integer
        ) :: :ok
  def set_size(
        width,
        height
      )
      when is_integer(width) and
             is_integer(height) do
    NIF.set_window_size(
      width,
      height
    )
  end

  @doc """
  Set window opacity [0.0f..1.0f]
  """
  @spec set_opacity(opacity :: float) :: :ok
  def set_opacity(opacity)
      when is_float(opacity) do
    NIF.set_window_opacity(opacity)
  end

  @doc """
  Set window focused
  """
  @spec set_focused() :: :ok
  def set_focused() do
    NIF.set_window_focused()
  end

  @doc """
  Get current screen width
  """
  @spec get_screen_width() :: integer
  def get_screen_width() do
    NIF.get_screen_width()
  end

  @doc """
  Get current screen height
  """
  @spec get_screen_height() :: integer
  def get_screen_height() do
    NIF.get_screen_height()
  end

  @doc """
  Get current render width (it considers HiDPI)
  """
  @spec get_render_width() :: integer
  def get_render_width() do
    NIF.get_render_width()
  end

  @doc """
  Get current render height (it considers HiDPI)
  """
  @spec get_render_height() :: integer
  def get_render_height() do
    NIF.get_render_height()
  end

  @doc """
  Get number of connected monitors
  """
  @spec get_monitor_count() :: integer
  def get_monitor_count() do
    NIF.get_monitor_count()
  end

  @doc """
  Get current monitor where window is placed
  """
  @spec get_current_monitor() :: integer
  def get_current_monitor() do
    NIF.get_current_monitor()
  end

  @doc """
  Get specified monitor position
  """
  @spec get_monitor_position(
          monitor :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  def get_monitor_position(
        monitor,
        return \\ :value
      )
      when is_integer(monitor) and
             is_nif_return(return) do
    NIF.get_monitor_position(
      monitor,
      return
    )
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Get specified monitor width (current video mode used by monitor)
  """
  @spec get_monitor_width(monitor :: integer) :: integer
  def get_monitor_width(monitor)
      when is_integer(monitor) do
    NIF.get_monitor_width(monitor)
  end

  @doc """
  Get specified monitor height (current video mode used by monitor)
  """
  @spec get_monitor_height(monitor :: integer) :: integer
  def get_monitor_height(monitor)
      when is_integer(monitor) do
    NIF.get_monitor_height(monitor)
  end

  @doc """
  Get specified monitor physical width in millimetres
  """
  @spec get_monitor_physical_width(monitor :: integer) :: integer
  def get_monitor_physical_width(monitor)
      when is_integer(monitor) do
    NIF.get_monitor_physical_width(monitor)
  end

  @doc """
  Get specified monitor physical height in millimetres
  """
  @spec get_monitor_physical_height(monitor :: integer) :: integer
  def get_monitor_physical_height(monitor)
      when is_integer(monitor) do
    NIF.get_monitor_physical_height(monitor)
  end

  @doc """
  Get specified monitor refresh rate
  """
  @spec get_monitor_refresh_rate(monitor :: integer) :: integer
  def get_monitor_refresh_rate(monitor)
      when is_integer(monitor) do
    NIF.get_monitor_refresh_rate(monitor)
  end

  @doc """
  Get window position XY on monitor
  """
  @spec get_position(return :: :value | :resource) :: Zexray.Type.Vector2.t_nif()
  def get_position(return \\ :value)
      when is_nif_return(return) do
    NIF.get_window_position(return)
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Get window scale DPI factor
  """
  @spec get_scale_dpi(return :: :value | :resource) :: Zexray.Type.Vector2.t_nif()
  def get_scale_dpi(return \\ :value)
      when is_nif_return(return) do
    NIF.get_window_scale_dpi(return)
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Get the human-readable, UTF-8 encoded name of the specified monitor
  """
  @spec get_monitor_name(monitor :: integer) :: binary
  def get_monitor_name(monitor)
      when is_integer(monitor) do
    NIF.get_monitor_name(monitor)
  end

  @doc """
  Set clipboard text content
  """
  @spec set_clipboard_text(text :: binary) :: :ok
  def set_clipboard_text(text)
      when is_binary(text) do
    NIF.set_clipboard_text(text)
  end

  @doc """
  Get clipboard text content
  """
  @spec get_clipboard_text() :: binary
  def get_clipboard_text() do
    NIF.get_clipboard_text()
  end

  @doc """
  Get clipboard image content
  """
  @spec get_clipboard_image(return :: :value | :resource) :: Zexray.Type.Image.t_nif()
  def get_clipboard_image(return \\ :value)
      when is_nif_return(return) do
    NIF.get_clipboard_image(return)
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Enable waiting for events on EndDrawing(), no automatic event polling
  """
  @spec enable_event_waiting() :: :ok
  def enable_event_waiting() do
    NIF.enable_event_waiting()
  end

  @doc """
  Disable waiting for events on EndDrawing(), automatic events polling
  """
  @spec disable_event_waiting() :: :ok
  def disable_event_waiting() do
    NIF.disable_event_waiting()
  end
end
