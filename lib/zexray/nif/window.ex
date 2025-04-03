defmodule Zexray.NIF.Window do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_window [
        # Window
        init_window: 3,
        close_window: 0,
        window_should_close: 0,
        is_window_ready: 0,
        is_window_fullscreen: 0,
        is_window_hidden: 0,
        is_window_minimized: 0,
        is_window_maximized: 0,
        is_window_focused: 0,
        is_window_resized: 0,
        is_window_state: 1,
        set_window_state: 1,
        set_config_flags: 1,
        clear_window_state: 1,
        toggle_fullscreen: 0,
        toggle_borderless_windowed: 0,
        maximize_window: 0,
        minimize_window: 0,
        restore_window: 0,
        set_window_icon: 1,
        set_window_icons: 1,
        set_window_title: 1,
        set_window_position: 2,
        set_window_min_size: 2,
        set_window_max_size: 2,
        set_window_size: 2,
        set_window_opacity: 1,
        set_window_focused: 0,
        get_screen_width: 0,
        get_screen_height: 0,
        get_render_width: 0,
        get_render_height: 0,
        get_window_position: 0,
        get_window_position: 1,
        get_window_scale_dpi: 0,
        get_window_scale_dpi: 1,
        set_clipboard_text: 1,
        get_clipboard_text: 0,
        get_clipboard_image: 0,
        get_clipboard_image: 1,
        enable_event_waiting: 0,
        disable_event_waiting: 0,
        screenshot: 0,
        screenshot: 1
      ]

      ############
      #  Window  #
      ############

      @doc """
      Initialize window and OpenGL context

      ```c
      // raylib.h
      RLAPI void InitWindow(int width, int height, const char *title);
      ```
      """
      @doc group: :window
      @spec init_window(
              width :: integer,
              height :: integer,
              title :: binary
            ) :: :ok
      def init_window(
            _width,
            _height,
            _title
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Close window and unload OpenGL context

      ```c
      // raylib.h
      RLAPI void CloseWindow(void);
      ```
      """
      @doc group: :window
      @spec close_window() :: :ok
      def close_window(), do: :erlang.nif_error(:undef)

      @doc """
      Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)

      ```c
      // raylib.h
      RLAPI bool WindowShouldClose(void);
      ```
      """
      @doc group: :window
      @spec window_should_close() :: boolean
      def window_should_close(), do: :erlang.nif_error(:undef)

      @doc """
      Check if window has been initialized successfully

      ```c
      // raylib.h
      RLAPI bool IsWindowReady(void);
      ```
      """
      @doc group: :window
      @spec is_window_ready() :: boolean
      def is_window_ready(), do: :erlang.nif_error(:undef)

      @doc """
      Check if window is currently fullscreen

      ```c
      // raylib.h
      RLAPI bool IsWindowFullscreen(void);
      ```
      """
      @doc group: :window
      @spec is_window_fullscreen() :: boolean
      def is_window_fullscreen(), do: :erlang.nif_error(:undef)

      @doc """
      Check if window is currently hidden

      ```c
      // raylib.h
      RLAPI bool IsWindowHidden(void);
      ```
      """
      @doc group: :window
      @spec is_window_hidden() :: boolean
      def is_window_hidden(), do: :erlang.nif_error(:undef)

      @doc """
      Check if window is currently minimized

      ```c
      // raylib.h
      RLAPI bool IsWindowMinimized(void);
      ```
      """
      @doc group: :window
      @spec is_window_minimized() :: boolean
      def is_window_minimized(), do: :erlang.nif_error(:undef)

      @doc """
      Check if window is currently maximized

      ```c
      // raylib.h
      RLAPI bool IsWindowMaximized(void);
      ```
      """
      @doc group: :window
      @spec is_window_maximized() :: boolean
      def is_window_maximized(), do: :erlang.nif_error(:undef)

      @doc """
      Check if window is currently focused

      ```c
      // raylib.h
      RLAPI bool IsWindowFocused(void);
      ```
      """
      @doc group: :window
      @spec is_window_focused() :: boolean
      def is_window_focused(), do: :erlang.nif_error(:undef)

      @doc """
      Check if window has been resized last frame

      ```c
      // raylib.h
      RLAPI bool IsWindowResized(void);
      ```
      """
      @doc group: :window
      @spec is_window_resized() :: boolean
      def is_window_resized(), do: :erlang.nif_error(:undef)

      @doc """
      Check if one specific window flag is enabled

      ```c
      // raylib.h
      RLAPI bool IsWindowState(unsigned int flag);
      ```
      """
      @doc group: :window
      @spec is_window_state(flag :: non_neg_integer) :: boolean
      def is_window_state(_flag), do: :erlang.nif_error(:undef)

      @doc """
      Set window configuration state using flags

      ```c
      // raylib.h
      RLAPI void SetWindowState(unsigned int flags);
      ```
      """
      @doc group: :window
      @spec set_window_state(flag :: non_neg_integer) :: :ok
      def set_window_state(_flag), do: :erlang.nif_error(:undef)

      @doc """
      Setup init configuration flags (view FLAGS)

      ```c
      // raylib.h
      RLAPI void SetConfigFlags(unsigned int flags);
      ```
      """
      @doc group: :window
      @spec set_config_flags(flag :: non_neg_integer) :: :ok
      def set_config_flags(_flag), do: :erlang.nif_error(:undef)

      @doc """
      Clear window configuration state flags

      ```c
      // raylib.h
      RLAPI void ClearWindowState(unsigned int flags);
      ```
      """
      @doc group: :window
      @spec clear_window_state(flag :: non_neg_integer) :: :ok
      def clear_window_state(_flag), do: :erlang.nif_error(:undef)

      @doc """
      Toggle window state: fullscreen/windowed, resizes monitor to match window resolution

      ```c
      // raylib.h
      RLAPI void ToggleFullscreen(void);
      ```
      """
      @doc group: :window
      @spec toggle_fullscreen() :: :ok
      def toggle_fullscreen(), do: :erlang.nif_error(:undef)

      @doc """
      Toggle window state: borderless windowed, resizes window to match monitor resolution

      ```c
      // raylib.h
      RLAPI void ToggleBorderlessWindowed(void);
      ```
      """
      @doc group: :window
      @spec toggle_borderless_windowed() :: :ok
      def toggle_borderless_windowed(), do: :erlang.nif_error(:undef)

      @doc """
      Set window state: maximized, if resizable

      ```c
      // raylib.h
      RLAPI void MaximizeWindow(void);
      ```
      """
      @doc group: :window
      @spec maximize_window() :: :ok
      def maximize_window(), do: :erlang.nif_error(:undef)

      @doc """
      Set window state: minimized, if resizable

      ```c
      // raylib.h
      RLAPI void MinimizeWindow(void);
      ```
      """
      @doc group: :window
      @spec minimize_window() :: :ok
      def minimize_window(), do: :erlang.nif_error(:undef)

      @doc """
      Set window state: not minimized/maximized

      ```c
      // raylib.h
      RLAPI void RestoreWindow(void);
      ```
      """
      @doc group: :window
      @spec restore_window() :: :ok
      def restore_window(), do: :erlang.nif_error(:undef)

      @doc """
      Set icon for window (single image, RGBA 32bit)

      ```c
      // raylib.h
      RLAPI void SetWindowIcon(Image image);
      ```
      """
      @doc group: :window
      @spec set_window_icon(image :: map | reference) :: :ok
      def set_window_icon(_image), do: :erlang.nif_error(:undef)

      @doc """
      Set icon for window (multiple images, RGBA 32bit)

      ```c
      // raylib.h
      RLAPI void SetWindowIcons(Image *images, int count);
      ```
      """
      @doc group: :window
      @spec set_window_icons(images :: [map | reference]) :: :ok
      def set_window_icons(_images), do: :erlang.nif_error(:undef)

      @doc """
      Set title for window

      ```c
      // raylib.h
      RLAPI void SetWindowTitle(const char *title);
      ```
      """
      @doc group: :window
      @spec set_window_title(title :: binary) :: :ok
      def set_window_title(_title), do: :erlang.nif_error(:undef)

      @doc """
      Set window position on screen

      ```c
      // raylib.h
      RLAPI void SetWindowPosition(int x, int y);
      ```
      """
      @doc group: :window
      @spec set_window_position(
              x :: integer,
              y :: integer
            ) :: :ok
      def set_window_position(
            _x,
            _y
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)

      ```c
      // raylib.h
      RLAPI void SetWindowMinSize(int width, int height);
      ```
      """
      @doc group: :window
      @spec set_window_min_size(
              width :: integer,
              height :: integer
            ) :: :ok
      def set_window_min_size(
            _width,
            _height
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)

      ```c
      // raylib.h
      RLAPI void SetWindowMaxSize(int width, int height);
      ```
      """
      @doc group: :window
      @spec set_window_max_size(
              width :: integer,
              height :: integer
            ) :: :ok
      def set_window_max_size(
            _width,
            _height
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set window dimensions

      ```c
      // raylib.h
      RLAPI void SetWindowSize(int width, int height);
      ```
      """
      @doc group: :window
      @spec set_window_size(
              width :: integer,
              height :: integer
            ) :: :ok
      def set_window_size(
            _width,
            _height
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set window opacity [0.0f..1.0f]

      ```c
      // raylib.h
      RLAPI void SetWindowOpacity(float opacity);
      ```
      """
      @doc group: :window
      @spec set_window_opacity(opacity :: float) :: :ok
      def set_window_opacity(_opacity), do: :erlang.nif_error(:undef)

      @doc """
      Set window focused

      ```c
      // raylib.h
      RLAPI void SetWindowFocused(void);
      ```
      """
      @doc group: :window
      @spec set_window_focused() :: :ok
      def set_window_focused(), do: :erlang.nif_error(:undef)

      @doc """
      Get current screen width

      ```c
      // raylib.h
      RLAPI int GetScreenWidth(void);
      ```
      """
      @doc group: :window
      @spec get_screen_width() :: integer
      def get_screen_width(), do: :erlang.nif_error(:undef)

      @doc """
      Get current screen height

      ```c
      // raylib.h
      RLAPI int GetScreenHeight(void);
      ```
      """
      @doc group: :window
      @spec get_screen_height() :: integer
      def get_screen_height(), do: :erlang.nif_error(:undef)

      @doc """
      Get current render width (it considers HiDPI)

      ```c
      // raylib.h
      RLAPI int GetRenderWidth(void);
      ```
      """
      @doc group: :window
      @spec get_render_width() :: integer
      def get_render_width(), do: :erlang.nif_error(:undef)

      @doc """
      Get current render height (it considers HiDPI)

      ```c
      // raylib.h
      RLAPI int GetRenderHeight(void);
      ```
      """
      @doc group: :window
      @spec get_render_height() :: integer
      def get_render_height(), do: :erlang.nif_error(:undef)

      @doc """
      Get window position XY on monitor

      ```c
      // raylib.h
      RLAPI Vector2 GetWindowPosition(void);
      ```
      """
      @doc group: :window
      @spec get_window_position(return :: :value | :resource) :: map | reference
      def get_window_position(_return \\ :value), do: :erlang.nif_error(:undef)

      @doc """
      Get window scale DPI factor

      ```c
      // raylib.h
      RLAPI Vector2 GetWindowScaleDPI(void);
      ```
      """
      @doc group: :window
      @spec get_window_scale_dpi(return :: :value | :resource) :: map | reference
      def get_window_scale_dpi(_return \\ :value), do: :erlang.nif_error(:undef)

      @doc """
      Set clipboard text content

      ```c
      // raylib.h
      RLAPI void SetClipboardText(const char *text);
      ```
      """
      @doc group: :window
      @spec set_clipboard_text(text :: binary) :: :ok
      def set_clipboard_text(_text), do: :erlang.nif_error(:undef)

      @doc """
      Get clipboard text content

      ```c
      // raylib.h
      RLAPI const char *GetClipboardText(void);
      ```
      """
      @doc group: :window
      @spec get_clipboard_text() :: binary
      def get_clipboard_text(), do: :erlang.nif_error(:undef)

      @doc """
      Get clipboard image content

      ```c
      // raylib.h
      RLAPI Image GetClipboardImage(void);
      ```
      """
      @doc group: :window
      @spec get_clipboard_image(return :: :value | :resource) :: map | reference
      def get_clipboard_image(_return \\ :value), do: :erlang.nif_error(:undef)

      @doc """
      Enable waiting for events on EndDrawing(), no automatic event polling

      ```c
      // raylib.h
      RLAPI void EnableEventWaiting(void);
      ```
      """
      @doc group: :window
      @spec enable_event_waiting() :: :ok
      def enable_event_waiting(), do: :erlang.nif_error(:undef)

      @doc """
      Disable waiting for events on EndDrawing(), automatic events polling

      ```c
      // raylib.h
      RLAPI void DisableEventWaiting(void);
      ```
      """
      @doc group: :window
      @spec disable_event_waiting() :: :ok
      def disable_event_waiting(), do: :erlang.nif_error(:undef)

      @doc """
      Takes a screenshot of current screen
      """
      @doc group: :window
      @spec screenshot(return :: :value | :resource) :: map | reference
      def screenshot(_return \\ :value), do: :erlang.nif_error(:undef)
    end
  end
end
