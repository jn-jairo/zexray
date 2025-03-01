defmodule Zexray.Guard do
  @moduledoc """
  Guards
  """

  alias Zexray.Type.{
    AudioStream,
    AutomationEvent,
    AutomationEventList,
    BoneInfo,
    BoundingBox,
    Camera,
    Camera2D,
    Camera3D,
    Color,
    FilePathList,
    Font,
    GlyphInfo,
    Image,
    Material,
    MaterialMap,
    Matrix,
    Mesh,
    Model,
    ModelAnimation,
    Music,
    NPatchInfo,
    Quaternion,
    Ray,
    RayCollision,
    Rectangle,
    RenderTexture,
    RenderTexture2D,
    Shader,
    Sound,
    Texture,
    Texture2D,
    TextureCubemap,
    Transform,
    Vector2,
    Vector3,
    Vector4,
    VrDeviceInfo,
    VrStereoConfig,
    Wave
  }

  defguard is_nif_return(value) when value in [:value, :resource]

  defguard is_structable(value)
           when is_map(value) or
                  (is_list(value) and
                     (value == [] or
                        (is_tuple(hd(value)) and tuple_size(hd(value)) == 2)))

  ##########
  #  Enum  #
  ##########

  @doc group: :enum
  defguard is_camera_projection(value) when is_integer(value)

  @doc group: :enum
  defguard is_config_flag(value) when is_integer(value)

  @doc group: :enum
  defguard is_keyboard_key(value) when is_integer(value)

  @doc group: :enum
  defguard is_mouse_button(value) when is_integer(value)

  @doc group: :enum
  defguard is_n_patch_layout(value) when is_integer(value)

  @doc group: :enum
  defguard is_pixel_format(value) when is_integer(value)

  @doc group: :enum
  defguard is_trace_log_level(value) when is_integer(value)

  @doc group: :enum
  defguard is_camera_projection_like(value) when is_camera_projection(value) or is_atom(value)

  @doc group: :enum
  defguard is_config_flag_like(value) when is_config_flag(value) or is_atom(value)

  @doc group: :enum
  defguard is_keyboard_key_like(value) when is_keyboard_key(value) or is_atom(value)

  @doc group: :enum
  defguard is_mouse_button_like(value) when is_mouse_button(value) or is_atom(value)

  @doc group: :enum
  defguard is_n_patch_layout_like(value) when is_n_patch_layout(value) or is_atom(value)

  @doc group: :enum
  defguard is_pixel_format_like(value) when is_pixel_format(value) or is_atom(value)

  @doc group: :enum
  defguard is_trace_log_level_like(value) when is_trace_log_level(value) or is_atom(value)

  ##########
  #  Type  #
  ##########

  @doc group: :type
  defguard is_audio_stream(value) when is_struct(value, AudioStream)

  @doc group: :type
  defguard is_automation_event(value) when is_struct(value, AutomationEvent)

  @doc group: :type
  defguard is_automation_event_list(value) when is_struct(value, AutomationEventList)

  @doc group: :type
  defguard is_bone_info(value) when is_struct(value, BoneInfo)

  @doc group: :type
  defguard is_bounding_box(value) when is_struct(value, BoundingBox)

  @doc group: :type
  defguard is_camera(value) when is_struct(value, Camera)

  @doc group: :type
  defguard is_camera_2d(value) when is_struct(value, Camera2D)

  @doc group: :type
  defguard is_camera_3d(value) when is_struct(value, Camera3D)

  @doc group: :type
  defguard is_color(value) when is_struct(value, Color)

  @doc group: :type
  defguard is_file_path_list(value) when is_struct(value, FilePathList)

  @doc group: :type
  defguard is_font(value) when is_struct(value, Font)

  @doc group: :type
  defguard is_glyph_info(value) when is_struct(value, GlyphInfo)

  @doc group: :type
  defguard is_image(value) when is_struct(value, Image)

  @doc group: :type
  defguard is_material(value) when is_struct(value, Material)

  @doc group: :type
  defguard is_material_map(value) when is_struct(value, MaterialMap)

  @doc group: :type
  defguard is_matrix(value) when is_struct(value, Matrix)

  @doc group: :type
  defguard is_mesh(value) when is_struct(value, Mesh)

  @doc group: :type
  defguard is_model(value) when is_struct(value, Model)

  @doc group: :type
  defguard is_model_animation(value) when is_struct(value, ModelAnimation)

  @doc group: :type
  defguard is_music(value) when is_struct(value, Music)

  @doc group: :type
  defguard is_n_patch_info(value) when is_struct(value, NPatchInfo)

  @doc group: :type
  defguard is_quaternion(value) when is_struct(value, Quaternion)

  @doc group: :type
  defguard is_ray(value) when is_struct(value, Ray)

  @doc group: :type
  defguard is_ray_collision(value) when is_struct(value, RayCollision)

  @doc group: :type
  defguard is_rectangle(value) when is_struct(value, Rectangle)

  @doc group: :type
  defguard is_render_texture(value) when is_struct(value, RenderTexture)

  @doc group: :type
  defguard is_render_texture_2d(value) when is_struct(value, RenderTexture2D)

  @doc group: :type
  defguard is_shader(value) when is_struct(value, Shader)

  @doc group: :type
  defguard is_sound(value) when is_struct(value, Sound)

  @doc group: :type
  defguard is_texture(value) when is_struct(value, Texture)

  @doc group: :type
  defguard is_texture_2d(value) when is_struct(value, Texture2D)

  @doc group: :type
  defguard is_texture_cubemap(value) when is_struct(value, TextureCubemap)

  @doc group: :type
  defguard is_transform(value) when is_struct(value, Transform)

  @doc group: :type
  defguard is_vector2(value) when is_struct(value, Vector2)

  @doc group: :type
  defguard is_vector3(value) when is_struct(value, Vector3)

  @doc group: :type
  defguard is_vector4(value) when is_struct(value, Vector4)

  @doc group: :type
  defguard is_vr_device_info(value) when is_struct(value, VrDeviceInfo)

  @doc group: :type
  defguard is_vr_stereo_config(value) when is_struct(value, VrStereoConfig)

  @doc group: :type
  defguard is_wave(value) when is_struct(value, Wave)

  @doc group: :type
  defguard is_audio_stream_like(value)
           when is_audio_stream(value) or
                  is_struct(value, AudioStream.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5)

  @doc group: :type
  defguard is_automation_event_like(value)
           when is_automation_event(value) or
                  is_struct(value, AutomationEvent.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

  @doc group: :type
  defguard is_automation_event_list_like(value)
           when is_automation_event_list(value) or
                  is_struct(value, AutomationEventList.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

  @doc group: :type
  defguard is_bone_info_like(value)
           when is_bone_info(value) or
                  is_struct(value, BoneInfo.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 2)

  @doc group: :type
  defguard is_bounding_box_like(value)
           when is_bounding_box(value) or
                  is_struct(value, BoundingBox.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 2)

  @doc group: :type
  defguard is_camera_like(value)
           when is_camera(value) or
                  is_struct(value, Camera.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5)

  @doc group: :type
  defguard is_camera_2d_like(value)
           when is_camera_2d(value) or
                  is_struct(value, Camera2D.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 4)

  @doc group: :type
  defguard is_camera_3d_like(value)
           when is_camera_3d(value) or
                  is_struct(value, Camera3D.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5)

  @doc group: :type
  defguard is_color_like(value)
           when is_color(value) or
                  is_struct(value, Color.Resource) or
                  is_structable(value) or
                  is_integer(value) or
                  is_atom(value) or
                  (is_bitstring(value) and bit_size(value) in [24, 32]) or
                  (is_tuple(value) and tuple_size(value) in [2, 3, 4])

  @doc group: :type
  defguard is_file_path_list_like(value)
           when is_file_path_list(value) or
                  is_struct(value, FilePathList.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

  @doc group: :type
  defguard is_font_like(value)
           when is_font(value) or
                  is_struct(value, Font.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 6)

  @doc group: :type
  defguard is_glyph_info_like(value)
           when is_glyph_info(value) or
                  is_struct(value, GlyphInfo.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5)

  @doc group: :type
  defguard is_image_like(value)
           when is_image(value) or
                  is_struct(value, Image.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5)

  @doc group: :type
  defguard is_material_like(value)
           when is_material(value) or
                  is_struct(value, Material.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

  @doc group: :type
  defguard is_material_map_like(value)
           when is_material_map(value) or
                  is_struct(value, MaterialMap.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

  @doc group: :type
  defguard is_matrix_like(value)
           when is_matrix(value) or
                  is_struct(value, Matrix.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 16) or
                  (is_tuple(value) and tuple_size(value) == 4 and
                     is_tuple(elem(value, 0)) and tuple_size(elem(value, 0)) == 4 and
                     is_tuple(elem(value, 1)) and tuple_size(elem(value, 1)) == 4 and
                     is_tuple(elem(value, 2)) and tuple_size(elem(value, 2)) == 4 and
                     is_tuple(elem(value, 3)) and tuple_size(elem(value, 3)) == 4)

  @doc group: :type
  defguard is_mesh_like(value)
           when is_mesh(value) or
                  is_struct(value, Mesh.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 17)

  @doc group: :type
  defguard is_model_like(value)
           when is_model(value) or
                  is_struct(value, Model.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 9)

  @doc group: :type
  defguard is_model_animation_like(value)
           when is_model_animation(value) or
                  is_struct(value, ModelAnimation.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5)

  @doc group: :type
  defguard is_music_like(value)
           when is_music(value) or
                  is_struct(value, Music.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5)

  @doc group: :type
  defguard is_n_patch_info_like(value)
           when is_n_patch_info(value) or
                  is_struct(value, NPatchInfo.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 6)

  @doc group: :type
  defguard is_quaternion_like(value)
           when is_quaternion(value) or
                  is_struct(value, Quaternion.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 4) or
                  is_struct(value, Vector4)

  @doc group: :type
  defguard is_ray_like(value)
           when is_ray(value) or
                  is_struct(value, Ray.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 2)

  @doc group: :type
  defguard is_ray_collision_like(value)
           when is_ray_collision(value) or
                  is_struct(value, RayCollision.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 4)

  @doc group: :type
  defguard is_rectangle_like(value)
           when is_rectangle(value) or
                  is_struct(value, Rectangle.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 4)

  @doc group: :type
  defguard is_render_texture_like(value)
           when is_render_texture(value) or
                  is_struct(value, RenderTexture.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3) or
                  is_struct(value, RenderTexture2D) or
                  is_struct(value, RenderTexture2D.Resource)

  @doc group: :type
  defguard is_render_texture_2d_like(value)
           when is_render_texture_2d(value) or
                  is_struct(value, RenderTexture2D.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3) or
                  is_struct(value, RenderTexture) or
                  is_struct(value, RenderTexture.Resource)

  @doc group: :type
  defguard is_shader_like(value)
           when is_shader(value) or
                  is_struct(value, Shader.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 2)

  @doc group: :type
  defguard is_sound_like(value)
           when is_sound(value) or
                  is_struct(value, Sound.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 2)

  @doc group: :type
  defguard is_texture_like(value)
           when is_texture(value) or
                  is_struct(value, Texture.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5) or
                  is_struct(value, Texture2D) or
                  is_struct(value, Texture2D.Resource) or
                  is_struct(value, TextureCubemap) or
                  is_struct(value, TextureCubemap.Resource)

  @doc group: :type
  defguard is_texture_2d_like(value)
           when is_texture_2d(value) or
                  is_struct(value, Texture2D.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5) or
                  is_struct(value, Texture) or
                  is_struct(value, Texture.Resource)

  @doc group: :type
  defguard is_texture_cubemap_like(value)
           when is_texture_cubemap(value) or
                  is_struct(value, TextureCubemap.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5) or
                  is_struct(value, Texture) or
                  is_struct(value, Texture.Resource)

  @doc group: :type
  defguard is_transform_like(value)
           when is_transform(value) or
                  is_struct(value, Transform.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

  @doc group: :type
  defguard is_vector2_like(value)
           when is_vector2(value) or
                  is_struct(value, Vector2.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 2)

  @doc group: :type
  defguard is_vector3_like(value)
           when is_vector3(value) or
                  is_struct(value, Vector3.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

  @doc group: :type
  defguard is_vector4_like(value)
           when is_vector4(value) or
                  is_struct(value, Vector4.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 4) or
                  is_struct(value, Quaternion)

  @doc group: :type
  defguard is_vr_device_info_like(value)
           when is_vr_device_info(value) or
                  is_struct(value, VrDeviceInfo.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 9)

  @doc group: :type
  defguard is_vr_stereo_config_like(value)
           when is_vr_stereo_config(value) or
                  is_struct(value, VrStereoConfig.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 8)

  @doc group: :type
  defguard is_wave_like(value)
           when is_wave(value) or
                  is_struct(value, Wave.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5)
end
