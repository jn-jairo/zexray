defmodule Zexray.Enum.ConfigFlagTest do
  use ExUnit.Case, async: true
  doctest Zexray.Enum.ConfigFlag

  import ExUnitParameterize

  import Bitwise
  import Zexray.EnumFixture

  alias Zexray.Enum.ConfigFlag, as: Type

  describe "value" do
    defp dataset_value(_) do
      %{value: value, name: name} = config_flag_fixture()

      datasets = %{
        atom: {value, [name]},
        integer: {value, [value]}
      }

      %{datasets: datasets}
    end

    setup [:dataset_value]

    parameterized_test "", %{datasets: datasets}, [
      [dataset: :atom],
      [dataset: :integer]
    ] do
      dataset = Map.fetch!(datasets, dataset)

      {expected, params} = dataset

      assert ^expected = apply(Type, :value, params)
      assert ^expected = apply(Type, :value_flag, params)
    end
  end

  describe "name" do
    defp dataset_name(_) do
      %{value: value, name: name} = config_flag_fixture()

      datasets = %{
        atom: {name, [name]},
        integer: {name, [value]}
      }

      %{datasets: datasets}
    end

    setup [:dataset_name]

    parameterized_test "", %{datasets: datasets}, [
      [dataset: :atom],
      [dataset: :integer]
    ] do
      dataset = Map.fetch!(datasets, dataset)

      {expected, params} = dataset

      assert ^expected = apply(Type, :name, params)
    end
  end

  test "value invalid" do
    assert_raise ArgumentError, fn -> Type.value(-100) end
    assert_raise ArgumentError, fn -> Type.value(:foo) end
  end

  test "name invalid" do
    assert_raise ArgumentError, fn -> Type.name(-100) end
    assert_raise ArgumentError, fn -> Type.name(:foo) end
  end

  test "value flag all" do
    value_all = Type.value_flag(:all)

    Type.values()
    |> Enum.each(fn value ->
      assert (value_all &&& value) == value
    end)
  end
end
