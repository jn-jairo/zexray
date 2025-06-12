defmodule Zexray.Window do
  @moduledoc """
  Window
  """

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
  def with_window(width, height, title, func) when is_function(func) do
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
      ) do
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
  defdelegate close(), to: NIF, as: :close_window

  ###########
  #  State  #
  ###########

  @doc """
  Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
  """
  @doc group: :state
  @spec should_close?() :: boolean
  defdelegate should_close?(), to: NIF, as: :window_should_close

  @doc """
  Check if window has been initialized successfully
  """
  @doc group: :state
  @spec ready?() :: boolean
  defdelegate ready?(), to: NIF, as: :is_window_ready

  @doc """
  Check if window is currently fullscreen
  """
  @doc group: :state
  @spec fullscreen?() :: boolean
  defdelegate fullscreen?(), to: NIF, as: :is_window_fullscreen

  @doc """
  Check if window is currently hidden
  """
  @doc group: :state
  @spec hidden?() :: boolean
  defdelegate hidden?(), to: NIF, as: :is_window_hidden

  @doc """
  Check if window is currently minimized
  """
  @doc group: :state
  @spec minimized?() :: boolean
  defdelegate minimized?(), to: NIF, as: :is_window_minimized

  @doc """
  Check if window is currently maximized
  """
  @doc group: :state
  @spec maximized?() :: boolean
  defdelegate maximized?(), to: NIF, as: :is_window_maximized

  @doc """
  Check if window is currently focused
  """
  @doc group: :state
  @spec focused?() :: boolean
  defdelegate focused?(), to: NIF, as: :is_window_focused

  @doc """
  Check if window has been resized last frame
  """
  @doc group: :state
  @spec resized?() :: boolean
  defdelegate resized?(), to: NIF, as: :is_window_resized

  @doc """
  Check if one specific window flag is enabled
  """
  @doc group: :state
  @spec state?(flag :: Zexray.Enum.ConfigFlag.t_free()) :: boolean
  defdelegate state?(flag), to: NIF, as: :is_window_state

  @doc """
  Set window configuration state using flags
  """
  @doc group: :state
  @spec set_state(flag :: Zexray.Enum.ConfigFlag.t_free()) :: :ok
  defdelegate set_state(flag), to: NIF, as: :set_window_state

  @doc """
  Setup init configuration flags (view FLAGS)
  """
  @doc group: :state
  @spec set_config_flags(flag :: Zexray.Enum.ConfigFlag.t_free()) :: :ok
  defdelegate set_config_flags(flag), to: NIF, as: :set_config_flags

  @doc """
  Clear window configuration state flags
  """
  @doc group: :state
  @spec clear_state(flag :: Zexray.Enum.ConfigFlag.t_free()) :: :ok
  defdelegate clear_state(flag), to: NIF, as: :clear_window_state

  @doc """
  Enable waiting for events on EndDrawing(), no automatic event polling
  """
  @doc group: :state
  @spec enable_event_waiting() :: :ok
  defdelegate enable_event_waiting(), to: NIF, as: :enable_event_waiting

  @doc """
  Disable waiting for events on EndDrawing(), automatic events polling
  """
  @doc group: :state
  @spec disable_event_waiting() :: :ok
  defdelegate disable_event_waiting(), to: NIF, as: :disable_event_waiting

  ############
  #  Action  #
  ############

  @doc """
  Toggle window state: fullscreen/windowed, resizes monitor to match window resolution
  """
  @doc group: :action
  @spec toggle_fullscreen() :: :ok
  defdelegate toggle_fullscreen(), to: NIF, as: :toggle_fullscreen

  @doc """
  Toggle window state: borderless windowed, resizes window to match monitor resolution
  """
  @doc group: :action
  @spec toggle_borderless() :: :ok
  defdelegate toggle_borderless(), to: NIF, as: :toggle_borderless_windowed

  @doc """
  Set window state: maximized, if resizable
  """
  @doc group: :action
  @spec maximize() :: :ok
  defdelegate maximize(), to: NIF, as: :maximize_window

  @doc """
  Set window state: minimized, if resizable
  """
  @doc group: :action
  @spec minimize() :: :ok
  defdelegate minimize(), to: NIF, as: :minimize_window

  @doc """
  Restore window from being minimized/maximized
  """
  @doc group: :action
  @spec restore() :: :ok
  defdelegate restore(), to: NIF, as: :restore_window

  @doc """
  Set window focused
  """
  @doc group: :action
  @spec focus() :: :ok
  defdelegate focus(), to: NIF, as: :set_window_focused

  @doc """
  Takes a screenshot of current screen
  """
  @doc group: :action
  @spec screenshot(return :: :auto | :value | :resource) :: Zexray.Type.Image.t_nif()
  defdelegate screenshot(return \\ :auto), to: NIF, as: :screenshot

  @doc """
  Takes a screenshot of current screen (filename extension defines format)
  """
  @doc group: :action
  @spec take_screenshot(file_name :: binary) :: boolean
  defdelegate take_screenshot(file_name), to: NIF, as: :take_screenshot

  ##############
  #  Property  #
  ##############

  @doc """
  Set icon for window (single image, RGBA 32bit)
  """
  @doc group: :property
  @spec set_icon(image :: Zexray.Type.Image.t_all()) :: :ok
  defdelegate set_icon(image), to: NIF, as: :set_window_icon

  @doc """
  Set icon for window (multiple images, RGBA 32bit)
  """
  @doc group: :property
  @spec set_icons(images :: [Zexray.Type.Image.t_all()]) :: :ok
  defdelegate set_icons(images), to: NIF, as: :set_window_icons

  @doc """
  Set title for window
  """
  @doc group: :property
  @spec set_title(title :: binary) :: :ok
  defdelegate set_title(title), to: NIF, as: :set_window_title

  @doc """
  Set window position on screen
  """
  @doc group: :property
  @spec set_position(
          x :: integer,
          y :: integer
        ) :: :ok
  defdelegate set_position(
                x,
                y
              ),
              to: NIF,
              as: :set_window_position

  @doc """
  Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
  """
  @doc group: :property
  @spec set_min_size(
          width :: integer,
          height :: integer
        ) :: :ok
  defdelegate set_min_size(
                width,
                height
              ),
              to: NIF,
              as: :set_window_min_size

  @doc """
  Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)
  """
  @doc group: :property
  @spec set_max_size(
          width :: integer,
          height :: integer
        ) :: :ok
  defdelegate set_max_size(
                width,
                height
              ),
              to: NIF,
              as: :set_window_max_size

  @doc """
  Set window dimensions
  """
  @doc group: :property
  @spec set_size(
          width :: integer,
          height :: integer
        ) :: :ok
  defdelegate set_size(
                width,
                height
              ),
              to: NIF,
              as: :set_window_size

  @doc """
  Set window opacity [0.0f..1.0f]
  """
  @doc group: :property
  @spec set_opacity(opacity :: float) :: :ok
  defdelegate set_opacity(opacity), to: NIF, as: :set_window_opacity

  @doc """
  Get current screen width
  """
  @doc group: :property
  @spec get_screen_width() :: integer
  defdelegate get_screen_width(), to: NIF, as: :get_screen_width

  @doc """
  Get current screen height
  """
  @doc group: :property
  @spec get_screen_height() :: integer
  defdelegate get_screen_height(), to: NIF, as: :get_screen_height

  @doc """
  Get current render width (it considers HiDPI)
  """
  @doc group: :property
  @spec get_render_width() :: integer
  defdelegate get_render_width(), to: NIF, as: :get_render_width

  @doc """
  Get current render height (it considers HiDPI)
  """
  @doc group: :property
  @spec get_render_height() :: integer
  defdelegate get_render_height(), to: NIF, as: :get_render_height

  @doc """
  Get window position XY on monitor
  """
  @doc group: :property
  @spec get_position(return :: :auto | :value | :resource) :: Zexray.Type.Vector2.t_nif()
  defdelegate get_position(return \\ :auto), to: NIF, as: :get_window_position

  @doc """
  Get window scale DPI factor
  """
  @doc group: :property
  @spec get_scale_dpi(return :: :auto | :value | :resource) :: Zexray.Type.Vector2.t_nif()
  defdelegate get_scale_dpi(return \\ :auto), to: NIF, as: :get_window_scale_dpi

  ###############
  #  Clipboard  #
  ###############

  @doc """
  Set clipboard text content
  """
  @doc group: :clipboard
  @spec set_clipboard_text(text :: binary) :: :ok
  defdelegate set_clipboard_text(text), to: NIF, as: :set_clipboard_text

  @doc """
  Get clipboard text content
  """
  @doc group: :clipboard
  @spec get_clipboard_text() :: binary
  defdelegate get_clipboard_text(), to: NIF, as: :get_clipboard_text

  @doc """
  Get clipboard image content
  """
  @doc group: :clipboard
  @spec get_clipboard_image(return :: :auto | :value | :resource) :: Zexray.Type.Image.t_nif()
  defdelegate get_clipboard_image(return \\ :auto), to: NIF, as: :get_clipboard_image
end
