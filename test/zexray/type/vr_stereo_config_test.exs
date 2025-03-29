defmodule Zexray.Type.VrStereoConfigTest.Type2 do
  defstruct [
    :projection,
    :view_offset,
    :left_lens_center,
    :right_lens_center,
    :left_screen_center,
    :right_screen_center,
    :scale,
    :scale_in
  ]
end

defmodule Zexray.Type.VrStereoConfigTest do
  use ExUnit.Case, async: true
  doctest Zexray.Type.VrStereoConfig

  import ExUnitParameterize

  import Zexray.TypeFixture

  alias Zexray.Type.VrStereoConfig, as: Type
  alias Zexray.Type.VrStereoConfigTest.Type2

  import Zexray.Util, only: [map_from_struct: 1]

  setup_all _ do
    %{
      value: vr_stereo_config_fixture()
    }
  end

  describe "new" do
    defp dataset_new(%{value: value}) do
      map = map_from_struct(value)

      struct = struct(Type2, map)

      tuple = {
        value.projection,
        value.view_offset,
        value.left_lens_center,
        value.right_lens_center,
        value.left_screen_center,
        value.right_screen_center,
        value.scale,
        value.scale_in
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
