defmodule Zexray.Type.WaveTest.Type2 do
  defstruct [
    :frame_count,
    :sample_rate,
    :sample_size,
    :channels,
    :data
  ]
end

defmodule Zexray.Type.WaveTest do
  use ExUnit.Case, async: true
  doctest Zexray.Type.Wave

  import ExUnitParameterize

  import Zexray.TypeFixture

  alias Zexray.Type.Wave, as: Type
  alias Zexray.Type.WaveTest.Type2

  import Zexray.Util, only: [map_from_struct: 1]

  setup_all _ do
    %{
      value: wave_fixture()
    }
  end

  describe "new" do
    defp dataset_new(%{value: value}) do
      map = map_from_struct(value)

      struct = struct(Type2, map)

      tuple = {
        value.frame_count,
        value.sample_rate,
        value.sample_size,
        value.channels,
        value.data
      }

      datasets = %{
        map: {value, [map]},
        tuple: {value, [tuple]},
        struct_other: {value, [struct]},
        struct_same: {value, [value]}
      }

      %{datasets: datasets}
    end

    setup [:dataset_new]

    parameterized_test "", %{datasets: datasets}, [
      [dataset: :map],
      [dataset: :tuple],
      [dataset: :struct_other],
      [dataset: :struct_same]
    ] do
      dataset = Map.fetch!(datasets, dataset)

      {expected, params} = dataset

      assert ^expected = apply(Type, :new, params)
      assert ^expected = apply(Type, :from_nif, params)
      assert apply(Type, :to_nif, [expected]) == apply(Type, :to_nif, params)
    end
  end

  test "new invalid" do
    assert_raise ArgumentError, fn -> Type.new({}) end
  end

  test "new nil", %{value: value} do
    map = value |> Map.from_struct()

    Enum.each(Map.keys(map), fn key ->
      assert apply(Type, :new, [%{map | key => nil}]) |> Map.fetch!(key) |> is_nil()
    end)
  end
end
