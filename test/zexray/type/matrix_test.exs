defmodule Zexray.Type.MatrixTest.Type2 do
  defstruct [
    :m0,
    :m1,
    :m2,
    :m3,
    :m4,
    :m5,
    :m6,
    :m7,
    :m8,
    :m9,
    :m10,
    :m11,
    :m12,
    :m13,
    :m14,
    :m15
  ]
end

defmodule Zexray.Type.MatrixTest do
  use ExUnit.Case, async: true
  doctest Zexray.Type.Matrix

  import ExUnitParameterize

  import Zexray.TypeFixture

  alias Zexray.Type.Matrix, as: Type
  alias Zexray.Type.MatrixTest.Type2

  import Zexray.Util, only: [map_from_struct: 1, similar?: 2]

  setup_all _ do
    %{
      value: matrix_fixture()
    }
  end

  describe "new" do
    defp dataset_new(%{value: value}) do
      map = map_from_struct(value)

      struct = struct(Type2, map)

      tuple = {
        value.m0,
        value.m1,
        value.m2,
        value.m3,
        value.m4,
        value.m5,
        value.m6,
        value.m7,
        value.m8,
        value.m9,
        value.m10,
        value.m11,
        value.m12,
        value.m13,
        value.m14,
        value.m15
      }

      tuple_rows = {
        {value.m0, value.m4, value.m8, value.m12},
        {value.m1, value.m5, value.m9, value.m13},
        {value.m2, value.m6, value.m10, value.m14},
        {value.m3, value.m7, value.m11, value.m15}
      }

      datasets = %{
        map: {value, [map]},
        tuple: {value, [tuple]},
        tuple_rows: {value, [tuple_rows]},
        struct_other: {value, [struct]},
        struct_same: {value, [value]}
      }

      %{datasets: datasets}
    end

    setup [:dataset_new]

    parameterized_test "", %{datasets: datasets}, [
      [dataset: :map],
      [dataset: :tuple],
      [dataset: :tuple_rows],
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
