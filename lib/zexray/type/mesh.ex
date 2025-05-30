defmodule Zexray.Type.Mesh do
  @moduledoc """
  Vertex data and vao/vbo

  ## Fields

  |                  |                                                                                                       |
  | ---------------- | ----------------------------------------------------------------------------------------------------- |
  | `vertex_count`   | Number of vertices stored in arrays                                                                   |
  | `triangle_count` | Number of triangles stored (indexed or not)                                                           |
  | `vertices`       | Vertex position (XYZ - 3 components per vertex) (shader-location = 0)                                 |
  | `texcoords`      | Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)                       |
  | `texcoords2`     | Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)                |
  | `normals`        | Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)                                  |
  | `tangents`       | Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)                                |
  | `colors`         | Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)                                  |
  | `indices`        | Vertex indices (3 components per triangle in case vertex data comes indexed)                          |
  | `anim_vertices`  | Animated vertex positions (after bones transformations)                                               |
  | `anim_normals`   | Animated normals (after bones transformations)                                                        |
  | `bone_ids`       | Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning) (shader-location = 6) |
  | `bone_weights`   | Vertex bone weight, up to 4 bones influence by vertex (skinning) (shader-location = 7)                |
  | `bone_matrices`  | Bones animated transformation matrices                                                                |
  | `bone_count`     | Number of bones                                                                                       |
  | `vao_id`         | OpenGL Vertex Array Object id                                                                         |
  | `vbo_id`         | OpenGL Vertex Buffer Objects id (default vertex data)                                                 |
  """

  require Record

  @type t ::
          record(:t,
            vertex_count: integer,
            triangle_count: integer,
            vertices: [float],
            texcoords: [float],
            texcoords2: [float],
            normals: [float],
            tangents: [float],
            colors: [byte],
            indices: [non_neg_integer],
            anim_vertices: [float],
            anim_normals: [float],
            bone_ids: [byte],
            bone_weights: [float],
            bone_matrices: [Zexray.Type.Matrix.t_nif()],
            bone_count: integer,
            vao_id: non_neg_integer,
            vbo_id: [non_neg_integer]
          )

  Record.defrecord(:t, :mesh,
    vertex_count: 0,
    triangle_count: 0,
    vertices: [],
    texcoords: [],
    texcoords2: [],
    normals: [],
    tangents: [],
    colors: [],
    indices: [],
    anim_vertices: [],
    anim_normals: [],
    bone_ids: [],
    bone_weights: [],
    bone_matrices: [],
    bone_count: 0,
    vao_id: 0,
    vbo_id: []
  )

  use Zexray.Type.TypeBase, prefix: "mesh"

  @type t_all :: t | t_resource
end
