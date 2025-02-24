defmodule Zexray.TypeTest do
  use ExUnit.Case, async: true

  import ExUnitParameterize

  alias Zexray.TypeFixture

  describe "nif conversion" do
    defp valid_to_nif?(value) when is_struct(value), do: false

    defp valid_to_nif?(value) when is_map(value) do
      if Map.keys(value) == [:reference] do
        false
      else
        value
        |> Enum.all?(fn {_k, v} ->
          valid_to_nif?(v)
        end)
      end
    end

    defp valid_to_nif?([]), do: true

    defp valid_to_nif?(value) when is_list(value) do
      value
      |> Enum.all?(fn v ->
        valid_to_nif?(v)
      end)
    end

    defp valid_to_nif?({}), do: false

    defp valid_to_nif?(value) when is_tuple(value) do
      value
      |> Tuple.to_list()
      |> Enum.all?(fn v ->
        valid_to_nif?(v)
      end)
    end

    defp valid_to_nif?(value) when is_number(value), do: true
    defp valid_to_nif?(value) when is_atom(value), do: true
    defp valid_to_nif?(value) when is_binary(value), do: true
    defp valid_to_nif?(value) when is_reference(value), do: true

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
        # resource
        vector2_resource: {"vector2", :resource},
        vector3_resource: {"vector3", :resource},
        vector4_resource: {"vector4", :resource},
        quaternion_resource: {"quaternion", :resource},
        matrix_resource: {"matrix", :resource},
        color_resource: {"color", :resource},
        rectangle_resource: {"rectangle", :resource},
        image_resource: {"image", :resource},
        texture_resource: {"texture", :resource},
        texture_2d_resource: {"texture_2d", :resource},
        texture_cubemap_resource: {"texture_cubemap", :resource},
        render_texture_resource: {"render_texture", :resource},
        render_texture_2d_resource: {"render_texture_2d", :resource},
        n_patch_info_resource: {"n_patch_info", :resource},
        glyph_info_resource: {"glyph_info", :resource},
        font_resource: {"font", :resource},
        camera_3d_resource: {"camera_3d", :resource},
        camera_resource: {"camera", :resource},
        camera_2d_resource: {"camera_2d", :resource},
        mesh_resource: {"mesh", :resource},
        shader_resource: {"shader", :resource},
        material_map_resource: {"material_map", :resource},
        material_resource: {"material", :resource},
        transform_resource: {"transform", :resource},
        bone_info_resource: {"bone_info", :resource},
        model_resource: {"model", :resource},
        model_animation_resource: {"model_animation", :resource},
        ray_resource: {"ray", :resource},
        ray_collision_resource: {"ray_collision", :resource},
        bounding_box_resource: {"bounding_box", :resource},
        wave_resource: {"wave", :resource},
        audio_stream_resource: {"audio_stream", :resource},
        sound_resource: {"sound", :resource},
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
        sound_empty: {"sound", :empty}
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
      # resource
      [dataset: :vector2_resource],
      [dataset: :vector3_resource],
      [dataset: :vector4_resource],
      [dataset: :quaternion_resource],
      [dataset: :matrix_resource],
      [dataset: :color_resource],
      [dataset: :rectangle_resource],
      [dataset: :image_resource],
      [dataset: :texture_resource],
      [dataset: :texture_2d_resource],
      [dataset: :texture_cubemap_resource],
      [dataset: :render_texture_resource],
      [dataset: :render_texture_2d_resource],
      [dataset: :n_patch_info_resource],
      [dataset: :glyph_info_resource],
      [dataset: :font_resource],
      [dataset: :camera_3d_resource],
      [dataset: :camera_resource],
      [dataset: :camera_2d_resource],
      [dataset: :mesh_resource],
      [dataset: :shader_resource],
      [dataset: :material_map_resource],
      [dataset: :material_resource],
      [dataset: :transform_resource],
      [dataset: :bone_info_resource],
      [dataset: :model_resource],
      [dataset: :model_animation_resource],
      [dataset: :ray_resource],
      [dataset: :ray_collision_resource],
      [dataset: :bounding_box_resource],
      [dataset: :wave_resource],
      [dataset: :audio_stream_resource],
      [dataset: :sound_resource],
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
      [dataset: :sound_empty]
    ] do
      dataset = Map.fetch!(datasets, dataset)

      {prefix, type} = dataset

      fixture = String.to_atom("#{prefix}_fixture")
      value = apply(TypeFixture, fixture, [type])

      module = value.__struct__
      module_resource = String.to_atom("#{Atom.to_string(module)}.Resource")

      value_to_nif = apply(module, :to_nif, [value])
      assert valid_to_nif?(value_to_nif)

      value_from_nif = apply(module, :from_nif, [value_to_nif])
      assert value == value_from_nif

      ref = make_ref()
      value_resource = apply(module_resource, :new, [ref])

      assert ref == apply(module, :to_nif, [ref])
      assert ref == apply(module, :to_nif, [value_resource])
      assert value_resource == apply(module, :from_nif, [ref])
    end
  end
end
