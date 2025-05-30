defmodule Zexray.TraceLog do
  @moduledoc """
  Trace Log
  """

  use Zexray.Enum

  alias Zexray.NIF

  @doc """
  Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
  """
  @spec trace_log(
          log_level :: Zexray.Enum.TraceLogLevel.t(),
          text :: binary
        ) :: :ok
  if Application.compile_env(:zexray, :trace_log, true) do
    defdelegate trace_log(
                  log_level,
                  text
                ),
                to: NIF,
                as: :trace_log
  else
    def trace_log(_log_level, _text), do: :ok
  end

  @doc """
  Trace logging, intended for internal use only

  Show `:trace` log message
  """
  @spec trace(text :: binary) :: :ok
  if Application.compile_env(:zexray, :trace_log, true) do
    def trace(text) do
      trace_log(enum_trace_log_level(:trace), text)
    end
  else
    def trace(_text), do: :ok
  end

  @doc """
  Debug logging, used for internal debugging, it should be disabled on release builds

  Show `:debug` log message
  """
  @spec debug(text :: binary) :: :ok
  if Application.compile_env(:zexray, :trace_log, true) and
       Application.compile_env(:zexray, :trace_log_debug, false) do
    def debug(text) do
      trace_log(enum_trace_log_level(:debug), text)
    end
  else
    def debug(_text), do: :ok
  end

  @doc """
  Info logging, used for program execution info

  Show `:info` log message
  """
  @spec info(text :: binary) :: :ok
  if Application.compile_env(:zexray, :trace_log, true) do
    def info(text) do
      trace_log(enum_trace_log_level(:info), text)
    end
  else
    def info(_text), do: :ok
  end

  @doc """
  Warning logging, used on recoverable failures 

  Show `:warning` log message
  """
  @spec warning(text :: binary) :: :ok
  if Application.compile_env(:zexray, :trace_log, true) do
    def warning(text) do
      trace_log(enum_trace_log_level(:warning), text)
    end
  else
    def warning(_text), do: :ok
  end

  @doc """
  Error logging, used on unrecoverable failures 

  Show `:error` log message
  """
  @spec error(text :: binary) :: :ok
  if Application.compile_env(:zexray, :trace_log, true) do
    def error(text) do
      trace_log(enum_trace_log_level(:error), text)
    end
  else
    def error(_text), do: :ok
  end

  @doc """
  Fatal logging, used to abort program: exit(EXIT_FAILURE) 

  Show `:fatal` log message
  """
  @spec fatal(text :: binary) :: :ok
  if Application.compile_env(:zexray, :trace_log, true) do
    def fatal(text) do
      trace_log(enum_trace_log_level(:fatal), text)
    end
  else
    def fatal(_text), do: :ok
  end

  @doc """
  Set the current threshold (minimum) log level
  """
  @spec set_level(log_level :: Zexray.Enum.TraceLogLevel.t()) :: :ok
  defdelegate set_level(log_level), to: NIF, as: :set_trace_log_level
end
