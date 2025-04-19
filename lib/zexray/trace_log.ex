defmodule Zexray.TraceLog do
  @moduledoc """
  Trace Log
  """

  import Zexray.Guard
  alias Zexray.NIF

  @doc """
  Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
  """
  @spec trace_log(
          log_level :: Zexray.Enum.TraceLogLevel.t_all(),
          text :: binary
        ) :: :ok
  if Application.compile_env(:zexray, :trace_log) do
    def trace_log(
          log_level,
          text
        )
        when is_like_trace_log_level(log_level) and
               is_binary(text) do
      NIF.trace_log(
        Zexray.Enum.TraceLogLevel.value(log_level),
        text
      )
    end
  else
    def trace_log(log_level, text)
        when is_like_trace_log_level(log_level) and is_binary(text),
        do: :ok
  end

  @doc """
  Trace logging, intended for internal use only

  Show `:trace` log message
  """
  @spec trace(text :: binary) :: :ok
  if Application.compile_env(:zexray, :trace_log) do
    def trace(text)
        when is_binary(text) do
      trace_log(:trace, text)
    end
  else
    def trace(text) when is_binary(text), do: :ok
  end

  @doc """
  Debug logging, used for internal debugging, it should be disabled on release builds

  Show `:debug` log message
  """
  @spec debug(text :: binary) :: :ok
  if Application.compile_env(:zexray, :trace_log) and
       Application.compile_env(:zexray, :trace_log_debug) do
    def debug(text)
        when is_binary(text) do
      trace_log(:debug, text)
    end
  else
    def debug(text) when is_binary(text), do: :ok
  end

  @doc """
  Info logging, used for program execution info

  Show `:info` log message
  """
  @spec info(text :: binary) :: :ok
  if Application.compile_env(:zexray, :trace_log) do
    def info(text)
        when is_binary(text) do
      trace_log(:info, text)
    end
  else
    def info(text) when is_binary(text), do: :ok
  end

  @doc """
  Warning logging, used on recoverable failures 

  Show `:warning` log message
  """
  @spec warning(text :: binary) :: :ok
  if Application.compile_env(:zexray, :trace_log) do
    def warning(text)
        when is_binary(text) do
      trace_log(:warning, text)
    end
  else
    def warning(text) when is_binary(text), do: :ok
  end

  @doc """
  Error logging, used on unrecoverable failures 

  Show `:error` log message
  """
  @spec error(text :: binary) :: :ok
  if Application.compile_env(:zexray, :trace_log) do
    def error(text)
        when is_binary(text) do
      trace_log(:error, text)
    end
  else
    def error(text) when is_binary(text), do: :ok
  end

  @doc """
  Fatal logging, used to abort program: exit(EXIT_FAILURE) 

  Show `:fatal` log message
  """
  @spec fatal(text :: binary) :: :ok
  if Application.compile_env(:zexray, :trace_log) do
    def fatal(text)
        when is_binary(text) do
      trace_log(:fatal, text)
    end
  else
    def fatal(text) when is_binary(text), do: :ok
  end

  @doc """
  Set the current threshold (minimum) log level
  """
  @spec set_level(log_level :: Zexray.Enum.TraceLogLevel.t_all()) :: :ok
  def set_level(log_level)
      when is_like_trace_log_level(log_level) do
    NIF.set_trace_log_level(Zexray.Enum.TraceLogLevel.value(log_level))
  end
end
