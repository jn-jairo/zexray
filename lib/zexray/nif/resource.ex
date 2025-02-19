defmodule Zexray.NIF.Resource do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_resource [
        # Vector2
        vector2_to_resource: 1,
        vector2_from_resource: 1,
        vector2_free_resource: 1,

        # Vector3
        vector3_to_resource: 1,
        vector3_from_resource: 1,
        vector3_free_resource: 1,

        # Vector4
        vector4_to_resource: 1,
        vector4_from_resource: 1,
        vector4_free_resource: 1,

        # Quaternion
        quaternion_to_resource: 1,
        quaternion_from_resource: 1,
        quaternion_free_resource: 1,

        # Matrix
        matrix_to_resource: 1,
        matrix_from_resource: 1,
        matrix_free_resource: 1,

        # Color
        color_to_resource: 1,
        color_from_resource: 1,
        color_free_resource: 1,

        # Rectangle
        rectangle_to_resource: 1,
        rectangle_from_resource: 1,
        rectangle_free_resource: 1,

        # Image
        image_to_resource: 1,
        image_from_resource: 1,
        image_free_resource: 1,

        # Texture
        texture_to_resource: 1,
        texture_from_resource: 1,
        texture_free_resource: 1,

        # Texture2D
        texture_2d_to_resource: 1,
        texture_2d_from_resource: 1,
        texture_2d_free_resource: 1,

        # TextureCubemap
        texture_cubemap_to_resource: 1,
        texture_cubemap_from_resource: 1,
        texture_cubemap_free_resource: 1,

        # RenderTexture
        render_texture_to_resource: 1,
        render_texture_from_resource: 1,
        render_texture_free_resource: 1,

        # RenderTexture2D
        render_texture_2d_to_resource: 1,
        render_texture_2d_from_resource: 1,
        render_texture_2d_free_resource: 1,

        # NPatchInfo
        n_patch_info_to_resource: 1,
        n_patch_info_from_resource: 1,
        n_patch_info_free_resource: 1,

        # GlyphInfo
        glyph_info_to_resource: 1,
        glyph_info_from_resource: 1,
        glyph_info_free_resource: 1,

        # Font
        font_to_resource: 1,
        font_from_resource: 1,
        font_free_resource: 1,

        # Camera3D
        camera_3d_to_resource: 1,
        camera_3d_from_resource: 1,
        camera_3d_free_resource: 1,

        # Camera
        camera_to_resource: 1,
        camera_from_resource: 1,
        camera_free_resource: 1,

        # Camera2D
        camera_2d_to_resource: 1,
        camera_2d_from_resource: 1,
        camera_2d_free_resource: 1,

        # Mesh
        mesh_to_resource: 1,
        mesh_from_resource: 1,
        mesh_free_resource: 1,

        # Shader
        shader_to_resource: 1,
        shader_from_resource: 1,
        shader_free_resource: 1,

        # MaterialMap
        material_map_to_resource: 1,
        material_map_from_resource: 1,
        material_map_free_resource: 1,

        # Material
        material_to_resource: 1,
        material_from_resource: 1,
        material_free_resource: 1,

        # Transform
        transform_to_resource: 1,
        transform_from_resource: 1,
        transform_free_resource: 1,

        # BoneInfo
        bone_info_to_resource: 1,
        bone_info_from_resource: 1,
        bone_info_free_resource: 1,

        # Model
        model_to_resource: 1,
        model_from_resource: 1,
        model_free_resource: 1,

        # ModelAnimation
        model_animation_to_resource: 1,
        model_animation_from_resource: 1,
        model_animation_free_resource: 1,

        # Ray
        ray_to_resource: 1,
        ray_from_resource: 1,
        ray_free_resource: 1,

        # RayCollision
        ray_collision_to_resource: 1,
        ray_collision_from_resource: 1,
        ray_collision_free_resource: 1
      ]

      #############
      #  Vector2  #
      #############

      @doc group: :resource
      @spec vector2_to_resource(value :: map) :: reference
      def vector2_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vector2_from_resource(resource :: reference) :: map
      def vector2_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vector2_free_resource(resource :: reference) :: :ok
      def vector2_free_resource(_resource), do: :erlang.nif_error(:undef)

      #############
      #  Vector3  #
      #############

      @doc group: :resource
      @spec vector3_to_resource(value :: map) :: reference
      def vector3_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vector3_from_resource(resource :: reference) :: map
      def vector3_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vector3_free_resource(resource :: reference) :: :ok
      def vector3_free_resource(_resource), do: :erlang.nif_error(:undef)

      #############
      #  Vector4  #
      #############

      @doc group: :resource
      @spec vector4_to_resource(value :: map) :: reference
      def vector4_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vector4_from_resource(resource :: reference) :: map
      def vector4_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vector4_free_resource(resource :: reference) :: :ok
      def vector4_free_resource(_resource), do: :erlang.nif_error(:undef)

      ################
      #  Quaternion  #
      ################

      @doc group: :resource
      @spec quaternion_to_resource(value :: map) :: reference
      def quaternion_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec quaternion_from_resource(resource :: reference) :: map
      def quaternion_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec quaternion_free_resource(resource :: reference) :: :ok
      def quaternion_free_resource(_resource), do: :erlang.nif_error(:undef)

      ############
      #  Matrix  #
      ############

      @doc group: :resource
      @spec matrix_to_resource(value :: map) :: reference
      def matrix_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec matrix_from_resource(resource :: reference) :: map
      def matrix_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec matrix_free_resource(resource :: reference) :: :ok
      def matrix_free_resource(_resource), do: :erlang.nif_error(:undef)

      ###########
      #  Color  #
      ###########

      @doc group: :resource
      @spec color_to_resource(value :: map) :: reference
      def color_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec color_from_resource(resource :: reference) :: map
      def color_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec color_free_resource(resource :: reference) :: :ok
      def color_free_resource(_resource), do: :erlang.nif_error(:undef)

      ###############
      #  Rectangle  #
      ###############

      @doc group: :resource
      @spec rectangle_to_resource(value :: map) :: reference
      def rectangle_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec rectangle_from_resource(resource :: reference) :: map
      def rectangle_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec rectangle_free_resource(resource :: reference) :: :ok
      def rectangle_free_resource(_resource), do: :erlang.nif_error(:undef)

      ###########
      #  Image  #
      ###########

      @doc group: :resource
      @spec image_to_resource(value :: map) :: reference
      def image_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec image_from_resource(resource :: reference) :: map
      def image_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec image_free_resource(resource :: reference) :: :ok
      def image_free_resource(_resource), do: :erlang.nif_error(:undef)

      #############
      #  Texture  #
      #############

      @doc group: :resource
      @spec texture_to_resource(value :: map) :: reference
      def texture_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec texture_from_resource(resource :: reference) :: map
      def texture_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec texture_free_resource(resource :: reference) :: :ok
      def texture_free_resource(_resource), do: :erlang.nif_error(:undef)

      ###############
      #  Texture2D  #
      ###############

      @doc group: :resource
      @spec texture_2d_to_resource(value :: map) :: reference
      def texture_2d_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec texture_2d_from_resource(resource :: reference) :: map
      def texture_2d_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec texture_2d_free_resource(resource :: reference) :: :ok
      def texture_2d_free_resource(_resource), do: :erlang.nif_error(:undef)

      ####################
      #  TextureCubemap  #
      ####################

      @doc group: :resource
      @spec texture_cubemap_to_resource(value :: map) :: reference
      def texture_cubemap_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec texture_cubemap_from_resource(resource :: reference) :: map
      def texture_cubemap_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec texture_cubemap_free_resource(resource :: reference) :: :ok
      def texture_cubemap_free_resource(_resource), do: :erlang.nif_error(:undef)

      ###################
      #  RenderTexture  #
      ###################

      @doc group: :resource
      @spec render_texture_to_resource(value :: map) :: reference
      def render_texture_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec render_texture_from_resource(resource :: reference) :: map
      def render_texture_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec render_texture_free_resource(resource :: reference) :: :ok
      def render_texture_free_resource(_resource), do: :erlang.nif_error(:undef)

      #####################
      #  RenderTexture2D  #
      #####################

      @doc group: :resource
      @spec render_texture_2d_to_resource(value :: map) :: reference
      def render_texture_2d_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec render_texture_2d_from_resource(resource :: reference) :: map
      def render_texture_2d_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec render_texture_2d_free_resource(resource :: reference) :: :ok
      def render_texture_2d_free_resource(_resource), do: :erlang.nif_error(:undef)

      ################
      #  NPatchInfo  #
      ################

      @doc group: :resource
      @spec n_patch_info_to_resource(value :: map) :: reference
      def n_patch_info_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec n_patch_info_from_resource(resource :: reference) :: map
      def n_patch_info_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec n_patch_info_free_resource(resource :: reference) :: :ok
      def n_patch_info_free_resource(_resource), do: :erlang.nif_error(:undef)

      ###############
      #  GlyphInfo  #
      ###############

      @doc group: :resource
      @spec glyph_info_to_resource(value :: map) :: reference
      def glyph_info_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec glyph_info_from_resource(resource :: reference) :: map
      def glyph_info_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec glyph_info_free_resource(resource :: reference) :: :ok
      def glyph_info_free_resource(_resource), do: :erlang.nif_error(:undef)

      ##########
      #  Font  #
      ##########

      @doc group: :resource
      @spec font_to_resource(value :: map) :: reference
      def font_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec font_from_resource(resource :: reference) :: map
      def font_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec font_free_resource(resource :: reference) :: :ok
      def font_free_resource(_resource), do: :erlang.nif_error(:undef)

      ##############
      #  Camera3D  #
      ##############

      @doc group: :resource
      @spec camera_3d_to_resource(value :: map) :: reference
      def camera_3d_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec camera_3d_from_resource(resource :: reference) :: map
      def camera_3d_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec camera_3d_free_resource(resource :: reference) :: :ok
      def camera_3d_free_resource(_resource), do: :erlang.nif_error(:undef)

      ############
      #  Camera  #
      ############

      @doc group: :resource
      @spec camera_to_resource(value :: map) :: reference
      def camera_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec camera_from_resource(resource :: reference) :: map
      def camera_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec camera_free_resource(resource :: reference) :: :ok
      def camera_free_resource(_resource), do: :erlang.nif_error(:undef)

      ##############
      #  Camera2D  #
      ##############

      @doc group: :resource
      @spec camera_2d_to_resource(value :: map) :: reference
      def camera_2d_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec camera_2d_from_resource(resource :: reference) :: map
      def camera_2d_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec camera_2d_free_resource(resource :: reference) :: :ok
      def camera_2d_free_resource(_resource), do: :erlang.nif_error(:undef)

      ##########
      #  Mesh  #
      ##########

      @doc group: :resource
      @spec mesh_to_resource(value :: map) :: reference
      def mesh_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec mesh_from_resource(resource :: reference) :: map
      def mesh_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec mesh_free_resource(resource :: reference) :: :ok
      def mesh_free_resource(_resource), do: :erlang.nif_error(:undef)

      ############
      #  Shader  #
      ############

      @doc group: :resource
      @spec shader_to_resource(value :: map) :: reference
      def shader_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec shader_from_resource(resource :: reference) :: map
      def shader_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec shader_free_resource(resource :: reference) :: :ok
      def shader_free_resource(_resource), do: :erlang.nif_error(:undef)

      #################
      #  MaterialMap  #
      #################

      @doc group: :resource
      @spec material_map_to_resource(value :: map) :: reference
      def material_map_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec material_map_from_resource(resource :: reference) :: map
      def material_map_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec material_map_free_resource(resource :: reference) :: :ok
      def material_map_free_resource(_resource), do: :erlang.nif_error(:undef)

      ##############
      #  Material  #
      ##############

      @doc group: :resource
      @spec material_to_resource(value :: map) :: reference
      def material_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec material_from_resource(resource :: reference) :: map
      def material_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec material_free_resource(resource :: reference) :: :ok
      def material_free_resource(_resource), do: :erlang.nif_error(:undef)

      ###############
      #  Transform  #
      ###############

      @doc group: :resource
      @spec transform_to_resource(value :: map) :: reference
      def transform_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec transform_from_resource(resource :: reference) :: map
      def transform_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec transform_free_resource(resource :: reference) :: :ok
      def transform_free_resource(_resource), do: :erlang.nif_error(:undef)

      ##############
      #  BoneInfo  #
      ##############

      @doc group: :resource
      @spec bone_info_to_resource(value :: map) :: reference
      def bone_info_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec bone_info_from_resource(resource :: reference) :: map
      def bone_info_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec bone_info_free_resource(resource :: reference) :: :ok
      def bone_info_free_resource(_resource), do: :erlang.nif_error(:undef)

      ###########
      #  Model  #
      ###########

      @doc group: :resource
      @spec model_to_resource(value :: map) :: reference
      def model_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec model_from_resource(resource :: reference) :: map
      def model_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec model_free_resource(resource :: reference) :: :ok
      def model_free_resource(_resource), do: :erlang.nif_error(:undef)

      ####################
      #  ModelAnimation  #
      ####################

      @doc group: :resource
      @spec model_animation_to_resource(value :: map) :: reference
      def model_animation_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec model_animation_from_resource(resource :: reference) :: map
      def model_animation_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec model_animation_free_resource(resource :: reference) :: :ok
      def model_animation_free_resource(_resource), do: :erlang.nif_error(:undef)

      #########
      #  Ray  #
      #########

      @doc group: :resource
      @spec ray_to_resource(value :: map) :: reference
      def ray_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec ray_from_resource(resource :: reference) :: map
      def ray_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec ray_free_resource(resource :: reference) :: :ok
      def ray_free_resource(_resource), do: :erlang.nif_error(:undef)

      ##################
      #  RayCollision  #
      ##################

      @doc group: :resource
      @spec ray_collision_to_resource(value :: map) :: reference
      def ray_collision_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec ray_collision_from_resource(resource :: reference) :: map
      def ray_collision_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec ray_collision_free_resource(resource :: reference) :: :ok
      def ray_collision_free_resource(_resource), do: :erlang.nif_error(:undef)
    end
  end
end
