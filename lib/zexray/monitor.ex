defmodule Zexray.Monitor do
  @moduledoc """
  Monitor
  """

  alias Zexray.NIF

  #############
  #  Monitor  #
  #############

  @doc """
  Set monitor for the current window
  """
  @spec set_current(monitor :: integer) :: :ok
  defdelegate set_current(monitor), to: NIF, as: :set_window_monitor

  @doc """
  Get number of connected monitors
  """
  @spec get_count() :: integer
  defdelegate get_count(), to: NIF, as: :get_monitor_count

  @doc """
  Get current monitor where window is placed
  """
  @spec get_current() :: integer
  defdelegate get_current(), to: NIF, as: :get_current_monitor

  @doc """
  Get specified monitor position
  """
  @spec get_position(
          monitor :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  defdelegate get_position(
                monitor,
                return \\ :value
              ),
              to: NIF,
              as: :get_monitor_position

  @doc """
  Get specified monitor width (current video mode used by monitor)
  """
  @spec get_width(monitor :: integer) :: integer
  defdelegate get_width(monitor), to: NIF, as: :get_monitor_width

  @doc """
  Get specified monitor height (current video mode used by monitor)
  """
  @spec get_height(monitor :: integer) :: integer
  defdelegate get_height(monitor), to: NIF, as: :get_monitor_height

  @doc """
  Get specified monitor physical width in millimetres
  """
  @spec get_physical_width(monitor :: integer) :: integer
  defdelegate get_physical_width(monitor), to: NIF, as: :get_monitor_physical_width

  @doc """
  Get specified monitor physical height in millimetres
  """
  @spec get_physical_height(monitor :: integer) :: integer
  defdelegate get_physical_height(monitor), to: NIF, as: :get_monitor_physical_height

  @doc """
  Get specified monitor refresh rate
  """
  @spec get_refresh_rate(monitor :: integer) :: integer
  defdelegate get_refresh_rate(monitor), to: NIF, as: :get_monitor_refresh_rate

  @doc """
  Get the human-readable, UTF-8 encoded name of the specified monitor
  """
  @spec get_name(monitor :: integer) :: binary
  defdelegate get_name(monitor), to: NIF, as: :get_monitor_name
end
