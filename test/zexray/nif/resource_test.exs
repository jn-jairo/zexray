defmodule Zexray.NIF.ResourceTest do
  use ExUnit.Case, async: true

  import ExUnitParameterize
  import Zexray.Util, only: [similar?: 2]

  alias Zexray.NIF
  alias Zexray.TypeFixture

  describe "resource conversion" do
    defp dataset_resource_conversion(_) do
      datasets = %{
        # base
        vector2: {"vector2", :base},
        vector3: {"vector3", :base},
        vector4: {"vector4", :base},
        quaternion: {"quaternion", :base},
        matrix: {"matrix", :base},
        color: {"color", :base},
        rectangle: {"rectangle", :base},
        image: {"image", :base},
        texture: {"texture", :base},
        texture_2d: {"texture_2d", :base},
        texture_cubemap: {"texture_cubemap", :base},
        render_texture: {"render_texture", :base},
        render_texture_2d: {"render_texture_2d", :base},
        n_patch_info: {"n_patch_info", :base},
        glyph_info: {"glyph_info", :base},
        font: {"font", :base},
        camera_3d: {"camera_3d", :base},
        camera: {"camera", :base},
        camera_2d: {"camera_2d", :base},
        mesh: {"mesh", :base},
        shader: {"shader", :base},
        material_map: {"material_map", :base},
        material: {"material", :base},
        transform: {"transform", :base},
        bone_info: {"bone_info", :base},
        model: {"model", :base},
        model_animation: {"model_animation", :base},
        ray: {"ray", :base},
        ray_collision: {"ray_collision", :base},
        bounding_box: {"bounding_box", :base},
        wave: {"wave", :base},
        audio_stream: {"audio_stream", :base},
        sound: {"sound", :base},
        music: {"music", :base},
        vr_device_info: {"vr_device_info", :base},
        vr_stereo_config: {"vr_stereo_config", :base},
        # empty
        vector2_empty: {"vector2", :empty},
        vector3_empty: {"vector3", :empty},
        vector4_empty: {"vector4", :empty},
        quaternion_empty: {"quaternion", :empty},
        matrix_empty: {"matrix", :empty},
        color_empty: {"color", :empty},
        rectangle_empty: {"rectangle", :empty},
        image_empty: {"image", :empty},
        texture_empty: {"texture", :empty},
        texture_2d_empty: {"texture_2d", :empty},
        texture_cubemap_empty: {"texture_cubemap", :empty},
        render_texture_empty: {"render_texture", :empty},
        render_texture_2d_empty: {"render_texture_2d", :empty},
        n_patch_info_empty: {"n_patch_info", :empty},
        glyph_info_empty: {"glyph_info", :empty},
        font_empty: {"font", :empty},
        camera_3d_empty: {"camera_3d", :empty},
        camera_empty: {"camera", :empty},
        camera_2d_empty: {"camera_2d", :empty},
        mesh_empty: {"mesh", :empty},
        shader_empty: {"shader", :empty},
        material_map_empty: {"material_map", :empty},
        material_empty: {"material", :empty},
        transform_empty: {"transform", :empty},
        bone_info_empty: {"bone_info", :empty},
        model_empty: {"model", :empty},
        model_animation_empty: {"model_animation", :empty},
        ray_empty: {"ray", :empty},
        ray_collision_empty: {"ray_collision", :empty},
        bounding_box_empty: {"bounding_box", :empty},
        wave_empty: {"wave", :empty},
        audio_stream_empty: {"audio_stream", :empty},
        sound_empty: {"sound", :empty},
        music_empty: {"music", :empty},
        vr_device_info_empty: {"vr_device_info", :empty},
        vr_stereo_config_empty: {"vr_stereo_config", :empty}
      }

      %{datasets: datasets}
    end

    setup [:dataset_resource_conversion]

    parameterized_test "", %{datasets: datasets}, [
      # base
      [dataset: :vector2],
      [dataset: :vector3],
      [dataset: :vector4],
      [dataset: :quaternion],
      [dataset: :matrix],
      [dataset: :color],
      [dataset: :rectangle],
      [dataset: :image],
      [dataset: :texture],
      [dataset: :texture_2d],
      [dataset: :texture_cubemap],
      [dataset: :render_texture],
      [dataset: :render_texture_2d],
      [dataset: :n_patch_info],
      [dataset: :glyph_info],
      [dataset: :font],
      [dataset: :camera_3d],
      [dataset: :camera],
      [dataset: :camera_2d],
      [dataset: :mesh],
      [dataset: :shader],
      [dataset: :material_map],
      [dataset: :material],
      [dataset: :transform],
      [dataset: :bone_info],
      [dataset: :model],
      [dataset: :model_animation],
      [dataset: :ray],
      [dataset: :ray_collision],
      [dataset: :bounding_box],
      [dataset: :wave],
      [dataset: :audio_stream],
      [dataset: :sound],
      [dataset: :music],
      [dataset: :vr_device_info],
      [dataset: :vr_stereo_config],
      # empty
      [dataset: :vector2_empty],
      [dataset: :vector3_empty],
      [dataset: :vector4_empty],
      [dataset: :quaternion_empty],
      [dataset: :matrix_empty],
      [dataset: :color_empty],
      [dataset: :rectangle_empty],
      [dataset: :image_empty],
      [dataset: :texture_empty],
      [dataset: :texture_2d_empty],
      [dataset: :texture_cubemap_empty],
      [dataset: :render_texture_empty],
      [dataset: :render_texture_2d_empty],
      [dataset: :n_patch_info_empty],
      [dataset: :glyph_info_empty],
      [dataset: :font_empty],
      [dataset: :camera_3d_empty],
      [dataset: :camera_empty],
      [dataset: :camera_2d_empty],
      [dataset: :mesh_empty],
      [dataset: :shader_empty],
      [dataset: :material_map_empty],
      [dataset: :material_empty],
      [dataset: :transform_empty],
      [dataset: :bone_info_empty],
      [dataset: :model_empty],
      [dataset: :model_animation_empty],
      [dataset: :ray_empty],
      [dataset: :ray_collision_empty],
      [dataset: :bounding_box_empty],
      [dataset: :wave_empty],
      [dataset: :audio_stream_empty],
      [dataset: :sound_empty],
      [dataset: :music_empty],
      [dataset: :vr_device_info_empty],
      [dataset: :vr_stereo_config_empty]
    ] do
      dataset = Map.fetch!(datasets, dataset)

      {prefix, type} = dataset

      from_resource = String.to_atom("#{prefix}_from_resource")
      to_resource = String.to_atom("#{prefix}_to_resource")
      free_resource = String.to_atom("#{prefix}_free_resource")
      fixture = String.to_atom("#{prefix}_fixture")

      assert_raise ArgumentError, fn -> apply(NIF, from_resource, [make_ref()]) end

      value = apply(TypeFixture, fixture, [type])
      resource = apply(NIF, to_resource, [value])

      assert is_reference(resource)
      assert similar?(value, apply(NIF, from_resource, [resource]))

      apply(NIF, free_resource, [resource])
    end
  end
end
