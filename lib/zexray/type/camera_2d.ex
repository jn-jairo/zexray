defmodule Zexray.Type.Camera2D do
  @moduledoc """
  Defines position/orientation in 2d space

  ## Fields

  |            |                                                  |
  | ---------- | ------------------------------------------------ |
  | `offset`   | Camera offset (displacement from target)         |
  | `target`   | Camera target (rotation and zoom origin)         |
  | `rotation` | Camera rotation in degrees                       |
  | `zoom`     | Camera zoom (scaling), should be 1.0f by default |
  """

  defstruct offset: nil,
            target: nil,
            rotation: nil,
            zoom: 1.0

  use Zexray.Type.TypeBase, prefix: "camera_2d"

  @type t ::
          %__MODULE__{
            offset: Zexray.Type.Vector2.t_nif(),
            target: Zexray.Type.Vector2.t_nif(),
            rotation: float,
            zoom: float
          }

  @type t_all ::
          t()
          | {
              Zexray.Type.Vector2.t_all(),
              Zexray.Type.Vector2.t_all(),
              float,
              float
            }
          | map
          | keyword
          | Resource.t()

  import Zexray.Guard

  @doc """
  Creates a new `t:t/0`.
  """
  def new(camera_2d)

  @spec new({
          offset :: Zexray.Type.Vector2.t_all(),
          target :: Zexray.Type.Vector2.t_all(),
          rotation :: float,
          zoom :: float
        }) :: t()
  def new({
        offset,
        target,
        rotation,
        zoom
      })
      when is_vector2_like(offset) and
             is_vector2_like(target) and
             is_float(rotation) and
             is_float(zoom) do
    new(
      offset: offset,
      target: target,
      rotation: rotation,
      zoom: zoom
    )
  end

  @spec new(camera_2d :: struct) :: t()
  def new(camera_2d) when is_struct(camera_2d) do
    camera_2d =
      if String.ends_with?(Atom.to_string(camera_2d.__struct__), ".Resource") do
        apply(camera_2d.__struct__, :content, [camera_2d])
      else
        camera_2d
      end

    case camera_2d do
      %__MODULE__{} = camera_2d -> camera_2d
      _ -> new(Map.from_struct(camera_2d))
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

              key in [:offset, :target] ->
                cond do
                  is_struct(value, Zexray.Type.Vector2.Resource) -> value
                  is_reference(value) -> Zexray.Type.Vector2.Resource.new(value)
                  true -> Zexray.Type.Vector2.new(value)
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
