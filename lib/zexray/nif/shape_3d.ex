defmodule Zexray.NIF.Shape3D do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_shape_3d [
        # Basic 3D shapes drawing
        draw_line_3d: 3,
        draw_point_3d: 2,
        draw_circle_3d: 5,
        draw_triangle_3d: 4,
        draw_triangle_strip_3d: 2,
        draw_cube: 5,
        draw_cube_v: 3,
        draw_cube_wires: 5,
        draw_cube_wires_v: 3,
        draw_sphere: 3,
        draw_sphere_ex: 5,
        draw_sphere_wires: 5,
        draw_cylinder: 6,
        draw_cylinder_ex: 6,
        draw_cylinder_wires: 6,
        draw_cylinder_wires_ex: 6,
        draw_capsule: 6,
        draw_capsule_wires: 6,
        draw_plane: 3,
        draw_ray: 2,
        draw_grid: 2,

        # Model management
        load_model: 1,
        load_model: 2,
        load_model_from_mesh: 1,
        load_model_from_mesh: 2,
        is_model_valid: 1,
        get_model_bounding_box: 1,
        get_model_bounding_box: 2,

        # Model drawing
        draw_model: 4,
        draw_model_ex: 6,
        draw_model_wires: 4,
        draw_model_wires_ex: 6,
        draw_model_points: 4,
        draw_model_points_ex: 6,
        draw_bounding_box: 2,
        draw_billboard: 5,
        draw_billboard_rec: 6,
        draw_billboard_pro: 9,

        # Mesh management
        upload_mesh: 2,
        upload_mesh: 3,
        update_mesh_buffer: 4,
        draw_mesh: 3,
        draw_mesh_instanced: 3,
        get_mesh_bounding_box: 1,
        get_mesh_bounding_box: 2,
        gen_mesh_tangents: 1,
        gen_mesh_tangents: 2,
        export_mesh: 2,

        # Mesh generation
        gen_mesh_poly: 2,
        gen_mesh_poly: 3,
        gen_mesh_plane: 4,
        gen_mesh_plane: 5,
        gen_mesh_cube: 3,
        gen_mesh_cube: 4,
        gen_mesh_sphere: 3,
        gen_mesh_sphere: 4,
        gen_mesh_hemi_sphere: 3,
        gen_mesh_hemi_sphere: 4,
        gen_mesh_cylinder: 3,
        gen_mesh_cylinder: 4,
        gen_mesh_cone: 3,
        gen_mesh_cone: 4,
        gen_mesh_torus: 4,
        gen_mesh_torus: 5,
        gen_mesh_knot: 4,
        gen_mesh_knot: 5,
        gen_mesh_heightmap: 2,
        gen_mesh_heightmap: 3,
        gen_mesh_cubicmap: 2,
        gen_mesh_cubicmap: 3,

        # Material management
        load_materials: 1,
        load_materials: 2,
        load_material_default: 0,
        load_material_default: 1,
        is_material_valid: 1,
        set_material_texture: 3,
        set_material_texture: 4,
        set_model_mesh_material: 3,
        set_model_mesh_material: 4,

        # Model animation
        load_model_animations: 1,
        load_model_animations: 2,
        update_model_animation: 3,
        update_model_animation: 4,
        update_model_animation_bones: 3,
        update_model_animation_bones: 4,
        is_model_animation_valid: 2,

        # Collision detection
        check_collision_spheres: 4,
        check_collision_boxes: 2,
        check_collision_box_sphere: 3,
        get_ray_collision_sphere: 3,
        get_ray_collision_sphere: 4,
        get_ray_collision_box: 2,
        get_ray_collision_box: 3,
        get_ray_collision_mesh: 3,
        get_ray_collision_mesh: 4,
        get_ray_collision_triangle: 4,
        get_ray_collision_triangle: 5,
        get_ray_collision_quad: 5,
        get_ray_collision_quad: 6
      ]

      #############################
      #  Basic 3D shapes drawing  #
      #############################

      @doc """
      Draw a line in 3D world space

      ```c
      // raylib.h
      RLAPI void DrawLine3D(Vector3 startPos, Vector3 endPos, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_line_3d(
              start_pos :: tuple,
              end_pos :: tuple,
              color :: tuple
            ) :: :ok
      def draw_line_3d(
            _start_pos,
            _end_pos,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a point in 3D space, actually a small line

      ```c
      // raylib.h
      RLAPI void DrawPoint3D(Vector3 position, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_point_3d(
              position :: tuple,
              color :: tuple
            ) :: :ok
      def draw_point_3d(
            _position,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a circle in 3D world space

      ```c
      // raylib.h
      RLAPI void DrawCircle3D(Vector3 center, float radius, Vector3 rotationAxis, float rotationAngle, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_circle_3d(
              center :: tuple,
              radius :: float,
              rotation_axis :: tuple,
              rotation_angle :: float,
              color :: tuple
            ) :: :ok
      def draw_circle_3d(
            _center,
            _radius,
            _rotation_axis,
            _rotation_angle,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a color-filled triangle (vertex in counter-clockwise order!)

      ```c
      // raylib.h
      RLAPI void DrawTriangle3D(Vector3 v1, Vector3 v2, Vector3 v3, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_triangle_3d(
              v1 :: tuple,
              v2 :: tuple,
              v3 :: tuple,
              color :: tuple
            ) :: :ok
      def draw_triangle_3d(
            _v1,
            _v2,
            _v3,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a triangle strip defined by points

      ```c
      // raylib.h
      RLAPI void DrawTriangleStrip3D(const Vector3 *points, int pointCount, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_triangle_strip_3d(
              points :: [tuple],
              color :: tuple
            ) :: :ok
      def draw_triangle_strip_3d(
            _points,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw cube

      ```c
      // raylib.h
      RLAPI void DrawCube(Vector3 position, float width, float height, float length, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_cube(
              position :: tuple,
              width :: float,
              height :: float,
              length :: float,
              color :: tuple
            ) :: :ok
      def draw_cube(
            _position,
            _width,
            _height,
            _length,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw cube (Vector version)

      ```c
      // raylib.h
      RLAPI void DrawCubeV(Vector3 position, Vector3 size, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_cube_v(
              position :: tuple,
              size :: tuple,
              color :: tuple
            ) :: :ok
      def draw_cube_v(
            _position,
            _size,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw cube wires

      ```c
      // raylib.h
      RLAPI void DrawCubeWires(Vector3 position, float width, float height, float length, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_cube_wires(
              position :: tuple,
              width :: float,
              height :: float,
              length :: float,
              color :: tuple
            ) :: :ok
      def draw_cube_wires(
            _position,
            _width,
            _height,
            _length,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw cube wires (Vector version)

      ```c
      // raylib.h
      RLAPI void DrawCubeWiresV(Vector3 position, Vector3 size, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_cube_wires_v(
              position :: tuple,
              size :: tuple,
              color :: tuple
            ) :: :ok
      def draw_cube_wires_v(
            _position,
            _size,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw sphere

      ```c
      // raylib.h
      RLAPI void DrawSphere(Vector3 centerPos, float radius, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_sphere(
              center_pos :: tuple,
              radius :: float,
              color :: tuple
            ) :: :ok
      def draw_sphere(
            _center_pos,
            _radius,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw sphere with extended parameters

      ```c
      // raylib.h
      RLAPI void DrawSphereEx(Vector3 centerPos, float radius, int rings, int slices, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_sphere_ex(
              center_pos :: tuple,
              radius :: float,
              rings :: integer,
              slices :: integer,
              color :: tuple
            ) :: :ok
      def draw_sphere_ex(
            _center_pos,
            _radius,
            _rings,
            _slices,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw sphere wires

      ```c
      // raylib.h
      RLAPI void DrawSphereWires(Vector3 centerPos, float radius, int rings, int slices, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_sphere_wires(
              center_pos :: tuple,
              radius :: float,
              rings :: integer,
              slices :: integer,
              color :: tuple
            ) :: :ok
      def draw_sphere_wires(
            _center_pos,
            _radius,
            _rings,
            _slices,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a cylinder/cone

      ```c
      // raylib.h
      RLAPI void DrawCylinder(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_cylinder(
              position :: tuple,
              radius_top :: float,
              radius_bottom :: float,
              height :: float,
              slices :: integer,
              color :: tuple
            ) :: :ok
      def draw_cylinder(
            _position,
            _radius_top,
            _radius_bottom,
            _height,
            _slices,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a cylinder with base at startPos and top at endPos

      ```c
      // raylib.h
      RLAPI void DrawCylinderEx(Vector3 startPos, Vector3 endPos, float startRadius, float endRadius, int sides, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_cylinder_ex(
              start_pos :: tuple,
              end_pos :: tuple,
              start_radius :: float,
              end_radius :: float,
              sides :: integer,
              color :: tuple
            ) :: :ok
      def draw_cylinder_ex(
            _start_pos,
            _end_pos,
            _start_radius,
            _end_radius,
            _sides,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a cylinder/cone wires

      ```c
      // raylib.h
      RLAPI void DrawCylinderWires(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_cylinder_wires(
              position :: tuple,
              radius_top :: float,
              radius_bottom :: float,
              height :: float,
              slices :: integer,
              color :: tuple
            ) :: :ok
      def draw_cylinder_wires(
            _position,
            _radius_top,
            _radius_bottom,
            _height,
            _slices,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a cylinder wires with base at startPos and top at endPos

      ```c
      // raylib.h
      RLAPI void DrawCylinderWiresEx(Vector3 startPos, Vector3 endPos, float startRadius, float endRadius, int sides, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_cylinder_wires_ex(
              start_pos :: tuple,
              end_pos :: tuple,
              start_radius :: float,
              end_radius :: float,
              sides :: integer,
              color :: tuple
            ) :: :ok
      def draw_cylinder_wires_ex(
            _start_pos,
            _end_pos,
            _start_radius,
            _end_radius,
            _sides,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a capsule with the center of its sphere caps at startPos and endPos

      ```c
      // raylib.h
      RLAPI void DrawCapsule(Vector3 startPos, Vector3 endPos, float radius, int slices, int rings, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_capsule(
              start_pos :: tuple,
              end_pos :: tuple,
              radius :: float,
              slices :: integer,
              rings :: integer,
              color :: tuple
            ) :: :ok
      def draw_capsule(
            _start_pos,
            _end_pos,
            _radius,
            _slices,
            _rings,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw capsule wireframe with the center of its sphere caps at startPos and endPos

      ```c
      // raylib.h
      RLAPI void DrawCapsuleWires(Vector3 startPos, Vector3 endPos, float radius, int slices, int rings, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_capsule_wires(
              start_pos :: tuple,
              end_pos :: tuple,
              radius :: float,
              slices :: integer,
              rings :: integer,
              color :: tuple
            ) :: :ok
      def draw_capsule_wires(
            _start_pos,
            _end_pos,
            _radius,
            _slices,
            _rings,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a plane XZ

      ```c
      // raylib.h
      RLAPI void DrawPlane(Vector3 centerPos, Vector2 size, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_plane(
              center_pos :: tuple,
              size :: tuple,
              color :: tuple
            ) :: :ok
      def draw_plane(
            _center_pos,
            _size,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a ray line

      ```c
      // raylib.h
      RLAPI void DrawRay(Ray ray, Color color);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_ray(
              ray :: tuple,
              color :: tuple
            ) :: :ok
      def draw_ray(
            _ray,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a grid (centered at (0, 0, 0))

      ```c
      // raylib.h
      RLAPI void DrawGrid(int slices, float spacing);
      ```
      """
      @doc group: :basic_3d_shapes_drawing
      @spec draw_grid(
              slices :: integer,
              spacing :: float
            ) :: :ok
      def draw_grid(
            _slices,
            _spacing
          ),
          do: :erlang.nif_error(:undef)

      ######################
      #  Model management  #
      ######################

      @doc """
      Load model from files (meshes and materials)

      ```c
      // raylib.h
      RLAPI Model LoadModel(const char *fileName);
      ```
      """
      @doc group: :model_management
      @spec load_model(
              file_name :: binary,
              return :: :auto | :value | :resource
            ) :: tuple
      def load_model(
            _file_name,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load model from generated mesh (default material)

      ```c
      // raylib.h
      RLAPI Model LoadModelFromMesh(Mesh mesh);
      ```
      """
      @doc group: :model_management
      @spec load_model_from_mesh(
              mesh :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def load_model_from_mesh(
            _mesh,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check if a model is valid (loaded in GPU, VAO/VBOs)

      ```c
      // raylib.h
      RLAPI bool IsModelValid(Model model);
      ```
      """
      @doc group: :model_management
      @spec is_model_valid(model :: tuple) :: boolean
      def is_model_valid(_model), do: :erlang.nif_error(:undef)

      @doc """
      Compute model bounding box limits (considers all meshes)

      ```c
      // raylib.h
      RLAPI BoundingBox GetModelBoundingBox(Model model);
      ```
      """
      @doc group: :model_management
      @spec get_model_bounding_box(
              model :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_model_bounding_box(
            _model,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      ###################
      #  Model drawing  #
      ###################

      @doc """
      Draw a model (with texture if set)

      ```c
      // raylib.h
      RLAPI void DrawModel(Model model, Vector3 position, float scale, Color tint);
      ```
      """
      @doc group: :model_drawing
      @spec draw_model(
              model :: tuple,
              position :: tuple,
              scale :: float,
              tint :: tuple
            ) :: :ok
      def draw_model(
            _model,
            _position,
            _scale,
            _tint
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a model with extended parameters

      ```c
      // raylib.h
      RLAPI void DrawModelEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint);
      ```
      """
      @doc group: :model_drawing
      @spec draw_model_ex(
              model :: tuple,
              position :: tuple,
              rotation_axis :: tuple,
              rotation_angle :: float,
              scale :: tuple,
              tint :: tuple
            ) :: :ok
      def draw_model_ex(
            _model,
            _position,
            _rotation_axis,
            _rotation_angle,
            _scale,
            _tint
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a model wires (with texture if set)

      ```c
      // raylib.h
      RLAPI void DrawModelWires(Model model, Vector3 position, float scale, Color tint);
      ```
      """
      @doc group: :model_drawing
      @spec draw_model_wires(
              model :: tuple,
              position :: tuple,
              scale :: float,
              tint :: tuple
            ) :: :ok
      def draw_model_wires(
            _model,
            _position,
            _scale,
            _tint
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a model wires (with texture if set) with extended parameters

      ```c
      // raylib.h
      RLAPI void DrawModelWiresEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint);
      ```
      """
      @doc group: :model_drawing
      @spec draw_model_wires_ex(
              model :: tuple,
              position :: tuple,
              rotation_axis :: tuple,
              rotation_angle :: float,
              scale :: tuple,
              tint :: tuple
            ) :: :ok
      def draw_model_wires_ex(
            _model,
            _position,
            _rotation_axis,
            _rotation_angle,
            _scale,
            _tint
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a model as points

      ```c
      // raylib.h
      RLAPI void DrawModelPoints(Model model, Vector3 position, float scale, Color tint);
      ```
      """
      @doc group: :model_drawing
      @spec draw_model_points(
              model :: tuple,
              position :: tuple,
              scale :: float,
              tint :: tuple
            ) :: :ok
      def draw_model_points(
            _model,
            _position,
            _scale,
            _tint
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a model as points with extended parameters

      ```c
      // raylib.h
      RLAPI void DrawModelPointsEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint);
      ```
      """
      @doc group: :model_drawing
      @spec draw_model_points_ex(
              model :: tuple,
              position :: tuple,
              rotation_axis :: tuple,
              rotation_angle :: float,
              scale :: tuple,
              tint :: tuple
            ) :: :ok
      def draw_model_points_ex(
            _model,
            _position,
            _rotation_axis,
            _rotation_angle,
            _scale,
            _tint
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw bounding box (wires)

      ```c
      // raylib.h
      RLAPI void DrawBoundingBox(BoundingBox box, Color color);
      ```
      """
      @doc group: :model_drawing
      @spec draw_bounding_box(
              box :: tuple,
              color :: tuple
            ) :: :ok
      def draw_bounding_box(
            _box,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a billboard texture

      ```c
      // raylib.h
      RLAPI void DrawBillboard(Camera camera, Texture2D texture, Vector3 position, float scale, Color tint);
      ```
      """
      @doc group: :model_drawing
      @spec draw_billboard(
              camera :: tuple,
              texture :: tuple,
              position :: tuple,
              scale :: float,
              tint :: tuple
            ) :: :ok
      def draw_billboard(
            _camera,
            _texture,
            _position,
            _scale,
            _tint
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a billboard texture defined by source

      ```c
      // raylib.h
      RLAPI void DrawBillboardRec(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector2 size, Color tint);
      ```
      """
      @doc group: :model_drawing
      @spec draw_billboard_rec(
              camera :: tuple,
              texture :: tuple,
              source :: tuple,
              position :: tuple,
              size :: tuple,
              tint :: tuple
            ) :: :ok
      def draw_billboard_rec(
            _camera,
            _texture,
            _source,
            _position,
            _size,
            _tint
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a billboard texture defined by source and rotation

      ```c
      // raylib.h
      RLAPI void DrawBillboardPro(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector3 up, Vector2 size, Vector2 origin, float rotation, Color tint);
      ```
      """
      @doc group: :model_drawing
      @spec draw_billboard_pro(
              camera :: tuple,
              texture :: tuple,
              source :: tuple,
              position :: tuple,
              up :: tuple,
              size :: tuple,
              origin :: tuple,
              rotation :: float,
              tint :: tuple
            ) :: :ok
      def draw_billboard_pro(
            _camera,
            _texture,
            _source,
            _position,
            _up,
            _size,
            _origin,
            _rotation,
            _tint
          ),
          do: :erlang.nif_error(:undef)

      #####################
      #  Mesh management  #
      #####################

      @doc """
      Upload mesh vertex data in GPU and provide VAO/VBO ids

      ```c
      // raylib.h
      RLAPI void UploadMesh(Mesh *mesh, bool dynamic);
      ```
      """
      @doc group: :mesh_management
      @spec upload_mesh(
              mesh :: tuple,
              dynamic :: boolean,
              return :: :auto | :value | :resource
            ) :: tuple
      def upload_mesh(
            _mesh,
            _dynamic,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Update mesh vertex data in GPU for a specific buffer index

      ```c
      // raylib.h
      RLAPI void UpdateMeshBuffer(Mesh mesh, int index, const void *data, int dataSize, int offset);
      ```
      """
      @doc group: :mesh_management
      @spec update_mesh_buffer(
              mesh :: tuple,
              index :: integer,
              data :: nil | [float] | [byte] | [non_neg_integer] | [tuple],
              offset :: integer
            ) :: :ok
      def update_mesh_buffer(
            _mesh,
            _index,
            _data,
            _offset
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a 3d mesh with material and transform

      ```c
      // raylib.h
      RLAPI void DrawMesh(Mesh mesh, Material material, Matrix transform);
      ```
      """
      @doc group: :mesh_management
      @spec draw_mesh(
              mesh :: tuple,
              material :: tuple,
              transform :: tuple
            ) :: :ok
      def draw_mesh(
            _mesh,
            _material,
            _transform
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw multiple mesh instances with material and different transforms

      ```c
      // raylib.h
      RLAPI void DrawMeshInstanced(Mesh mesh, Material material, const Matrix *transforms, int instances);
      ```
      """
      @doc group: :mesh_management
      @spec draw_mesh_instanced(
              mesh :: tuple,
              material :: tuple,
              transforms :: [tuple]
            ) :: :ok
      def draw_mesh_instanced(
            _mesh,
            _material,
            _transforms
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Compute mesh bounding box limits

      ```c
      // raylib.h
      RLAPI BoundingBox GetMeshBoundingBox(Mesh mesh);
      ```
      """
      @doc group: :mesh_management
      @spec get_mesh_bounding_box(
              mesh :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_mesh_bounding_box(
            _mesh,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Compute mesh tangents

      ```c
      // raylib.h
      RLAPI void GenMeshTangents(Mesh *mesh);
      ```
      """
      @doc group: :mesh_management
      @spec gen_mesh_tangents(
              mesh :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def gen_mesh_tangents(
            _mesh,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Export mesh data to file, returns true on success

      ```c
      // raylib.h
      RLAPI bool ExportMesh(Mesh mesh, const char *fileName);
      ```
      """
      @doc group: :mesh_management
      @spec export_mesh(
              mesh :: tuple,
              file_name :: binary
            ) :: boolean
      def export_mesh(
            _mesh,
            _file_name
          ),
          do: :erlang.nif_error(:undef)

      #####################
      #  Mesh generation  #
      #####################

      @doc """
      Generate polygonal mesh

      ```c
      // raylib.h
      RLAPI Mesh GenMeshPoly(int sides, float radius);
      ```
      """
      @doc group: :mesh_generation
      @spec gen_mesh_poly(
              sides :: integer,
              radius :: float,
              return :: :auto | :value | :resource
            ) :: tuple
      def gen_mesh_poly(
            _sides,
            _radius,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Generate plane mesh (with subdivisions)

      ```c
      // raylib.h
      RLAPI Mesh GenMeshPlane(float width, float length, int resX, int resZ);
      ```
      """
      @doc group: :mesh_generation
      @spec gen_mesh_plane(
              width :: float,
              length :: float,
              res_x :: integer,
              res_z :: integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def gen_mesh_plane(
            _width,
            _length,
            _res_x,
            _res_z,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Generate cuboid mesh

      ```c
      // raylib.h
      RLAPI Mesh GenMeshCube(float width, float height, float length);
      ```
      """
      @doc group: :mesh_generation
      @spec gen_mesh_cube(
              width :: float,
              height :: float,
              length :: float,
              return :: :auto | :value | :resource
            ) :: tuple
      def gen_mesh_cube(
            _width,
            _height,
            _length,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Generate sphere mesh (standard sphere)

      ```c
      // raylib.h
      RLAPI Mesh GenMeshSphere(float radius, int rings, int slices);
      ```
      """
      @doc group: :mesh_generation
      @spec gen_mesh_sphere(
              radius :: float,
              rings :: integer,
              slices :: integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def gen_mesh_sphere(
            _radius,
            _rings,
            _slices,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Generate half-sphere mesh (no bottom cap)

      ```c
      // raylib.h
      RLAPI Mesh GenMeshHemiSphere(float radius, int rings, int slices);
      ```
      """
      @doc group: :mesh_generation
      @spec gen_mesh_hemi_sphere(
              radius :: float,
              rings :: integer,
              slices :: integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def gen_mesh_hemi_sphere(
            _radius,
            _rings,
            _slices,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Generate cylinder mesh

      ```c
      // raylib.h
      RLAPI Mesh GenMeshCylinder(float radius, float height, int slices);
      ```
      """
      @doc group: :mesh_generation
      @spec gen_mesh_cylinder(
              radius :: float,
              height :: float,
              slices :: integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def gen_mesh_cylinder(
            _radius,
            _height,
            _slices,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Generate cone/pyramid mesh

      ```c
      // raylib.h
      RLAPI Mesh GenMeshCone(float radius, float height, int slices);
      ```
      """
      @doc group: :mesh_generation
      @spec gen_mesh_cone(
              radius :: float,
              height :: float,
              slices :: integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def gen_mesh_cone(
            _radius,
            _height,
            _slices,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Generate torus mesh

      ```c
      // raylib.h
      RLAPI Mesh GenMeshTorus(float radius, float size, int radSeg, int sides);
      ```
      """
      @doc group: :mesh_generation
      @spec gen_mesh_torus(
              radius :: float,
              size :: float,
              rad_seg :: integer,
              sides :: integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def gen_mesh_torus(
            _radius,
            _size,
            _rad_seg,
            _sides,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Generate trefoil knot mesh

      ```c
      // raylib.h
      RLAPI Mesh GenMeshKnot(float radius, float size, int radSeg, int sides);
      ```
      """
      @doc group: :mesh_generation
      @spec gen_mesh_knot(
              radius :: float,
              size :: float,
              rad_seg :: integer,
              sides :: integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def gen_mesh_knot(
            _radius,
            _size,
            _rad_seg,
            _sides,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Generate heightmap mesh from image data

      ```c
      // raylib.h
      RLAPI Mesh GenMeshHeightmap(Image heightmap, Vector3 size);
      ```
      """
      @doc group: :mesh_generation
      @spec gen_mesh_heightmap(
              heightmap :: tuple,
              size :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def gen_mesh_heightmap(
            _heightmap,
            _size,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Generate cubes-based map mesh from image data

      ```c
      // raylib.h
      RLAPI Mesh GenMeshCubicmap(Image cubicmap, Vector3 cubeSize);
      ```
      """
      @doc group: :mesh_generation
      @spec gen_mesh_cubicmap(
              cubicmap :: tuple,
              cube_size :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def gen_mesh_cubicmap(
            _cubicmap,
            _cube_size,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      #########################
      #  Material management  #
      #########################

      @doc """
      Load materials from model file

      ```c
      // raylib.h
      RLAPI Material *LoadMaterials(const char *fileName, int *materialCount);
      ```
      """
      @doc group: :material_management
      @spec load_materials(
              file_name :: binary,
              return :: :auto | :value | :resource
            ) :: [tuple]
      def load_materials(
            _file_name,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)

      ```c
      // raylib.h
      RLAPI Material LoadMaterialDefault(void);
      ```
      """
      @doc group: :material_management
      @spec load_material_default(return :: :auto | :value | :resource) :: tuple
      def load_material_default(_return \\ :auto), do: :erlang.nif_error(:undef)

      @doc """
      Check if a material is valid (shader assigned, map textures loaded in GPU)

      ```c
      // raylib.h
      RLAPI bool IsMaterialValid(Material material);
      ```
      """
      @doc group: :material_management
      @spec is_material_valid(material :: tuple) :: boolean
      def is_material_valid(_material), do: :erlang.nif_error(:undef)

      @doc """
      Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)

      ```c
      // raylib.h
      RLAPI void SetMaterialTexture(Material *material, int mapType, Texture2D texture);
      ```
      """
      @doc group: :material_management
      @spec set_material_texture(
              material :: tuple,
              map_type :: integer,
              texture :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def set_material_texture(
            _material,
            _map_type,
            _texture,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set material for a mesh

      ```c
      // raylib.h
      RLAPI void SetModelMeshMaterial(Model *model, int meshId, int materialId);
      ```
      """
      @doc group: :material_management
      @spec set_model_mesh_material(
              model :: tuple,
              mesh_id :: integer,
              material_id :: integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def set_model_mesh_material(
            _model,
            _mesh_id,
            _material_id,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      #####################
      #  Model animation  #
      #####################

      @doc """
      Load model animations from file

      ```c
      // raylib.h
      RLAPI ModelAnimation *LoadModelAnimations(const char *fileName, int *animCount);
      ```
      """
      @doc group: :model_animation
      @spec load_model_animations(
              file_name :: binary,
              return :: :auto | :value | :resource
            ) :: [tuple]
      def load_model_animations(
            _file_name,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Update model animation pose (CPU)

      ```c
      // raylib.h
      RLAPI void UpdateModelAnimation(Model model, ModelAnimation anim, int frame);
      ```
      """
      @doc group: :model_animation
      @spec update_model_animation(
              model :: tuple,
              anim :: tuple,
              frame :: integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def update_model_animation(
            _model,
            _anim,
            _frame,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Update model animation mesh bone matrices (GPU skinning)

      ```c
      // raylib.h
      RLAPI void UpdateModelAnimationBones(Model model, ModelAnimation anim, int frame);
      ```
      """
      @doc group: :model_animation
      @spec update_model_animation_bones(
              model :: tuple,
              anim :: tuple,
              frame :: integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def update_model_animation_bones(
            _model,
            _anim,
            _frame,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check model animation skeleton match

      ```c
      // raylib.h
      RLAPI bool IsModelAnimationValid(Model model, ModelAnimation anim);
      ```
      """
      @doc group: :model_animation
      @spec is_model_animation_valid(
              model :: tuple,
              anim :: tuple
            ) :: boolean
      def is_model_animation_valid(
            _model,
            _anim
          ),
          do: :erlang.nif_error(:undef)

      #########################
      #  Collision detection  #
      #########################

      @doc """
      Check collision between two spheres

      ```c
      // raylib.h
      RLAPI bool CheckCollisionSpheres(Vector3 center1, float radius1, Vector3 center2, float radius2);
      ```
      """
      @doc group: :collision_detection
      @spec check_collision_spheres(
              center1 :: tuple,
              radius1 :: float,
              center2 :: tuple,
              radius2 :: float
            ) :: boolean
      def check_collision_spheres(
            _center1,
            _radius1,
            _center2,
            _radius2
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check collision between two bounding boxes

      ```c
      // raylib.h
      RLAPI bool CheckCollisionBoxes(BoundingBox box1, BoundingBox box2);
      ```
      """
      @doc group: :collision_detection
      @spec check_collision_boxes(
              box1 :: tuple,
              box2 :: tuple
            ) :: boolean
      def check_collision_boxes(
            _box1,
            _box2
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check collision between box and sphere

      ```c
      // raylib.h
      RLAPI bool CheckCollisionBoxSphere(BoundingBox box, Vector3 center, float radius);
      ```
      """
      @doc group: :collision_detection
      @spec check_collision_box_sphere(
              box :: tuple,
              center :: tuple,
              radius :: float
            ) :: boolean
      def check_collision_box_sphere(
            _box,
            _center,
            _radius
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get collision info between ray and sphere

      ```c
      // raylib.h
      RLAPI RayCollision GetRayCollisionSphere(Ray ray, Vector3 center, float radius);
      ```
      """
      @doc group: :collision_detection
      @spec get_ray_collision_sphere(
              ray :: tuple,
              center :: tuple,
              radius :: float,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_ray_collision_sphere(
            _ray,
            _center,
            _radius,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get collision info between ray and box

      ```c
      // raylib.h
      RLAPI RayCollision GetRayCollisionBox(Ray ray, BoundingBox box);
      ```
      """
      @doc group: :collision_detection
      @spec get_ray_collision_box(
              ray :: tuple,
              box :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_ray_collision_box(
            _ray,
            _box,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get collision info between ray and mesh

      ```c
      // raylib.h
      RLAPI RayCollision GetRayCollisionMesh(Ray ray, Mesh mesh, Matrix transform);
      ```
      """
      @doc group: :collision_detection
      @spec get_ray_collision_mesh(
              ray :: tuple,
              mesh :: tuple,
              transform :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_ray_collision_mesh(
            _ray,
            _mesh,
            _transform,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get collision info between ray and triangle

      ```c
      // raylib.h
      RLAPI RayCollision GetRayCollisionTriangle(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3);
      ```
      """
      @doc group: :collision_detection
      @spec get_ray_collision_triangle(
              ray :: tuple,
              p1 :: tuple,
              p2 :: tuple,
              p3 :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_ray_collision_triangle(
            _ray,
            _p1,
            _p2,
            _p3,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get collision info between ray and quad

      ```c
      // raylib.h
      RLAPI RayCollision GetRayCollisionQuad(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4);
      ```
      """
      @doc group: :collision_detection
      @spec get_ray_collision_quad(
              ray :: tuple,
              p1 :: tuple,
              p2 :: tuple,
              p3 :: tuple,
              p4 :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_ray_collision_quad(
            _ray,
            _p1,
            _p2,
            _p3,
            _p4,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)
    end
  end
end
