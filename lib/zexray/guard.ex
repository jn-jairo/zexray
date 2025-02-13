defmodule Zexray.Guard do
  @moduledoc """
  Guards
  """

  alias Zexray.Type.{
    BoneInfo,
    Camera,
    Camera2D,
    Camera3D,
    Color,
    Font,
    GlyphInfo,
    Image,
    Material,
    MaterialMap,
    Matrix,
    Mesh,
    Model,
    ModelAnimation,
    NPatchInfo,
    Quaternion,
    Ray,
    Rectangle,
    RenderTexture,
    RenderTexture2D,
    Shader,
    Texture,
    Texture2D,
    TextureCubemap,
    Transform,
    Vector2,
    Vector3,
    Vector4
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

  defguard is_camera_projection(value) when is_integer(value)
  defguard is_n_patch_layout(value) when is_integer(value)
  defguard is_pixel_format(value) when is_integer(value)
  defguard is_trace_log_level(value) when is_integer(value)

  defguard is_camera_projection_like(value)
           when is_camera_projection(value) or
                  is_atom(value)

  defguard is_n_patch_layout_like(value)
           when is_n_patch_layout(value) or
                  is_atom(value)

  defguard is_pixel_format_like(value)
           when is_pixel_format(value) or
                  is_atom(value)

  defguard is_trace_log_level_like(value)
           when is_trace_log_level(value) or
                  is_atom(value)

  ##########
  #  Type  #
  ##########

  defguard is_bone_info(value) when is_struct(value, BoneInfo)
  defguard is_camera(value) when is_struct(value, Camera)
  defguard is_camera_2d(value) when is_struct(value, Camera2D)
  defguard is_camera_3d(value) when is_struct(value, Camera3D)
  defguard is_color(value) when is_struct(value, Color)
  defguard is_font(value) when is_struct(value, Font)
  defguard is_glyph_info(value) when is_struct(value, GlyphInfo)
  defguard is_image(value) when is_struct(value, Image)
  defguard is_material(value) when is_struct(value, Material)
  defguard is_material_map(value) when is_struct(value, MaterialMap)
  defguard is_matrix(value) when is_struct(value, Matrix)
  defguard is_mesh(value) when is_struct(value, Mesh)
  defguard is_model(value) when is_struct(value, Model)
  defguard is_model_animation(value) when is_struct(value, ModelAnimation)
  defguard is_n_patch_info(value) when is_struct(value, NPatchInfo)
  defguard is_quaternion(value) when is_struct(value, Quaternion)
  defguard is_ray(value) when is_struct(value, Ray)
  defguard is_rectangle(value) when is_struct(value, Rectangle)
  defguard is_render_texture(value) when is_struct(value, RenderTexture)
  defguard is_render_texture_2d(value) when is_struct(value, RenderTexture2D)
  defguard is_shader(value) when is_struct(value, Shader)
  defguard is_texture(value) when is_struct(value, Texture)
  defguard is_texture_2d(value) when is_struct(value, Texture2D)
  defguard is_texture_cubemap(value) when is_struct(value, TextureCubemap)
  defguard is_transform(value) when is_struct(value, Transform)
  defguard is_vector2(value) when is_struct(value, Vector2)
  defguard is_vector3(value) when is_struct(value, Vector3)
  defguard is_vector4(value) when is_struct(value, Vector4)

  defguard is_bone_info_like(value)
           when is_bone_info(value) or
                  is_struct(value, BoneInfo.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 2)

  defguard is_camera_like(value)
           when is_camera(value) or
                  is_struct(value, Camera.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5)

  defguard is_camera_2d_like(value)
           when is_camera_2d(value) or
                  is_struct(value, Camera2D.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 4)

  defguard is_camera_3d_like(value)
           when is_camera_3d(value) or
                  is_struct(value, Camera3D.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5)

  defguard is_color_like(value)
           when is_color(value) or
                  is_struct(value, Color.Resource) or
                  is_structable(value) or
                  is_integer(value) or
                  is_atom(value) or
                  (is_bitstring(value) and bit_size(value) in [24, 32]) or
                  (is_tuple(value) and tuple_size(value) in [2, 3, 4])

  defguard is_font_like(value)
           when is_font(value) or
                  is_struct(value, Font.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 6)

  defguard is_glyph_info_like(value)
           when is_glyph_info(value) or
                  is_struct(value, GlyphInfo.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5)

  defguard is_image_like(value)
           when is_image(value) or
                  is_struct(value, Image.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5)

  defguard is_material_like(value)
           when is_material(value) or
                  is_struct(value, Material.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

  defguard is_material_map_like(value)
           when is_material_map(value) or
                  is_struct(value, MaterialMap.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

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

  defguard is_mesh_like(value)
           when is_mesh(value) or
                  is_struct(value, Mesh.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 17)

  defguard is_model_like(value)
           when is_model(value) or
                  is_struct(value, Model.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 9)

  defguard is_model_animation_like(value)
           when is_model_animation(value) or
                  is_struct(value, ModelAnimation.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5)

  defguard is_n_patch_info_like(value)
           when is_n_patch_info(value) or
                  is_struct(value, NPatchInfo.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 6)

  defguard is_quaternion_like(value)
           when is_quaternion(value) or
                  is_struct(value, Quaternion.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 4) or
                  is_struct(value, Vector4)

  defguard is_ray_like(value)
           when is_ray(value) or
                  is_struct(value, Ray.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 2)

  defguard is_rectangle_like(value)
           when is_rectangle(value) or
                  is_struct(value, Rectangle.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 4)

  defguard is_render_texture_like(value)
           when is_render_texture(value) or
                  is_struct(value, RenderTexture.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3) or
                  is_struct(value, RenderTexture2D) or
                  is_struct(value, RenderTexture2D.Resource)

  defguard is_render_texture_2d_like(value)
           when is_render_texture_2d(value) or
                  is_struct(value, RenderTexture2D.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3) or
                  is_struct(value, RenderTexture) or
                  is_struct(value, RenderTexture.Resource)

  defguard is_shader_like(value)
           when is_shader(value) or
                  is_struct(value, Shader.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 2)

  defguard is_texture_like(value)
           when is_texture(value) or
                  is_struct(value, Texture.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5) or
                  is_struct(value, Texture2D) or
                  is_struct(value, Texture2D.Resource) or
                  is_struct(value, TextureCubemap) or
                  is_struct(value, TextureCubemap.Resource)

  defguard is_texture_2d_like(value)
           when is_texture_2d(value) or
                  is_struct(value, Texture2D.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5) or
                  is_struct(value, Texture) or
                  is_struct(value, Texture.Resource)

  defguard is_texture_cubemap_like(value)
           when is_texture_cubemap(value) or
                  is_struct(value, TextureCubemap.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 5) or
                  is_struct(value, Texture) or
                  is_struct(value, Texture.Resource)

  defguard is_transform_like(value)
           when is_transform(value) or
                  is_struct(value, Transform.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

  defguard is_vector2_like(value)
           when is_vector2(value) or
                  is_struct(value, Vector2.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 2)

  defguard is_vector3_like(value)
           when is_vector3(value) or
                  is_struct(value, Vector3.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 3)

  defguard is_vector4_like(value)
           when is_vector4(value) or
                  is_struct(value, Vector4.Resource) or
                  is_structable(value) or
                  (is_tuple(value) and tuple_size(value) == 4) or
                  is_struct(value, Quaternion)
end
