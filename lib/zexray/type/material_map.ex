defmodule Zexray.Type.MaterialMap do
  @moduledoc """
  Material Map

  ## Fields

  |           |                      |
  | --------- | -------------------- |
  | `texture` | Material map texture |
  | `color`   | Material map color   |
  | `value`   | Material map value   |
  """

  defstruct texture: nil,
            color: nil,
            value: 0

  use Zexray.Type.TypeBase, prefix: "material_map"

  @type t ::
          %__MODULE__{
            texture: Zexray.Type.Texture2D.t_nif(),
            color: Zexray.Type.Color.t_nif(),
            value: float
          }

  @type t_all ::
          t
          | {
              Zexray.Type.Texture2D.t_all(),
              Zexray.Type.Color.t_all(),
              float
            }
          | map
          | keyword
          | Resource.t()

  import Zexray.Guard

  @doc """
  Creates a new `t:t/0`.
  """
  def new(material_map)

  @spec new({
          texture :: Zexray.Type.Texture2D.t_all(),
          color :: Zexray.Type.Color.t_all(),
          value :: float
        }) :: t()
  def new({texture, color, value})
      when is_texture_2d_like(texture) and
             is_color_like(color) and
             is_float(value) do
    new(
      texture: texture,
      color: color,
      value: value
    )
  end

  @spec new(material_map :: struct) :: t()
  def new(material_map) when is_struct(material_map) do
    material_map =
      if String.ends_with?(Atom.to_string(material_map.__struct__), ".Resource") do
        apply(material_map.__struct__, :content, [material_map])
      else
        material_map
      end

    case material_map do
      %__MODULE__{} = material_map -> material_map
      _ -> new(Map.from_struct(material_map))
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

              key == :texture ->
                cond do
                  is_struct(value, Zexray.Type.Texture2D.Resource) -> value
                  is_reference(value) -> Zexray.Type.Texture2D.Resource.new(value)
                  true -> Zexray.Type.Texture2D.new(value)
                end

              key == :color ->
                cond do
                  is_struct(value, Zexray.Type.Color.Resource) -> value
                  is_reference(value) -> Zexray.Type.Color.Resource.new(value)
                  true -> Zexray.Type.Color.new(value)
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
