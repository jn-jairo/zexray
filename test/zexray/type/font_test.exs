defmodule Zexray.Type.FontTest.Type2 do
  defstruct [
    :base_size,
    :glyph_count,
    :glyph_padding,
    :texture,
    :recs,
    :glyphs
  ]
end

defmodule Zexray.Type.FontTest do
  use ExUnit.Case, async: true
  doctest Zexray.Type.Font

  import ExUnitParameterize

  import Zexray.TypeFixture

  alias Zexray.Type.Font, as: Type
  alias Zexray.Type.FontTest.Type2

  import Zexray.Util, only: [map_from_struct: 1, similar?: 2]

  setup_all _ do
    %{
      value: font_fixture()
    }
  end

  describe "new" do
    defp dataset_new(%{value: value}) do
      map = map_from_struct(value)

      struct = struct(Type2, map)

      tuple = {
        value.base_size,
        value.glyph_count,
        value.glyph_padding,
        value.texture,
        value.recs,
        value.glyphs
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

  test "resource", %{value: value} do
    resource = Type.Resource.new(value)
    assert similar?(value, Type.new(resource))
    Type.Resource.free(resource)
  end
end
