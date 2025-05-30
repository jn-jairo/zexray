defmodule Zexray.NIF.Resource do
  @moduledoc false
  defmacro __using__(_opts) do
    quote do
      @nifs_resource [
        # Vector2
        vector2_to_resource: 1,
        vector2_from_resource: 1,
        vector2_free_resource: 1,
        vector2_update_resource: 2,

        # IVector2
        ivector2_to_resource: 1,
        ivector2_from_resource: 1,
        ivector2_free_resource: 1,
        ivector2_update_resource: 2,

        # UIVector2
        uivector2_to_resource: 1,
        uivector2_from_resource: 1,
        uivector2_free_resource: 1,
        uivector2_update_resource: 2,

        # Vector3
        vector3_to_resource: 1,
        vector3_from_resource: 1,
        vector3_free_resource: 1,
        vector3_update_resource: 2,

        # IVector3
        ivector3_to_resource: 1,
        ivector3_from_resource: 1,
        ivector3_free_resource: 1,
        ivector3_update_resource: 2,

        # UIVector3
        uivector3_to_resource: 1,
        uivector3_from_resource: 1,
        uivector3_free_resource: 1,
        uivector3_update_resource: 2,

        # Vector4
        vector4_to_resource: 1,
        vector4_from_resource: 1,
        vector4_free_resource: 1,
        vector4_update_resource: 2,

        # IVector4
        ivector4_to_resource: 1,
        ivector4_from_resource: 1,
        ivector4_free_resource: 1,
        ivector4_update_resource: 2,

        # UIVector4
        uivector4_to_resource: 1,
        uivector4_from_resource: 1,
        uivector4_free_resource: 1,
        uivector4_update_resource: 2,

        # Quaternion
        quaternion_to_resource: 1,
        quaternion_from_resource: 1,
        quaternion_free_resource: 1,
        quaternion_update_resource: 2,

        # Matrix
        matrix_to_resource: 1,
        matrix_from_resource: 1,
        matrix_free_resource: 1,
        matrix_update_resource: 2,

        # Color
        color_to_resource: 1,
        color_from_resource: 1,
        color_free_resource: 1,
        color_update_resource: 2,

        # Rectangle
        rectangle_to_resource: 1,
        rectangle_from_resource: 1,
        rectangle_free_resource: 1,
        rectangle_update_resource: 2,

        # Image
        image_to_resource: 1,
        image_from_resource: 1,
        image_free_resource: 1,
        image_update_resource: 2,

        # Texture
        texture_to_resource: 1,
        texture_from_resource: 1,
        texture_free_resource: 1,
        texture_update_resource: 2,

        # Texture2D
        texture_2d_to_resource: 1,
        texture_2d_from_resource: 1,
        texture_2d_free_resource: 1,
        texture_2d_update_resource: 2,

        # TextureCubemap
        texture_cubemap_to_resource: 1,
        texture_cubemap_from_resource: 1,
        texture_cubemap_free_resource: 1,
        texture_cubemap_update_resource: 2,

        # RenderTexture
        render_texture_to_resource: 1,
        render_texture_from_resource: 1,
        render_texture_free_resource: 1,
        render_texture_update_resource: 2,

        # RenderTexture2D
        render_texture_2d_to_resource: 1,
        render_texture_2d_from_resource: 1,
        render_texture_2d_free_resource: 1,
        render_texture_2d_update_resource: 2,

        # NPatchInfo
        n_patch_info_to_resource: 1,
        n_patch_info_from_resource: 1,
        n_patch_info_free_resource: 1,
        n_patch_info_update_resource: 2,

        # GlyphInfo
        glyph_info_to_resource: 1,
        glyph_info_from_resource: 1,
        glyph_info_free_resource: 1,
        glyph_info_update_resource: 2,

        # Font
        font_to_resource: 1,
        font_from_resource: 1,
        font_free_resource: 1,
        font_update_resource: 2,

        # Camera3D
        camera_3d_to_resource: 1,
        camera_3d_from_resource: 1,
        camera_3d_free_resource: 1,
        camera_3d_update_resource: 2,

        # Camera
        camera_to_resource: 1,
        camera_from_resource: 1,
        camera_free_resource: 1,
        camera_update_resource: 2,

        # Camera2D
        camera_2d_to_resource: 1,
        camera_2d_from_resource: 1,
        camera_2d_free_resource: 1,
        camera_2d_update_resource: 2,

        # Mesh
        mesh_to_resource: 1,
        mesh_from_resource: 1,
        mesh_free_resource: 1,
        mesh_update_resource: 2,

        # Shader
        shader_to_resource: 1,
        shader_from_resource: 1,
        shader_free_resource: 1,
        shader_update_resource: 2,

        # MaterialMap
        material_map_to_resource: 1,
        material_map_from_resource: 1,
        material_map_free_resource: 1,
        material_map_update_resource: 2,

        # Material
        material_to_resource: 1,
        material_from_resource: 1,
        material_free_resource: 1,
        material_update_resource: 2,

        # Transform
        transform_to_resource: 1,
        transform_from_resource: 1,
        transform_free_resource: 1,
        transform_update_resource: 2,

        # BoneInfo
        bone_info_to_resource: 1,
        bone_info_from_resource: 1,
        bone_info_free_resource: 1,
        bone_info_update_resource: 2,

        # Model
        model_to_resource: 1,
        model_from_resource: 1,
        model_free_resource: 1,
        model_update_resource: 2,

        # ModelAnimation
        model_animation_to_resource: 1,
        model_animation_from_resource: 1,
        model_animation_free_resource: 1,
        model_animation_update_resource: 2,

        # Ray
        ray_to_resource: 1,
        ray_from_resource: 1,
        ray_free_resource: 1,
        ray_update_resource: 2,

        # RayCollision
        ray_collision_to_resource: 1,
        ray_collision_from_resource: 1,
        ray_collision_free_resource: 1,
        ray_collision_update_resource: 2,

        # BoundingBox
        bounding_box_to_resource: 1,
        bounding_box_from_resource: 1,
        bounding_box_free_resource: 1,
        bounding_box_update_resource: 2,

        # Wave
        wave_to_resource: 1,
        wave_from_resource: 1,
        wave_free_resource: 1,
        wave_update_resource: 2,

        # AudioStream
        audio_stream_to_resource: 1,
        audio_stream_from_resource: 1,
        audio_stream_free_resource: 1,
        audio_stream_update_resource: 2,

        # Sound
        sound_to_resource: 1,
        sound_from_resource: 1,
        sound_free_resource: 1,
        sound_update_resource: 2,

        # SoundAlias
        sound_alias_to_resource: 1,
        sound_alias_from_resource: 1,
        sound_alias_free_resource: 1,
        sound_alias_update_resource: 2,

        # Music
        music_to_resource: 1,
        music_from_resource: 1,
        music_free_resource: 1,
        music_update_resource: 2,

        # VrDeviceInfo
        vr_device_info_to_resource: 1,
        vr_device_info_from_resource: 1,
        vr_device_info_free_resource: 1,
        vr_device_info_update_resource: 2,

        # VrStereoConfig
        vr_stereo_config_to_resource: 1,
        vr_stereo_config_from_resource: 1,
        vr_stereo_config_free_resource: 1,
        vr_stereo_config_update_resource: 2,

        # FilePathList
        file_path_list_to_resource: 1,
        file_path_list_from_resource: 1,
        file_path_list_free_resource: 1,
        file_path_list_update_resource: 2,

        # AutomationEvent
        automation_event_to_resource: 1,
        automation_event_from_resource: 1,
        automation_event_free_resource: 1,
        automation_event_update_resource: 2,

        # AutomationEventList
        automation_event_list_to_resource: 1,
        automation_event_list_from_resource: 1,
        automation_event_list_free_resource: 1,
        automation_event_list_update_resource: 2
      ]

      #############
      #  Vector2  #
      #############

      @doc group: :resource
      @spec vector2_to_resource(value :: tuple) :: tuple
      def vector2_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vector2_from_resource(resource :: tuple) :: tuple
      def vector2_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vector2_free_resource(resource :: tuple) :: :ok
      def vector2_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vector2_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def vector2_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ##############
      #  IVector2  #
      ##############

      @doc group: :resource
      @spec ivector2_to_resource(value :: tuple) :: tuple
      def ivector2_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec ivector2_from_resource(resource :: tuple) :: tuple
      def ivector2_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec ivector2_free_resource(resource :: tuple) :: :ok
      def ivector2_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec ivector2_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def ivector2_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ###############
      #  UIVector2  #
      ###############

      @doc group: :resource
      @spec uivector2_to_resource(value :: tuple) :: tuple
      def uivector2_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec uivector2_from_resource(resource :: tuple) :: tuple
      def uivector2_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec uivector2_free_resource(resource :: tuple) :: :ok
      def uivector2_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec uivector2_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def uivector2_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      #############
      #  Vector3  #
      #############

      @doc group: :resource
      @spec vector3_to_resource(value :: tuple) :: tuple
      def vector3_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vector3_from_resource(resource :: tuple) :: tuple
      def vector3_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vector3_free_resource(resource :: tuple) :: :ok
      def vector3_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vector3_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def vector3_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ##############
      #  IVector3  #
      ##############

      @doc group: :resource
      @spec ivector3_to_resource(value :: tuple) :: tuple
      def ivector3_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec ivector3_from_resource(resource :: tuple) :: tuple
      def ivector3_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec ivector3_free_resource(resource :: tuple) :: :ok
      def ivector3_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec ivector3_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def ivector3_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ###############
      #  UIVector3  #
      ###############

      @doc group: :resource
      @spec uivector3_to_resource(value :: tuple) :: tuple
      def uivector3_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec uivector3_from_resource(resource :: tuple) :: tuple
      def uivector3_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec uivector3_free_resource(resource :: tuple) :: :ok
      def uivector3_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec uivector3_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def uivector3_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      #############
      #  Vector4  #
      #############

      @doc group: :resource
      @spec vector4_to_resource(value :: tuple) :: tuple
      def vector4_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vector4_from_resource(resource :: tuple) :: tuple
      def vector4_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vector4_free_resource(resource :: tuple) :: :ok
      def vector4_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vector4_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def vector4_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ##############
      #  IVector4  #
      ##############

      @doc group: :resource
      @spec ivector4_to_resource(value :: tuple) :: tuple
      def ivector4_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec ivector4_from_resource(resource :: tuple) :: tuple
      def ivector4_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec ivector4_free_resource(resource :: tuple) :: :ok
      def ivector4_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec ivector4_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def ivector4_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ###############
      #  UIVector4  #
      ###############

      @doc group: :resource
      @spec uivector4_to_resource(value :: tuple) :: tuple
      def uivector4_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec uivector4_from_resource(resource :: tuple) :: tuple
      def uivector4_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec uivector4_free_resource(resource :: tuple) :: :ok
      def uivector4_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec uivector4_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def uivector4_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ################
      #  Quaternion  #
      ################

      @doc group: :resource
      @spec quaternion_to_resource(value :: tuple) :: tuple
      def quaternion_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec quaternion_from_resource(resource :: tuple) :: tuple
      def quaternion_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec quaternion_free_resource(resource :: tuple) :: :ok
      def quaternion_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec quaternion_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def quaternion_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ############
      #  Matrix  #
      ############

      @doc group: :resource
      @spec matrix_to_resource(value :: tuple) :: tuple
      def matrix_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec matrix_from_resource(resource :: tuple) :: tuple
      def matrix_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec matrix_free_resource(resource :: tuple) :: :ok
      def matrix_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec matrix_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def matrix_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ###########
      #  Color  #
      ###########

      @doc group: :resource
      @spec color_to_resource(value :: tuple) :: tuple
      def color_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec color_from_resource(resource :: tuple) :: tuple
      def color_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec color_free_resource(resource :: tuple) :: :ok
      def color_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec color_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def color_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ###############
      #  Rectangle  #
      ###############

      @doc group: :resource
      @spec rectangle_to_resource(value :: tuple) :: tuple
      def rectangle_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec rectangle_from_resource(resource :: tuple) :: tuple
      def rectangle_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec rectangle_free_resource(resource :: tuple) :: :ok
      def rectangle_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec rectangle_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def rectangle_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ###########
      #  Image  #
      ###########

      @doc group: :resource
      @spec image_to_resource(value :: tuple) :: tuple
      def image_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec image_from_resource(resource :: tuple) :: tuple
      def image_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec image_free_resource(resource :: tuple) :: :ok
      def image_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec image_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def image_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      #############
      #  Texture  #
      #############

      @doc group: :resource
      @spec texture_to_resource(value :: tuple) :: tuple
      def texture_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec texture_from_resource(resource :: tuple) :: tuple
      def texture_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec texture_free_resource(resource :: tuple) :: :ok
      def texture_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec texture_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def texture_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ###############
      #  Texture2D  #
      ###############

      @doc group: :resource
      @spec texture_2d_to_resource(value :: tuple) :: tuple
      def texture_2d_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec texture_2d_from_resource(resource :: tuple) :: tuple
      def texture_2d_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec texture_2d_free_resource(resource :: tuple) :: :ok
      def texture_2d_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec texture_2d_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def texture_2d_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ####################
      #  TextureCubemap  #
      ####################

      @doc group: :resource
      @spec texture_cubemap_to_resource(value :: tuple) :: tuple
      def texture_cubemap_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec texture_cubemap_from_resource(resource :: tuple) :: tuple
      def texture_cubemap_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec texture_cubemap_free_resource(resource :: tuple) :: :ok
      def texture_cubemap_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec texture_cubemap_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def texture_cubemap_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ###################
      #  RenderTexture  #
      ###################

      @doc group: :resource
      @spec render_texture_to_resource(value :: tuple) :: tuple
      def render_texture_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec render_texture_from_resource(resource :: tuple) :: tuple
      def render_texture_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec render_texture_free_resource(resource :: tuple) :: :ok
      def render_texture_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec render_texture_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def render_texture_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      #####################
      #  RenderTexture2D  #
      #####################

      @doc group: :resource
      @spec render_texture_2d_to_resource(value :: tuple) :: tuple
      def render_texture_2d_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec render_texture_2d_from_resource(resource :: tuple) :: tuple
      def render_texture_2d_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec render_texture_2d_free_resource(resource :: tuple) :: :ok
      def render_texture_2d_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec render_texture_2d_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def render_texture_2d_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ################
      #  NPatchInfo  #
      ################

      @doc group: :resource
      @spec n_patch_info_to_resource(value :: tuple) :: tuple
      def n_patch_info_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec n_patch_info_from_resource(resource :: tuple) :: tuple
      def n_patch_info_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec n_patch_info_free_resource(resource :: tuple) :: :ok
      def n_patch_info_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec n_patch_info_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def n_patch_info_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ###############
      #  GlyphInfo  #
      ###############

      @doc group: :resource
      @spec glyph_info_to_resource(value :: tuple) :: tuple
      def glyph_info_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec glyph_info_from_resource(resource :: tuple) :: tuple
      def glyph_info_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec glyph_info_free_resource(resource :: tuple) :: :ok
      def glyph_info_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec glyph_info_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def glyph_info_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ##########
      #  Font  #
      ##########

      @doc group: :resource
      @spec font_to_resource(value :: tuple) :: tuple
      def font_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec font_from_resource(resource :: tuple) :: tuple
      def font_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec font_free_resource(resource :: tuple) :: :ok
      def font_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec font_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def font_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ##############
      #  Camera3D  #
      ##############

      @doc group: :resource
      @spec camera_3d_to_resource(value :: tuple) :: tuple
      def camera_3d_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec camera_3d_from_resource(resource :: tuple) :: tuple
      def camera_3d_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec camera_3d_free_resource(resource :: tuple) :: :ok
      def camera_3d_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec camera_3d_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def camera_3d_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ############
      #  Camera  #
      ############

      @doc group: :resource
      @spec camera_to_resource(value :: tuple) :: tuple
      def camera_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec camera_from_resource(resource :: tuple) :: tuple
      def camera_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec camera_free_resource(resource :: tuple) :: :ok
      def camera_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec camera_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def camera_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ##############
      #  Camera2D  #
      ##############

      @doc group: :resource
      @spec camera_2d_to_resource(value :: tuple) :: tuple
      def camera_2d_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec camera_2d_from_resource(resource :: tuple) :: tuple
      def camera_2d_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec camera_2d_free_resource(resource :: tuple) :: :ok
      def camera_2d_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec camera_2d_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def camera_2d_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ##########
      #  Mesh  #
      ##########

      @doc group: :resource
      @spec mesh_to_resource(value :: tuple) :: tuple
      def mesh_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec mesh_from_resource(resource :: tuple) :: tuple
      def mesh_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec mesh_free_resource(resource :: tuple) :: :ok
      def mesh_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec mesh_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def mesh_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ############
      #  Shader  #
      ############

      @doc group: :resource
      @spec shader_to_resource(value :: tuple) :: tuple
      def shader_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec shader_from_resource(resource :: tuple) :: tuple
      def shader_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec shader_free_resource(resource :: tuple) :: :ok
      def shader_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec shader_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def shader_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      #################
      #  MaterialMap  #
      #################

      @doc group: :resource
      @spec material_map_to_resource(value :: tuple) :: tuple
      def material_map_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec material_map_from_resource(resource :: tuple) :: tuple
      def material_map_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec material_map_free_resource(resource :: tuple) :: :ok
      def material_map_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec material_map_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def material_map_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ##############
      #  Material  #
      ##############

      @doc group: :resource
      @spec material_to_resource(value :: tuple) :: tuple
      def material_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec material_from_resource(resource :: tuple) :: tuple
      def material_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec material_free_resource(resource :: tuple) :: :ok
      def material_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec material_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def material_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ###############
      #  Transform  #
      ###############

      @doc group: :resource
      @spec transform_to_resource(value :: tuple) :: tuple
      def transform_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec transform_from_resource(resource :: tuple) :: tuple
      def transform_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec transform_free_resource(resource :: tuple) :: :ok
      def transform_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec transform_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def transform_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ##############
      #  BoneInfo  #
      ##############

      @doc group: :resource
      @spec bone_info_to_resource(value :: tuple) :: tuple
      def bone_info_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec bone_info_from_resource(resource :: tuple) :: tuple
      def bone_info_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec bone_info_free_resource(resource :: tuple) :: :ok
      def bone_info_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec bone_info_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def bone_info_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ###########
      #  Model  #
      ###########

      @doc group: :resource
      @spec model_to_resource(value :: tuple) :: tuple
      def model_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec model_from_resource(resource :: tuple) :: tuple
      def model_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec model_free_resource(resource :: tuple) :: :ok
      def model_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec model_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def model_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ####################
      #  ModelAnimation  #
      ####################

      @doc group: :resource
      @spec model_animation_to_resource(value :: tuple) :: tuple
      def model_animation_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec model_animation_from_resource(resource :: tuple) :: tuple
      def model_animation_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec model_animation_free_resource(resource :: tuple) :: :ok
      def model_animation_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec model_animation_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def model_animation_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      #########
      #  Ray  #
      #########

      @doc group: :resource
      @spec ray_to_resource(value :: tuple) :: tuple
      def ray_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec ray_from_resource(resource :: tuple) :: tuple
      def ray_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec ray_free_resource(resource :: tuple) :: :ok
      def ray_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec ray_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def ray_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ##################
      #  RayCollision  #
      ##################

      @doc group: :resource
      @spec ray_collision_to_resource(value :: tuple) :: tuple
      def ray_collision_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec ray_collision_from_resource(resource :: tuple) :: tuple
      def ray_collision_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec ray_collision_free_resource(resource :: tuple) :: :ok
      def ray_collision_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec ray_collision_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def ray_collision_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      #################
      #  BoundingBox  #
      #################

      @doc group: :resource
      @spec bounding_box_to_resource(value :: tuple) :: tuple
      def bounding_box_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec bounding_box_from_resource(resource :: tuple) :: tuple
      def bounding_box_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec bounding_box_free_resource(resource :: tuple) :: :ok
      def bounding_box_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec bounding_box_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def bounding_box_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ##########
      #  Wave  #
      ##########

      @doc group: :resource
      @spec wave_to_resource(value :: tuple) :: tuple
      def wave_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec wave_from_resource(resource :: tuple) :: tuple
      def wave_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec wave_free_resource(resource :: tuple) :: :ok
      def wave_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec wave_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def wave_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      #################
      #  AudioStream  #
      #################

      @doc group: :resource
      @spec audio_stream_to_resource(value :: tuple) :: tuple
      def audio_stream_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec audio_stream_from_resource(resource :: tuple) :: tuple
      def audio_stream_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec audio_stream_free_resource(resource :: tuple) :: :ok
      def audio_stream_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec audio_stream_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def audio_stream_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ###########
      #  Sound  #
      ###########

      @doc group: :resource
      @spec sound_to_resource(value :: tuple) :: tuple
      def sound_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec sound_from_resource(resource :: tuple) :: tuple
      def sound_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec sound_free_resource(resource :: tuple) :: :ok
      def sound_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec sound_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def sound_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ################
      #  SoundAlias  #
      ################

      @doc group: :resource
      @spec sound_alias_to_resource(value :: tuple) :: tuple
      def sound_alias_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec sound_alias_from_resource(resource :: tuple) :: tuple
      def sound_alias_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec sound_alias_free_resource(resource :: tuple) :: :ok
      def sound_alias_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec sound_alias_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def sound_alias_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ###########
      #  Music  #
      ###########

      @doc group: :resource
      @spec music_to_resource(value :: tuple) :: tuple
      def music_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec music_from_resource(resource :: tuple) :: tuple
      def music_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec music_free_resource(resource :: tuple) :: :ok
      def music_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec music_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def music_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ##################
      #  VrDeviceInfo  #
      ##################

      @doc group: :resource
      @spec vr_device_info_to_resource(value :: tuple) :: tuple
      def vr_device_info_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vr_device_info_from_resource(resource :: tuple) :: tuple
      def vr_device_info_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vr_device_info_free_resource(resource :: tuple) :: :ok
      def vr_device_info_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vr_device_info_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def vr_device_info_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ####################
      #  VrStereoConfig  #
      ####################

      @doc group: :resource
      @spec vr_stereo_config_to_resource(value :: tuple) :: tuple
      def vr_stereo_config_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vr_stereo_config_from_resource(resource :: tuple) :: tuple
      def vr_stereo_config_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vr_stereo_config_free_resource(resource :: tuple) :: :ok
      def vr_stereo_config_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec vr_stereo_config_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def vr_stereo_config_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      ##################
      #  FilePathList  #
      ##################

      @doc group: :resource
      @spec file_path_list_to_resource(value :: tuple) :: tuple
      def file_path_list_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec file_path_list_from_resource(resource :: tuple) :: tuple
      def file_path_list_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec file_path_list_free_resource(resource :: tuple) :: :ok
      def file_path_list_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec file_path_list_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def file_path_list_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      #####################
      #  AutomationEvent  #
      #####################

      @doc group: :resource
      @spec automation_event_to_resource(value :: tuple) :: tuple
      def automation_event_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec automation_event_from_resource(resource :: tuple) :: tuple
      def automation_event_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec automation_event_free_resource(resource :: tuple) :: :ok
      def automation_event_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec automation_event_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def automation_event_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)

      #########################
      #  AutomationEventList  #
      #########################

      @doc group: :resource
      @spec automation_event_list_to_resource(value :: tuple) :: tuple
      def automation_event_list_to_resource(_value), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec automation_event_list_from_resource(resource :: tuple) :: tuple
      def automation_event_list_from_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec automation_event_list_free_resource(resource :: tuple) :: :ok
      def automation_event_list_free_resource(_resource), do: :erlang.nif_error(:undef)

      @doc group: :resource
      @spec automation_event_list_update_resource(
              resource :: tuple,
              value :: tuple
            ) :: :ok
      def automation_event_list_update_resource(
            _resource,
            _value
          ),
          do: :erlang.nif_error(:undef)
    end
  end
end
