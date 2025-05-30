defmodule Zexray.Type.TypeBase do
  @moduledoc false

  defmacro __using__(opts) do
    prefix = Keyword.fetch!(opts, :prefix)
    resource_tag = String.to_atom("#{prefix}_resource")
    from_resource = String.to_atom("#{prefix}_from_resource")
    to_resource = String.to_atom("#{prefix}_to_resource")
    free_resource = String.to_atom("#{prefix}_free_resource")
    update_resource = String.to_atom("#{prefix}_update_resource")

    quote generated: true do
      @type t_resource ::
              record(:t_resource,
                reference: reference
              )

      Record.defrecord(:t_resource, unquote(resource_tag), reference: nil)

      @type t_nif :: t | t_resource

      alias Zexray.NIF

      @doc """
      Creates a new resource for `t:t/0`.
      """
      @spec to_resource(value :: t()) :: t_resource()
      def to_resource(t() = value) do
        apply(NIF, unquote(to_resource), [value])
      end

      @doc """
      Free the memory used by the resource.
      """
      @spec free_resource(resource :: t_resource()) :: :ok
      def free_resource(t_resource() = resource) do
        if function_exported?(NIF, unquote(free_resource), 1) do
          apply(NIF, unquote(free_resource), [resource])
        else
          :ok
        end
      end

      @doc """
      Update the resource.
      """
      @spec update_resource(
              resource :: t_resource(),
              value :: t()
            ) :: :ok
      def update_resource(
            t_resource() = resource,
            t() = value
          ) do
        if function_exported?(NIF, unquote(update_resource), 2) do
          apply(NIF, unquote(update_resource), [resource, value])
        else
          :ok
        end
      end

      @doc """
      Get the `t:t/0` from the resource.
      """
      @spec from_resource(resource :: t_resource()) :: t()
      def from_resource(t_resource() = resource) do
        apply(NIF, unquote(from_resource), [resource])
      end
    end
  end
end
