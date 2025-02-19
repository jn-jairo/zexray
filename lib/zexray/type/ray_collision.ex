defmodule Zexray.Type.RayCollision do
  @moduledoc """
  Ray hit information

  ## Fields

  |            |                             |
  | ---------- | --------------------------- |
  | `hit`      | Did the ray hit something?  |
  | `distance` | Distance to the nearest hit |
  | `point`    | Point of the nearest hit    |
  | `normal`   | Surface normal of hit       |
  """

  defstruct hit: false,
            distance: nil,
            point: nil,
            normal: nil

  use Zexray.Type.TypeBase, prefix: "ray_collision"

  @type t ::
          %__MODULE__{
            hit: boolean,
            distance: float,
            point: Zexray.Type.Vector3.t_nif(),
            normal: Zexray.Type.Vector3.t_nif()
          }

  @type t_all ::
          t
          | {
              boolean,
              float,
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
  def new(ray_collision)

  @spec new({
          hit :: boolean,
          distance :: float,
          point :: Zexray.Type.Vector3.t_all(),
          normal :: Zexray.Type.Vector3.t_all()
        }) :: t()
  def new({hit, distance, point, normal})
      when is_boolean(hit) and
             is_float(distance) and
             is_vector3_like(point) and
             is_vector3_like(normal) do
    new(
      hit: hit,
      distance: distance,
      point: point,
      normal: normal
    )
  end

  @spec new(ray_collision :: struct) :: t()
  def new(ray_collision) when is_struct(ray_collision) do
    ray_collision =
      if String.ends_with?(Atom.to_string(ray_collision.__struct__), ".Resource") do
        apply(ray_collision.__struct__, :content, [ray_collision])
      else
        ray_collision
      end

    case ray_collision do
      %__MODULE__{} = ray_collision -> ray_collision
      _ -> new(Map.from_struct(ray_collision))
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

              key in [:point, :normal] ->
                cond do
                  is_struct(value, Zexray.Type.Vector3.Resource) -> value
                  is_reference(value) -> Zexray.Type.Vector3.Resource.new(value)
                  true -> Zexray.Type.Vector3.new(value)
                end

              true ->
                value
            end

          {key, value}
        end)
      )
    else
      raise_argument_error(fields)
    end
  end
end
