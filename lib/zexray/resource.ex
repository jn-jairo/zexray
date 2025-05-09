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
  def new!(value)

  @spec new!(values :: list) :: list
  def new!(values) when is_list(values) do
    values |> Enum.map(&new!/1)
  end

  @spec new!(value :: map) :: map
  @spec new!(value :: any) :: struct
  def new!(value) do
    cond do
      resourceable?(value) ->
        apply(to_resource_module(value.__struct__), :new, [value])

      is_struct(value) ->
        struct(
          value.__struct__,
          Map.from_struct(value)
          |> Enum.into(%{}, fn {k, v} ->
            {k, new!(v)}
          end)
        )

      is_map(value) ->
        Enum.into(value, %{}, fn {k, v} ->
          {k, new!(v)}
        end)

      true ->
        raise_invalid_resourceable(value)
    end
  end

  @doc """
  Creates a new resource if it is a resourceable or return the value.
  """
  def new(value)

  @spec new(values :: list) :: list
  def new(values) when is_list(values) do
    values |> Enum.map(&new/1)
  end

  @spec new(value :: map) :: map
  @spec new(value :: any) :: struct
  def new(value) do
    cond do
      resourceable?(value) ->
        apply(to_resource_module(value.__struct__), :new, [value])

      is_struct(value) ->
        struct(
          value.__struct__,
          Map.from_struct(value)
          |> Enum.into(%{}, fn {k, v} ->
            {k, new(v)}
          end)
        )

      is_map(value) ->
        Enum.into(value, %{}, fn {k, v} ->
          {k, new(v)}
        end)

      true ->
        value
    end
  end

  @doc """
  Get the content from the resource.
  """
  def content!(resource)

  @spec content!(resources :: list) :: list
  def content!(resources) when is_list(resources) do
    resources |> Enum.map(&content!/1)
  end

  @spec content!(resource :: map) :: map
  @spec content!(resource :: any) :: struct
  def content!(resource) do
    cond do
      resource?(resource) ->
        apply(resource.__struct__, :content, [resource])

      is_struct(resource) ->
        struct(
          resource.__struct__,
          Map.from_struct(resource)
          |> Enum.into(%{}, fn {k, v} ->
            {k, content!(v)}
          end)
        )

      is_map(resource) ->
        Enum.into(resource, %{}, fn {k, v} ->
          {k, content!(v)}
        end)

      true ->
        raise_invalid_resource(resource)
    end
  end

  @doc """
  Get the content from the resource if it is a resource or return the value.
  """
  def content(value)

  @spec content(values :: list) :: list
  def content(values) when is_list(values) do
    values |> Enum.map(&content/1)
  end

  @spec content(value :: map) :: map
  @spec content(value :: any) :: struct
  def content(value) do
    cond do
      resource?(value) ->
        apply(value.__struct__, :content, [value])

      is_struct(value) ->
        struct(
          value.__struct__,
          Map.from_struct(value)
          |> Enum.into(%{}, fn {k, v} ->
            {k, content(v)}
          end)
        )

      is_map(value) ->
        Enum.into(value, %{}, fn {k, v} ->
          {k, content(v)}
        end)

      true ->
        value
    end
  end

  @doc """
  Get the content type of the resource.
  """
  def content_type!(resource)

  @spec content_type!(resources :: list) :: list
  def content_type!(resources) when is_list(resources) do
    resources |> Enum.map(&content_type!/1)
  end

  @spec content_type!(resource :: map) :: map
  @spec content_type!(resource :: any) :: module
  def content_type!(resource) do
    cond do
      resource?(resource) ->
        apply(resource.__struct__, :content_type, [])

      is_struct(resource) ->
        struct(
          resource.__struct__,
          Map.from_struct(resource)
          |> Enum.into(%{}, fn {k, v} ->
            {k, content_type!(v)}
          end)
        )

      is_map(resource) ->
        Enum.into(resource, %{}, fn {k, v} ->
          {k, content_type!(v)}
        end)

      true ->
        raise_invalid_resource(resource)
    end
  end

  @doc """
  Get the content type of the resource if it is a resource or return the value.
  """
  def content_type(value)

  @spec content_type(values :: list) :: list
  def content_type(values) when is_list(values) do
    values |> Enum.map(&content_type/1)
  end

  @spec content_type(value :: map) :: map
  @spec content_type(value :: any) :: module
  def content_type(value) do
    cond do
      resource?(value) ->
        apply(value.__struct__, :content_type, [])

      is_struct(value) ->
        struct(
          value.__struct__,
          Map.from_struct(value)
          |> Enum.into(%{}, fn {k, v} ->
            {k, content_type(v)}
          end)
        )

      is_map(value) ->
        Enum.into(value, %{}, fn {k, v} ->
          {k, content_type(v)}
        end)

      true ->
        value
    end
  end

  @doc """
  Free the memory used by the resource.
  """
  def free!(resource)

  @spec free!(resources :: list) :: list
  def free!(resources) when is_list(resources) do
    resources |> Enum.map(&free!/1)
  end

  @spec free!(resource :: map) :: map
  @spec free!(resource :: any) :: :ok
  def free!(resource) do
    cond do
      resource?(resource) ->
        apply(resource.__struct__, :free, [resource])

      is_struct(resource) ->
        struct(
          resource.__struct__,
          Map.from_struct(resource)
          |> Enum.into(%{}, fn {k, v} ->
            {k, free!(v)}
          end)
        )

      is_map(resource) ->
        Enum.into(resource, %{}, fn {k, v} ->
          {k, free!(v)}
        end)

      true ->
        raise_invalid_resource(resource)
    end
  end

  @doc """
  Free the memory used by the resource if it is a resource.
  """
  def free(value)

  @spec free(values :: list) :: list
  def free(values) when is_list(values) do
    values |> Enum.map(&free/1)
  end

  @spec free(value :: map) :: map
  @spec free(value :: any) :: :ok
  def free(value) do
    cond do
      resource?(value) ->
        apply(value.__struct__, :free, [value])

      is_struct(value) ->
        struct(
          value.__struct__,
          Map.from_struct(value)
          |> Enum.into(%{}, fn {k, v} ->
            {k, free(v)}
          end)
        )

      is_map(value) ->
        Enum.into(value, %{}, fn {k, v} ->
          {k, free(v)}
        end)

      true ->
        value
    end
  end

  @doc """
  Free the memory used by the resource asynchronously.
  """
  def free_async!(
        resource,
        seconds \\ 1.0
      )

  @spec free_async!(
          resources :: list,
          seconds :: number
        ) :: list
  def free_async!(
        resources,
        seconds
      )
      when is_list(resources) and
             is_number(seconds) do
    resources |> Enum.map(&free_async!(&1, seconds))
  end

  @spec free_async!(
          resource :: map,
          seconds :: number
        ) :: map
  @spec free_async!(
          resource :: any,
          seconds :: number
        ) :: :ok
  def free_async!(
        resource,
        seconds
      )
      when is_number(seconds) do
    cond do
      resource?(resource) ->
        Task.start(fn ->
          wait_time(seconds)
          free!(resource)
        end)

        :ok

      is_struct(resource) ->
        struct(
          resource.__struct__,
          Map.from_struct(resource)
          |> Enum.into(%{}, fn {k, v} ->
            {k, free_async!(v, seconds)}
          end)
        )

      is_map(resource) ->
        Enum.into(resource, %{}, fn {k, v} ->
          {k, free_async!(v, seconds)}
        end)

      true ->
        raise_invalid_resource(resource)
    end
  end

  @doc """
  Free the memory used by the resource asynchronously if it is a resource.
  """
  def free_async(
        value,
        seconds \\ 1.0
      )

  @spec free_async(
          values :: list,
          seconds :: number
        ) :: list
  def free_async(
        values,
        seconds
      )
      when is_list(values) and
             is_number(seconds) do
    values |> Enum.map(&free_async(&1, seconds))
  end

  @spec free_async(
          value :: map,
          seconds :: number
        ) :: map
  @spec free_async(
          value :: any,
          seconds :: number
        ) :: :ok
  def free_async(
        value,
        seconds
      )
      when is_number(seconds) do
    cond do
      resource?(value) ->
        Task.start(fn ->
          wait_time(seconds)
          free(value)
        end)

        :ok

      is_struct(value) ->
        struct(
          value.__struct__,
          Map.from_struct(value)
          |> Enum.into(%{}, fn {k, v} ->
            {k, free_async(v, seconds)}
          end)
        )

      is_map(value) ->
        Enum.into(value, %{}, fn {k, v} ->
          {k, free_async(v, seconds)}
        end)

      true ->
        value
    end
  end

  @doc """
  Update the resource.
  """
  @spec update!(resource :: any, value :: any) :: :ok
  def update!(resource, value) do
    cond do
      resource?(resource) ->
        cond do
          resourceable?(value) ->
            apply(resource.__struct__, :update, [resource, value])

          true ->
            raise_invalid_resourceable(value)
        end

      true ->
        raise_invalid_resource(resource)
    end
  end

  @doc """
  Update the resource if it is a resource.
  """
  @spec update(resource :: any, value :: any) :: :ok | :invalid_resource | :invalid_resourceable
  def update(resource, value) do
    cond do
      resource?(resource) ->
        cond do
          resourceable?(value) ->
            apply(resource.__struct__, :update, [resource, value])

          true ->
            :invalid_resourceable
        end

      true ->
        :invalid_resource
    end
  end

  @doc """
  Run function with resource and free it after.
  """
  @spec with_resource(
          resource :: (-> list | map) | list | map,
          func :: (list | map -> any)
        ) :: any
  def with_resource(
        resource,
        func
      )
      when (is_function(resource) or is_list(resource) or is_map(resource)) and
             is_function(func) do
    resource =
      if is_function(resource) do
        resource.()
      else
        resource
      end

    try do
      func.(resource)
    after
      free(resource)
    end
  end

  @doc """
  Run function with resource and free it after asynchronously.
  """
  @spec with_resource_async(
          resource :: (-> list | map) | list | map,
          func :: (list | map -> any),
          seconds :: number
        ) :: any
  def with_resource_async(
        resource,
        func,
        seconds \\ 1.0
      )
      when (is_function(resource) or is_list(resource) or is_map(resource)) and
             is_function(func) and
             is_number(seconds) do
    resource =
      if is_function(resource) do
        resource.()
      else
        resource
      end

    try do
      func.(resource)
    after
      free_async(resource, seconds)
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
