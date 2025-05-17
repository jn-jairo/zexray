defmodule Zexray.Window do
  @moduledoc """
  Window
  """

  import Zexray.Guard
  alias Zexray.NIF

  ####################
  #  Initialization  #
  ####################

  @doc """
  Run function with window and close it after.
  """
  @doc group: :initialization
  @spec with_window(
          width :: integer,
          height :: integer,
          title :: binary,
          func :: (-> any)
        ) :: any
  def with_window(
        width,
        height,
        title,
        func
      )
      when is_integer(width) and
             is_integer(height) and
             is_binary(title) and
             is_function(func) do
    try do
      init(width, height, title)
      func.()
    after
      close()
    end
  end

  @doc """
  Initialize window and OpenGL context
  """
  @doc group: :initialization
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
    ret =
      NIF.init_window(
        width,
        height,
        title
      )

    Zexray.Gamepad.set_default_mappings()

    ret
  end

  @doc """
  Close window and unload OpenGL context
  """
  @doc group: :initialization
  @spec close() :: :ok
  def close() do
    NIF.close_window()
  end

  ###########
  #  State  #
  ###########

  @doc """
  Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
  """
  @doc group: :state
  @spec should_close?() :: boolean
  def should_close?() do
    NIF.window_should_close()
  end

  @doc """
  Check if window has been initialized successfully
  """
  @doc group: :state
  @spec ready?() :: boolean
  def ready?() do
    NIF.is_window_ready()
  end

  @doc """
  Check if window is currently fullscreen
  """
  @doc group: :state
  @spec fullscreen?() :: boolean
  def fullscreen?() do
    NIF.is_window_fullscreen()
  end

  @doc """
  Check if window is currently hidden
  """
  @doc group: :state
  @spec hidden?() :: boolean
  def hidden?() do
    NIF.is_window_hidden()
  end

  @doc """
  Check if window is currently minimized
  """
  @doc group: :state
  @spec minimized?() :: boolean
  def minimized?() do
    NIF.is_window_minimized()
  end

  @doc """
  Check if window is currently maximized
  """
  @doc group: :state
  @spec maximized?() :: boolean
  def maximized?() do
    NIF.is_window_maximized()
  end

  @doc """
  Check if window is currently focused
  """
  @doc group: :state
  @spec focused?() :: boolean
  def focused?() do
    NIF.is_window_focused()
  end

  @doc """
  Check if window has been resized last frame
  """
  @doc group: :state
  @spec resized?() :: boolean
  def resized?() do
    NIF.is_window_resized()
  end

  @doc """
  Check if one specific window flag is enabled
  """
  @doc group: :state
  @spec state?(flag :: Zexray.Enum.ConfigFlag.t_all_flag()) :: boolean
  def state?(flag)
      when is_like_config_flag(flag) or
             (is_list(flag) and (flag == [] or is_like_config_flag(hd(flag)))) do
    NIF.is_window_state(Zexray.Enum.ConfigFlag.value_flag(flag))
  end

  @doc """
  Set window configuration state using flags
  """
  @doc group: :state
  @spec set_state(flag :: Zexray.Enum.ConfigFlag.t_all_flag()) :: :ok
  def set_state(flag)
      when is_like_config_flag(flag) or
             (is_list(flag) and (flag == [] or is_like_config_flag(hd(flag)))) do
    NIF.set_window_state(Zexray.Enum.ConfigFlag.value_flag(flag))
  end

  @doc """
  Setup init configuration flags (view FLAGS)
  """
  @doc group: :state
  @spec set_config_flags(flag :: Zexray.Enum.ConfigFlag.t_all_flag()) :: :ok
  def set_config_flags(flag)
      when is_like_config_flag(flag) or
             (is_list(flag) and (flag == [] or is_like_config_flag(hd(flag)))) do
    NIF.set_config_flags(Zexray.Enum.ConfigFlag.value_flag(flag))
  end

  @doc """
  Clear window configuration state flags
  """
  @doc group: :state
  @spec clear_state(flag :: Zexray.Enum.ConfigFlag.t_all_flag()) :: :ok
  def clear_state(flag)
      when is_like_config_flag(flag) or
             (is_list(flag) and (flag == [] or is_like_config_flag(hd(flag)))) do
    NIF.clear_window_state(Zexray.Enum.ConfigFlag.value_flag(flag))
  end

  @doc """
  Enable waiting for events on EndDrawing(), no automatic event polling
  """
  @doc group: :state
  @spec enable_event_waiting() :: :ok
  def enable_event_waiting() do
    NIF.enable_event_waiting()
  end

  @doc """
  Disable waiting for events on EndDrawing(), automatic events polling
  """
  @doc group: :state
  @spec disable_event_waiting() :: :ok
  def disable_event_waiting() do
    NIF.disable_event_waiting()
  end

  ############
  #  Action  #
  ############

  @doc """
  Toggle window state: fullscreen/windowed, resizes monitor to match window resolution
  """
  @doc group: :action
  @spec toggle_fullscreen() :: :ok
  def toggle_fullscreen() do
    NIF.toggle_fullscreen()
  end

  @doc """
  Toggle window state: borderless windowed, resizes window to match monitor resolution
  """
  @doc group: :action
  @spec toggle_borderless() :: :ok
  def toggle_borderless() do
    NIF.toggle_borderless_windowed()
  end

  @doc """
  Set window state: maximized, if resizable
  """
  @doc group: :action
  @spec maximize() :: :ok
  def maximize() do
    NIF.maximize_window()
  end

  @doc """
  Set window state: minimized, if resizable
  """
  @doc group: :action
  @spec minimize() :: :ok
  def minimize() do
    NIF.minimize_window()
  end

  @doc """
  Set window state: not minimized/maximized
  """
  @doc group: :action
  @spec restore() :: :ok
  def restore() do
    NIF.restore_window()
  end

  @doc """
  Set window focused
  """
  @doc group: :action
  @spec focus() :: :ok
  def focus() do
    NIF.set_window_focused()
  end

  @doc """
  Takes a screenshot of current screen
  """
  @doc group: :action
  @spec screenshot(return :: :value | :resource) :: Zexray.Type.Image.t_nif()
  def screenshot(return \\ :value)
      when is_nif_return(return) do
    NIF.screenshot(return)
    |> Zexray.Type.Image.from_nif()
  end

  @doc """
  Takes a screenshot of current screen (filename extension defines format)
  """
  @doc group: :action
  @spec take_screenshot(file_name :: binary) :: boolean
  def take_screenshot(file_name)
      when is_binary(file_name) do
    NIF.take_screenshot(file_name)
  end

  ##############
  #  Property  #
  ##############

  @doc """
  Set icon for window (single image, RGBA 32bit)
  """
  @doc group: :property
  @spec set_icon(image :: Zexray.Type.Image.t_all()) :: :ok
  def set_icon(image)
      when is_like_image(image) do
    NIF.set_window_icon(image |> Zexray.Type.Image.to_nif())
  end

  @doc """
  Set icon for window (multiple images, RGBA 32bit)
  """
  @doc group: :property
  @spec set_icons(images :: [Zexray.Type.Image.t_all()]) :: :ok
  def set_icons(images)
      when is_list(images) and (images == [] or is_like_image(hd(images))) do
    NIF.set_window_icons(images |> Zexray.Type.Image.to_nif())
  end

  @doc """
  Set title for window
  """
  @doc group: :property
  @spec set_title(title :: binary) :: :ok
  def set_title(title)
      when is_binary(title) do
    NIF.set_window_title(title)
  end

  @doc """
  Set window position on screen
  """
  @doc group: :property
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
  Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
  """
  @doc group: :property
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
  @doc group: :property
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
  @doc group: :property
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
  @doc group: :property
  @spec set_opacity(opacity :: float) :: :ok
  def set_opacity(opacity)
      when is_float(opacity) do
    NIF.set_window_opacity(opacity)
  end

  @doc """
  Get current screen width
  """
  @doc group: :property
  @spec get_screen_width() :: integer
  def get_screen_width() do
    NIF.get_screen_width()
  end

  @doc """
  Get current screen height
  """
  @doc group: :property
  @spec get_screen_height() :: integer
  def get_screen_height() do
    NIF.get_screen_height()
  end

  @doc """
  Get current render width (it considers HiDPI)
  """
  @doc group: :property
  @spec get_render_width() :: integer
  def get_render_width() do
    NIF.get_render_width()
  end

  @doc """
  Get current render height (it considers HiDPI)
  """
  @doc group: :property
  @spec get_render_height() :: integer
  def get_render_height() do
    NIF.get_render_height()
  end

  @doc """
  Get window position XY on monitor
  """
  @doc group: :property
  @spec get_position(return :: :value | :resource) :: Zexray.Type.Vector2.t_nif()
  def get_position(return \\ :value)
      when is_nif_return(return) do
    NIF.get_window_position(return)
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Get window scale DPI factor
  """
  @doc group: :property
  @spec get_scale_dpi(return :: :value | :resource) :: Zexray.Type.Vector2.t_nif()
  def get_scale_dpi(return \\ :value)
      when is_nif_return(return) do
    NIF.get_window_scale_dpi(return)
    |> Zexray.Type.Vector2.from_nif()
  end

  ###############
  #  Clipboard  #
  ###############

  @doc """
  Set clipboard text content
  """
  @doc group: :clipboard
  @spec set_clipboard_text(text :: binary) :: :ok
  def set_clipboard_text(text)
      when is_binary(text) do
    NIF.set_clipboard_text(text)
  end

  @doc """
  Get clipboard text content
  """
  @doc group: :clipboard
  @spec get_clipboard_text() :: binary
  def get_clipboard_text() do
    NIF.get_clipboard_text()
  end

  @doc """
  Get clipboard image content
  """
  @doc group: :clipboard
  @spec get_clipboard_image(return :: :value | :resource) :: Zexray.Type.Image.t_nif()
  def get_clipboard_image(return \\ :value)
      when is_nif_return(return) do
    NIF.get_clipboard_image(return)
    |> Zexray.Type.Image.from_nif()
  end
end
