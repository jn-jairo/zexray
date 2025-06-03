defmodule Zexray.Guard do
  @moduledoc """
  Guards
  """

  defguard is_nif_return(value) when value in [:auto, :value, :resource]

  defguard is_non_neg_integer(value) when is_integer(value) and value >= 0

  defguard is_record(value, tag, arity)
           when is_tuple(value) and tuple_size(value) == arity and elem(value, 0) == tag

  defguard is_record_like(value, arity)
           when is_tuple(value) and tuple_size(value) == arity and is_atom(elem(value, 0))

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
  defguard is_audio_info(value)
           when is_record(value, :audio_info, 5) or is_record(value, :audio_info_resource, 2)

  @doc group: :type
  defguard is_audio_stream(value)
           when is_record(value, :audio_stream, 6) or is_record(value, :audio_stream_resource, 2)

  @doc group: :type
  defguard is_automation_event(value)
           when is_record(value, :automation_event, 4) or
                  is_record(value, :automation_event_resource, 2)

  @doc group: :type
  defguard is_automation_event_list(value)
           when is_record(value, :automation_event_list, 4) or
                  is_record(value, :automation_event_list_resource, 2)

  @doc group: :type
  defguard is_bone_info(value)
           when is_record(value, :bone_info, 3) or is_record(value, :bone_info_resource, 2)

  @doc group: :type
  defguard is_bounding_box(value)
           when is_record(value, :bounding_box, 3) or is_record(value, :bounding_box_resource, 2)

  @doc group: :type
  defguard is_camera(value)
           when is_record(value, :camera, 6) or is_record(value, :camera_resource, 2)

  @doc group: :type
  defguard is_camera_2d(value)
           when is_record(value, :camera_2d, 5) or is_record(value, :camera_2d_resource, 2)

  @doc group: :type
  defguard is_camera_3d(value)
           when is_record(value, :camera_3d, 6) or is_record(value, :camera_3d_resource, 2)

  @doc group: :type
  defguard is_color(value)
           when is_record(value, :color, 5) or is_record(value, :color_resource, 2)

  @doc group: :type
  defguard is_file_path_list(value)
           when is_record(value, :file_path_list, 4) or
                  is_record(value, :file_path_list_resource, 2)

  @doc group: :type
  defguard is_font(value) when is_record(value, :font, 7) or is_record(value, :font_resource, 2)

  @doc group: :type
  defguard is_glyph_info(value)
           when is_record(value, :glyph_info, 6) or is_record(value, :glyph_info_resource, 2)

  @doc group: :type
  defguard is_image(value)
           when is_record(value, :image, 6) or is_record(value, :image_resource, 2)

  @doc group: :type
  defguard is_material(value)
           when is_record(value, :material, 4) or is_record(value, :material_resource, 2)

  @doc group: :type
  defguard is_material_map(value)
           when is_record(value, :material_map, 4) or is_record(value, :material_map_resource, 2)

  @doc group: :type
  defguard is_matrix(value)
           when is_record(value, :matrix, 17) or is_record(value, :matrix_resource, 2)

  @doc group: :type
  defguard is_mesh(value) when is_record(value, :mesh, 18) or is_record(value, :mesh_resource, 2)

  @doc group: :type
  defguard is_model(value)
           when is_record(value, :model, 10) or is_record(value, :model_resource, 2)

  @doc group: :type
  defguard is_model_animation(value)
           when is_record(value, :model_animation, 6) or
                  is_record(value, :model_animation_resource, 2)

  @doc group: :type
  defguard is_music(value)
           when is_record(value, :music, 6) or is_record(value, :music_resource, 2)

  @doc group: :type
  defguard is_n_patch_info(value)
           when is_record(value, :n_patch_info, 7) or is_record(value, :n_patch_info_resource, 2)

  @doc group: :type
  defguard is_quaternion(value)
           when is_record(value, :quaternion, 5) or is_record(value, :quaternion_resource, 2)

  @doc group: :type
  defguard is_ray(value) when is_record(value, :ray, 3) or is_record(value, :ray_resource, 2)

  @doc group: :type
  defguard is_ray_collision(value)
           when is_record(value, :ray_collision, 5) or
                  is_record(value, :ray_collision_resource, 2)

  @doc group: :type
  defguard is_rectangle(value)
           when is_record(value, :rectangle, 5) or is_record(value, :rectangle_resource, 2)

  @doc group: :type
  defguard is_render_texture(value)
           when is_record(value, :render_texture, 4) or
                  is_record(value, :render_texture_resource, 2)

  @doc group: :type
  defguard is_render_texture_2d(value)
           when is_record(value, :render_texture_2d, 4) or
                  is_record(value, :render_texture_2d_resource, 2)

  @doc group: :type
  defguard is_shader(value)
           when is_record(value, :shader, 3) or is_record(value, :shader_resource, 2)

  @doc group: :type
  defguard is_sound(value)
           when is_record(value, :sound, 3) or is_record(value, :sound_resource, 2)

  @doc group: :type
  defguard is_sound_alias(value)
           when is_record(value, :sound_alias, 3) or is_record(value, :sound_alias_resource, 2)

  @doc group: :type
  defguard is_sound_stream(value)
           when is_record(value, :sound_stream, 5) or is_record(value, :sound_stream_resource, 2)

  @doc group: :type
  defguard is_sound_stream_alias(value)
           when is_record(value, :sound_stream_alias, 5) or
                  is_record(value, :sound_stream_alias_resource, 2)

  @doc group: :type
  defguard is_texture(value)
           when is_record(value, :texture, 6) or is_record(value, :texture_resource, 2)

  @doc group: :type
  defguard is_texture_2d(value)
           when is_record(value, :texture_2d, 6) or is_record(value, :texture_2d_resource, 2)

  @doc group: :type
  defguard is_texture_cubemap(value)
           when is_record(value, :texture_cubemap, 6) or
                  is_record(value, :texture_cubemap_resource, 2)

  @doc group: :type
  defguard is_transform(value)
           when is_record(value, :transform, 4) or is_record(value, :transform_resource, 2)

  @doc group: :type
  defguard is_vector2(value)
           when is_record(value, :vector2, 3) or is_record(value, :vector2_resource, 2)

  @doc group: :type
  defguard is_ivector2(value)
           when is_record(value, :ivector2, 3) or is_record(value, :ivector2_resource, 2)

  @doc group: :type
  defguard is_uivector2(value)
           when is_record(value, :uivector2, 3) or is_record(value, :uivector2_resource, 2)

  @doc group: :type
  defguard is_vector3(value)
           when is_record(value, :vector3, 4) or is_record(value, :vector3_resource, 2)

  @doc group: :type
  defguard is_ivector3(value)
           when is_record(value, :ivector3, 4) or is_record(value, :ivector3_resource, 2)

  @doc group: :type
  defguard is_uivector3(value)
           when is_record(value, :uivector3, 4) or is_record(value, :uivector3_resource, 2)

  @doc group: :type
  defguard is_vector4(value)
           when is_record(value, :vector4, 5) or is_record(value, :vector4_resource, 2)

  @doc group: :type
  defguard is_ivector4(value)
           when is_record(value, :ivector4, 5) or is_record(value, :ivector4_resource, 2)

  @doc group: :type
  defguard is_uivector4(value)
           when is_record(value, :uivector4, 5) or is_record(value, :uivector4_resource, 2)

  @doc group: :type
  defguard is_vr_device_info(value)
           when is_record(value, :vr_device_info, 10) or
                  is_record(value, :vr_device_info_resource, 2)

  @doc group: :type
  defguard is_vr_stereo_config(value)
           when is_record(value, :vr_stereo_config, 9) or
                  is_record(value, :vr_stereo_config_resource, 2)

  @doc group: :type
  defguard is_wave(value) when is_record(value, :wave, 6) or is_record(value, :wave_resource, 2)

  @doc group: :type
  defguard is_like_audio_info(value) when is_audio_info(value) or is_record_like(value, 5)

  @doc group: :type
  defguard is_like_audio_stream(value) when is_audio_stream(value) or is_record_like(value, 6)

  @doc group: :type
  defguard is_like_automation_event(value)
           when is_automation_event(value) or is_record_like(value, 4)

  @doc group: :type
  defguard is_like_automation_event_list(value)
           when is_automation_event_list(value) or is_record_like(value, 4)

  @doc group: :type
  defguard is_like_bone_info(value) when is_bone_info(value) or is_record_like(value, 3)

  @doc group: :type
  defguard is_like_bounding_box(value) when is_bounding_box(value) or is_record_like(value, 3)

  @doc group: :type
  defguard is_like_camera(value)
           when is_camera(value) or is_record_like(value, 6) or is_camera_3d(value)

  @doc group: :type
  defguard is_like_camera_2d(value) when is_camera_2d(value) or is_record_like(value, 5)

  @doc group: :type
  defguard is_like_camera_3d(value)
           when is_camera_3d(value) or is_record_like(value, 6) or is_camera(value)

  @doc group: :type
  defguard is_like_color(value) when is_color(value) or is_record_like(value, 5)

  @doc group: :type
  defguard is_like_file_path_list(value) when is_file_path_list(value) or is_record_like(value, 4)

  @doc group: :type
  defguard is_like_font(value) when is_font(value) or is_record_like(value, 7)

  @doc group: :type
  defguard is_like_glyph_info(value) when is_glyph_info(value) or is_record_like(value, 6)

  @doc group: :type
  defguard is_like_image(value) when is_image(value) or is_record_like(value, 6)

  @doc group: :type
  defguard is_like_material(value) when is_material(value) or is_record_like(value, 4)

  @doc group: :type
  defguard is_like_material_map(value) when is_material_map(value) or is_record_like(value, 4)

  @doc group: :type
  defguard is_like_matrix(value) when is_matrix(value) or is_record_like(value, 17)

  @doc group: :type
  defguard is_like_mesh(value) when is_mesh(value) or is_record_like(value, 18)

  @doc group: :type
  defguard is_like_model(value) when is_model(value) or is_record_like(value, 10)

  @doc group: :type
  defguard is_like_model_animation(value)
           when is_model_animation(value) or is_record_like(value, 6)

  @doc group: :type
  defguard is_like_music(value) when is_music(value) or is_record_like(value, 6)

  @doc group: :type
  defguard is_like_n_patch_info(value) when is_n_patch_info(value) or is_record_like(value, 7)

  @doc group: :type
  defguard is_like_quaternion(value)
           when is_quaternion(value) or is_record_like(value, 5) or is_vector4(value)

  @doc group: :type
  defguard is_like_ray(value) when is_ray(value) or is_record_like(value, 3)

  @doc group: :type
  defguard is_like_ray_collision(value) when is_ray_collision(value) or is_record_like(value, 5)

  @doc group: :type
  defguard is_like_rectangle(value) when is_rectangle(value) or is_record_like(value, 5)

  @doc group: :type
  defguard is_like_render_texture(value)
           when is_render_texture(value) or is_record_like(value, 4) or
                  is_render_texture_2d(value)

  @doc group: :type
  defguard is_like_render_texture_2d(value)
           when is_render_texture_2d(value) or is_record_like(value, 4) or
                  is_render_texture(value)

  @doc group: :type
  defguard is_like_shader(value) when is_shader(value) or is_record_like(value, 3)

  @doc group: :type
  defguard is_like_sound(value)
           when is_sound(value) or is_record_like(value, 3) or is_sound_alias(value)

  @doc group: :type
  defguard is_like_sound_alias(value)
           when is_sound_alias(value) or is_record_like(value, 3) or is_sound(value)

  @doc group: :type
  defguard is_like_sound_stream(value)
           when is_sound_stream(value) or is_record_like(value, 5) or is_sound_stream_alias(value)

  @doc group: :type
  defguard is_like_sound_stream_alias(value)
           when is_sound_stream_alias(value) or is_record_like(value, 5) or is_sound_stream(value)

  @doc group: :type
  defguard is_like_texture(value)
           when is_texture(value) or is_record_like(value, 6) or is_texture_2d(value) or
                  is_texture_cubemap(value)

  @doc group: :type
  defguard is_like_texture_2d(value)
           when is_texture_2d(value) or is_record_like(value, 6) or is_texture(value)

  @doc group: :type
  defguard is_like_texture_cubemap(value)
           when is_texture_cubemap(value) or is_record_like(value, 6) or is_texture(value)

  @doc group: :type
  defguard is_like_transform(value) when is_transform(value) or is_record_like(value, 4)

  @doc group: :type
  defguard is_like_vector2(value) when is_vector2(value) or is_record_like(value, 3)

  @doc group: :type
  defguard is_like_ivector2(value) when is_ivector2(value) or is_record_like(value, 3)

  @doc group: :type
  defguard is_like_uivector2(value) when is_uivector2(value) or is_record_like(value, 3)

  @doc group: :type
  defguard is_like_vector3(value) when is_vector3(value) or is_record_like(value, 4)

  @doc group: :type
  defguard is_like_ivector3(value) when is_ivector3(value) or is_record_like(value, 4)

  @doc group: :type
  defguard is_like_uivector3(value) when is_uivector3(value) or is_record_like(value, 4)

  @doc group: :type
  defguard is_like_vector4(value)
           when is_vector4(value) or is_record_like(value, 5) or is_quaternion(value)

  @doc group: :type
  defguard is_like_ivector4(value) when is_ivector4(value) or is_record_like(value, 5)

  @doc group: :type
  defguard is_like_uivector4(value) when is_uivector4(value) or is_record_like(value, 5)

  @doc group: :type
  defguard is_like_vr_device_info(value)
           when is_vr_device_info(value) or is_record_like(value, 10)

  @doc group: :type
  defguard is_like_vr_stereo_config(value)
           when is_vr_stereo_config(value) or is_record_like(value, 9)

  @doc group: :type
  defguard is_like_wave(value) when is_wave(value) or is_record_like(value, 6)
end
