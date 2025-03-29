defmodule Zexray.Util do
  @moduledoc """
  Utilities
  """

  import Zexray.Guard
  alias Zexray.NIF

  # @epsilon 0.000001
  @epsilon 0.00001

  @doc """
  Convert struct to map recursively using `Map.from_struct/1`.
  """
  def map_from_struct(value)

  @spec map_from_struct(value :: struct) :: map
  @spec map_from_struct(value :: map) :: map
  @spec map_from_struct(value :: list) :: list
  @spec map_from_struct(value :: tuple) :: tuple
  def map_from_struct(value)
      when is_struct(value) or is_map(value) or is_list(value) or is_tuple(value) do
    do_map_from_struct(value)
  end

  @spec do_map_from_struct(value :: struct) :: map
  defp do_map_from_struct(value) when is_struct(value) do
    value
    |> Map.from_struct()
    |> Map.new(&do_map_from_struct/1)
  end

  @spec do_map_from_struct(value :: map) :: map
  defp do_map_from_struct(value) when is_map(value) do
    value
    |> Map.new(&do_map_from_struct/1)
  end

  @spec do_map_from_struct(value :: list) :: list
  defp do_map_from_struct(value) when is_list(value) do
    value
    |> Enum.map(&do_map_from_struct/1)
  end

  @spec do_map_from_struct(value :: tuple) :: tuple
  defp do_map_from_struct(value) when is_tuple(value) do
    value
    |> Tuple.to_list()
    |> Enum.map(&do_map_from_struct/1)
    |> List.to_tuple()
  end

  @spec do_map_from_struct(value :: any) :: any
  defp do_map_from_struct(value), do: value

  @doc """
  Check if the values are similar.

  It's considered similar:

  - exactly equal values
  - `t:number/0` that are closer to each other than #{@epsilon}
  - different `t:struct/0` with same keys and similar values
  - `t:map/0` with same keys and similar values
  - `t:list/0` with same length and similar values
  - `t:tuple/0` with same length and similar values
  """
  @spec similar?(expected :: any, actual :: any) :: boolean
  def similar?(expected, actual)

  def similar?(expected, actual) when expected == actual, do: true

  def similar?(expected, actual) when is_number(expected) and is_number(actual) do
    abs(expected - actual) < @epsilon
  end

  def similar?([expected | expected_tail], [actual | actual_tail]) do
    if similar?(expected, actual) do
      similar?(expected_tail, actual_tail)
    else
      false
    end
  end

  def similar?(expected, actual) when is_tuple(expected) and is_tuple(actual) do
    similar?(Tuple.to_list(expected), Tuple.to_list(actual))
  end

  def similar?(%{} = expected, %{} = actual)
      when is_map(expected) and is_map(actual) do
    expected =
      if is_struct(expected) do
        Map.from_struct(expected)
      else
        expected
      end

    actual =
      if is_struct(actual) do
        Map.from_struct(actual)
      else
        actual
      end

    if Map.keys(expected) == Map.keys(actual) do
      try do
        Enum.each(expected, fn {key, value} ->
          actual_value = Map.get(actual, key)

          case value do
            value ->
              if not similar?(value, actual_value) do
                throw(false)
              end
          end
        end)

        true
      catch
        similar -> similar
      end
    else
      false
    end
  end

  def similar?(_, _), do: false

  @doc """
  Set the current threshold (minimum) log level
  """
  @spec set_trace_log_level(log_level :: Zexray.Enum.TraceLogLevel.t_all()) :: :ok
  def set_trace_log_level(log_level)
      when is_like_trace_log_level(log_level) do
    NIF.set_trace_log_level(Zexray.Enum.TraceLogLevel.value(log_level))
  end

  @doc """
  Wait for some time (halt program execution)
  """
  @spec wait_time(seconds :: number) :: :ok

  def wait_time(seconds) when is_number(seconds) and seconds <= 0, do: :ok

  def wait_time(seconds) when is_number(seconds) do
    destination_time = System.os_time(:microsecond) + seconds * 1_000_000
    seconds = seconds * 0.9

    if seconds >= 0.001 do
      # Process.sleep/1 only supports whole milliseconds
      Process.sleep(trunc(seconds * 1_000))
    end

    loop = fn loop, destination_time ->
      if System.os_time(:microsecond) < destination_time do
        loop.(loop, destination_time)
      end
    end

    loop.(loop, destination_time)

    :ok
  end

  @doc """
  Wait for the function to return `true`
  """
  @spec wait_fn(function :: (-> boolean), seconds :: number, max_seconds :: number) :: :ok

  def wait_fn(function, seconds \\ 0.001, max_seconds \\ 1.0)

  def wait_fn(_function, seconds, max_seconds)
      when is_number(seconds) and
             is_number(max_seconds) and
             seconds >= max_seconds,
      do: :ok

  def wait_fn(function, seconds, max_seconds)
      when is_function(function) and
             is_number(seconds) and
             is_number(max_seconds) do
    if not function.() do
      wait_time(seconds)
      wait_fn(function, seconds, max_seconds - seconds)
    else
      :ok
    end
  end
end
