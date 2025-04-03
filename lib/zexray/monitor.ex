defmodule Zexray.Monitor do
  alias Zexray.NIF

  import Zexray.Guard

  #############
  #  Monitor  #
  #############

  @doc """
  Set monitor for the current window
  """
  @spec set_current(monitor :: integer) :: :ok
  def set_current(monitor)
      when is_integer(monitor) do
    NIF.set_window_monitor(monitor)
  end

  @doc """
  Get number of connected monitors
  """
  @spec get_count() :: integer
  def get_count() do
    NIF.get_monitor_count()
  end

  @doc """
  Get current monitor where window is placed
  """
  @spec get_current() :: integer
  def get_current() do
    NIF.get_current_monitor()
  end

  @doc """
  Get specified monitor position
  """
  @spec get_position(
          monitor :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  def get_position(
        monitor,
        return \\ :value
      )
      when is_integer(monitor) and
             is_nif_return(return) do
    NIF.get_monitor_position(
      monitor,
      return
    )
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Get specified monitor width (current video mode used by monitor)
  """
  @spec get_width(monitor :: integer) :: integer
  def get_width(monitor)
      when is_integer(monitor) do
    NIF.get_monitor_width(monitor)
  end

  @doc """
  Get specified monitor height (current video mode used by monitor)
  """
  @spec get_height(monitor :: integer) :: integer
  def get_height(monitor)
      when is_integer(monitor) do
    NIF.get_monitor_height(monitor)
  end

  @doc """
  Get specified monitor physical width in millimetres
  """
  @spec get_physical_width(monitor :: integer) :: integer
  def get_physical_width(monitor)
      when is_integer(monitor) do
    NIF.get_monitor_physical_width(monitor)
  end

  @doc """
  Get specified monitor physical height in millimetres
  """
  @spec get_physical_height(monitor :: integer) :: integer
  def get_physical_height(monitor)
      when is_integer(monitor) do
    NIF.get_monitor_physical_height(monitor)
  end

  @doc """
  Get specified monitor refresh rate
  """
  @spec get_refresh_rate(monitor :: integer) :: integer
  def get_refresh_rate(monitor)
      when is_integer(monitor) do
    NIF.get_monitor_refresh_rate(monitor)
  end

  @doc """
  Get the human-readable, UTF-8 encoded name of the specified monitor
  """
  @spec get_name(monitor :: integer) :: binary
  def get_name(monitor)
      when is_integer(monitor) do
    NIF.get_monitor_name(monitor)
  end
end
