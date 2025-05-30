defmodule Zexray.NIF.Monitor do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_monitor [
        # Monitor
        set_window_monitor: 1,
        get_monitor_count: 0,
        get_current_monitor: 0,
        get_monitor_position: 1,
        get_monitor_position: 2,
        get_monitor_width: 1,
        get_monitor_height: 1,
        get_monitor_physical_width: 1,
        get_monitor_physical_height: 1,
        get_monitor_refresh_rate: 1,
        get_monitor_name: 1
      ]

      #############
      #  Monitor  #
      #############

      @doc """
      Set monitor for the current window

      ```c
      // raylib.h
      RLAPI void SetWindowMonitor(int monitor);
      ```
      """
      @doc group: :window
      @spec set_window_monitor(monitor :: integer) :: :ok
      def set_window_monitor(_monitor), do: :erlang.nif_error(:undef)

      @doc """
      Get number of connected monitors

      ```c
      // raylib.h
      RLAPI int GetMonitorCount(void);
      ```
      """
      @doc group: :window
      @spec get_monitor_count() :: integer
      def get_monitor_count(), do: :erlang.nif_error(:undef)

      @doc """
      Get current monitor where window is placed

      ```c
      // raylib.h
      RLAPI int GetCurrentMonitor(void);
      ```
      """
      @doc group: :window
      @spec get_current_monitor() :: integer
      def get_current_monitor(), do: :erlang.nif_error(:undef)

      @doc """
      Get specified monitor position

      ```c
      // raylib.h
      RLAPI Vector2 GetMonitorPosition(int monitor);
      ```
      """
      @doc group: :window
      @spec get_monitor_position(
              monitor :: integer,
              return :: :value | :resource
            ) :: tuple
      def get_monitor_position(
            _monitor,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get specified monitor width (current video mode used by monitor)

      ```c
      // raylib.h
      RLAPI int GetMonitorWidth(int monitor);
      ```
      """
      @doc group: :window
      @spec get_monitor_width(monitor :: integer) :: integer
      def get_monitor_width(_monitor), do: :erlang.nif_error(:undef)

      @doc """
      Get specified monitor height (current video mode used by monitor)

      ```c
      // raylib.h
      RLAPI int GetMonitorHeight(int monitor);
      ```
      """
      @doc group: :window
      @spec get_monitor_height(monitor :: integer) :: integer
      def get_monitor_height(_monitor), do: :erlang.nif_error(:undef)

      @doc """
      Get specified monitor physical width in millimetres

      ```c
      // raylib.h
      RLAPI int GetMonitorPhysicalWidth(int monitor);
      ```
      """
      @doc group: :window
      @spec get_monitor_physical_width(monitor :: integer) :: integer
      def get_monitor_physical_width(_monitor), do: :erlang.nif_error(:undef)

      @doc """
      Get specified monitor physical height in millimetres

      ```c
      // raylib.h
      RLAPI int GetMonitorPhysicalHeight(int monitor);
      ```
      """
      @doc group: :window
      @spec get_monitor_physical_height(monitor :: integer) :: integer
      def get_monitor_physical_height(_monitor), do: :erlang.nif_error(:undef)

      @doc """
      Get specified monitor refresh rate

      ```c
      // raylib.h
      RLAPI int GetMonitorRefreshRate(int monitor);
      ```
      """
      @doc group: :window
      @spec get_monitor_refresh_rate(monitor :: integer) :: integer
      def get_monitor_refresh_rate(_monitor), do: :erlang.nif_error(:undef)

      @doc """
      Get the human-readable, UTF-8 encoded name of the specified monitor

      ```c
      // raylib.h
      RLAPI const char *GetMonitorName(int monitor);
      ```
      """
      @doc group: :window
      @spec get_monitor_name(monitor :: integer) :: binary
      def get_monitor_name(_monitor), do: :erlang.nif_error(:undef)
    end
  end
end
