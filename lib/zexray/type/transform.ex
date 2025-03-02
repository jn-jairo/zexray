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
  def new({
        translation,
        rotation,
        scale
      })
      when is_like_vector3(translation) and
             is_like_quaternion(rotation) and
             is_like_vector3(scale) do
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
          value =
            cond do
              is_nil(value) ->
                value

              key in [:translation, :scale] ->
                cond do
                  is_struct(value, Zexray.Type.Vector3.Resource) -> value
                  is_reference(value) -> Zexray.Type.Vector3.Resource.new(value)
                  true -> Zexray.Type.Vector3.new(value)
                end

              key == :rotation ->
                cond do
                  is_struct(value, Zexray.Type.Quaternion.Resource) -> value
                  is_reference(value) -> Zexray.Type.Quaternion.Resource.new(value)
                  true -> Zexray.Type.Quaternion.new(value)
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
