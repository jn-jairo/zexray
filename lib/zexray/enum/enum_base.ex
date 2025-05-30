defmodule Zexray.Enum.EnumBase do
  @moduledoc false

  import Bitwise

  defmacro __using__(opts) do
    prefix = Keyword.fetch!(opts, :prefix)
    value_type = Keyword.get(opts, :value_type, quote(do: integer()))
    name = String.replace(prefix, "_", " ")
    values_by_name = Keyword.fetch!(opts, :values)

    quote generated: true do
      import Bitwise

      @name unquote(name)
      @values unquote(get_values(values_by_name))
      @flag_all unquote(get_flag_all(values_by_name))
      @names unquote(get_names(values_by_name))
      @values_by_name unquote(values_by_name)
      @names_by_value unquote(get_names_by_value(values_by_name))

      @type t :: unquote(get_type_t(values_by_name))
      @type t_name :: unquote(get_type_t_name(values_by_name))

      @type t_free :: t | unquote(value_type)
      @type t_name_free :: t_name | atom

      @type t_all :: t | t_name

      @type t_all_free :: t_free | t_name_free

      @type t_all_flag ::
              unquote(value_type) | t_name | :all | list(unquote(value_type) | t_name | :all)

      @spec values() :: nonempty_list(unquote(value_type))
      def values(), do: @values

      @spec names() :: nonempty_list(atom)
      def names(), do: @names

      @spec values_by_name() :: %{atom => unquote(value_type)}
      def values_by_name(), do: @values_by_name

      @spec names_by_value() :: %{unquote(value_type) => atom}
      def names_by_value(), do: @names_by_value

      @spec value(name :: atom | unquote(value_type)) :: unquote(value_type)
      def value(name)

      def value(name) when is_atom(name) do
        if Map.has_key?(@values_by_name, name) do
          @values_by_name[name]
        else
          raise_invalid_value(@names, name)
        end
      end

      def value(value) do
        if Map.has_key?(@names_by_value, value) do
          value
        else
          raise_invalid_value(@values, value)
        end
      end

      @spec value_free(name :: atom | unquote(value_type)) :: unquote(value_type)
      def value_free(name)

      def value_free(name) when is_atom(name) do
        if Map.has_key?(@values_by_name, name) do
          @values_by_name[name]
        else
          name_string = Atom.to_string(name)

          if String.starts_with?(name_string, "#{unquote(prefix)}_") do
            name_suffix = String.replace_prefix(name_string, "#{unquote(prefix)}_", "")

            case Integer.parse(name_suffix) do
              {value, _} when is_integer(value) -> value
              _ -> raise_invalid_value(@names, name)
            end
          else
            raise_invalid_value(@names, name)
          end
        end
      end

      def value_free(value) do
        value
      end

      @spec value_flag(name :: atom | integer | list) :: integer
      def value_flag(name)

      def value_flag([]), do: 0

      def value_flag(values) when is_list(values) do
        values
        |> Enum.reduce(0, fn value, acc ->
          v = value_flag(value)

          if is_integer(v) do
            v ||| acc
          else
            acc
          end
        end)
      end

      def value_flag(:all), do: @flag_all

      def value_flag(name) when is_atom(name) do
        v = value(name)

        if is_integer(v) do
          v
        else
          0
        end
      end

      def value_flag(value) when is_integer(value) do
        if value >= 0 and value <= @flag_all do
          value
        else
          raise_invalid_value(@values, value)
        end
      end

      @spec name(value :: unquote(value_type) | atom) :: atom
      def name(value)

      def name(name) when is_atom(name) do
        if Map.has_key?(@values_by_name, name) do
          name
        else
          raise_invalid_value(@names, name)
        end
      end

      def name(value) do
        if Map.has_key?(@names_by_value, value) do
          @names_by_value[value]
        else
          raise_invalid_value(@values, value)
        end
      end

      @spec name_free(value :: unquote(value_type) | atom) :: atom
      def name_free(value)

      def name_free(name) when is_atom(name) do
        if Map.has_key?(@values_by_name, name) do
          name
        else
          name_string = Atom.to_string(name)

          if String.starts_with?(name_string, "#{unquote(prefix)}_") do
            name_suffix = String.replace_prefix(name_string, "#{unquote(prefix)}_", "")

            case Integer.parse(name_suffix) do
              {value, _} when is_integer(value) -> name_free(value)
              _ -> raise_invalid_value(@names, name)
            end
          else
            raise_invalid_value(@names, name)
          end
        end
      end

      def name_free(value) do
        if Map.has_key?(@names_by_value, value) do
          @names_by_value[value]
        else
          String.to_atom("#{unquote(prefix)}_#{value}")
        end
      end

      @spec enum(value :: any) :: any
      defmacro enum(value) do
        {value, _} = Code.eval_quoted(value)

        v =
          cond do
            is_atom(value) ->
              if Map.has_key?(@values_by_name, value) do
                @values_by_name[value]
              else
                raise_invalid_value(@names, value)
              end

            true ->
              if Map.has_key?(@names_by_value, value) do
                @names_by_value[value]
              else
                raise_invalid_value(@values, value)
              end
          end

        Macro.escape(v)
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

  defp get_flag_all({_, _, values_by_name}) do
    Keyword.values(values_by_name)
    |> Enum.uniq()
    |> Enum.reduce(0, fn value, acc ->
      if is_integer(value) do
        value ||| acc
      else
        acc
      end
    end)
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
