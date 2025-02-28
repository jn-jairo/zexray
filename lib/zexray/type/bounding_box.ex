defmodule Zexray.Type.BoundingBox do
  @moduledoc """
  Bounding Box

  ## Fields

  |       |                           |
  | ----- | ------------------------- |
  | `min` | Minimum vertex box-corner |
  | `max` | Maximum vertex box-corner |
  """

  defstruct min: nil,
            max: nil

  use Zexray.Type.TypeBase, prefix: "bounding_box"

  @type t ::
          %__MODULE__{
            min: Zexray.Type.Vector3.t_nif(),
            max: Zexray.Type.Vector3.t_nif()
          }

  @type t_all ::
          t
          | {
              Zexray.Type.Vector3.t_all(),
              Zexray.Type.Vector3.t_all()
            }
          | map
          | keyword
          | Resource.t()

  import Zexray.Guard

  @doc """
  Creates a new `t:t/0`.
  """
  def new(bounding_box)

  @spec new({
          min :: Zexray.Type.Vector3.t_all(),
          max :: Zexray.Type.Vector3.t_all()
        }) :: t()
  def new({
        min,
        max
      })
      when is_vector3_like(min) and
             is_vector3_like(max) do
    new(
      min: min,
      max: max
    )
  end

  @spec new(bounding_box :: struct) :: t()
  def new(bounding_box) when is_struct(bounding_box) do
    bounding_box =
      if String.ends_with?(Atom.to_string(bounding_box.__struct__), ".Resource") do
        apply(bounding_box.__struct__, :content, [bounding_box])
      else
        bounding_box
      end

    case bounding_box do
      %__MODULE__{} = bounding_box -> bounding_box
      _ -> new(Map.from_struct(bounding_box))
    end
  end

  @spec new(fields :: Enumerable.t()) :: t()
  def new(fields) do
    if Enumerable.impl_for(fields) != nil do
      struct!(
        __MODULE__,
        fields
        |> Enum.map(fn {key, value} ->
          value =
            cond do
              is_nil(value) ->
                value

              key in [:min, :max] ->
                cond do
                  is_struct(value, Zexray.Type.Vector3.Resource) -> value
                  is_reference(value) -> Zexray.Type.Vector3.Resource.new(value)
                  true -> Zexray.Type.Vector3.new(value)
                end
            end

          {key, value}
        end)
      )
    else
      raise_argument_error(fields)
    end
  end
end
