defmodule Zexray.Resource do
  @moduledoc """
  Resource
  """

  import Zexray.Util, only: [wait_time: 1]

  @doc """
  Check if the value is a resource struct.
  """
  @spec resource?(value :: any) :: boolean
  def resource?(value)

  def resource?(value) when is_struct(value) do
    String.ends_with?(Atom.to_string(value.__struct__), ".Resource")
  end

  def resource?(_value), do: false

  @doc """
  Check if the value is a resourceable struct.
  """
  @spec resourceable?(value :: any) :: boolean
  def resourceable?(value)

  def resourceable?(value) when is_struct(value) do
    module = to_resource_module(value.__struct__)

    case Code.ensure_compiled(module) do
      {:module, ^module} -> true
      _ -> false
    end
  end

  def resourceable?(_value), do: false

  @doc """
  Creates a new resource.
  """
  @spec new!(value :: any) :: struct
  def new!(value) do
    if resourceable?(value) do
      apply(to_resource_module(value.__struct__), :new, [value])
    else
      raise_invalid_resourceable(value)
    end
  end

  @doc """
  Creates a new resource if it is a resourceable or return the value.
  """
  @spec new(value :: any) :: struct
  def new(value) do
    if resourceable?(value) do
      apply(to_resource_module(value.__struct__), :new, [value])
    else
      value
    end
  end

  @doc """
  Get the content from the resource.
  """
  @spec content!(resource :: any) :: struct
  def content!(resource) do
    if resource?(resource) do
      apply(resource.__struct__, :content, [resource])
    else
      raise_invalid_resource(resource)
    end
  end

  @doc """
  Get the content from the resource if it is a resource or return the value.
  """
  @spec content(value :: any) :: struct
  def content(value) do
    if resource?(value) do
      apply(value.__struct__, :content, [value])
    else
      value
    end
  end

  @doc """
  Get the content type of the resource.
  """
  @spec content_type!(resource :: any) :: module
  def content_type!(resource) do
    if resource?(resource) do
      apply(resource.__struct__, :content_type, [])
    else
      raise_invalid_resource(resource)
    end
  end

  @doc """
  Get the content type of the resource if it is a resource or return the value.
  """
  @spec content_type(value :: any) :: module
  def content_type(value) do
    if resource?(value) do
      apply(value.__struct__, :content_type, [])
    else
      value
    end
  end

  @doc """
  Free the memory used by the resource.
  """
  @spec free!(resource :: any) :: :ok
  def free!(resource) do
    if resource?(resource) do
      apply(resource.__struct__, :free, [resource])
    else
      raise_invalid_resource(resource)
    end
  end

  @doc """
  Free the memory used by the resource if it is a resource.
  """
  @spec free(value :: any) :: :ok
  def free(value) do
    if resource?(value) do
      apply(value.__struct__, :free, [value])
    else
      :ok
    end
  end

  @doc """
  Free the memory used by the resource asynchronously.
  """
  @spec free_async!(resource :: any, seconds :: number) :: :ok
  def free_async!(resource, seconds \\ 1.0)

  def free_async!(resource, seconds) do
    if resource?(resource) do
      Task.start(fn ->
        wait_time(seconds)
        free!(resource)
      end)

      :ok
    else
      raise_invalid_resource(resource)
    end
  end

  @doc """
  Free the memory used by the resource asynchronously if it is a resource.
  """
  @spec free_async(value :: any, seconds :: number) :: :ok
  def free_async(value, seconds \\ 1.0)

  def free_async(value, seconds) do
    if resource?(value) do
      Task.start(fn ->
        wait_time(seconds)
        free(value)
      end)

      :ok
    else
      :ok
    end
  end

  @spec to_resource_module(module :: module) :: module
  defp to_resource_module(module) when is_atom(module) do
    String.to_atom("#{Atom.to_string(module)}.Resource")
  end

  @spec raise_invalid_resource(value :: any) :: no_return
  defp raise_invalid_resource(value) do
    raise ArgumentError, "Invalid resource: #{inspect(value)}"
  end

  @spec raise_invalid_resourceable(value :: any) :: no_return
  defp raise_invalid_resourceable(value) do
    raise ArgumentError, "Invalid resourceable: #{inspect(value)}"
  end
end
