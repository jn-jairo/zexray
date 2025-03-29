defmodule Zexray.NIF.Util do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_util [
        # TraceLog
        trace_log: 2,
        set_trace_log_level: 1,
        set_trace_log_callback: 0,
        screenshot: 0,
        screenshot: 1
      ]

      ##############
      #  TraceLog  #
      ##############

      @doc """
      Set the current threshold (minimum) log level

      ```c
      // raylib.h
      RLAPI void SetTraceLogLevel(int logLevel);
      ```
      """
      @doc group: :util
      @spec set_trace_log_level(log_level :: integer) :: :ok
      def set_trace_log_level(_log_level), do: :erlang.nif_error(:undef)

      @doc """
      Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)

      ```c
      // raylib.h
      RLAPI void TraceLog(int logLevel, const char *text, ...);
      ```
      """
      @doc group: :util
      @spec trace_log(
              log_level :: integer,
              text :: binary
            ) :: :ok
      def trace_log(
            _log_level,
            _text
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set custom trace log

      ```c
      // raylib.h
      RLAPI void SetTraceLogCallback(TraceLogCallback callback);
      ```
      """
      @doc group: :util
      @spec set_trace_log_callback() :: :ok
      def set_trace_log_callback(), do: :erlang.nif_error(:undef)

      @doc """
      Takes a screenshot of current screen
      """
      @doc group: :util
      @spec screenshot(return :: :value | :resource) :: map | reference
      def screenshot(_return \\ :value), do: :erlang.nif_error(:undef)
    end
  end
end
