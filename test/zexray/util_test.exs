defmodule Zexray.UtilTest.Foo do
  defstruct [
    :atom,
    :float,
    :integer,
    :binary,
    :struct
  ]
end

defmodule Zexray.UtilTest do
  use ExUnit.Case, async: true
  doctest Zexray.Util

  import ExUnitParameterize

  alias Zexray.Util
  alias Zexray.UtilTest.Foo

  describe "map_from_struct" do
    defp dataset_new(_) do
      v = %{
        atom: :foo,
        float: 1.23,
        integer: 123,
        binary: "foo"
      }

      v = Map.put(v, :struct, v)

      s = struct(Foo, v)

      datasets = %{
        struct: {v, [s]},
        map: {%{v: v}, [%{v: s}]},
        list: {[v, v], [[s, s]]},
        tuple: {{v, v}, [{s, s}]}
      }

      %{datasets: datasets}
    end

    setup [:dataset_new]

    parameterized_test "", %{datasets: datasets}, [
      [dataset: :struct],
      [dataset: :map],
      [dataset: :list],
      [dataset: :tuple]
    ] do
      dataset = Map.fetch!(datasets, dataset)

      {expected, params} = dataset

      assert expected == apply(Util, :map_from_struct, params)
    end
  end

  describe "similar?" do
    defp dataset_similar?(_) do
      v1 = %{
        atom: :foo,
        float: 1.23,
        integer: 123,
        binary: "foo"
      }

      v1 = Map.put(v1, :struct, v1)
      s1 = struct(Foo, v1)

      v2 = %{
        atom: :foo,
        float: 1.230000001,
        integer: 123.0000001,
        binary: "foo"
      }

      v2 = Map.put(v2, :struct, v2)
      s2 = struct(Foo, v2)

      v3 = %{
        atom: :fooo,
        float: 1.231,
        integer: 123.1,
        binary: "fooo"
      }

      v3 = Map.put(v3, :struct, v3)
      s3 = struct(Foo, v3)

      datasets = %{
        struct_similar: {true, [s1, s2]},
        struct_not_similar: {false, [s1, s3]},
        #
        map_similar: {true, [v1, v2]},
        map_not_similar: {false, [v1, v3]},
        map_different_keys: {false, [%{foo: :foo}, %{bar: :bar}]},
        #
        list_similar: {true, [[v1, v1], [v2, v2]]},
        list_not_similar: {false, [[v1, v1], [v1, v3]]},
        list_different_length: {false, [[v1], [v1, v3]]},
        #
        tuple_similar: {true, [{v1, v1}, {v2, v2}]},
        tuple_not_similar: {false, [{v1, v1}, {v1, v3}]},
        tuple_different_length: {false, [{v1}, {v1, v3}]},
        #
        float_similar: {true, [v1.float, v2.float]},
        float_not_similar: {false, [v1.float, v3.float]},
        #
        integer_similar: {true, [v1.integer, v2.integer]},
        integer_not_similar: {false, [v1.integer, v3.integer]},
        #
        atom_similar: {true, [v1.atom, v2.atom]},
        atom_not_similar: {false, [v1.atom, v3.atom]},
        #
        binary_similar: {true, [v1.binary, v2.binary]},
        binary_not_similar: {false, [v1.binary, v3.binary]},
        #
        nil_similar: {true, [nil, nil]},
        nil_not_similar: {false, [nil, :foo]}
      }

      %{datasets: datasets}
    end

    setup [:dataset_similar?]

    parameterized_test "", %{datasets: datasets}, [
      [dataset: :struct_similar],
      [dataset: :struct_not_similar],
      #
      [dataset: :map_similar],
      [dataset: :map_not_similar],
      [dataset: :map_different_keys],
      #
      [dataset: :list_similar],
      [dataset: :list_not_similar],
      [dataset: :list_different_length],
      #
      [dataset: :tuple_similar],
      [dataset: :tuple_not_similar],
      [dataset: :tuple_different_length],
      #
      [dataset: :float_similar],
      [dataset: :float_not_similar],
      #
      [dataset: :integer_similar],
      [dataset: :integer_not_similar],
      #
      [dataset: :atom_similar],
      [dataset: :atom_not_similar],
      #
      [dataset: :binary_similar],
      [dataset: :binary_not_similar],
      #
      [dataset: :nil_similar],
      [dataset: :nil_not_similar]
    ] do
      dataset = Map.fetch!(datasets, dataset)

      {expected, params} = dataset

      assert expected == apply(Util, :similar?, params)
    end
  end
end
