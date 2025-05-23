defmodule Zexray.NIF.TraceLog do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_trace_log [
        # TraceLog
        trace_log: 2,
        set_trace_log_level: 1,
        set_trace_log_callback: 0
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
      @doc group: :trace_log
      @spec set_trace_log_level(log_level :: integer) :: :ok
      def set_trace_log_level(_log_level), do: :erlang.nif_error(:undef)

      @doc """
      Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)

      ```c
      // raylib.h
      RLAPI void TraceLog(int logLevel, const char *text, ...);
      ```
      """
      @doc group: :trace_log
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
      @doc group: :trace_log
      @spec set_trace_log_callback() :: :ok
      def set_trace_log_callback(), do: :erlang.nif_error(:undef)
    end
  end
end
