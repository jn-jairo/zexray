defmodule Zexray.Type.Transform do
  @moduledoc """
  Vertex transformation data

  ## Fields

  |               |             |
  | ------------- | ----------- |
  | `translation` | Translation |
  | `rotation`    | Rotation    |
  | `scale`       | Scale       |
  """

  defstruct translation: nil,
            rotation: nil,
            scale: nil

  use Zexray.Type.TypeBase, prefix: "transform"

  @type t ::
          %__MODULE__{
            translation: Zexray.Type.Vector3.t_nif(),
            rotation: Zexray.Type.Quaternion.t_nif(),
            scale: Zexray.Type.Vector3.t_nif()
          }

  @type t_all ::
          t
          | {
              Zexray.Type.Vector3.t_all(),
              Zexray.Type.Quaternion.t_all(),
              Zexray.Type.Vector3.t_all()
            }
          | map
          | keyword
          | Resource.t()

  import Zexray.Guard

  @doc """
  Creates a new `t:t/0`.
  """
  def new(transform)

  @spec new({
          translation :: Zexray.Type.Vector3.t_all(),
          rotation :: Zexray.Type.Quaternion.t_all(),
          scale :: Zexray.Type.Vector3.t_all()
        }) :: t()
  def new({translation, rotation, scale})
      when is_vector3_like(translation) and
             is_quaternion_like(rotation) and
             is_vector3_like(scale) do
    new(
      translation: translation,
      rotation: rotation,
      scale: scale
    )
  end

  @spec new(transform :: struct) :: t()
  def new(transform) when is_struct(transform) do
    transform =
      if String.ends_with?(Atom.to_string(transform.__struct__), ".Resource") do
        apply(transform.__struct__, :content, [transform])
      else
        transform
      end

    case transform do
      %__MODULE__{} = transform -> transform
      _ -> new(Map.from_struct(transform))
    end
  end

  @spec new(fields :: Enumerable.t()) :: t()
  def new(fields) do
    if Enumerable.impl_for(fields) != nil do
      struct!(
        __MODULE__,
        fields
        |> Enum.map(fn {key, value} ->
          cond do
            key == :translation and is_struct(value, Zexray.Type.Vector3.Resource) -> {key, value}
            key == :translation and not is_nil(value) -> {key, Zexray.Type.Vector3.new(value)}
            key == :rotation and is_struct(value, Zexray.Type.Quaternion.Resource) -> {key, value}
            key == :rotation and not is_nil(value) -> {key, Zexray.Type.Quaternion.new(value)}
            key == :scale and is_struct(value, Zexray.Type.Vector3.Resource) -> {key, value}
            key == :scale and not is_nil(value) -> {key, Zexray.Type.Vector3.new(value)}
          end
        end)
      )
    else
      raise ArgumentError, "Invalid transform: #{inspect(fields)}"
    end
  end
end
