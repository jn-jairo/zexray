defmodule Zexray.Type.ModelTest.Type2 do
  defstruct [
    :transform,
    :mesh_count,
    :material_count,
    :meshes,
    :materials,
    :mesh_material,
    :bone_count,
    :bones,
    :bind_pose
  ]
end

defmodule Zexray.Type.ModelTest do
  use ExUnit.Case, async: true
  doctest Zexray.Type.Model

  import ExUnitParameterize

  import Zexray.TypeFixture

  alias Zexray.Type.Model, as: Type
  alias Zexray.Type.ModelTest.Type2

  import Zexray.Util, only: [map_from_struct: 1, similar?: 2]

  setup_all _ do
    %{
      value: model_fixture()
    }
  end

  describe "new" do
    defp dataset_new(%{value: value}) do
      map = map_from_struct(value)

      struct = struct(Type2, map)

      tuple = {
        value.transform,
        value.mesh_count,
        value.material_count,
        value.meshes,
        value.materials,
        value.mesh_material,
        value.bone_count,
        value.bones,
        value.bind_pose
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

  test "resource", %{value: value} do
    resource = Type.Resource.new(value)
    assert similar?(value, Type.new(resource))
    Type.Resource.free(resource)
  end
end
