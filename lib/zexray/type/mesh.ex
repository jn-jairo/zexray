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

  defstruct vertex_count: 0,
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

  use Zexray.Type.TypeBase, prefix: "mesh"

  @type t ::
          %__MODULE__{
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
          }

  @type t_all ::
          t
          | {
              integer,
              integer,
              [float],
              [float],
              [float],
              [float],
              [float],
              [byte],
              [non_neg_integer],
              [float],
              [float],
              [byte],
              [float],
              [Zexray.Type.Matrix.t_all()],
              integer,
              non_neg_integer,
              [non_neg_integer]
            }
          | map
          | keyword
          | Resource.t()

  import Zexray.Guard

  @doc """
  Creates a new `t:t/0`.
  """
  def new(mesh)

  @spec new({
          vertex_count :: integer,
          triangle_count :: integer,
          vertices :: [float],
          texcoords :: [float],
          texcoords2 :: [float],
          normals :: [float],
          tangents :: [float],
          colors :: [byte],
          indices :: [non_neg_integer],
          anim_vertices :: [float],
          anim_normals :: [float],
          bone_ids :: [byte],
          bone_weights :: [float],
          bone_matrices :: [Zexray.Type.Matrix.t_all()],
          bone_count :: integer,
          vao_id :: non_neg_integer,
          vbo_id :: [non_neg_integer]
        }) :: t()
  def new({
        vertex_count,
        triangle_count,
        vertices,
        texcoords,
        texcoords2,
        normals,
        tangents,
        colors,
        indices,
        anim_vertices,
        anim_normals,
        bone_ids,
        bone_weights,
        bone_matrices,
        bone_count,
        vao_id,
        vbo_id
      })
      when is_integer(vertex_count) and
             is_integer(triangle_count) and
             is_list(vertices) and (vertices == [] or is_float(hd(vertices))) and
             is_list(texcoords) and (texcoords == [] or is_float(hd(texcoords))) and
             is_list(texcoords2) and (texcoords2 == [] or is_float(hd(texcoords2))) and
             is_list(normals) and (normals == [] or is_float(hd(normals))) and
             is_list(tangents) and (tangents == [] or is_float(hd(tangents))) and
             is_list(colors) and (colors == [] or is_integer(hd(colors))) and
             is_list(indices) and (indices == [] or is_integer(hd(indices))) and
             is_list(anim_vertices) and (anim_vertices == [] or is_float(hd(anim_vertices))) and
             is_list(anim_normals) and (anim_normals == [] or is_float(hd(anim_normals))) and
             is_list(bone_ids) and (bone_ids == [] or is_integer(hd(bone_ids))) and
             is_list(bone_weights) and (bone_weights == [] or is_float(hd(bone_weights))) and
             is_list(bone_matrices) and (bone_matrices == [] or is_like_matrix(hd(bone_matrices))) and
             is_integer(bone_count) and
             is_integer(vao_id) and
             is_list(vbo_id) and (vbo_id == [] or is_integer(hd(vbo_id))) do
    new(
      vertex_count: vertex_count,
      triangle_count: triangle_count,
      vertices: vertices,
      texcoords: texcoords,
      texcoords2: texcoords2,
      normals: normals,
      tangents: tangents,
      colors: colors,
      indices: indices,
      anim_vertices: anim_vertices,
      anim_normals: anim_normals,
      bone_ids: bone_ids,
      bone_weights: bone_weights,
      bone_matrices: bone_matrices,
      bone_count: bone_count,
      vao_id: vao_id,
      vbo_id: vbo_id
    )
  end

  @spec new(mesh :: struct) :: t()
  def new(mesh) when is_struct(mesh) do
    mesh =
      if String.ends_with?(Atom.to_string(mesh.__struct__), ".Resource") do
        apply(mesh.__struct__, :content, [mesh])
      else
        mesh
      end

    case mesh do
      %__MODULE__{} = mesh -> mesh
      _ -> new(Map.from_struct(mesh))
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

              key == :bone_matrices and is_list(value) ->
                Enum.map(value, fn v ->
                  cond do
                    is_struct(v, Zexray.Type.Matrix.Resource) -> v
                    is_reference(v) -> Zexray.Type.Matrix.Resource.new(v)
                    true -> Zexray.Type.Matrix.new(v)
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
