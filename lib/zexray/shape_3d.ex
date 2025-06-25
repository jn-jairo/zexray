defmodule Zexray.Shape3D do
  @moduledoc """
  Shape 3D
  """

  alias Zexray.NIF

  #############################
  #  Basic 3D shapes drawing  #
  #############################

  @doc """
  Draw a line in 3D world space
  """
  @doc group: :basic_drawing
  @spec draw_line(
          start_pos :: Zexray.Type.Vector3.t_all(),
          end_pos :: Zexray.Type.Vector3.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_line(
                start_pos,
                end_pos,
                color
              ),
              to: NIF,
              as: :draw_line_3d

  @doc """
  Draw a point in 3D space, actually a small line
  """
  @doc group: :basic_drawing
  @spec draw_point(
          position :: Zexray.Type.Vector3.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_point(
                position,
                color
              ),
              to: NIF,
              as: :draw_point_3d

  @doc """
  Draw a circle in 3D world space
  """
  @doc group: :basic_drawing
  @spec draw_circle(
          center :: Zexray.Type.Vector3.t_all(),
          radius :: number,
          rotation_axis :: Zexray.Type.Vector3.t_all(),
          rotation_angle :: number,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_circle(
                center,
                radius,
                rotation_axis,
                rotation_angle,
                color
              ),
              to: NIF,
              as: :draw_circle_3d

  @doc """
  Draw a color-filled triangle (vertex in counter-clockwise order!)
  """
  @doc group: :basic_drawing
  @spec draw_triangle(
          v1 :: Zexray.Type.Vector3.t_all(),
          v2 :: Zexray.Type.Vector3.t_all(),
          v3 :: Zexray.Type.Vector3.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_triangle(
                v1,
                v2,
                v3,
                color
              ),
              to: NIF,
              as: :draw_triangle_3d

  @doc """
  Draw a triangle strip defined by points
  """
  @doc group: :basic_drawing
  @spec draw_triangle_strip(
          points :: [Zexray.Type.Vector3.t_all()],
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_triangle_strip(
                points,
                color
              ),
              to: NIF,
              as: :draw_triangle_strip_3d

  @doc """
  Draw cube
  """
  @doc group: :basic_drawing
  @spec draw_cube(
          position :: Zexray.Type.Vector3.t_all(),
          width :: number,
          height :: number,
          length :: number,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_cube(
                position,
                width,
                height,
                length,
                color
              ),
              to: NIF,
              as: :draw_cube

  @doc """
  Draw cube (Vector version)
  """
  @doc group: :basic_drawing
  @spec draw_cube_v(
          position :: Zexray.Type.Vector3.t_all(),
          size :: Zexray.Type.Vector3.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_cube_v(
                position,
                size,
                color
              ),
              to: NIF,
              as: :draw_cube_v

  @doc """
  Draw cube wires
  """
  @doc group: :basic_drawing
  @spec draw_cube_wires(
          position :: Zexray.Type.Vector3.t_all(),
          width :: number,
          height :: number,
          length :: number,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_cube_wires(
                position,
                width,
                height,
                length,
                color
              ),
              to: NIF,
              as: :draw_cube_wires

  @doc """
  Draw cube wires (Vector version)
  """
  @doc group: :basic_drawing
  @spec draw_cube_wires_v(
          position :: Zexray.Type.Vector3.t_all(),
          size :: Zexray.Type.Vector3.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_cube_wires_v(
                position,
                size,
                color
              ),
              to: NIF,
              as: :draw_cube_wires_v

  @doc """
  Draw sphere
  """
  @doc group: :basic_drawing
  @spec draw_sphere(
          center_pos :: Zexray.Type.Vector3.t_all(),
          radius :: number,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_sphere(
                center_pos,
                radius,
                color
              ),
              to: NIF,
              as: :draw_sphere

  @doc """
  Draw sphere with extended parameters
  """
  @doc group: :basic_drawing
  @spec draw_sphere_ex(
          center_pos :: Zexray.Type.Vector3.t_all(),
          radius :: number,
          rings :: number,
          slices :: number,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_sphere_ex(
                center_pos,
                radius,
                rings,
                slices,
                color
              ),
              to: NIF,
              as: :draw_sphere_ex

  @doc """
  Draw sphere wires
  """
  @doc group: :basic_drawing
  @spec draw_sphere_wires(
          center_pos :: Zexray.Type.Vector3.t_all(),
          radius :: number,
          rings :: number,
          slices :: number,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_sphere_wires(
                center_pos,
                radius,
                rings,
                slices,
                color
              ),
              to: NIF,
              as: :draw_sphere_wires

  @doc """
  Draw a cylinder/cone
  """
  @doc group: :basic_drawing
  @spec draw_cylinder(
          position :: Zexray.Type.Vector3.t_all(),
          radius_top :: number,
          radius_bottom :: number,
          height :: number,
          slices :: number,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_cylinder(
                position,
                radius_top,
                radius_bottom,
                height,
                slices,
                color
              ),
              to: NIF,
              as: :draw_cylinder

  @doc """
  Draw a cylinder with base at startPos and top at endPos
  """
  @doc group: :basic_drawing
  @spec draw_cylinder_ex(
          start_pos :: Zexray.Type.Vector3.t_all(),
          end_pos :: Zexray.Type.Vector3.t_all(),
          start_radius :: number,
          end_radius :: number,
          sides :: number,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_cylinder_ex(
                start_pos,
                end_pos,
                start_radius,
                end_radius,
                sides,
                color
              ),
              to: NIF,
              as: :draw_cylinder_ex

  @doc """
  Draw a cylinder/cone wires
  """
  @doc group: :basic_drawing
  @spec draw_cylinder_wires(
          position :: Zexray.Type.Vector3.t_all(),
          radius_top :: number,
          radius_bottom :: number,
          height :: number,
          slices :: number,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_cylinder_wires(
                position,
                radius_top,
                radius_bottom,
                height,
                slices,
                color
              ),
              to: NIF,
              as: :draw_cylinder_wires

  @doc """
  Draw a cylinder wires with base at startPos and top at endPos
  """
  @doc group: :basic_drawing
  @spec draw_cylinder_wires_ex(
          start_pos :: Zexray.Type.Vector3.t_all(),
          end_pos :: Zexray.Type.Vector3.t_all(),
          start_radius :: number,
          end_radius :: number,
          sides :: number,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_cylinder_wires_ex(
                start_pos,
                end_pos,
                start_radius,
                end_radius,
                sides,
                color
              ),
              to: NIF,
              as: :draw_cylinder_wires_ex

  @doc """
  Draw a capsule with the center of its sphere caps at startPos and endPos
  """
  @doc group: :basic_drawing
  @spec draw_capsule(
          start_pos :: Zexray.Type.Vector3.t_all(),
          end_pos :: Zexray.Type.Vector3.t_all(),
          radius :: number,
          slices :: number,
          rings :: number,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_capsule(
                start_pos,
                end_pos,
                radius,
                slices,
                rings,
                color
              ),
              to: NIF,
              as: :draw_capsule

  @doc """
  Draw capsule wireframe with the center of its sphere caps at startPos and endPos
  """
  @doc group: :basic_drawing
  @spec draw_capsule_wires(
          start_pos :: Zexray.Type.Vector3.t_all(),
          end_pos :: Zexray.Type.Vector3.t_all(),
          radius :: number,
          slices :: number,
          rings :: number,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_capsule_wires(
                start_pos,
                end_pos,
                radius,
                slices,
                rings,
                color
              ),
              to: NIF,
              as: :draw_capsule_wires

  @doc """
  Draw a plane XZ
  """
  @doc group: :basic_drawing
  @spec draw_plane(
          center_pos :: Zexray.Type.Vector3.t_all(),
          size :: Zexray.Type.Vector2.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_plane(
                center_pos,
                size,
                color
              ),
              to: NIF,
              as: :draw_plane

  @doc """
  Draw a ray line
  """
  @doc group: :basic_drawing
  @spec draw_ray(
          ray :: Zexray.Type.Ray.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_ray(
                ray,
                color
              ),
              to: NIF,
              as: :draw_ray

  @doc """
  Draw a grid (centered at (0, 0, 0))
  """
  @doc group: :basic_drawing
  @spec draw_grid(
          slices :: number,
          spacing :: number
        ) :: :ok
  defdelegate draw_grid(
                slices,
                spacing
              ),
              to: NIF,
              as: :draw_grid

  ######################
  #  Model management  #
  ######################

  @doc """
  Load model from files (meshes and materials)
  """
  @doc group: :model_management
  @spec load_model(
          file_name :: binary,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Model.t_nif()
  defdelegate load_model(
                file_name,
                return \\ :auto
              ),
              to: NIF,
              as: :load_model

  @doc """
  Load model from generated mesh (default material)
  """
  @doc group: :model_management
  @spec load_model_from_mesh(
          mesh :: Zexray.Type.Mesh.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Model.t_nif()
  defdelegate load_model_from_mesh(
                mesh,
                return \\ :auto
              ),
              to: NIF,
              as: :load_model_from_mesh

  @doc """
  Check if a model is valid (loaded in GPU, VAO/VBOs)
  """
  @doc group: :model_management
  @spec model_valid?(model :: Zexray.Type.Model.t_all()) :: boolean
  defdelegate model_valid?(model), to: NIF, as: :is_model_valid

  @doc """
  Compute model bounding box limits (considers all meshes)
  """
  @doc group: :model_management
  @spec get_model_bounding_box(
          model :: Zexray.Type.Model.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.BoundingBox.t_nif()
  defdelegate get_model_bounding_box(
                model,
                return \\ :auto
              ),
              to: NIF,
              as: :get_model_bounding_box

  ###################
  #  Model drawing  #
  ###################

  @doc """
  Draw a model (with texture if set)
  """
  @doc group: :model_drawing
  @spec draw_model(
          model :: Zexray.Type.Model.t_all(),
          position :: Zexray.Type.Vector3.t_all(),
          scale :: number,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_model(
                model,
                position,
                scale,
                tint
              ),
              to: NIF,
              as: :draw_model

  @doc """
  Draw a model with extended parameters
  """
  @doc group: :model_drawing
  @spec draw_model_ex(
          model :: Zexray.Type.Model.t_all(),
          position :: Zexray.Type.Vector3.t_all(),
          rotation_axis :: Zexray.Type.Vector3.t_all(),
          rotation_angle :: number,
          scale :: Zexray.Type.Vector3.t_all(),
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_model_ex(
                model,
                position,
                rotation_axis,
                rotation_angle,
                scale,
                tint
              ),
              to: NIF,
              as: :draw_model_ex

  @doc """
  Draw a model wires (with texture if set)
  """
  @doc group: :model_drawing
  @spec draw_model_wires(
          model :: Zexray.Type.Model.t_all(),
          position :: Zexray.Type.Vector3.t_all(),
          scale :: number,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_model_wires(
                model,
                position,
                scale,
                tint
              ),
              to: NIF,
              as: :draw_model_wires

  @doc """
  Draw a model wires (with texture if set) with extended parameters
  """
  @doc group: :model_drawing
  @spec draw_model_wires_ex(
          model :: Zexray.Type.Model.t_all(),
          position :: Zexray.Type.Vector3.t_all(),
          rotation_axis :: Zexray.Type.Vector3.t_all(),
          rotation_angle :: number,
          scale :: Zexray.Type.Vector3.t_all(),
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_model_wires_ex(
                model,
                position,
                rotation_axis,
                rotation_angle,
                scale,
                tint
              ),
              to: NIF,
              as: :draw_model_wires_ex

  @doc """
  Draw a model as points
  """
  @doc group: :model_drawing
  @spec draw_model_points(
          model :: Zexray.Type.Model.t_all(),
          position :: Zexray.Type.Vector3.t_all(),
          scale :: number,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_model_points(
                model,
                position,
                scale,
                tint
              ),
              to: NIF,
              as: :draw_model_points

  @doc """
  Draw a model as points with extended parameters
  """
  @doc group: :model_drawing
  @spec draw_model_points_ex(
          model :: Zexray.Type.Model.t_all(),
          position :: Zexray.Type.Vector3.t_all(),
          rotation_axis :: Zexray.Type.Vector3.t_all(),
          rotation_angle :: number,
          scale :: Zexray.Type.Vector3.t_all(),
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_model_points_ex(
                model,
                position,
                rotation_axis,
                rotation_angle,
                scale,
                tint
              ),
              to: NIF,
              as: :draw_model_points_ex

  @doc """
  Draw bounding box (wires)
  """
  @doc group: :model_drawing
  @spec draw_bounding_box(
          box :: Zexray.Type.BoundingBox.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_bounding_box(
                box,
                color
              ),
              to: NIF,
              as: :draw_bounding_box

  @doc """
  Draw a billboard texture
  """
  @doc group: :model_drawing
  @spec draw_billboard(
          camera :: Zexray.Type.Camera.t_all(),
          texture :: Zexray.Type.Texture2D.t_all(),
          position :: Zexray.Type.Vector3.t_all(),
          scale :: number,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_billboard(
                camera,
                texture,
                position,
                scale,
                tint
              ),
              to: NIF,
              as: :draw_billboard

  @doc """
  Draw a billboard texture defined by source
  """
  @doc group: :model_drawing
  @spec draw_billboard_rec(
          camera :: Zexray.Type.Camera.t_all(),
          texture :: Zexray.Type.Texture2D.t_all(),
          source :: Zexray.Type.Rectangle.t_all(),
          position :: Zexray.Type.Vector3.t_all(),
          size :: Zexray.Type.Vector2.t_all(),
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_billboard_rec(
                camera,
                texture,
                source,
                position,
                size,
                tint
              ),
              to: NIF,
              as: :draw_billboard_rec

  @doc """
  Draw a billboard texture defined by source and rotation
  """
  @doc group: :model_drawing
  @spec draw_billboard_pro(
          camera :: Zexray.Type.Camera.t_all(),
          texture :: Zexray.Type.Texture2D.t_all(),
          source :: Zexray.Type.Rectangle.t_all(),
          position :: Zexray.Type.Vector3.t_all(),
          up :: Zexray.Type.Vector3.t_all(),
          size :: Zexray.Type.Vector2.t_all(),
          origin :: Zexray.Type.Vector2.t_all(),
          rotation :: number,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_billboard_pro(
                camera,
                texture,
                source,
                position,
                up,
                size,
                origin,
                rotation,
                tint
              ),
              to: NIF,
              as: :draw_billboard_pro

  #####################
  #  Mesh management  #
  #####################

  @doc """
  Upload mesh vertex data in GPU and provide VAO/VBO ids
  """
  @doc group: :mesh_management
  @spec upload_mesh(
          mesh :: Zexray.Type.Mesh.t_all(),
          dynamic :: boolean,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  defdelegate upload_mesh(
                mesh,
                dynamic,
                return \\ :auto
              ),
              to: NIF,
              as: :upload_mesh

  @doc """
  Update mesh vertex data in GPU for a specific buffer index
  """
  @doc group: :mesh_management
  @spec update_mesh_buffer(
          mesh :: Zexray.Type.Mesh.t_all(),
          index :: Zexray.Enum.ShaderAttributeLocationIndex.t(),
          data ::
            nil
            | [float]
            | [byte]
            | [non_neg_integer]
            | [Zexray.Type.Matrix.t_all()],
          offset :: integer
        ) :: :ok
  defdelegate update_mesh_buffer(
                mesh,
                index,
                data,
                offset \\ 0
              ),
              to: NIF,
              as: :update_mesh_buffer

  @doc """
  Draw a 3d mesh with material and transform
  """
  @doc group: :mesh_management
  @spec draw_mesh(
          mesh :: Zexray.Type.Mesh.t_all(),
          material :: Zexray.Type.Material.t_all(),
          transform :: Zexray.Type.Matrix.t_all()
        ) :: :ok
  defdelegate draw_mesh(
                mesh,
                material,
                transform
              ),
              to: NIF,
              as: :draw_mesh

  @doc """
  Draw multiple mesh instances with material and different transforms
  """
  @doc group: :mesh_management
  @spec draw_mesh_instanced(
          mesh :: Zexray.Type.Mesh.t_all(),
          material :: Zexray.Type.Material.t_all(),
          transforms :: [Zexray.Type.Matrix.t_all()]
        ) :: :ok
  defdelegate draw_mesh_instanced(
                mesh,
                material,
                transforms
              ),
              to: NIF,
              as: :draw_mesh_instanced

  @doc """
  Compute mesh bounding box limits
  """
  @doc group: :mesh_management
  @spec get_mesh_bounding_box(
          mesh :: Zexray.Type.Mesh.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.BoundingBox.t_nif()
  defdelegate get_mesh_bounding_box(
                mesh,
                return \\ :auto
              ),
              to: NIF,
              as: :get_mesh_bounding_box

  @doc """
  Compute mesh tangents
  """
  @doc group: :mesh_management
  @spec gen_mesh_tangents(
          mesh :: Zexray.Type.Mesh.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  defdelegate gen_mesh_tangents(
                mesh,
                return \\ :auto
              ),
              to: NIF,
              as: :gen_mesh_tangents

  @doc """
  Export mesh data to file, returns true on success
  """
  @doc group: :mesh_management
  @spec export_mesh(
          mesh :: Zexray.Type.Mesh.t_all(),
          file_name :: binary
        ) :: boolean
  defdelegate export_mesh(
                mesh,
                file_name
              ),
              to: NIF,
              as: :export_mesh

  #####################
  #  Mesh generation  #
  #####################

  @doc """
  Generate polygonal mesh
  """
  @doc group: :mesh_generation
  @spec gen_mesh_poly(
          sides :: number,
          radius :: number,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  defdelegate gen_mesh_poly(
                sides,
                radius,
                return \\ :auto
              ),
              to: NIF,
              as: :gen_mesh_poly

  @doc """
  Generate plane mesh (with subdivisions)
  """
  @doc group: :mesh_generation
  @spec gen_mesh_plane(
          width :: number,
          length :: number,
          res_x :: number,
          res_z :: number,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  defdelegate gen_mesh_plane(
                width,
                length,
                res_x,
                res_z,
                return \\ :auto
              ),
              to: NIF,
              as: :gen_mesh_plane

  @doc """
  Generate cuboid mesh
  """
  @doc group: :mesh_generation
  @spec gen_mesh_cube(
          width :: number,
          height :: number,
          length :: number,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  defdelegate gen_mesh_cube(
                width,
                height,
                length,
                return \\ :auto
              ),
              to: NIF,
              as: :gen_mesh_cube

  @doc """
  Generate sphere mesh (standard sphere)
  """
  @doc group: :mesh_generation
  @spec gen_mesh_sphere(
          radius :: number,
          rings :: number,
          slices :: number,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  defdelegate gen_mesh_sphere(
                radius,
                rings,
                slices,
                return \\ :auto
              ),
              to: NIF,
              as: :gen_mesh_sphere

  @doc """
  Generate half-sphere mesh (no bottom cap)
  """
  @doc group: :mesh_generation
  @spec gen_mesh_hemi_sphere(
          radius :: number,
          rings :: number,
          slices :: number,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  defdelegate gen_mesh_hemi_sphere(
                radius,
                rings,
                slices,
                return \\ :auto
              ),
              to: NIF,
              as: :gen_mesh_hemi_sphere

  @doc """
  Generate cylinder mesh
  """
  @doc group: :mesh_generation
  @spec gen_mesh_cylinder(
          radius :: number,
          height :: number,
          slices :: number,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  defdelegate gen_mesh_cylinder(
                radius,
                height,
                slices,
                return \\ :auto
              ),
              to: NIF,
              as: :gen_mesh_cylinder

  @doc """
  Generate cone/pyramid mesh
  """
  @doc group: :mesh_generation
  @spec gen_mesh_cone(
          radius :: number,
          height :: number,
          slices :: number,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  defdelegate gen_mesh_cone(
                radius,
                height,
                slices,
                return \\ :auto
              ),
              to: NIF,
              as: :gen_mesh_cone

  @doc """
  Generate torus mesh
  """
  @doc group: :mesh_generation
  @spec gen_mesh_torus(
          radius :: number,
          size :: number,
          rad_seg :: number,
          sides :: number,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  defdelegate gen_mesh_torus(
                radius,
                size,
                rad_seg,
                sides,
                return \\ :auto
              ),
              to: NIF,
              as: :gen_mesh_torus

  @doc """
  Generate trefoil knot mesh
  """
  @doc group: :mesh_generation
  @spec gen_mesh_knot(
          radius :: number,
          size :: number,
          rad_seg :: number,
          sides :: number,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  defdelegate gen_mesh_knot(
                radius,
                size,
                rad_seg,
                sides,
                return \\ :auto
              ),
              to: NIF,
              as: :gen_mesh_knot

  @doc """
  Generate heightmap mesh from image data
  """
  @doc group: :mesh_generation
  @spec gen_mesh_heightmap(
          heightmap :: Zexray.Type.Image.t_all(),
          size :: Zexray.Type.Vector3.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  defdelegate gen_mesh_heightmap(
                heightmap,
                size,
                return \\ :auto
              ),
              to: NIF,
              as: :gen_mesh_heightmap

  @doc """
  Generate cubes-based map mesh from image data
  """
  @doc group: :mesh_generation
  @spec gen_mesh_cubicmap(
          cubicmap :: Zexray.Type.Image.t_all(),
          cube_size :: Zexray.Type.Vector3.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  defdelegate gen_mesh_cubicmap(
                cubicmap,
                cube_size,
                return \\ :auto
              ),
              to: NIF,
              as: :gen_mesh_cubicmap

  #########################
  #  Material management  #
  #########################

  @doc """
  Load materials from model file
  """
  @doc group: :material_management
  @spec load_materials(
          file_name :: binary,
          return :: :auto | :value | :resource
        ) :: [Zexray.Type.Material.t_nif()]
  defdelegate load_materials(
                file_name,
                return \\ :auto
              ),
              to: NIF,
              as: :load_materials

  @doc """
  Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
  """
  @doc group: :material_management
  @spec load_material_default(return :: :auto | :value | :resource) ::
          Zexray.Type.Material.t_nif()
  defdelegate load_material_default(return \\ :auto), to: NIF, as: :load_material_default

  @doc """
  Check if a material is valid (shader assigned, map textures loaded in GPU)
  """
  @doc group: :material_management
  @spec material_valid?(material :: Zexray.Type.Material.t_all()) :: boolean
  defdelegate material_valid?(material), to: NIF, as: :is_material_valid

  @doc """
  Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
  """
  @doc group: :material_management
  @spec set_material_texture(
          material :: Zexray.Type.Material.t_all(),
          map_type :: Zexray.Enum.MaterialMapIndex.t(),
          texture :: Zexray.Type.Texture2D.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Material.t_nif()
  defdelegate set_material_texture(
                material,
                map_type,
                texture,
                return \\ :auto
              ),
              to: NIF,
              as: :set_material_texture

  @doc """
  Set material for a mesh
  """
  @doc group: :material_management
  @spec set_model_mesh_material(
          model :: Zexray.Type.Model.t_all(),
          mesh_id :: integer,
          material_id :: integer,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Model.t_nif()
  defdelegate set_model_mesh_material(
                model,
                mesh_id,
                material_id,
                return \\ :auto
              ),
              to: NIF,
              as: :set_model_mesh_material

  #####################
  #  Model animation  #
  #####################

  @doc """
  Load model animations from file
  """
  @doc group: :model_animation
  @spec load_model_animations(
          file_name :: binary,
          return :: :auto | :value | :resource
        ) :: [Zexray.Type.ModelAnimation.t_nif()]
  defdelegate load_model_animations(
                file_name,
                return \\ :auto
              ),
              to: NIF,
              as: :load_model_animations

  @doc """
  Update model animation pose (CPU)
  """
  @doc group: :model_animation
  @spec update_model_animation(
          model :: Zexray.Type.Model.t_all(),
          anim :: Zexray.Type.ModelAnimation.t_all(),
          frame :: integer,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Model.t_nif()
  defdelegate update_model_animation(
                model,
                anim,
                frame,
                return \\ :auto
              ),
              to: NIF,
              as: :update_model_animation

  @doc """
  Update model animation mesh bone matrices (GPU skinning)
  """
  @doc group: :model_animation
  @spec update_model_animation_bones(
          model :: Zexray.Type.Model.t_all(),
          anim :: Zexray.Type.ModelAnimation.t_all(),
          frame :: integer,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Model.t_nif()
  defdelegate update_model_animation_bones(
                model,
                anim,
                frame,
                return \\ :auto
              ),
              to: NIF,
              as: :update_model_animation_bones

  @doc """
  Check model animation skeleton match
  """
  @doc group: :model_animation
  @spec model_animation_valid?(
          model :: Zexray.Type.Model.t_all(),
          anim :: Zexray.Type.ModelAnimation.t_all()
        ) :: boolean
  defdelegate model_animation_valid?(
                model,
                anim
              ),
              to: NIF,
              as: :is_model_animation_valid

  #########################
  #  Collision detection  #
  #########################

  @doc """
  Check collision between two spheres
  """
  @doc group: :collision_detection
  @spec collision_spheres?(
          center1 :: Zexray.Type.Vector3.t_all(),
          radius1 :: number,
          center2 :: Zexray.Type.Vector3.t_all(),
          radius2 :: number
        ) :: boolean
  defdelegate collision_spheres?(
                center1,
                radius1,
                center2,
                radius2
              ),
              to: NIF,
              as: :check_collision_spheres

  @doc """
  Check collision between two bounding boxes
  """
  @doc group: :collision_detection
  @spec collision_boxes?(
          box1 :: Zexray.Type.BoundingBox.t_all(),
          box2 :: Zexray.Type.BoundingBox.t_all()
        ) :: boolean
  defdelegate collision_boxes?(
                box1,
                box2
              ),
              to: NIF,
              as: :check_collision_boxes

  @doc """
  Check collision between box and sphere
  """
  @doc group: :collision_detection
  @spec collision_box_sphere?(
          box :: Zexray.Type.BoundingBox.t_all(),
          center :: Zexray.Type.Vector3.t_all(),
          radius :: number
        ) :: boolean
  defdelegate collision_box_sphere?(
                box,
                center,
                radius
              ),
              to: NIF,
              as: :check_collision_box_sphere

  @doc """
  Get collision info between ray and sphere
  """
  @doc group: :collision_detection
  @spec get_ray_collision_sphere(
          ray :: Zexray.Type.Ray.t_all(),
          center :: Zexray.Type.Vector3.t_all(),
          radius :: number,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.RayCollision.t_nif()
  defdelegate get_ray_collision_sphere(
                ray,
                center,
                radius,
                return \\ :auto
              ),
              to: NIF,
              as: :get_ray_collision_sphere

  @doc """
  Get collision info between ray and box
  """
  @doc group: :collision_detection
  @spec get_ray_collision_box(
          ray :: Zexray.Type.Ray.t_all(),
          box :: Zexray.Type.BoundingBox.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.RayCollision.t_nif()
  defdelegate get_ray_collision_box(
                ray,
                box,
                return \\ :auto
              ),
              to: NIF,
              as: :get_ray_collision_box

  @doc """
  Get collision info between ray and mesh
  """
  @doc group: :collision_detection
  @spec get_ray_collision_mesh(
          ray :: Zexray.Type.Ray.t_all(),
          mesh :: Zexray.Type.Mesh.t_all(),
          transform :: Zexray.Type.Matrix.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.RayCollision.t_nif()
  defdelegate get_ray_collision_mesh(
                ray,
                mesh,
                transform,
                return \\ :auto
              ),
              to: NIF,
              as: :get_ray_collision_mesh

  @doc """
  Get collision info between ray and triangle
  """
  @doc group: :collision_detection
  @spec get_ray_collision_triangle(
          ray :: Zexray.Type.Ray.t_all(),
          p1 :: Zexray.Type.Vector3.t_all(),
          p2 :: Zexray.Type.Vector3.t_all(),
          p3 :: Zexray.Type.Vector3.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.RayCollision.t_nif()
  defdelegate get_ray_collision_triangle(
                ray,
                p1,
                p2,
                p3,
                return \\ :auto
              ),
              to: NIF,
              as: :get_ray_collision_triangle

  @doc """
  Get collision info between ray and quad
  """
  @doc group: :collision_detection
  @spec get_ray_collision_quad(
          ray :: Zexray.Type.Ray.t_all(),
          p1 :: Zexray.Type.Vector3.t_all(),
          p2 :: Zexray.Type.Vector3.t_all(),
          p3 :: Zexray.Type.Vector3.t_all(),
          p4 :: Zexray.Type.Vector3.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.RayCollision.t_nif()
  defdelegate get_ray_collision_quad(
                ray,
                p1,
                p2,
                p3,
                p4,
                return \\ :auto
              ),
              to: NIF,
              as: :get_ray_collision_quad
end
