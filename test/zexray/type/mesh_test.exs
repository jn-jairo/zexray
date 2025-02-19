defmodule Zexray.Type.MeshTest.Type2 do
  defstruct [
    :vertex_count,
    :triangle_count,
    :vertices,
    :texcoords,
    :texcoords2,
    :normals,
    :tangents,
    :colors,
    :indices,
    :anim_vertices,
    :anim_normals,
    :bone_ids,
    :bone_weights,
    :bone_matrices,
    :bone_count,
    :vao_id,
    :vbo_id
  ]
end

defmodule Zexray.Type.MeshTest do
  use ExUnit.Case, async: true
  doctest Zexray.Type.Mesh

  import ExUnitParameterize

  import Zexray.TypeFixture

  alias Zexray.Type.Mesh, as: Type
  alias Zexray.Type.MeshTest.Type2

  import Zexray.Util, only: [map_from_struct: 1, similar?: 2]

  setup_all _ do
    %{
      value: mesh_fixture()
    }
  end

  describe "new" do
    defp dataset_new(%{value: value}) do
      map = map_from_struct(value)

      struct = struct(Type2, map)

      tuple = {
        value.vertex_count,
        value.triangle_count,
        value.vertices,
        value.texcoords,
        value.texcoords2,
        value.normals,
        value.tangents,
        value.colors,
        value.indices,
        value.anim_vertices,
        value.anim_normals,
        value.bone_ids,
        value.bone_weights,
        value.bone_matrices,
        value.bone_count,
        value.vao_id,
        value.vbo_id
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
