defmodule Zexray.Type.ColorTest.Type2 do
  defstruct [
    :r,
    :g,
    :b,
    :a
  ]
end

defmodule Zexray.Type.ColorTest do
  use ExUnit.Case, async: true
  doctest Zexray.Type.Color

  import ExUnitParameterize

  import Zexray.TypeFixture

  alias Zexray.Type.Color, as: Type
  alias Zexray.Type.ColorTest.Type2

  import Zexray.Util, only: [map_from_struct: 1, similar?: 2]

  setup_all _ do
    atom = :violet

    %{
      value: color_fixture(atom),
      atom: atom
    }
  end

  describe "new" do
    defp dataset_new(%{value: value, atom: atom}) do
      bitstring_24 = <<
        value.r::8,
        value.g::8,
        value.b::8
      >>

      bitstring_32 = <<
        value.r::8,
        value.g::8,
        value.b::8,
        value.a::8
      >>

      integer_24 = :binary.decode_unsigned(bitstring_24)

      integer_32 = :binary.decode_unsigned(bitstring_32)

      map = map_from_struct(value)

      struct = struct(Type2, map)

      tuple_rgba = {
        value.r,
        value.g,
        value.b,
        value.a
      }

      tuple_rgb = {
        value.r,
        value.g,
        value.b
      }

      tuple_rgb_integer = {:rgb, integer_24}
      tuple_rgba_integer = {:rgba, integer_32}

      datasets = %{
        atom: {value, [atom]},
        integer: {value, [integer_32]},
        bitstring_24: {value, [bitstring_24]},
        bitstring_32: {value, [bitstring_32]},
        map: {value, [map]},
        tuple_rgb: {value, [tuple_rgb]},
        tuple_rgba: {value, [tuple_rgba]},
        tuple_rgb_integer: {value, [tuple_rgb_integer]},
        tuple_rgba_integer: {value, [tuple_rgba_integer]},
        struct_other: {value, [struct]},
        struct_same: {value, [value]}
      }

      %{datasets: datasets}
    end

    setup [:dataset_new]

    parameterized_test "", %{datasets: datasets}, [
      [dataset: :atom],
      [dataset: :integer],
      [dataset: :bitstring_24],
      [dataset: :bitstring_32],
      [dataset: :map],
      [dataset: :tuple_rgb],
      [dataset: :tuple_rgba],
      [dataset: :tuple_rgb_integer],
      [dataset: :tuple_rgba_integer],
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
    assert_raise ArgumentError, fn -> Type.new(:foo) end
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
