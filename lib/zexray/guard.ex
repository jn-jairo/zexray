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
    IVector2,
    UIVector2,
    Vector3,
    IVector3,
    UIVector3,
    Vector4,
    IVector4,
    UIVector4,
    VrDeviceInfo,
    VrStereoConfig,
    Wave
  }

  defguard is_nif_return(value) when value in [:value, :resource]

  defguard is_non_neg_integer(value) when is_integer(value) and value >= 0

  defguard is_structable(value)
           when is_map(value) or
                  (is_list(value) and
                     (value == [] or
                        (is_tuple(hd(value)) and tuple_size(hd(value)) == 2)))

  ##########
  #  Enum  #
  ##########

  @doc group: :enum
  defguard is_blend_mode(value) when is_integer(value)

  @doc group: :enum
  defguard is_camera_mode(value) when is_integer(value)

  @doc group: :enum
  defguard is_camera_projection(value) when is_integer(value)

  @doc group: :enum
  defguard is_config_flag(value) when is_integer(value)

  @doc group: :enum
  defguard is_cubemap_layout(value) when is_integer(value)

  @doc group: :enum
  defguard is_font_type(value) when is_integer(value)

  @doc group: :enum
  defguard is_gamepad_axis(value) when is_integer(value)

  @doc group: :enum
  defguard is_gamepad_button(value) when is_integer(value)

  @doc group: :enum
  defguard is_gesture(value) when is_integer(value)

  @doc group: :enum
  defguard is_keyboard_key(value) when is_integer(value)

  @doc group: :enum
  defguard is_material_map_index(value) when is_integer(value)

  @doc group: :enum
  defguard is_mouse_button(value) when is_integer(value)

  @doc group: :enum
  defguard is_mouse_cursor(value) when is_integer(value)

  @doc group: :enum
  defguard is_n_patch_layout(value) when is_integer(value)

  @doc group: :enum
  defguard is_pixel_format(value) when is_integer(value)

  @doc group: :enum
  defguard is_shader_attribute_data_type(value) when is_integer(value)

  @doc group: :enum
  defguard is_shader_attribute_location_index(value) when is_integer(value)

  @doc group: :enum
  defguard is_shader_location_index(value) when is_integer(value)

  @doc group: :enum
  defguard is_shader_uniform_data_type(value) when is_integer(value)

  @doc group: :enum
  defguard is_texture_filter(value) when is_integer(value)

  @doc group: :enum
  defguard is_texture_wrap(value) when is_integer(value)

  @doc group: :enum
  defguard is_trace_log_level(value) when is_integer(value)

  @doc group: :enum
  defguard is_like_blend_mode(value) when is_blend_mode(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_camera_mode(value) when is_camera_mode(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_camera_projection(value) when is_camera_projection(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_config_flag(value) when is_config_flag(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_cubemap_layout(value) when is_cubemap_layout(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_font_type(value) when is_font_type(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_gamepad_axis(value) when is_gamepad_axis(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_gamepad_button(value) when is_gamepad_button(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_gesture(value) when is_gesture(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_keyboard_key(value) when is_keyboard_key(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_material_map_index(value) when is_material_map_index(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_mouse_button(value) when is_mouse_button(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_mouse_cursor(value) when is_mouse_cursor(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_n_patch_layout(value) when is_n_patch_layout(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_pixel_format(value) when is_pixel_format(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_shader_attribute_data_type(value)
           when is_shader_attribute_data_type(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_shader_attribute_location_index(value)
           when is_shader_attribute_location_index(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_shader_location_index(value)
           when is_shader_location_index(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_shader_uniform_data_type(value)
           when is_shader_uniform_data_type(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_texture_filter(value) when is_texture_filter(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_texture_wrap(value) when is_texture_wrap(value) or is_atom(value)

  @doc group: :enum
  defguard is_like_trace_log_level(value) when is_trace_log_level(value) or is_atom(value)

  ##########
  #  Type  #
  ##########

  @doc group: :type
  defguard is_audio_stream(value) when is_struct(value, AudioStream) or is_struct(value, AudioStream.Resource)

  @doc group: :type
  defguard is_automation_event(value) when is_struct(value, AutomationEvent) or is_struct(value, AutomationEvent.Resource)

  @doc group: :type
  defguard is_automation_event_list(value) when is_struct(value, AutomationEventList) or is_struct(value, AutomationEventList.Resource)

  @doc group: :type
  defguard is_bone_info(value) when is_struct(value, BoneInfo) or is_struct(value, BoneInfo.Resource)

  @doc group: :type
  defguard is_bounding_box(value) when is_struct(value, BoundingBox) or is_struct(value, BoundingBox.Resource)

  @doc group: :type
  defguard is_camera(value) when is_struct(value, Camera) or is_struct(value, Camera.Resource)

  @doc group: :type
  defguard is_camera_2d(value) when is_struct(value, Camera2D) or is_struct(value, Camera2D.Resource)

  @doc group: :type
  defguard is_camera_3d(value) when is_struct(value, Camera3D) or is_struct(value, Camera3D.Resource)

  @doc group: :type
  defguard is_color(value) when is_struct(value, Color) or is_struct(value, Color.Resource)

  @doc group: :type
  defguard is_file_path_list(value) when is_struct(value, FilePathList) or is_struct(value, FilePathList.Resource)

  @doc group: :type
  defguard is_font(value) when is_struct(value, Font) or is_struct(value, Font.Resource)

  @doc group: :type
  defguard is_glyph_info(value) when is_struct(value, GlyphInfo) or is_struct(value, GlyphInfo.Resource)

  @doc group: :type
  defguard is_image(value) when is_struct(value, Image) or is_struct(value, Image.Resource)

  @doc group: :type
  defguard is_material(value) when is_struct(value, Material) or is_struct(value, Material.Resource)

  @doc group: :type
  defguard is_material_map(value) when is_struct(value, MaterialMap) or is_struct(value, MaterialMap.Resource)

  @doc group: :type
  defguard is_matrix(value) when is_struct(value, Matrix) or is_struct(value, Matrix.Resource)

  @doc group: :type
  defguard is_mesh(value) when is_struct(value, Mesh) or is_struct(value, Mesh.Resource)

  @doc group: :type
  defguard is_model(value) when is_struct(value, Model) or is_struct(value, Model.Resource)

  @doc group: :type
  defguard is_model_animation(value) when is_struct(value, ModelAnimation) or is_struct(value, ModelAnimation.Resource)

  @doc group: :type
  defguard is_music(value) when is_struct(value, Music) or is_struct(value, Music.Resource)

  @doc group: :type
  defguard is_n_patch_info(value) when is_struct(value, NPatchInfo) or is_struct(value, NPatchInfo.Resource)

  @doc group: :type
  defguard is_quaternion(value) when is_struct(value, Quaternion) or is_struct(value, Quaternion.Resource)

  @doc group: :type
  defguard is_ray(value) when is_struct(value, Ray) or is_struct(value, Ray.Resource)

  @doc group: :type
  defguard is_ray_collision(value) when is_struct(value, RayCollision) or is_struct(value, RayCollision.Resource)

  @doc group: :type
  defguard is_rectangle(value) when is_struct(value, Rectangle) or is_struct(value, Rectangle.Resource)

  @doc group: :type
  defguard is_render_texture(value) when is_struct(value, RenderTexture) or is_struct(value, RenderTexture.Resource)

  @doc group: :type
  defguard is_render_texture_2d(value) when is_struct(value, RenderTexture2D) or is_struct(value, RenderTexture2D.Resource)

  @doc group: :type
  defguard is_shader(value) when is_struct(value, Shader) or is_struct(value, Shader.Resource)

  @doc group: :type
  defguard is_sound(value) when is_struct(value, Sound) or is_struct(value, Sound.Resource)

  @doc group: :type
  defguard is_texture(value) when is_struct(value, Texture) or is_struct(value, Texture.Resource)

  @doc group: :type
  defguard is_texture_2d(value) when is_struct(value, Texture2D) or is_struct(value, Texture2D.Resource)

  @doc group: :type
  defguard is_texture_cubemap(value) when is_struct(value, TextureCubemap) or is_struct(value, TextureCubemap.Resource)

  @doc group: :type
  defguard is_transform(value) when is_struct(value, Transform) or is_struct(value, Transform.Resource)

  @doc group: :type
  defguard is_vector2(value) when is_struct(value, Vector2) or is_struct(value, Vector2.Resource)

  @doc group: :type
  defguard is_ivector2(value) when is_struct(value, IVector2) or is_struct(value, IVector2.Resource)

  @doc group: :type
  defguard is_uivector2(value) when is_struct(value, UIVector2) or is_struct(value, UIVector2.Resource)

  @doc group: :type
  defguard is_vector3(value) when is_struct(value, Vector3) or is_struct(value, Vector3.Resource)

  @doc group: :type
  defguard is_ivector3(value) when is_struct(value, IVector3) or is_struct(value, IVector3.Resource)

  @doc group: :type
  defguard is_uivector3(value) when is_struct(value, UIVector3) or is_struct(value, UIVector3.Resource)

  @doc group: :type
  defguard is_vector4(value) when is_struct(value, Vector4) or is_struct(value, Vector4.Resource)

  @doc group: :type
  defguard is_ivector4(value) when is_struct(value, IVector4) or is_struct(value, IVector4.Resource)

  @doc group: :type
  defguard is_uivector4(value) when is_struct(value, UIVector4) or is_struct(value, UIVector4.Resource)

  @doc group: :type
  defguard is_vr_device_info(value) when is_struct(value, VrDeviceInfo) or is_struct(value, VrDeviceInfo.Resource)

  @doc group: :type
  defguard is_vr_stereo_config(value) when is_struct(value, VrStereoConfig) or is_struct(value, VrStereoConfig.Resource)

  @doc group: :type
  defguard is_wave(value) when is_struct(value, Wave) or is_struct(value, Wave.Resource)

  @doc group: :type
  defguard is_like_audio_stream(value)
           when is_audio_stream(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5)

  @doc group: :type
  defguard is_like_automation_event(value)
           when is_automation_event(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

  @doc group: :type
  defguard is_like_automation_event_list(value)
           when is_automation_event_list(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

  @doc group: :type
  defguard is_like_bone_info(value)
           when is_bone_info(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 2)

  @doc group: :type
  defguard is_like_bounding_box(value)
           when is_bounding_box(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 2)

  @doc group: :type
  defguard is_like_camera(value)
           when is_camera(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5) or
                  is_camera_3d(value)

  @doc group: :type
  defguard is_like_camera_2d(value)
           when is_camera_2d(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 4)

  @doc group: :type
  defguard is_like_camera_3d(value)
           when is_camera_3d(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5) or
                  is_camera(value)

  @doc group: :type
  defguard is_like_color(value)
           when is_color(value) or
                  is_structable(value) or
                  is_integer(value) or
                  is_atom(value) or
                  (is_bitstring(value) and bit_size(value) in [24, 32]) or
                  (is_tuple(value) and tuple_size(value) in [2, 3, 4])

  @doc group: :type
  defguard is_like_file_path_list(value)
           when is_file_path_list(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

  @doc group: :type
  defguard is_like_font(value)
           when is_font(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 6)

  @doc group: :type
  defguard is_like_glyph_info(value)
           when is_glyph_info(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5)

  @doc group: :type
  defguard is_like_image(value)
           when is_image(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5)

  @doc group: :type
  defguard is_like_material(value)
           when is_material(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

  @doc group: :type
  defguard is_like_material_map(value)
           when is_material_map(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

  @doc group: :type
  defguard is_like_matrix(value)
           when is_matrix(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 16) or
                  (is_tuple(value) and tuple_size(value) == 4 and
                     is_tuple(elem(value, 0)) and tuple_size(elem(value, 0)) == 4 and
                     is_tuple(elem(value, 1)) and tuple_size(elem(value, 1)) == 4 and
                     is_tuple(elem(value, 2)) and tuple_size(elem(value, 2)) == 4 and
                     is_tuple(elem(value, 3)) and tuple_size(elem(value, 3)) == 4)

  @doc group: :type
  defguard is_like_mesh(value)
           when is_mesh(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 17)

  @doc group: :type
  defguard is_like_model(value)
           when is_model(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 9)

  @doc group: :type
  defguard is_like_model_animation(value)
           when is_model_animation(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5)

  @doc group: :type
  defguard is_like_music(value)
           when is_music(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5)

  @doc group: :type
  defguard is_like_n_patch_info(value)
           when is_n_patch_info(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 6)

  @doc group: :type
  defguard is_like_quaternion(value)
           when is_quaternion(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 4) or
                  is_struct(value, Vector4)

  @doc group: :type
  defguard is_like_ray(value)
           when is_ray(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 2)

  @doc group: :type
  defguard is_like_ray_collision(value)
           when is_ray_collision(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 4)

  @doc group: :type
  defguard is_like_rectangle(value)
           when is_rectangle(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 4)

  @doc group: :type
  defguard is_like_render_texture(value)
           when is_render_texture(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3) or
                  is_render_texture_2d(value)

  @doc group: :type
  defguard is_like_render_texture_2d(value)
           when is_render_texture_2d(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3) or
                  is_render_texture(value)

  @doc group: :type
  defguard is_like_shader(value)
           when is_shader(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 2)

  @doc group: :type
  defguard is_like_sound(value)
           when is_sound(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 2)

  @doc group: :type
  defguard is_like_texture(value)
           when is_texture(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5) or
                  is_texture_2d(value) or
                  is_texture_cubemap(value)

  @doc group: :type
  defguard is_like_texture_2d(value)
           when is_texture_2d(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5) or
                  is_texture(value)

  @doc group: :type
  defguard is_like_texture_cubemap(value)
           when is_texture_cubemap(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5) or
                  is_texture(value)

  @doc group: :type
  defguard is_like_transform(value)
           when is_transform(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

  @doc group: :type
  defguard is_like_vector2(value)
           when is_vector2(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 2)

  @doc group: :type
  defguard is_like_ivector2(value)
           when is_ivector2(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 2)

  @doc group: :type
  defguard is_like_uivector2(value)
           when is_uivector2(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 2)

  @doc group: :type
  defguard is_like_vector3(value)
           when is_vector3(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

  @doc group: :type
  defguard is_like_ivector3(value)
           when is_ivector3(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

  @doc group: :type
  defguard is_like_uivector3(value)
           when is_uivector3(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

  @doc group: :type
  defguard is_like_vector4(value)
           when is_vector4(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 4) or
                  is_struct(value, Quaternion)

  @doc group: :type
  defguard is_like_ivector4(value)
           when is_ivector4(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 4)

  @doc group: :type
  defguard is_like_uivector4(value)
           when is_uivector4(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 4)

  @doc group: :type
  defguard is_like_vr_device_info(value)
           when is_vr_device_info(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 9)

  @doc group: :type
  defguard is_like_vr_stereo_config(value)
           when is_vr_stereo_config(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 8)

  @doc group: :type
  defguard is_like_wave(value)
           when is_wave(value) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5)
end
