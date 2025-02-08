defmodule Zexray.Type.Vector4Test.Type2 do
  defstruct [
    :x,
    :y,
    :z,
    :w
  ]
end

defmodule Zexray.Type.Vector4Test do
  use ExUnit.Case, async: true
  doctest Zexray.Type.Vector4

  import ExUnitParameterize

  import Zexray.TypeFixture

  alias Zexray.Type.Vector4, as: Type
  alias Zexray.Type.Vector4Test.Type2

  import Zexray.Util, only: [map_from_struct: 1, similar?: 2]

  setup_all _ do
    %{
      value: vector4_fixture()
    }
  end

  describe "new" do
    defp dataset_new(%{value: value}) do
      map = map_from_struct(value)

      struct = struct(Type2, map)

      tuple = {
        value.x,
        value.y,
        value.z,
        value.w
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
