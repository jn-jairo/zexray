defmodule Zexray.NIF.Util do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_util [
        # TraceLog
        set_trace_log_level: 1
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
    end
  end
end
