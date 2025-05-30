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

  require Record

  @type t ::
          record(:t,
            transform: Zexray.Type.Matrix.t_nif(),
            mesh_count: integer,
            material_count: integer,
            meshes: [Zexray.Type.Mesh.t_nif()],
            materials: [Zexray.Type.Material.t_nif()],
            mesh_material: [integer],
            bone_count: integer,
            bones: [Zexray.Type.BoneInfo.t_nif()],
            bind_pose: [Zexray.Type.Transform.t_nif()]
          )

  Record.defrecord(:t, :model,
    transform: nil,
    mesh_count: 0,
    material_count: 0,
    meshes: [],
    materials: [],
    mesh_material: [],
    bone_count: 0,
    bones: [],
    bind_pose: []
  )

  use Zexray.Type.TypeBase, prefix: "model"

  @type t_all :: t | t_resource
end
