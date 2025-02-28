defmodule Zexray.Type.Material do
  @moduledoc """
  Material, includes shader and maps

  ## Fields

  |          |                             |
  | -------- | --------------------------- |
  | `shader` | Material shader             |
  | `maps`   | Material maps array         |
  | `params` | Material generic parameters |
  """

  defstruct shader: nil,
            maps: [],
            params: []

  use Zexray.Type.TypeBase, prefix: "material"

  @type t ::
          %__MODULE__{
            shader: Zexray.Type.Shader.t_nif(),
            maps: [Zexray.Type.MaterialMap.t_nif()],
            params: [float]
          }

  @type t_all ::
          t
          | {
              Zexray.Type.Shader.t_all(),
              [Zexray.Type.MaterialMap.t_all()],
              [float]
            }
          | map
          | keyword
          | Resource.t()

  import Zexray.Guard

  @doc """
  Creates a new `t:t/0`.
  """
  def new(material)

  @spec new({
          shader :: Zexray.Type.Shader.t_all(),
          maps :: [Zexray.Type.MaterialMap.t_all()],
          params :: [float]
        }) :: t()
  def new({
        shader,
        maps,
        params
      })
      when is_shader_like(shader) and
             is_list(maps) and (maps == [] or is_material_map_like(hd(maps))) and
             is_list(params) and (params == [] or is_float(hd(params))) do
    new(
      shader: shader,
      maps: maps,
      params: params
    )
  end

  @spec new(material :: struct) :: t()
  def new(material) when is_struct(material) do
    material =
      if String.ends_with?(Atom.to_string(material.__struct__), ".Resource") do
        apply(material.__struct__, :content, [material])
      else
        material
      end

    case material do
      %__MODULE__{} = material -> material
      _ -> new(Map.from_struct(material))
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

              key == :shader ->
                cond do
                  is_struct(value, Zexray.Type.Shader.Resource) -> value
                  is_reference(value) -> Zexray.Type.Shader.Resource.new(value)
                  true -> Zexray.Type.Shader.new(value)
                end

              key == :maps and is_list(value) ->
                Enum.map(value, fn v ->
                  cond do
                    is_struct(v, Zexray.Type.MaterialMap.Resource) -> v
                    is_reference(v) -> Zexray.Type.MaterialMap.Resource.new(v)
                    true -> Zexray.Type.MaterialMap.new(v)
                  end
                end)

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
