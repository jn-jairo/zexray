defmodule Zexray.Type.MaterialMapTest.Type2 do
  defstruct [
    :texture,
    :color,
    :value
  ]
end

defmodule Zexray.Type.MaterialMapTest do
  use ExUnit.Case, async: true
  doctest Zexray.Type.MaterialMap

  import ExUnitParameterize

  import Zexray.TypeFixture

  alias Zexray.Type.MaterialMap, as: Type
  alias Zexray.Type.MaterialMapTest.Type2

  import Zexray.Util, only: [map_from_struct: 1, similar?: 2]

  setup_all _ do
    %{
      value: material_map_fixture()
    }
  end

  describe "new" do
    defp dataset_new(%{value: value}) do
      map = map_from_struct(value)

      struct = struct(Type2, map)

      tuple = {
        value.texture,
        value.color,
        value.value
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
    end
  end

  test "new invalid" do
    assert_raise ArgumentError, fn -> Type.new({}) end
  end

  test "resource", %{value: value} do
    resource = Type.Resource.new(value)
    assert similar?(value, Type.new(resource))
    Type.Resource.free(resource)
  end
end
