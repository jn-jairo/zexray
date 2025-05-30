defmodule Zexray.Resource do
  @moduledoc """
  Resource
  """

  import Zexray.Util, only: [wait_time: 1]

  alias Zexray.NIF
  Code.ensure_compiled(Zexray.NIF)

  defmacrop record_type_string(value) when is_tuple(value) and is_atom(elem(value, 0)) do
    quote do
      unquote(value)
      |> elem(0)
      |> Atom.to_string()
    end
  end

  defmacrop record_type_suffix(value, suffix)
            when is_tuple(value) and is_atom(elem(value, 0)) and is_binary(suffix) do
    quote do
      String.to_atom("#{record_type_string(unquote(value))}_#{unquote(suffix)}")
    end
  end

  defmacrop resourceable_type_string(value) when is_tuple(value) and is_atom(elem(value, 0)) do
    quote do
      unquote(value)
      |> elem(0)
      |> Atom.to_string()
      |> String.replace_suffix("_resource", "")
    end
  end

  defmacrop resourceable_type_suffix(value, suffix)
            when is_tuple(value) and is_atom(elem(value, 0)) and is_binary(suffix) do
    quote do
      String.to_atom("#{resourceable_type_string(unquote(value))}_#{unquote(suffix)}")
    end
  end

  @doc """
  Check if the value is a resource struct.
  """
  @spec resource?(value :: any) :: boolean
  def resource?(value)

  def resource?(value) when is_tuple(value) and is_atom(elem(value, 0)) do
    String.ends_with?(record_type_string(value), "_resource")
  end

  def resource?(_value), do: false

  @doc """
  Check if the value is a resourceable struct.
  """
  @spec resourceable?(value :: any) :: boolean
  def resourceable?(value)

  def resourceable?(value) when is_tuple(value) and is_atom(elem(value, 0)) do
    record_type =
      record_type_string(value)

    if String.ends_with?(record_type, "_resource") do
      false
    else
      function_exported?(NIF, String.to_atom("#{record_type}_to_resource"), 1)
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
        apply(NIF, record_type_suffix(value, "to_resource"), [value])

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

      is_tuple(value) ->
        value
        |> Tuple.to_list()
        |> new!()
        |> List.to_tuple()

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
        apply(NIF, record_type_suffix(value, "to_resource"), [value])

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

      is_tuple(value) ->
        value
        |> Tuple.to_list()
        |> new()
        |> List.to_tuple()

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
        apply(NIF, resourceable_type_suffix(resource, "from_resource"), [resource])

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

      is_tuple(resource) ->
        resource
        |> Tuple.to_list()
        |> content!()
        |> List.to_tuple()

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
        apply(NIF, resourceable_type_suffix(value, "from_resource"), [value])

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

      is_tuple(value) ->
        value
        |> Tuple.to_list()
        |> content()
        |> List.to_tuple()

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
        apply(NIF, resourceable_type_suffix(resource, "free_resource"), [resource])

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

      is_tuple(resource) ->
        resource
        |> Tuple.to_list()
        |> free!()
        |> List.to_tuple()

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
        apply(NIF, resourceable_type_suffix(value, "free_resource"), [value])

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

      is_tuple(value) ->
        value
        |> Tuple.to_list()
        |> free()
        |> List.to_tuple()

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

      is_tuple(resource) ->
        resource
        |> Tuple.to_list()
        |> free_async!(seconds)
        |> List.to_tuple()

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

      is_tuple(value) ->
        value
        |> Tuple.to_list()
        |> free_async(seconds)
        |> List.to_tuple()

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
            apply(NIF, resourceable_type_suffix(resource, "update_resource"), [resource, value])

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
            apply(NIF, resourceable_type_suffix(resource, "update_resource"), [resource, value])

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
          resource :: (-> list | map | tuple) | list | map | tuple,
          func :: (list | map -> any)
        ) :: any
  def with_resource(
        resource,
        func
      )
      when (is_function(resource) or is_list(resource) or is_map(resource) or is_tuple(resource)) and
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
          resource :: (-> list | map | tuple) | list | map | tuple,
          func :: (list | map -> any),
          seconds :: number
        ) :: any
  def with_resource_async(
        resource,
        func,
        seconds \\ 1.0
      )
      when (is_function(resource) or is_list(resource) or is_map(resource) or is_tuple(resource)) and
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

  @spec raise_invalid_resource(value :: any) :: no_return
  defp raise_invalid_resource(value) do
    raise ArgumentError, "Invalid resource: #{inspect(value)}"
  end

  @spec raise_invalid_resourceable(value :: any) :: no_return
  defp raise_invalid_resourceable(value) do
    raise ArgumentError, "Invalid resourceable: #{inspect(value)}"
  end
end
