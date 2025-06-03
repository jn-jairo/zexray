defmodule Zexray.Touch do
  @moduledoc """
  Touch
  """

  alias Zexray.NIF

  ###########
  #  Touch  #
  ###########

  @doc """
  Get touch position X for touch point 0 (relative to screen size)
  """
  @spec get_x() :: integer
  defdelegate get_x(), to: NIF, as: :get_touch_x

  @doc """
  Get touch position Y for touch point 0 (relative to screen size)
  """
  @spec get_y() :: integer
  defdelegate get_y(), to: NIF, as: :get_touch_y

  @doc """
  Get touch position XY for a touch point index (relative to screen size)
  """
  @spec get_position(
          index :: integer,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  defdelegate get_position(
                index,
                return \\ :auto
              ),
              to: NIF,
              as: :get_touch_position

  @doc """
  Get touch point identifier for given index
  """
  @spec get_point_id(index :: integer) :: integer
  defdelegate get_point_id(index), to: NIF, as: :get_touch_point_id

  @doc """
  Get number of touch points
  """
  @spec get_point_count() :: integer
  defdelegate get_point_count(), to: NIF, as: :get_touch_point_count
end
