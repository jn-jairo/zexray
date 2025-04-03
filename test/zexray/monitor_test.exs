defmodule Zexray.MonitorTest do
  use Zexray.WindowCase
  doctest Zexray.Monitor

  @moduletag :nif
  @moduletag :window

  alias Zexray.Resource
  alias Zexray.Monitor

  import Zexray.Guard
  import Zexray.Util, only: [wait_fn: 1]

  test "monitor" do
    monitor_count = Monitor.get_count()

    0..(monitor_count - 1)
    |> Enum.each(fn monitor ->
      Monitor.set_current(monitor)
      wait_fn(fn -> Monitor.get_current() == monitor end)
      assert ^monitor = Monitor.get_current()

      assert is_binary(Monitor.get_name(monitor))
      assert Monitor.get_refresh_rate(monitor) > 0
      assert Monitor.get_width(monitor) > 0
      assert Monitor.get_height(monitor) > 0
      assert Monitor.get_physical_width(monitor) > 0
      assert Monitor.get_physical_height(monitor) > 0

      position = Monitor.get_position(monitor)
      assert is_vector2(position)

      position_resource = Monitor.get_position(monitor, :resource)
      assert is_vector2(Resource.content(position_resource))
      Resource.free_async(position_resource)
    end)
  end
end
