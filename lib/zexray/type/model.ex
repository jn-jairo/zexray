defmodule Zexray.Type.Model do
  @moduledoc """
  Meshes, materials and animation data

  ## Fields

  |                  |                                  |
  | ---------------- | -------------------------------- |
  | `transform`      | Local transform matrix           |
  | `mesh_count`     | Number of meshes                 |
  | `material_count` | Number of materials              |
  | `meshes`         | Meshes array                     |
  | `materials`      | Materials array                  |
  | `mesh_material`  | Mesh material number             |
  | `bone_count`     | Number of bones                  |
  | `bones`          | Bones information (skeleton)     |
  | `bind_pose`      | Bones base transformation (pose) |
  """

  defstruct transform: nil,
            mesh_count: 0,
            material_count: 0,
            meshes: [],
            materials: [],
            mesh_material: [],
            bone_count: 0,
            bones: [],
            bind_pose: []

  use Zexray.Type.TypeBase, prefix: "model"

  @type t ::
          %__MODULE__{
            transform: Zexray.Type.Matrix.t_nif(),
            mesh_count: integer,
            material_count: integer,
            meshes: [Zexray.Type.Mesh.t_nif()],
            materials: [Zexray.Type.Material.t_nif()],
            mesh_material: [integer],
            bone_count: integer,
            bones: [Zexray.Type.BoneInfo.t_nif()],
            bind_pose: [Zexray.Type.Transform.t_nif()]
          }

  @type t_all ::
          t
          | {
              Zexray.Type.Matrix.t_all(),
              integer,
              integer,
              [Zexray.Type.Mesh.t_all()],
              [Zexray.Type.Material.t_all()],
              [integer],
              integer,
              [Zexray.Type.BoneInfo.t_all()],
              [Zexray.Type.Transform.t_all()]
            }
          | map
          | keyword
          | Resource.t()

  import Zexray.Guard

  @doc """
  Creates a new `t:t/0`.
  """
  def new(model)

  @spec new({
          transform :: Zexray.Type.Matrix.t_all(),
          mesh_count :: integer,
          material_count :: integer,
          meshes :: [Zexray.Type.Mesh.t_all()],
          materials :: [Zexray.Type.Material.t_all()],
          mesh_material :: [integer],
          bone_count :: integer,
          bones :: [Zexray.Type.BoneInfo.t_all()],
          bind_pose :: [Zexray.Type.Transform.t_all()]
        }) :: t()
  def new({
        transform,
        mesh_count,
        material_count,
        meshes,
        materials,
        mesh_material,
        bone_count,
        bones,
        bind_pose
      })
      when is_transform_like(transform) and
             is_integer(mesh_count) and
             is_integer(material_count) and
             is_list(meshes) and (meshes == [] or is_mesh_like(hd(meshes))) and
             is_list(materials) and (materials == [] or is_material_like(hd(materials))) and
             is_list(mesh_material) and (mesh_material == [] or is_integer(hd(mesh_material))) and
             is_integer(bone_count) and
             is_list(bones) and (bones == [] or is_bone_info_like(hd(bones))) and
             is_list(bind_pose) and (bind_pose == [] or is_transform_like(hd(bind_pose))) do
    new(
      transform: transform,
      mesh_count: mesh_count,
      material_count: material_count,
      meshes: meshes,
      materials: materials,
      mesh_material: mesh_material,
      bone_count: bone_count,
      bones: bones,
      bind_pose: bind_pose
    )
  end

  @spec new(model :: struct) :: t()
  def new(model) when is_struct(model) do
    model =
      if String.ends_with?(Atom.to_string(model.__struct__), ".Resource") do
        apply(model.__struct__, :content, [model])
      else
        model
      end

    case model do
      %__MODULE__{} = model -> model
      _ -> new(Map.from_struct(model))
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
            key == :transform and is_struct(value, Zexray.Type.Matrix.Resource) ->
              {key, value}

            key == :transform and not is_nil(value) ->
              {key, Zexray.Type.Matrix.new(value)}

            key == :meshes and is_list(value) ->
              {key,
               Enum.map(value, fn v ->
                 cond do
                   is_struct(v, Zexray.Type.Mesh.Resource) -> v
                   true -> Zexray.Type.Mesh.new(v)
                 end
               end)}

            key == :materials and is_list(value) ->
              {key,
               Enum.map(value, fn v ->
                 cond do
                   is_struct(v, Zexray.Type.Material.Resource) -> v
                   true -> Zexray.Type.Material.new(v)
                 end
               end)}

            key == :bones and is_list(value) ->
              {key,
               Enum.map(value, fn v ->
                 cond do
                   is_struct(v, Zexray.Type.BoneInfo.Resource) -> v
                   true -> Zexray.Type.BoneInfo.new(v)
                 end
               end)}

            key == :bind_pose and is_list(value) ->
              {key,
               Enum.map(value, fn v ->
                 cond do
                   is_struct(v, Zexray.Type.Transform.Resource) -> v
                   true -> Zexray.Type.Transform.new(v)
                 end
               end)}

            true ->
              {key, value}
          end
        end)
      )
    else
      raise ArgumentError, "Invalid model: #{inspect(fields)}"
    end
  end
end
