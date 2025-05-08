defmodule Zexray.Shape3D do
  @moduledoc """
  Shape 3D
  """

  import Zexray.Guard
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
  def draw_line(
        start_pos,
        end_pos,
        color
      )
      when is_like_vector3(start_pos) and
             is_like_vector3(end_pos) and
             is_like_color(color) do
    NIF.draw_line_3d(
      start_pos |> Zexray.Type.Vector3.to_nif(),
      end_pos |> Zexray.Type.Vector3.to_nif(),
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a point in 3D space, actually a small line
  """
  @doc group: :basic_drawing
  @spec draw_point(
          position :: Zexray.Type.Vector3.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_point(
        position,
        color
      )
      when is_like_vector3(position) and
             is_like_color(color) do
    NIF.draw_point_3d(
      position |> Zexray.Type.Vector3.to_nif(),
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a circle in 3D world space
  """
  @doc group: :basic_drawing
  @spec draw_circle(
          center :: Zexray.Type.Vector3.t_all(),
          radius :: float,
          rotation_axis :: Zexray.Type.Vector3.t_all(),
          rotation_angle :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_circle(
        center,
        radius,
        rotation_axis,
        rotation_angle,
        color
      )
      when is_like_vector3(center) and
             is_float(radius) and
             is_like_vector3(rotation_axis) and
             is_float(rotation_angle) and
             is_like_color(color) do
    NIF.draw_circle_3d(
      center |> Zexray.Type.Vector3.to_nif(),
      radius,
      rotation_axis |> Zexray.Type.Vector3.to_nif(),
      rotation_angle,
      color |> Zexray.Type.Color.to_nif()
    )
  end

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
  def draw_triangle(
        v1,
        v2,
        v3,
        color
      )
      when is_like_vector3(v1) and
             is_like_vector3(v2) and
             is_like_vector3(v3) and
             is_like_color(color) do
    NIF.draw_triangle_3d(
      v1 |> Zexray.Type.Vector3.to_nif(),
      v2 |> Zexray.Type.Vector3.to_nif(),
      v3 |> Zexray.Type.Vector3.to_nif(),
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a triangle strip defined by points
  """
  @doc group: :basic_drawing
  @spec draw_triangle_strip(
          points :: [Zexray.Type.Vector3.t_all()],
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_triangle_strip(
        points,
        color
      )
      when is_list(points) and (points == [] or is_like_vector3(hd(points))) and
             is_like_color(color) do
    NIF.draw_triangle_strip_3d(
      points |> Zexray.Type.Vector3.to_nif(),
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw cube
  """
  @doc group: :basic_drawing
  @spec draw_cube(
          position :: Zexray.Type.Vector3.t_all(),
          width :: float,
          height :: float,
          length :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_cube(
        position,
        width,
        height,
        length,
        color
      )
      when is_like_vector3(position) and
             is_float(width) and
             is_float(height) and
             is_float(length) and
             is_like_color(color) do
    NIF.draw_cube(
      position |> Zexray.Type.Vector3.to_nif(),
      width,
      height,
      length,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw cube (Vector version)
  """
  @doc group: :basic_drawing
  @spec draw_cube_v(
          position :: Zexray.Type.Vector3.t_all(),
          size :: Zexray.Type.Vector3.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_cube_v(
        position,
        size,
        color
      )
      when is_like_vector3(position) and
             is_like_vector3(size) and
             is_like_color(color) do
    NIF.draw_cube_v(
      position |> Zexray.Type.Vector3.to_nif(),
      size |> Zexray.Type.Vector3.to_nif(),
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw cube wires
  """
  @doc group: :basic_drawing
  @spec draw_cube_wires(
          position :: Zexray.Type.Vector3.t_all(),
          width :: float,
          height :: float,
          length :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_cube_wires(
        position,
        width,
        height,
        length,
        color
      )
      when is_like_vector3(position) and
             is_float(width) and
             is_float(height) and
             is_float(length) and
             is_like_color(color) do
    NIF.draw_cube_wires(
      position |> Zexray.Type.Vector3.to_nif(),
      width,
      height,
      length,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw cube wires (Vector version)
  """
  @doc group: :basic_drawing
  @spec draw_cube_wires_v(
          position :: Zexray.Type.Vector3.t_all(),
          size :: Zexray.Type.Vector3.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_cube_wires_v(
        position,
        size,
        color
      )
      when is_like_vector3(position) and
             is_like_vector3(size) and
             is_like_color(color) do
    NIF.draw_cube_wires_v(
      position |> Zexray.Type.Vector3.to_nif(),
      size |> Zexray.Type.Vector3.to_nif(),
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw sphere
  """
  @doc group: :basic_drawing
  @spec draw_sphere(
          center_pos :: Zexray.Type.Vector3.t_all(),
          radius :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_sphere(
        center_pos,
        radius,
        color
      )
      when is_like_vector3(center_pos) and
             is_float(radius) and
             is_like_color(color) do
    NIF.draw_sphere(
      center_pos |> Zexray.Type.Vector3.to_nif(),
      radius,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw sphere with extended parameters
  """
  @doc group: :basic_drawing
  @spec draw_sphere_ex(
          center_pos :: Zexray.Type.Vector3.t_all(),
          radius :: float,
          rings :: integer,
          slices :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_sphere_ex(
        center_pos,
        radius,
        rings,
        slices,
        color
      )
      when is_like_vector3(center_pos) and
             is_float(radius) and
             is_integer(rings) and
             is_integer(slices) and
             is_like_color(color) do
    NIF.draw_sphere_ex(
      center_pos |> Zexray.Type.Vector3.to_nif(),
      radius,
      rings,
      slices,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw sphere wires
  """
  @doc group: :basic_drawing
  @spec draw_sphere_wires(
          center_pos :: Zexray.Type.Vector3.t_all(),
          radius :: float,
          rings :: integer,
          slices :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_sphere_wires(
        center_pos,
        radius,
        rings,
        slices,
        color
      )
      when is_like_vector3(center_pos) and
             is_float(radius) and
             is_integer(rings) and
             is_integer(slices) and
             is_like_color(color) do
    NIF.draw_sphere_wires(
      center_pos |> Zexray.Type.Vector3.to_nif(),
      radius,
      rings,
      slices,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a cylinder/cone
  """
  @doc group: :basic_drawing
  @spec draw_cylinder(
          position :: Zexray.Type.Vector3.t_all(),
          radius_top :: float,
          radius_bottom :: float,
          height :: float,
          slices :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_cylinder(
        position,
        radius_top,
        radius_bottom,
        height,
        slices,
        color
      )
      when is_like_vector3(position) and
             is_float(radius_top) and
             is_float(radius_bottom) and
             is_float(height) and
             is_integer(slices) and
             is_like_color(color) do
    NIF.draw_cylinder(
      position |> Zexray.Type.Vector3.to_nif(),
      radius_top,
      radius_bottom,
      height,
      slices,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a cylinder with base at startPos and top at endPos
  """
  @doc group: :basic_drawing
  @spec draw_cylinder_ex(
          start_pos :: Zexray.Type.Vector3.t_all(),
          end_pos :: Zexray.Type.Vector3.t_all(),
          start_radius :: float,
          end_radius :: float,
          sides :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_cylinder_ex(
        start_pos,
        end_pos,
        start_radius,
        end_radius,
        sides,
        color
      )
      when is_like_vector3(start_pos) and
             is_like_vector3(end_pos) and
             is_float(start_radius) and
             is_float(end_radius) and
             is_integer(sides) and
             is_like_color(color) do
    NIF.draw_cylinder_ex(
      start_pos |> Zexray.Type.Vector3.to_nif(),
      end_pos |> Zexray.Type.Vector3.to_nif(),
      start_radius,
      end_radius,
      sides,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a cylinder/cone wires
  """
  @doc group: :basic_drawing
  @spec draw_cylinder_wires(
          position :: Zexray.Type.Vector3.t_all(),
          radius_top :: float,
          radius_bottom :: float,
          height :: float,
          slices :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_cylinder_wires(
        position,
        radius_top,
        radius_bottom,
        height,
        slices,
        color
      )
      when is_like_vector3(position) and
             is_float(radius_top) and
             is_float(radius_bottom) and
             is_float(height) and
             is_integer(slices) and
             is_like_color(color) do
    NIF.draw_cylinder_wires(
      position |> Zexray.Type.Vector3.to_nif(),
      radius_top,
      radius_bottom,
      height,
      slices,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a cylinder wires with base at startPos and top at endPos
  """
  @doc group: :basic_drawing
  @spec draw_cylinder_wires_ex(
          start_pos :: Zexray.Type.Vector3.t_all(),
          end_pos :: Zexray.Type.Vector3.t_all(),
          start_radius :: float,
          end_radius :: float,
          sides :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_cylinder_wires_ex(
        start_pos,
        end_pos,
        start_radius,
        end_radius,
        sides,
        color
      )
      when is_like_vector3(start_pos) and
             is_like_vector3(end_pos) and
             is_float(start_radius) and
             is_float(end_radius) and
             is_integer(sides) and
             is_like_color(color) do
    NIF.draw_cylinder_wires_ex(
      start_pos |> Zexray.Type.Vector3.to_nif(),
      end_pos |> Zexray.Type.Vector3.to_nif(),
      start_radius,
      end_radius,
      sides,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a capsule with the center of its sphere caps at startPos and endPos
  """
  @doc group: :basic_drawing
  @spec draw_capsule(
          start_pos :: Zexray.Type.Vector3.t_all(),
          end_pos :: Zexray.Type.Vector3.t_all(),
          radius :: float,
          slices :: integer,
          rings :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_capsule(
        start_pos,
        end_pos,
        radius,
        slices,
        rings,
        color
      )
      when is_like_vector3(start_pos) and
             is_like_vector3(end_pos) and
             is_float(radius) and
             is_integer(slices) and
             is_integer(rings) and
             is_like_color(color) do
    NIF.draw_capsule(
      start_pos |> Zexray.Type.Vector3.to_nif(),
      end_pos |> Zexray.Type.Vector3.to_nif(),
      radius,
      slices,
      rings,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw capsule wireframe with the center of its sphere caps at startPos and endPos
  """
  @doc group: :basic_drawing
  @spec draw_capsule_wires(
          start_pos :: Zexray.Type.Vector3.t_all(),
          end_pos :: Zexray.Type.Vector3.t_all(),
          radius :: float,
          slices :: integer,
          rings :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_capsule_wires(
        start_pos,
        end_pos,
        radius,
        slices,
        rings,
        color
      )
      when is_like_vector3(start_pos) and
             is_like_vector3(end_pos) and
             is_float(radius) and
             is_integer(slices) and
             is_integer(rings) and
             is_like_color(color) do
    NIF.draw_capsule_wires(
      start_pos |> Zexray.Type.Vector3.to_nif(),
      end_pos |> Zexray.Type.Vector3.to_nif(),
      radius,
      slices,
      rings,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a plane XZ
  """
  @doc group: :basic_drawing
  @spec draw_plane(
          center_pos :: Zexray.Type.Vector3.t_all(),
          size :: Zexray.Type.Vector2.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_plane(
        center_pos,
        size,
        color
      )
      when is_like_vector3(center_pos) and
             is_like_vector2(size) and
             is_like_color(color) do
    NIF.draw_plane(
      center_pos |> Zexray.Type.Vector3.to_nif(),
      size |> Zexray.Type.Vector2.to_nif(),
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a ray line
  """
  @doc group: :basic_drawing
  @spec draw_ray(
          ray :: Zexray.Type.Ray.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_ray(
        ray,
        color
      )
      when is_like_ray(ray) and
             is_like_color(color) do
    NIF.draw_ray(
      ray |> Zexray.Type.Ray.to_nif(),
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a grid (centered at (0, 0, 0))
  """
  @doc group: :basic_drawing
  @spec draw_grid(
          slices :: integer,
          spacing :: float
        ) :: :ok
  def draw_grid(
        slices,
        spacing
      )
      when is_integer(slices) and
             is_float(spacing) do
    NIF.draw_grid(
      slices,
      spacing
    )
  end

  ######################
  #  Model management  #
  ######################

  @doc """
  Load model from files (meshes and materials)
  """
  @doc group: :model_management
  @spec load_model(
          file_name :: binary,
          return :: :value | :resource
        ) :: Zexray.Type.Model.t_nif()
  def load_model(
        file_name,
        return \\ :value
      )
      when is_binary(file_name) and
             is_nif_return(return) do
    NIF.load_model(
      file_name,
      return
    )
    |> Zexray.Type.Model.from_nif()
  end

  @doc """
  Load model from generated mesh (default material)
  """
  @doc group: :model_management
  @spec load_model_from_mesh(
          mesh :: Zexray.Type.Mesh.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Model.t_nif()
  def load_model_from_mesh(
        mesh,
        return \\ :value
      )
      when is_like_mesh(mesh) and
             is_nif_return(return) do
    NIF.load_model_from_mesh(
      mesh |> Zexray.Type.Mesh.to_nif(),
      return
    )
    |> Zexray.Type.Model.from_nif()
  end

  @doc """
  Check if a model is valid (loaded in GPU, VAO/VBOs)
  """
  @doc group: :model_management
  @spec model_valid?(model :: Zexray.Type.Model.t_all()) :: boolean
  def model_valid?(model)
      when is_like_model(model) do
    NIF.is_model_valid(model |> Zexray.Type.Model.to_nif())
  end

  @doc """
  Compute model bounding box limits (considers all meshes)
  """
  @doc group: :model_management
  @spec get_model_bounding_box(
          model :: Zexray.Type.Model.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.BoundingBox.t_nif()
  def get_model_bounding_box(
        model,
        return \\ :value
      )
      when is_like_model(model) and
             is_nif_return(return) do
    NIF.get_model_bounding_box(
      model |> Zexray.Type.Model.to_nif(),
      return
    )
    |> Zexray.Type.BoundingBox.from_nif()
  end

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
          scale :: float,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_model(
        model,
        position,
        scale,
        tint
      )
      when is_like_model(model) and
             is_like_vector3(position) and
             is_float(scale) and
             is_like_color(tint) do
    NIF.draw_model(
      model |> Zexray.Type.Model.to_nif(),
      position |> Zexray.Type.Vector3.to_nif(),
      scale,
      tint |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a model with extended parameters
  """
  @doc group: :model_drawing
  @spec draw_model_ex(
          model :: Zexray.Type.Model.t_all(),
          position :: Zexray.Type.Vector3.t_all(),
          rotation_axis :: Zexray.Type.Vector3.t_all(),
          rotation_angle :: float,
          scale :: Zexray.Type.Vector3.t_all(),
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_model_ex(
        model,
        position,
        rotation_axis,
        rotation_angle,
        scale,
        tint
      )
      when is_like_model(model) and
             is_like_vector3(position) and
             is_like_vector3(rotation_axis) and
             is_float(rotation_angle) and
             is_like_vector3(scale) and
             is_like_color(tint) do
    NIF.draw_model_ex(
      model |> Zexray.Type.Model.to_nif(),
      position |> Zexray.Type.Vector3.to_nif(),
      rotation_axis |> Zexray.Type.Vector3.to_nif(),
      rotation_angle,
      scale |> Zexray.Type.Vector3.to_nif(),
      tint |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a model wires (with texture if set)
  """
  @doc group: :model_drawing
  @spec draw_model_wires(
          model :: Zexray.Type.Model.t_all(),
          position :: Zexray.Type.Vector3.t_all(),
          scale :: float,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_model_wires(
        model,
        position,
        scale,
        tint
      )
      when is_like_model(model) and
             is_like_vector3(position) and
             is_float(scale) and
             is_like_color(tint) do
    NIF.draw_model_wires(
      model |> Zexray.Type.Model.to_nif(),
      position |> Zexray.Type.Vector3.to_nif(),
      scale,
      tint |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a model wires (with texture if set) with extended parameters
  """
  @doc group: :model_drawing
  @spec draw_model_wires_ex(
          model :: Zexray.Type.Model.t_all(),
          position :: Zexray.Type.Vector3.t_all(),
          rotation_axis :: Zexray.Type.Vector3.t_all(),
          rotation_angle :: float,
          scale :: Zexray.Type.Vector3.t_all(),
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_model_wires_ex(
        model,
        position,
        rotation_axis,
        rotation_angle,
        scale,
        tint
      )
      when is_like_model(model) and
             is_like_vector3(position) and
             is_like_vector3(rotation_axis) and
             is_float(rotation_angle) and
             is_like_vector3(scale) and
             is_like_color(tint) do
    NIF.draw_model_wires_ex(
      model |> Zexray.Type.Model.to_nif(),
      position |> Zexray.Type.Vector3.to_nif(),
      rotation_axis |> Zexray.Type.Vector3.to_nif(),
      rotation_angle,
      scale |> Zexray.Type.Vector3.to_nif(),
      tint |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a model as points
  """
  @doc group: :model_drawing
  @spec draw_model_points(
          model :: Zexray.Type.Model.t_all(),
          position :: Zexray.Type.Vector3.t_all(),
          scale :: float,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_model_points(
        model,
        position,
        scale,
        tint
      )
      when is_like_model(model) and
             is_like_vector3(position) and
             is_float(scale) and
             is_like_color(tint) do
    NIF.draw_model_points(
      model |> Zexray.Type.Model.to_nif(),
      position |> Zexray.Type.Vector3.to_nif(),
      scale,
      tint |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a model as points with extended parameters
  """
  @doc group: :model_drawing
  @spec draw_model_points_ex(
          model :: Zexray.Type.Model.t_all(),
          position :: Zexray.Type.Vector3.t_all(),
          rotation_axis :: Zexray.Type.Vector3.t_all(),
          rotation_angle :: float,
          scale :: Zexray.Type.Vector3.t_all(),
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_model_points_ex(
        model,
        position,
        rotation_axis,
        rotation_angle,
        scale,
        tint
      )
      when is_like_model(model) and
             is_like_vector3(position) and
             is_like_vector3(rotation_axis) and
             is_float(rotation_angle) and
             is_like_vector3(scale) and
             is_like_color(tint) do
    NIF.draw_model_points_ex(
      model |> Zexray.Type.Model.to_nif(),
      position |> Zexray.Type.Vector3.to_nif(),
      rotation_axis |> Zexray.Type.Vector3.to_nif(),
      rotation_angle,
      scale |> Zexray.Type.Vector3.to_nif(),
      tint |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw bounding box (wires)
  """
  @doc group: :model_drawing
  @spec draw_bounding_box(
          box :: Zexray.Type.BoundingBox.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_bounding_box(
        box,
        color
      )
      when is_like_bounding_box(box) and
             is_like_color(color) do
    NIF.draw_bounding_box(
      box |> Zexray.Type.BoundingBox.to_nif(),
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a billboard texture
  """
  @doc group: :model_drawing
  @spec draw_billboard(
          camera :: Zexray.Type.Camera.t_all(),
          texture :: Zexray.Type.Texture2D.t_all(),
          position :: Zexray.Type.Vector3.t_all(),
          scale :: float,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_billboard(
        camera,
        texture,
        position,
        scale,
        tint
      )
      when is_like_camera(camera) and
             is_like_texture_2d(texture) and
             is_like_vector3(position) and
             is_float(scale) and
             is_like_color(tint) do
    NIF.draw_billboard(
      camera |> Zexray.Type.Camera.to_nif(),
      texture |> Zexray.Type.Texture2D.to_nif(),
      position |> Zexray.Type.Vector3.to_nif(),
      scale,
      tint |> Zexray.Type.Color.to_nif()
    )
  end

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
  def draw_billboard_rec(
        camera,
        texture,
        source,
        position,
        size,
        tint
      )
      when is_like_camera(camera) and
             is_like_texture_2d(texture) and
             is_like_rectangle(source) and
             is_like_vector3(position) and
             is_like_vector2(size) and
             is_like_color(tint) do
    NIF.draw_billboard_rec(
      camera |> Zexray.Type.Camera.to_nif(),
      texture |> Zexray.Type.Texture2D.to_nif(),
      source |> Zexray.Type.Rectangle.to_nif(),
      position |> Zexray.Type.Vector3.to_nif(),
      size |> Zexray.Type.Vector2.to_nif(),
      tint |> Zexray.Type.Color.to_nif()
    )
  end

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
          rotation :: float,
          tint :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_billboard_pro(
        camera,
        texture,
        source,
        position,
        up,
        size,
        origin,
        rotation,
        tint
      )
      when is_like_camera(camera) and
             is_like_texture_2d(texture) and
             is_like_rectangle(source) and
             is_like_vector3(position) and
             is_like_vector3(up) and
             is_like_vector2(size) and
             is_like_vector2(origin) and
             is_float(rotation) and
             is_like_color(tint) do
    NIF.draw_billboard_pro(
      camera |> Zexray.Type.Camera.to_nif(),
      texture |> Zexray.Type.Texture2D.to_nif(),
      source |> Zexray.Type.Rectangle.to_nif(),
      position |> Zexray.Type.Vector3.to_nif(),
      up |> Zexray.Type.Vector3.to_nif(),
      size |> Zexray.Type.Vector2.to_nif(),
      origin |> Zexray.Type.Vector2.to_nif(),
      rotation,
      tint |> Zexray.Type.Color.to_nif()
    )
  end

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
          return :: :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  def upload_mesh(
        mesh,
        dynamic,
        return \\ :value
      )
      when is_like_mesh(mesh) and
             is_boolean(dynamic) and
             is_nif_return(return) do
    NIF.upload_mesh(
      mesh |> Zexray.Type.Mesh.to_nif(),
      dynamic,
      return
    )
    |> Zexray.Type.Mesh.from_nif()
  end

  @doc """
  Update mesh vertex data in GPU for a specific buffer index
  """
  @doc group: :mesh_management
  @spec update_mesh_buffer(
          mesh :: Zexray.Type.Mesh.t_all(),
          index :: Zexray.Enum.ShaderAttributeLocationIndex.t_all(),
          data ::
            nil
            | [float]
            | [byte]
            | [non_neg_integer]
            | [Zexray.Type.Matrix.t_all()],
          offset :: integer
        ) :: :ok
  def update_mesh_buffer(
        mesh,
        index,
        data,
        offset \\ 0
      )
      when is_like_mesh(mesh) and
             is_like_shader_attribute_location_index(index) and
             (is_nil(data) or
                (is_list(data) and
                   (data == [] or
                      is_float(hd(data)) or
                      is_non_neg_integer(hd(data)) or
                      is_like_matrix(hd(data))))) and
             is_integer(offset) do
    NIF.update_mesh_buffer(
      mesh |> Zexray.Type.Mesh.to_nif(),
      Zexray.Enum.ShaderAttributeLocationIndex.value(index),
      data,
      offset
    )
  end

  @doc """
  Draw a 3d mesh with material and transform
  """
  @doc group: :mesh_management
  @spec draw_mesh(
          mesh :: Zexray.Type.Mesh.t_all(),
          material :: Zexray.Type.Material.t_all(),
          transform :: Zexray.Type.Matrix.t_all()
        ) :: :ok
  def draw_mesh(
        mesh,
        material,
        transform
      )
      when is_like_mesh(mesh) and
             is_like_material(material) and
             is_like_matrix(transform) do
    NIF.draw_mesh(
      mesh |> Zexray.Type.Mesh.to_nif(),
      material |> Zexray.Type.Material.to_nif(),
      transform |> Zexray.Type.Matrix.to_nif()
    )
  end

  @doc """
  Draw multiple mesh instances with material and different transforms
  """
  @doc group: :mesh_management
  @spec draw_mesh_instanced(
          mesh :: Zexray.Type.Mesh.t_all(),
          material :: Zexray.Type.Material.t_all(),
          transforms :: [Zexray.Type.Matrix.t_all()]
        ) :: :ok
  def draw_mesh_instanced(
        mesh,
        material,
        transforms
      )
      when is_like_mesh(mesh) and
             is_like_material(material) and
             is_list(transforms) and (transforms == [] or is_like_matrix(hd(transforms))) do
    NIF.draw_mesh_instanced(
      mesh |> Zexray.Type.Mesh.to_nif(),
      material |> Zexray.Type.Material.to_nif(),
      transforms |> Zexray.Type.Matrix.to_nif()
    )
  end

  @doc """
  Compute mesh bounding box limits
  """
  @doc group: :mesh_management
  @spec get_mesh_bounding_box(
          mesh :: Zexray.Type.Mesh.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.BoundingBox.t_nif()
  def get_mesh_bounding_box(
        mesh,
        return \\ :value
      )
      when is_like_mesh(mesh) and
             is_nif_return(return) do
    NIF.get_mesh_bounding_box(
      mesh |> Zexray.Type.Mesh.to_nif(),
      return
    )
    |> Zexray.Type.BoundingBox.from_nif()
  end

  @doc """
  Compute mesh tangents
  """
  @doc group: :mesh_management
  @spec gen_mesh_tangents(
          mesh :: Zexray.Type.Mesh.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  def gen_mesh_tangents(
        mesh,
        return \\ :value
      )
      when is_like_mesh(mesh) and
             is_nif_return(return) do
    NIF.gen_mesh_tangents(
      mesh |> Zexray.Type.Mesh.to_nif(),
      return
    )
    |> Zexray.Type.Mesh.from_nif()
  end

  @doc """
  Export mesh data to file, returns true on success
  """
  @doc group: :mesh_management
  @spec export_mesh(
          mesh :: Zexray.Type.Mesh.t_all(),
          file_name :: binary
        ) :: boolean
  def export_mesh(
        mesh,
        file_name
      )
      when is_like_mesh(mesh) and
             is_binary(file_name) do
    NIF.export_mesh(
      mesh |> Zexray.Type.Mesh.to_nif(),
      file_name
    )
  end

  #####################
  #  Mesh generation  #
  #####################

  @doc """
  Generate polygonal mesh
  """
  @doc group: :mesh_generation
  @spec gen_mesh_poly(
          sides :: integer,
          radius :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  def gen_mesh_poly(
        sides,
        radius,
        return \\ :value
      )
      when is_integer(sides) and
             is_float(radius) and
             is_nif_return(return) do
    NIF.gen_mesh_poly(
      sides,
      radius,
      return
    )
    |> Zexray.Type.Mesh.from_nif()
  end

  @doc """
  Generate plane mesh (with subdivisions)
  """
  @doc group: :mesh_generation
  @spec gen_mesh_plane(
          width :: float,
          length :: float,
          res_x :: integer,
          res_z :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  def gen_mesh_plane(
        width,
        length,
        res_x,
        res_z,
        return \\ :value
      )
      when is_float(width) and
             is_float(length) and
             is_integer(res_x) and
             is_integer(res_z) and
             is_nif_return(return) do
    NIF.gen_mesh_plane(
      width,
      length,
      res_x,
      res_z,
      return
    )
    |> Zexray.Type.Mesh.from_nif()
  end

  @doc """
  Generate cuboid mesh
  """
  @doc group: :mesh_generation
  @spec gen_mesh_cube(
          width :: float,
          height :: float,
          length :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  def gen_mesh_cube(
        width,
        height,
        length,
        return \\ :value
      )
      when is_float(width) and
             is_float(height) and
             is_float(length) and
             is_nif_return(return) do
    NIF.gen_mesh_cube(
      width,
      height,
      length,
      return
    )
    |> Zexray.Type.Mesh.from_nif()
  end

  @doc """
  Generate sphere mesh (standard sphere)
  """
  @doc group: :mesh_generation
  @spec gen_mesh_sphere(
          radius :: float,
          rings :: integer,
          slices :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  def gen_mesh_sphere(
        radius,
        rings,
        slices,
        return \\ :value
      )
      when is_float(radius) and
             is_integer(rings) and
             is_integer(slices) and
             is_nif_return(return) do
    NIF.gen_mesh_sphere(
      radius,
      rings,
      slices,
      return
    )
    |> Zexray.Type.Mesh.from_nif()
  end

  @doc """
  Generate half-sphere mesh (no bottom cap)
  """
  @doc group: :mesh_generation
  @spec gen_mesh_hemi_sphere(
          radius :: float,
          rings :: integer,
          slices :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  def gen_mesh_hemi_sphere(
        radius,
        rings,
        slices,
        return \\ :value
      )
      when is_float(radius) and
             is_integer(rings) and
             is_integer(slices) and
             is_nif_return(return) do
    NIF.gen_mesh_hemi_sphere(
      radius,
      rings,
      slices,
      return
    )
    |> Zexray.Type.Mesh.from_nif()
  end

  @doc """
  Generate cylinder mesh
  """
  @doc group: :mesh_generation
  @spec gen_mesh_cylinder(
          radius :: float,
          height :: float,
          slices :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  def gen_mesh_cylinder(
        radius,
        height,
        slices,
        return \\ :value
      )
      when is_float(radius) and
             is_float(height) and
             is_integer(slices) and
             is_nif_return(return) do
    NIF.gen_mesh_cylinder(
      radius,
      height,
      slices,
      return
    )
    |> Zexray.Type.Mesh.from_nif()
  end

  @doc """
  Generate cone/pyramid mesh
  """
  @doc group: :mesh_generation
  @spec gen_mesh_cone(
          radius :: float,
          height :: float,
          slices :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  def gen_mesh_cone(
        radius,
        height,
        slices,
        return \\ :value
      )
      when is_float(radius) and
             is_float(height) and
             is_integer(slices) and
             is_nif_return(return) do
    NIF.gen_mesh_cone(
      radius,
      height,
      slices,
      return
    )
    |> Zexray.Type.Mesh.from_nif()
  end

  @doc """
  Generate torus mesh
  """
  @doc group: :mesh_generation
  @spec gen_mesh_torus(
          radius :: float,
          size :: float,
          rad_seg :: integer,
          sides :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  def gen_mesh_torus(
        radius,
        size,
        rad_seg,
        sides,
        return \\ :value
      )
      when is_float(radius) and
             is_float(size) and
             is_integer(rad_seg) and
             is_integer(sides) and
             is_nif_return(return) do
    NIF.gen_mesh_torus(
      radius,
      size,
      rad_seg,
      sides,
      return
    )
    |> Zexray.Type.Mesh.from_nif()
  end

  @doc """
  Generate trefoil knot mesh
  """
  @doc group: :mesh_generation
  @spec gen_mesh_knot(
          radius :: float,
          size :: float,
          rad_seg :: integer,
          sides :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  def gen_mesh_knot(
        radius,
        size,
        rad_seg,
        sides,
        return \\ :value
      )
      when is_float(radius) and
             is_float(size) and
             is_integer(rad_seg) and
             is_integer(sides) and
             is_nif_return(return) do
    NIF.gen_mesh_knot(
      radius,
      size,
      rad_seg,
      sides,
      return
    )
    |> Zexray.Type.Mesh.from_nif()
  end

  @doc """
  Generate heightmap mesh from image data
  """
  @doc group: :mesh_generation
  @spec gen_mesh_heightmap(
          heightmap :: Zexray.Type.Image.t_all(),
          size :: Zexray.Type.Vector3.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  def gen_mesh_heightmap(
        heightmap,
        size,
        return \\ :value
      )
      when is_like_image(heightmap) and
             is_like_vector3(size) and
             is_nif_return(return) do
    NIF.gen_mesh_heightmap(
      heightmap |> Zexray.Type.Image.to_nif(),
      size |> Zexray.Type.Vector3.to_nif(),
      return
    )
    |> Zexray.Type.Mesh.from_nif()
  end

  @doc """
  Generate cubes-based map mesh from image data
  """
  @doc group: :mesh_generation
  @spec gen_mesh_cubicmap(
          cubicmap :: Zexray.Type.Image.t_all(),
          cube_size :: Zexray.Type.Vector3.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Mesh.t_nif()
  def gen_mesh_cubicmap(
        cubicmap,
        cube_size,
        return \\ :value
      )
      when is_like_image(cubicmap) and
             is_like_vector3(cube_size) and
             is_nif_return(return) do
    NIF.gen_mesh_cubicmap(
      cubicmap |> Zexray.Type.Image.to_nif(),
      cube_size |> Zexray.Type.Vector3.to_nif(),
      return
    )
    |> Zexray.Type.Mesh.from_nif()
  end

  #########################
  #  Material management  #
  #########################

  @doc """
  Load materials from model file
  """
  @doc group: :material_management
  @spec load_materials(
          file_name :: binary,
          return :: :value | :resource
        ) :: [Zexray.Type.Material.t_nif()]
  def load_materials(
        file_name,
        return \\ :value
      )
      when is_binary(file_name) and
             is_nif_return(return) do
    NIF.load_materials(
      file_name,
      return
    )
    |> Zexray.Type.Material.from_nif()
  end

  @doc """
  Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
  """
  @doc group: :material_management
  @spec load_material_default(return :: :value | :resource) :: Zexray.Type.Material.t_nif()
  def load_material_default(return \\ :value)
      when is_nif_return(return) do
    NIF.load_material_default(return)
    |> Zexray.Type.Material.from_nif()
  end

  @doc """
  Check if a material is valid (shader assigned, map textures loaded in GPU)
  """
  @doc group: :material_management
  @spec material_valid?(material :: Zexray.Type.Material.t_all()) :: boolean
  def material_valid?(material)
      when is_like_material(material) do
    NIF.is_material_valid(material |> Zexray.Type.Material.to_nif())
  end

  @doc """
  Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
  """
  @doc group: :material_management
  @spec set_material_texture(
          material :: Zexray.Type.Material.t_all(),
          map_type :: Zexray.Enum.MaterialMapIndex.t_all(),
          texture :: Zexray.Type.Texture2D.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Material.t_nif()
  def set_material_texture(
        material,
        map_type,
        texture,
        return \\ :value
      )
      when is_like_material(material) and
             is_like_material_map_index(map_type) and
             is_like_texture_2d(texture) and
             is_nif_return(return) do
    NIF.set_material_texture(
      material |> Zexray.Type.Material.to_nif(),
      Zexray.Enum.MaterialMapIndex.value(map_type),
      texture |> Zexray.Type.Texture2D.to_nif(),
      return
    )
    |> Zexray.Type.Material.from_nif()
  end

  @doc """
  Set material for a mesh
  """
  @doc group: :material_management
  @spec set_model_mesh_material(
          model :: Zexray.Type.Model.t_all(),
          mesh_id :: integer,
          material_id :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Model.t_nif()
  def set_model_mesh_material(
        model,
        mesh_id,
        material_id,
        return \\ :value
      )
      when is_like_model(model) and
             is_integer(mesh_id) and
             is_integer(material_id) and
             is_nif_return(return) do
    NIF.set_model_mesh_material(
      model |> Zexray.Type.Model.to_nif(),
      mesh_id,
      material_id,
      return
    )
    |> Zexray.Type.Model.from_nif()
  end

  #####################
  #  Model animation  #
  #####################

  @doc """
  Load model animations from file
  """
  @doc group: :model_animation
  @spec load_model_animations(
          file_name :: binary,
          return :: :value | :resource
        ) :: [Zexray.Type.ModelAnimation.t_nif()]
  def load_model_animations(
        file_name,
        return \\ :value
      )
      when is_binary(file_name) and
             is_nif_return(return) do
    NIF.load_model_animations(
      file_name,
      return
    )
    |> Zexray.Type.ModelAnimation.from_nif()
  end

  @doc """
  Update model animation pose (CPU)
  """
  @doc group: :model_animation
  @spec update_model_animation(
          model :: Zexray.Type.Model.t_all(),
          anim :: Zexray.Type.ModelAnimation.t_all(),
          frame :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Model.t_nif()
  def update_model_animation(
        model,
        anim,
        frame,
        return \\ :value
      )
      when is_like_model(model) and
             is_like_model_animation(anim) and
             is_integer(frame) and
             is_nif_return(return) do
    NIF.update_model_animation(
      model |> Zexray.Type.Model.to_nif(),
      anim |> Zexray.Type.ModelAnimation.to_nif(),
      frame,
      return
    )
    |> Zexray.Type.Model.from_nif()
  end

  @doc """
  Update model animation mesh bone matrices (GPU skinning)
  """
  @doc group: :model_animation
  @spec update_model_animation_bones(
          model :: Zexray.Type.Model.t_all(),
          anim :: Zexray.Type.ModelAnimation.t_all(),
          frame :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Model.t_nif()
  def update_model_animation_bones(
        model,
        anim,
        frame,
        return \\ :value
      )
      when is_like_model(model) and
             is_like_model_animation(anim) and
             is_integer(frame) and
             is_nif_return(return) do
    NIF.update_model_animation_bones(
      model |> Zexray.Type.Model.to_nif(),
      anim |> Zexray.Type.ModelAnimation.to_nif(),
      frame,
      return
    )
    |> Zexray.Type.Model.from_nif()
  end

  @doc """
  Check model animation skeleton match
  """
  @doc group: :model_animation
  @spec model_animation_valid?(
          model :: Zexray.Type.Model.t_all(),
          anim :: Zexray.Type.ModelAnimation.t_all()
        ) :: boolean
  def model_animation_valid?(
        model,
        anim
      )
      when is_like_model(model) and
             is_like_model_animation(anim) do
    NIF.is_model_animation_valid(
      model |> Zexray.Type.Model.to_nif(),
      anim |> Zexray.Type.ModelAnimation.to_nif()
    )
  end

  #########################
  #  Collision detection  #
  #########################

  @doc """
  Check collision between two spheres
  """
  @doc group: :collision_detection
  @spec collision_spheres?(
          center1 :: Zexray.Type.Vector3.t_all(),
          radius1 :: float,
          center2 :: Zexray.Type.Vector3.t_all(),
          radius2 :: float
        ) :: boolean
  def collision_spheres?(
        center1,
        radius1,
        center2,
        radius2
      )
      when is_like_vector3(center1) and
             is_float(radius1) and
             is_like_vector3(center2) and
             is_float(radius2) do
    NIF.check_collision_spheres(
      center1 |> Zexray.Type.Vector3.to_nif(),
      radius1,
      center2 |> Zexray.Type.Vector3.to_nif(),
      radius2
    )
  end

  @doc """
  Check collision between two bounding boxes
  """
  @doc group: :collision_detection
  @spec collision_boxes?(
          box1 :: Zexray.Type.BoundingBox.t_all(),
          box2 :: Zexray.Type.BoundingBox.t_all()
        ) :: boolean
  def collision_boxes?(
        box1,
        box2
      )
      when is_like_bounding_box(box1) and
             is_like_bounding_box(box2) do
    NIF.check_collision_boxes(
      box1 |> Zexray.Type.BoundingBox.to_nif(),
      box2 |> Zexray.Type.BoundingBox.to_nif()
    )
  end

  @doc """
  Check collision between box and sphere
  """
  @doc group: :collision_detection
  @spec collision_box_sphere?(
          box :: Zexray.Type.BoundingBox.t_all(),
          center :: Zexray.Type.Vector3.t_all(),
          radius :: float
        ) :: boolean
  def collision_box_sphere?(
        box,
        center,
        radius
      )
      when is_like_bounding_box(box) and
             is_like_vector3(center) and
             is_float(radius) do
    NIF.check_collision_box_sphere(
      box |> Zexray.Type.BoundingBox.to_nif(),
      center |> Zexray.Type.Vector3.to_nif(),
      radius
    )
  end

  @doc """
  Get collision info between ray and sphere
  """
  @doc group: :collision_detection
  @spec get_ray_collision_sphere(
          ray :: Zexray.Type.Ray.t_all(),
          center :: Zexray.Type.Vector3.t_all(),
          radius :: float,
          return :: :value | :resource
        ) :: Zexray.Type.RayCollision.t_nif()
  def get_ray_collision_sphere(
        ray,
        center,
        radius,
        return \\ :value
      )
      when is_like_ray(ray) and
             is_like_vector3(center) and
             is_float(radius) and
             is_nif_return(return) do
    NIF.get_ray_collision_sphere(
      ray |> Zexray.Type.Ray.to_nif(),
      center |> Zexray.Type.Vector3.to_nif(),
      radius,
      return
    )
    |> Zexray.Type.RayCollision.from_nif()
  end

  @doc """
  Get collision info between ray and box
  """
  @doc group: :collision_detection
  @spec get_ray_collision_box(
          ray :: Zexray.Type.Ray.t_all(),
          box :: Zexray.Type.BoundingBox.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.RayCollision.t_nif()
  def get_ray_collision_box(
        ray,
        box,
        return \\ :value
      )
      when is_like_ray(ray) and
             is_like_bounding_box(box) and
             is_nif_return(return) do
    NIF.get_ray_collision_box(
      ray |> Zexray.Type.Ray.to_nif(),
      box |> Zexray.Type.BoundingBox.to_nif(),
      return
    )
    |> Zexray.Type.RayCollision.from_nif()
  end

  @doc """
  Get collision info between ray and mesh
  """
  @doc group: :collision_detection
  @spec get_ray_collision_mesh(
          ray :: Zexray.Type.Ray.t_all(),
          mesh :: Zexray.Type.Mesh.t_all(),
          transform :: Zexray.Type.Matrix.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.RayCollision.t_nif()
  def get_ray_collision_mesh(
        ray,
        mesh,
        transform,
        return \\ :value
      )
      when is_like_ray(ray) and
             is_like_mesh(mesh) and
             is_like_matrix(transform) and
             is_nif_return(return) do
    NIF.get_ray_collision_mesh(
      ray |> Zexray.Type.Ray.to_nif(),
      mesh |> Zexray.Type.Mesh.to_nif(),
      transform |> Zexray.Type.Matrix.to_nif(),
      return
    )
    |> Zexray.Type.RayCollision.from_nif()
  end

  @doc """
  Get collision info between ray and triangle
  """
  @doc group: :collision_detection
  @spec get_ray_collision_triangle(
          ray :: Zexray.Type.Ray.t_all(),
          p1 :: Zexray.Type.Vector3.t_all(),
          p2 :: Zexray.Type.Vector3.t_all(),
          p3 :: Zexray.Type.Vector3.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.RayCollision.t_nif()
  def get_ray_collision_triangle(
        ray,
        p1,
        p2,
        p3,
        return \\ :value
      )
      when is_like_ray(ray) and
             is_like_vector3(p1) and
             is_like_vector3(p2) and
             is_like_vector3(p3) and
             is_nif_return(return) do
    NIF.get_ray_collision_triangle(
      ray |> Zexray.Type.Ray.to_nif(),
      p1 |> Zexray.Type.Vector3.to_nif(),
      p2 |> Zexray.Type.Vector3.to_nif(),
      p3 |> Zexray.Type.Vector3.to_nif(),
      return
    )
    |> Zexray.Type.RayCollision.from_nif()
  end

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
          return :: :value | :resource
        ) :: Zexray.Type.RayCollision.t_nif()
  def get_ray_collision_quad(
        ray,
        p1,
        p2,
        p3,
        p4,
        return \\ :value
      )
      when is_like_ray(ray) and
             is_like_vector3(p1) and
             is_like_vector3(p2) and
             is_like_vector3(p3) and
             is_like_vector3(p4) and
             is_nif_return(return) do
    NIF.get_ray_collision_quad(
      ray |> Zexray.Type.Ray.to_nif(),
      p1 |> Zexray.Type.Vector3.to_nif(),
      p2 |> Zexray.Type.Vector3.to_nif(),
      p3 |> Zexray.Type.Vector3.to_nif(),
      p4 |> Zexray.Type.Vector3.to_nif(),
      return
    )
    |> Zexray.Type.RayCollision.from_nif()
  end
end
