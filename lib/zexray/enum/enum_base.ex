defmodule Zexray.Enum.EnumBase do
  @moduledoc false

  defmacro __using__(opts) do
    prefix = Keyword.fetch!(opts, :prefix)
    name = String.replace(prefix, "_", " ")
    values_by_name = Keyword.fetch!(opts, :values)

    quote do
      @name unquote(name)
      @values unquote(get_values(values_by_name))
      @names unquote(get_names(values_by_name))
      @values_by_name unquote(values_by_name)
      @names_by_value unquote(get_names_by_value(values_by_name))

      @type t :: unquote(get_type_t(values_by_name))
      @type t_name :: unquote(get_type_t_name(values_by_name))

      @type t_all :: t | t_name

      @spec values() :: nonempty_list(integer)
      def values(), do: @values

      @spec names() :: nonempty_list(atom)
      def names(), do: @names

      @spec values_by_name() :: %{atom => integer}
      def values_by_name(), do: @values_by_name

      @spec names_by_value() :: %{integer => atom}
      def names_by_value(), do: @names_by_value

      @spec value(name :: atom | integer) :: integer
      def value(name)

      def value(name) when is_atom(name) do
        if Map.has_key?(@values_by_name, name) do
          @values_by_name[name]
        else
          raise_invalid_value(@names, name)
        end
      end

      def value(value) when is_integer(value) do
        if Map.has_key?(@names_by_value, value) do
          value
        else
          raise_invalid_value(@values, value)
        end
      end

      @spec name(value :: integer | atom) :: atom
      def name(value)

      def name(value) when is_integer(value) do
        if Map.has_key?(@names_by_value, value) do
          @names_by_value[value]
        else
          raise_invalid_value(@values, value)
        end
      end

      def name(name) when is_atom(name) do
        if Map.has_key?(@values_by_name, name) do
          name
        else
          raise_invalid_value(@names, name)
        end
      end

      @spec raise_invalid_value(values :: any, value :: any) :: no_return
      defp raise_invalid_value(values, value) do
        raise ArgumentError,
              "Invalid #{@name}: #{inspect(value)}\nAvailable #{@name}: #{inspect(values)}"
      end
    end
  end

  defp get_names({_, _, values_by_name}) do
    Keyword.keys(values_by_name)
    |> Enum.uniq()
  end

  defp get_values({_, _, values_by_name}) do
    Keyword.values(values_by_name)
    |> Enum.uniq()
  end

  defp get_names_by_value({_, _, values_by_name}) do
    {
      :%{},
      [],
      Enum.into(values_by_name, %{}, fn {name, value} ->
        {value, name}
      end)
      |> Map.to_list()
    }
  end

  defp get_type_t({_, _, values_by_name}) do
    Keyword.values(values_by_name)
    |> Enum.uniq()
    |> Enum.reverse()
    |> Enum.reduce(nil, fn value, acc ->
      if acc do
        {:|, [], [value, acc]}
      else
        value
      end
    end)
  end

  defp get_type_t_name({_, _, values_by_name}) do
    Keyword.keys(values_by_name)
    |> Enum.uniq()
    |> Enum.reverse()
    |> Enum.reduce(nil, fn value, acc ->
      if acc do
        {:|, [], [value, acc]}
      else
        value
      end
    end)
  end
end
