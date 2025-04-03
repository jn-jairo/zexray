defmodule Zexray.Enum.KeyboardKeyTest do
  use ExUnit.Case, async: true
  doctest Zexray.Enum.KeyboardKey

  import ExUnitParameterize

  import Zexray.EnumFixture

  alias Zexray.Enum.KeyboardKey, as: Type

  describe "value" do
    defp dataset_value(_) do
      %{value: value, name: name} = keyboard_key_fixture()

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
    end
  end

  describe "name" do
    defp dataset_name(_) do
      %{value: value, name: name} = keyboard_key_fixture()

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

  test "value free" do
    assert :keyboard_key_161 = apply(Type, :name_free, [161])
    assert :keyboard_key_161 = apply(Type, :name_free, [:keyboard_key_161])
  end

  test "name free" do
    assert 161 = apply(Type, :value_free, [:keyboard_key_161])
    assert 161 = apply(Type, :value_free, [161])
  end
end
