defmodule Zexray.Touch do
  import Zexray.Guard
  alias Zexray.NIF

  ###########
  #  Touch  #
  ###########

  @doc """
  Get touch position X for touch point 0 (relative to screen size)
  """
  @spec get_x() :: integer
  def get_x() do
    NIF.get_touch_x()
  end

  @doc """
  Get touch position Y for touch point 0 (relative to screen size)
  """
  @spec get_y() :: integer
  def get_y() do
    NIF.get_touch_y()
  end

  @doc """
  Get touch position XY for a touch point index (relative to screen size)
  """
  @spec get_position(
          index :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  def get_position(
        index,
        return \\ :value
      )
      when is_integer(index) and
             is_nif_return(return) do
    NIF.get_touch_position(
      index,
      return
    )
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Get touch point identifier for given index
  """
  @spec get_point_id(index :: integer) :: integer
  def get_point_id(index)
      when is_integer(index) do
    NIF.get_touch_point_id(index)
  end

  @doc """
  Get number of touch points
  """
  @spec get_point_count() :: integer
  def get_point_count() do
    NIF.get_touch_point_count()
  end
end
