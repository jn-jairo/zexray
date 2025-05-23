defmodule Zexray.Type.Ray do
  @moduledoc """
  Ray for raycasting

  ## Fields

  |             |                            |
  | ----------- | -------------------------- |
  | `position`  | Ray position (origin)      |
  | `direction` | Ray direction (normalized) |
  """

  defstruct position: nil,
            direction: nil

  use Zexray.Type.TypeBase, prefix: "ray"

  @type t ::
          %__MODULE__{
            position: Zexray.Type.Vector3.t_nif(),
            direction: Zexray.Type.Vector3.t_nif()
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
  def new(ray)

  @spec new({
          position :: Zexray.Type.Vector3.t_all(),
          direction :: Zexray.Type.Vector3.t_all()
        }) :: t()
  def new({
        position,
        direction
      })
      when is_like_vector3(position) and
             is_like_vector3(direction) do
    new(
      position: position,
      direction: direction
    )
  end

  @spec new(ray :: struct) :: t()
  def new(ray) when is_struct(ray) do
    ray =
      if String.ends_with?(Atom.to_string(ray.__struct__), ".Resource") do
        apply(ray.__struct__, :content, [ray])
      else
        ray
      end

    case ray do
      %__MODULE__{} = ray -> ray
      _ -> new(Map.from_struct(ray))
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

              key in [:position, :direction] ->
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
