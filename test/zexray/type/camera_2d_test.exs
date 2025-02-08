defmodule Zexray.Type.Camera2DTest.Type2 do
  defstruct [
    :offset,
    :target,
    :rotation,
    :zoom
  ]
end

defmodule Zexray.Type.Camera2DTest do
  use ExUnit.Case, async: true
  doctest Zexray.Type.Camera2D

  import ExUnitParameterize

  import Zexray.TypeFixture

  alias Zexray.Type.Camera2D, as: Type
  alias Zexray.Type.Camera2DTest.Type2

  import Zexray.Util, only: [map_from_struct: 1, similar?: 2]

  setup_all _ do
    %{
      value: camera_2d_fixture()
    }
  end

  describe "new" do
    defp dataset_new(%{value: value}) do
      map = map_from_struct(value)

      struct = struct(Type2, map)

      tuple = {
        value.offset,
        value.target,
        value.rotation,
        value.zoom
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
