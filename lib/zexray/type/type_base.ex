defmodule Zexray.Type.TypeBase do
  @moduledoc false

  defmacro __using__(opts) do
    base_module = __CALLER__.module

    base_module_name =
      base_module
      |> Atom.to_string()
      |> String.replace_prefix("Elixir.", "")
      |> String.to_atom()

    prefix = Keyword.fetch!(opts, :prefix)
    name = String.replace(prefix, "_", " ")
    from_resource = String.to_atom("#{prefix}_from_resource")
    to_resource = String.to_atom("#{prefix}_to_resource")
    free_resource = String.to_atom("#{prefix}_free_resource")

    quote do
      defmodule Resource do
        @moduledoc """
        Resource for `t:#{unquote(base_module_name)}.t/0`
        """
        defstruct reference: nil
        @type t :: %__MODULE__{reference: reference}

        import Zexray.Util, only: [map_from_struct: 1]

        alias Zexray.NIF

        @doc """
        Creates a new resource for `t:#{unquote(base_module)}.t/0`.
        """
        def new(value)

        @spec new(reference :: reference) :: t()
        def new(reference) when is_reference(reference) do
          %__MODULE__{reference: reference}
        end

        @spec new(value :: unquote(base_module).t()) :: t()
        def new(value) when is_struct(value, unquote(base_module)) do
          apply(NIF, unquote(to_resource), [unquote(base_module).to_nif(value)])
          |> new()
        end

        @spec new(value :: map) :: t()
        def new(%{} = value) do
          apply(NIF, unquote(to_resource), [map_from_struct(value)])
          |> new()
        end

        @doc """
        Free the memory used by the resource.
        """
        @spec free(resource :: t()) :: :ok
        def free(%__MODULE__{} = resource) do
          if function_exported?(NIF, unquote(free_resource), 1) do
            apply(NIF, unquote(free_resource), [resource.reference])
          else
            :ok
          end
        end

        @doc """
        Get the `t:#{unquote(base_module_name)}.t/0` from the resource.
        """
        @spec content(resource :: t()) :: unquote(base_module).t()
        def content(%__MODULE__{} = resource) do
          map = apply(NIF, unquote(from_resource), [resource.reference])
          apply(unquote(base_module), :new, [map])
        end
      end

      @name unquote(name)

      @type t_nif :: t | __MODULE__.Resource.t()

      @spec raise_argument_error(value :: any) :: no_return
      defp raise_argument_error(value) do
        raise ArgumentError, "Invalid #{@name}: #{inspect(value)}"
      end

      @spec raise_argument_error(value :: any, available :: any) :: no_return
      defp raise_argument_error(value, available) do
        raise ArgumentError,
              "Invalid #{@name}: #{inspect(value)}\nAvailable: #{inspect(available)}"
      end

      @doc """
      Converts to a format accepted by the NIF.
      """
      def to_nif(value)

      @spec to_nif(values :: list) :: list
      def to_nif(values) when is_list(values) do
        values |> Enum.map(&to_nif/1)
      end

      @spec to_nif(reference :: reference) :: reference
      def to_nif(reference) when is_reference(reference) do
        reference
      end

      @spec to_nif(resource :: __MODULE__.Resource.t()) :: reference
      def to_nif(%__MODULE__.Resource{} = resource) do
        resource.reference
      end

      @spec to_nif(value :: t()) :: map
      def to_nif(%__MODULE__{} = value) do
        value
        |> Map.from_struct()
        |> Enum.into(%{}, fn {key, value} ->
          cond do
            is_list(value) ->
              {key, list_to_nif(value)}

            is_struct(value) and function_exported?(value.__struct__, :to_nif, 1) ->
              {key, value.__struct__.to_nif(value)}

            is_struct(value) and String.ends_with?(Atom.to_string(value.__struct__), ".Resource") ->
              {key, value.reference}

            true ->
              {key, value}
          end
        end)
        |> Zexray.Util.map_from_struct()
      end

      @spec to_nif(value :: any) :: map
      def to_nif(value) do
        apply(__MODULE__, :new, [value])
        |> to_nif()
      end

      @spec list_to_nif(values :: list) :: list
      defp list_to_nif(values) when is_list(values) do
        values
        |> Enum.map(fn value ->
          cond do
            is_list(value) ->
              list_to_nif(value)

            is_struct(value) and function_exported?(value.__struct__, :to_nif, 1) ->
              value.__struct__.to_nif(value)

            is_struct(value) and String.ends_with?(Atom.to_string(value.__struct__), ".Resource") ->
              value.reference

            true ->
              value
          end
        end)
      end

      @doc """
      Converts from a format returned by the NIF.
      """
      def from_nif(value)

      @spec from_nif(values :: list) :: list
      def from_nif(values) when is_list(values) do
        values |> Enum.map(&from_nif/1)
      end

      @spec from_nif(reference :: reference) :: __MODULE__.Resource.t()
      def from_nif(reference) when is_reference(reference) do
        apply(__MODULE__.Resource, :new, [reference])
      end

      @spec from_nif(value :: map) :: __MODULE__.t()
      def from_nif(%{} = value) do
        apply(__MODULE__, :new, [value])
      end

      @spec from_nif(value :: any) :: __MODULE__.t()
      def from_nif(value) do
        apply(__MODULE__, :new, [value])
      end
    end
  end
end
