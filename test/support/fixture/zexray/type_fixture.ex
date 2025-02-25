defmodule Zexray.TypeFixture do
  @moduledoc false

  alias Zexray.Type.{
    AudioStream,
    BoneInfo,
    BoundingBox,
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
    Wave
  }

  def audio_stream_fixture(type \\ :base, attrs \\ %{}) do
    sample_rate = 16_000
    sample_size = 8
    channels = 1

    case type do
      :base ->
        %{
          buffer: nil,
          processor: nil,
          sample_rate: sample_rate,
          sample_size: sample_size,
          channels: channels
        }

      :resource ->
        %{
          buffer: make_ref(),
          processor: make_ref(),
          sample_rate: sample_rate,
          sample_size: sample_size,
          channels: channels
        }

      :empty ->
        %{
          buffer: nil,
          processor: nil,
          sample_rate: 0,
          sample_size: 0,
          channels: 0
        }
    end
    |> Map.merge(attrs)
    |> AudioStream.new()
  end

  def bone_info_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      t when t in [:base, :resource] ->
        %{
          name:
            Enum.map(1..Zexray.Model.bone_info_max_name(), fn n -> "#{rem(n, 10)}" end)
            |> Enum.join(),
          parent: 1
        }

      :empty ->
        %{
          name: "",
          parent: 0
        }
    end
    |> Map.merge(attrs)
    |> BoneInfo.new()
  end

  def bounding_box_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      :base ->
        %{
          min: vector3_fixture(type),
          max: vector3_fixture(type)
        }

      :resource ->
        %{
          min: make_ref(),
          max: make_ref()
        }

      :empty ->
        %{
          min: vector3_fixture(type),
          max: vector3_fixture(type)
        }
    end
    |> Map.merge(attrs)
    |> BoundingBox.new()
  end

  def camera_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      :base ->
        %{
          position: vector3_fixture(type),
          target: vector3_fixture(type),
          up: vector3_fixture(type),
          fovy: 1.5,
          projection: 0
        }

      :resource ->
        %{
          position: make_ref(),
          target: make_ref(),
          up: make_ref(),
          fovy: 1.5,
          projection: 0
        }

      :empty ->
        %{
          position: vector3_fixture(type),
          target: vector3_fixture(type),
          up: vector3_fixture(type),
          fovy: 0.0,
          projection: 0
        }
    end
    |> Map.merge(attrs)
    |> Camera.new()
  end

  def camera_2d_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      :base ->
        %{
          offset: vector2_fixture(type),
          target: vector2_fixture(type),
          rotation: 0.0,
          zoom: 1.0
        }

      :resource ->
        %{
          offset: make_ref(),
          target: make_ref(),
          rotation: 0.0,
          zoom: 1.0
        }

      :empty ->
        %{
          offset: vector2_fixture(type),
          target: vector2_fixture(type),
          rotation: 0.0,
          zoom: 0.0
        }
    end
    |> Map.merge(attrs)
    |> Camera2D.new()
  end

  def camera_3d_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      :base ->
        %{
          position: vector3_fixture(type),
          target: vector3_fixture(type),
          up: vector3_fixture(type),
          fovy: 1.5,
          projection: 0
        }

      :resource ->
        %{
          position: make_ref(),
          target: make_ref(),
          up: make_ref(),
          fovy: 1.5,
          projection: 0
        }

      :empty ->
        %{
          position: vector3_fixture(type),
          target: vector3_fixture(type),
          up: vector3_fixture(type),
          fovy: 0.0,
          projection: 0
        }
    end
    |> Map.merge(attrs)
    |> Camera3D.new()
  end

  def color_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      t when t in [:base, :resource] ->
        %{
          r: 0x87,
          g: 0x3C,
          b: 0xBE,
          a: 0xFF
        }

      :empty ->
        %{
          r: 0,
          g: 0,
          b: 0,
          a: 0
        }

      value when is_atom(value) ->
        Color.new(value)
        |> Map.from_struct()
    end
    |> Map.merge(attrs)
    |> Color.new()
  end

  def font_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      :base ->
        %{
          base_size: 32,
          glyph_count: 3,
          glyph_padding: 4,
          texture: texture_fixture(type),
          recs: Enum.map(1..3, fn _ -> rectangle_fixture(type) end),
          glyphs: Enum.map(1..3, fn _ -> glyph_info_fixture(type) end)
        }

      :resource ->
        %{
          base_size: 32,
          glyph_count: 3,
          glyph_padding: 4,
          texture: make_ref(),
          recs: Enum.map(1..3, fn _ -> make_ref() end),
          glyphs: Enum.map(1..3, fn _ -> make_ref() end)
        }

      :empty ->
        %{
          base_size: 0,
          glyph_count: 0,
          glyph_padding: 0,
          texture: texture_fixture(type),
          recs: [],
          glyphs: []
        }
    end
    |> Map.merge(attrs)
    |> Font.new()
  end

  def glyph_info_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      :base ->
        %{
          value: 65,
          offset_x: 1,
          offset_y: 2,
          advance_x: 3,
          image: image_fixture(type)
        }

      :resource ->
        %{
          value: 65,
          offset_x: 1,
          offset_y: 2,
          advance_x: 3,
          image: make_ref()
        }

      :empty ->
        %{
          value: 0,
          offset_x: 0,
          offset_y: 0,
          advance_x: 0,
          image: image_fixture(type)
        }
    end
    |> Map.merge(attrs)
    |> GlyphInfo.new()
  end

  def image_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      t when t in [:base, :resource] ->
        %{
          data:
            <<18, 35, 52, 255, 18, 35, 52, 255, 18, 35, 52, 255, 18, 35, 52, 255, 18, 35, 52, 255,
              18, 35, 52, 255, 18, 35, 52, 255, 18, 35, 52, 255>>,
          width: 4,
          height: 2,
          mipmaps: 1,
          format: 7
        }

      :empty ->
        %{
          data: <<>>,
          width: 0,
          height: 0,
          mipmaps: 0,
          format: 0
        }
    end
    |> Map.merge(attrs)
    |> Image.new()
  end

  def material_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      :base ->
        %{
          shader: shader_fixture(type),
          maps: Enum.map(1..Zexray.Material.max_maps(), fn _ -> material_map_fixture(type) end),
          params:
            Enum.map(1..Zexray.Material.max_params(), fn n -> Float.round(1.0 + n / 100, 2) end)
        }

      :resource ->
        %{
          shader: make_ref(),
          maps: Enum.map(1..Zexray.Material.max_maps(), fn _ -> make_ref() end),
          params:
            Enum.map(1..Zexray.Material.max_params(), fn n -> Float.round(1.0 + n / 100, 2) end)
        }

      :empty ->
        %{
          shader: shader_fixture(type),
          maps: Enum.map(1..Zexray.Material.max_maps(), fn _ -> material_map_fixture(type) end),
          params: Enum.map(1..Zexray.Material.max_params(), fn _ -> 0.0 end)
        }
    end
    |> Map.merge(attrs)
    |> Material.new()
  end

  def material_map_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      :base ->
        %{
          texture: texture_2d_fixture(type),
          color: color_fixture(type),
          value: 1.23
        }

      :resource ->
        %{
          texture: make_ref(),
          color: make_ref(),
          value: 1.23
        }

      :empty ->
        %{
          texture: texture_2d_fixture(type),
          color: color_fixture(type),
          value: 0.0
        }
    end
    |> Map.merge(attrs)
    |> MaterialMap.new()
  end

  def matrix_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      t when t in [:base, :resource] ->
        %{
          m0: 1.00,
          m1: 1.01,
          m2: 1.02,
          m3: 1.03,
          m4: 1.04,
          m5: 1.05,
          m6: 1.06,
          m7: 1.07,
          m8: 1.08,
          m9: 1.09,
          m10: 1.10,
          m11: 1.11,
          m12: 1.12,
          m13: 1.13,
          m14: 1.14,
          m15: 1.15
        }

      :empty ->
        %{
          m0: 0.0,
          m1: 0.0,
          m2: 0.0,
          m3: 0.0,
          m4: 0.0,
          m5: 0.0,
          m6: 0.0,
          m7: 0.0,
          m8: 0.0,
          m9: 0.0,
          m10: 0.0,
          m11: 0.0,
          m12: 0.0,
          m13: 0.0,
          m14: 0.0,
          m15: 0.0
        }
    end
    |> Map.merge(attrs)
    |> Matrix.new()
  end

  def mesh_fixture(type \\ :base, attrs \\ %{}) do
    vertex_count = 4
    triangle_count = 2
    bone_count = 3

    case type do
      :base ->
        %{
          vertex_count: 4,
          triangle_count: 2,
          vertices: Enum.map(1..(vertex_count * 3), fn n -> Float.round(1.0 + n / 100, 2) end),
          texcoords: Enum.map(1..(vertex_count * 2), fn n -> Float.round(1.0 + n / 100, 2) end),
          texcoords2: Enum.map(1..(vertex_count * 2), fn n -> Float.round(1.0 + n / 100, 2) end),
          normals: Enum.map(1..(vertex_count * 3), fn n -> Float.round(1.0 + n / 100, 2) end),
          tangents: Enum.map(1..(vertex_count * 4), fn n -> Float.round(1.0 + n / 100, 2) end),
          colors: Enum.map(1..(vertex_count * 4), fn n -> n end),
          indices: Enum.map(1..(triangle_count * 3), fn n -> n end),
          anim_vertices:
            Enum.map(1..(vertex_count * 3), fn n -> Float.round(1.0 + n / 100, 2) end),
          anim_normals:
            Enum.map(1..(vertex_count * 3), fn n -> Float.round(1.0 + n / 100, 2) end),
          bone_ids: Enum.map(1..(vertex_count * 4), fn n -> n end),
          bone_weights:
            Enum.map(1..(vertex_count * 4), fn n -> Float.round(1.0 + n / 100, 2) end),
          bone_matrices: Enum.map(1..bone_count, fn _ -> matrix_fixture(type) end),
          bone_count: bone_count,
          vao_id: 0,
          vbo_id: Enum.map(1..Zexray.Mesh.max_vertex_buffers(), fn _ -> 0 end)
        }

      :resource ->
        %{
          vertex_count: 4,
          triangle_count: 2,
          vertices: Enum.map(1..(vertex_count * 3), fn n -> Float.round(1.0 + n / 100, 2) end),
          texcoords: Enum.map(1..(vertex_count * 2), fn n -> Float.round(1.0 + n / 100, 2) end),
          texcoords2: Enum.map(1..(vertex_count * 2), fn n -> Float.round(1.0 + n / 100, 2) end),
          normals: Enum.map(1..(vertex_count * 3), fn n -> Float.round(1.0 + n / 100, 2) end),
          tangents: Enum.map(1..(vertex_count * 4), fn n -> Float.round(1.0 + n / 100, 2) end),
          colors: Enum.map(1..(vertex_count * 4), fn n -> n end),
          indices: Enum.map(1..(triangle_count * 3), fn n -> n end),
          anim_vertices:
            Enum.map(1..(vertex_count * 3), fn n -> Float.round(1.0 + n / 100, 2) end),
          anim_normals:
            Enum.map(1..(vertex_count * 3), fn n -> Float.round(1.0 + n / 100, 2) end),
          bone_ids: Enum.map(1..(vertex_count * 4), fn n -> n end),
          bone_weights:
            Enum.map(1..(vertex_count * 4), fn n -> Float.round(1.0 + n / 100, 2) end),
          bone_matrices: Enum.map(1..bone_count, fn _ -> make_ref() end),
          bone_count: bone_count,
          vao_id: 0,
          vbo_id: Enum.map(1..Zexray.Mesh.max_vertex_buffers(), fn _ -> 0 end)
        }

      :empty ->
        %{
          vertex_count: 0,
          triangle_count: 0,
          vertices: [],
          texcoords: [],
          texcoords2: [],
          normals: [],
          tangents: [],
          colors: [],
          indices: [],
          anim_vertices: [],
          anim_normals: [],
          bone_ids: [],
          bone_weights: [],
          bone_matrices: [],
          bone_count: 0,
          vao_id: 0,
          vbo_id: []
        }
    end
    |> Map.merge(attrs)
    |> Mesh.new()
  end

  def model_fixture(type \\ :base, attrs \\ %{}) do
    mesh_count = 2
    material_count = 2
    bone_count = 3

    case type do
      :base ->
        %{
          transform: matrix_fixture(type),
          mesh_count: mesh_count,
          material_count: material_count,
          meshes: Enum.map(1..mesh_count, fn _ -> mesh_fixture(type) end),
          materials: Enum.map(1..material_count, fn _ -> material_fixture(type) end),
          mesh_material: Enum.map(0..(mesh_count - 1), fn n -> n end),
          bone_count: bone_count,
          bones: Enum.map(1..bone_count, fn _ -> bone_info_fixture(type) end),
          bind_pose: Enum.map(1..bone_count, fn _ -> transform_fixture(type) end)
        }

      :resource ->
        %{
          transform: make_ref(),
          mesh_count: mesh_count,
          material_count: material_count,
          meshes: Enum.map(1..mesh_count, fn _ -> make_ref() end),
          materials: Enum.map(1..material_count, fn _ -> make_ref() end),
          mesh_material: Enum.map(0..(mesh_count - 1), fn n -> n end),
          bone_count: bone_count,
          bones: Enum.map(1..bone_count, fn _ -> make_ref() end),
          bind_pose: Enum.map(1..bone_count, fn _ -> make_ref() end)
        }

      :empty ->
        %{
          transform: matrix_fixture(type),
          mesh_count: 0,
          material_count: 0,
          meshes: [],
          materials: [],
          mesh_material: [],
          bone_count: 0,
          bones: [],
          bind_pose: []
        }
    end
    |> Map.merge(attrs)
    |> Model.new()
  end

  def model_animation_fixture(type \\ :base, attrs \\ %{}) do
    bone_count = 3
    frame_count = 2

    case type do
      :base ->
        %{
          bone_count: bone_count,
          frame_count: frame_count,
          bones: Enum.map(1..bone_count, fn _ -> bone_info_fixture(type) end),
          frame_poses:
            Enum.map(1..frame_count, fn _ ->
              Enum.map(1..bone_count, fn _ ->
                transform_fixture(type)
              end)
            end),
          name:
            Enum.map(1..Zexray.Model.model_animation_max_name(), fn n -> "#{rem(n, 10)}" end)
            |> Enum.join()
        }

      :resource ->
        %{
          bone_count: bone_count,
          frame_count: frame_count,
          bones: Enum.map(1..bone_count, fn _ -> make_ref() end),
          frame_poses:
            Enum.map(1..frame_count, fn _ ->
              Enum.map(1..bone_count, fn _ ->
                make_ref()
              end)
            end),
          name:
            Enum.map(1..Zexray.Model.model_animation_max_name(), fn n -> "#{rem(n, 10)}" end)
            |> Enum.join()
        }

      :empty ->
        %{
          bone_count: 0,
          frame_count: 0,
          bones: [],
          frame_poses: [],
          name: ""
        }
    end
    |> Map.merge(attrs)
    |> ModelAnimation.new()
  end

  def music_fixture(type \\ :base, attrs \\ %{}) do
    frame_count = 24_000
    looping = true

    case type do
      :base ->
        %{
          stream: audio_stream_fixture(type),
          frame_count: frame_count,
          looping: looping,
          ctx_type: 0,
          ctx_data: nil
        }

      :resource ->
        %{
          stream: make_ref(),
          frame_count: frame_count,
          looping: looping,
          ctx_type: 0,
          ctx_data: make_ref()
        }

      :empty ->
        %{
          stream: audio_stream_fixture(type),
          frame_count: 0,
          looping: false,
          ctx_type: 0,
          ctx_data: nil
        }
    end
    |> Map.merge(attrs)
    |> Music.new()
  end

  def n_patch_info_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      :base ->
        %{
          source: rectangle_fixture(type),
          left: 0,
          top: 1,
          right: 2,
          bottom: 3,
          layout: 0
        }

      :resource ->
        %{
          source: make_ref(),
          left: 0,
          top: 1,
          right: 2,
          bottom: 3,
          layout: 0
        }

      :empty ->
        %{
          source: rectangle_fixture(type),
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          layout: 0
        }
    end
    |> Map.merge(attrs)
    |> NPatchInfo.new()
  end

  def quaternion_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      t when t in [:base, :resource] ->
        %{
          x: 1.23,
          y: 2.34,
          z: 3.45,
          w: 4.56
        }

      :empty ->
        %{
          x: 0.0,
          y: 0.0,
          z: 0.0,
          w: 0.0
        }
    end
    |> Map.merge(attrs)
    |> Quaternion.new()
  end

  def ray_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      :base ->
        %{
          position: vector3_fixture(type),
          direction: vector3_fixture(type)
        }

      :resource ->
        %{
          position: make_ref(),
          direction: make_ref()
        }

      :empty ->
        %{
          position: vector3_fixture(type),
          direction: vector3_fixture(type)
        }
    end
    |> Map.merge(attrs)
    |> Ray.new()
  end

  def ray_collision_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      :base ->
        %{
          hit: true,
          distance: 2.34,
          point: vector3_fixture(type),
          normal: vector3_fixture(type)
        }

      :resource ->
        %{
          hit: true,
          distance: 2.34,
          point: make_ref(),
          normal: make_ref()
        }

      :empty ->
        %{
          hit: false,
          distance: 0.0,
          point: vector3_fixture(type),
          normal: vector3_fixture(type)
        }
    end
    |> Map.merge(attrs)
    |> RayCollision.new()
  end

  def rectangle_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      t when t in [:base, :resource] ->
        %{
          x: 1.23,
          y: 2.34,
          width: 123.45,
          height: 234.56
        }

      :empty ->
        %{
          x: 0.0,
          y: 0.0,
          width: 0.0,
          height: 0.0
        }
    end
    |> Map.merge(attrs)
    |> Rectangle.new()
  end

  def render_texture_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      :base ->
        %{
          id: 0,
          texture: texture_fixture(type),
          depth: texture_fixture(type)
        }

      :resource ->
        %{
          id: 0,
          texture: make_ref(),
          depth: make_ref()
        }

      :empty ->
        %{
          id: 0,
          texture: texture_fixture(type),
          depth: texture_fixture(type)
        }
    end
    |> Map.merge(attrs)
    |> RenderTexture.new()
  end

  def render_texture_2d_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      :base ->
        %{
          id: 0,
          texture: texture_fixture(type),
          depth: texture_fixture(type)
        }

      :resource ->
        %{
          id: 0,
          texture: make_ref(),
          depth: make_ref()
        }

      :empty ->
        %{
          id: 0,
          texture: texture_fixture(type),
          depth: texture_fixture(type)
        }
    end
    |> Map.merge(attrs)
    |> RenderTexture2D.new()
  end

  def shader_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      t when t in [:base, :resource] ->
        %{
          id: 0,
          locs: Enum.map(1..Zexray.Shader.max_locations(), fn _ -> -1 end)
        }

      :empty ->
        %{
          id: 0,
          locs: []
        }
    end
    |> Map.merge(attrs)
    |> Shader.new()
  end

  def sound_fixture(type \\ :base, attrs \\ %{}) do
    frame_count = 24_000

    case type do
      :base ->
        %{
          stream: audio_stream_fixture(type),
          frame_count: frame_count
        }

      :resource ->
        %{
          stream: make_ref(),
          frame_count: frame_count
        }

      :empty ->
        %{
          stream: audio_stream_fixture(type),
          frame_count: 0
        }
    end
    |> Map.merge(attrs)
    |> Sound.new()
  end

  def texture_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      t when t in [:base, :resource] ->
        %{
          id: 0,
          width: 800,
          height: 600,
          mipmaps: 1,
          format: 7
        }

      :empty ->
        %{
          id: 0,
          width: 0,
          height: 0,
          mipmaps: 0,
          format: 0
        }
    end
    |> Map.merge(attrs)
    |> Texture.new()
  end

  def texture_2d_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      t when t in [:base, :resource] ->
        %{
          id: 0,
          width: 800,
          height: 600,
          mipmaps: 1,
          format: 7
        }

      :empty ->
        %{
          id: 0,
          width: 0,
          height: 0,
          mipmaps: 0,
          format: 0
        }
    end
    |> Map.merge(attrs)
    |> Texture2D.new()
  end

  def texture_cubemap_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      t when t in [:base, :resource] ->
        %{
          id: 0,
          width: 800,
          height: 600,
          mipmaps: 1,
          format: 7
        }

      :empty ->
        %{
          id: 0,
          width: 0,
          height: 0,
          mipmaps: 0,
          format: 0
        }
    end
    |> Map.merge(attrs)
    |> TextureCubemap.new()
  end

  def transform_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      :base ->
        %{
          translation: vector3_fixture(type),
          rotation: quaternion_fixture(type),
          scale: vector3_fixture(type)
        }

      :resource ->
        %{
          translation: make_ref(),
          rotation: make_ref(),
          scale: make_ref()
        }

      :empty ->
        %{
          translation: vector3_fixture(type),
          rotation: quaternion_fixture(type),
          scale: vector3_fixture(type)
        }
    end
    |> Map.merge(attrs)
    |> Transform.new()
  end

  def vector2_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      t when t in [:base, :resource] ->
        %{
          x: 1.23,
          y: 2.34
        }

      :empty ->
        %{
          x: 0.0,
          y: 0.0
        }
    end
    |> Map.merge(attrs)
    |> Vector2.new()
  end

  def vector3_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      t when t in [:base, :resource] ->
        %{
          x: 1.23,
          y: 2.34,
          z: 3.45
        }

      :empty ->
        %{
          x: 0.0,
          y: 0.0,
          z: 0.0
        }
    end
    |> Map.merge(attrs)
    |> Vector3.new()
  end

  def vector4_fixture(type \\ :base, attrs \\ %{}) do
    case type do
      t when t in [:base, :resource] ->
        %{
          x: 1.23,
          y: 2.34,
          z: 3.45,
          w: 4.56
        }

      :empty ->
        %{
          x: 0.0,
          y: 0.0,
          z: 0.0,
          w: 0.0
        }
    end
    |> Map.merge(attrs)
    |> Vector4.new()
  end

  def vr_device_info_fixture(type \\ :base, attrs \\ %{}) do
    h_resolution = 800
    v_resolution = 600
    h_screen_size = 1920.0
    v_screen_size = 1440.0
    eye_to_screen_distance = 123.45
    lens_separation_distance = 1.23
    interpupillary_distance = 0.12

    case type do
      t when t in [:base, :resource] ->
        %{
          h_resolution: h_resolution,
          v_resolution: v_resolution,
          h_screen_size: h_screen_size,
          v_screen_size: v_screen_size,
          eye_to_screen_distance: eye_to_screen_distance,
          lens_separation_distance: lens_separation_distance,
          interpupillary_distance: interpupillary_distance,
          lens_distortion_values:
            Enum.map(1..Zexray.Vr.vr_device_info_max_lens_distortion_values(), fn n ->
              Float.round(1.0 + n / 100, 2)
            end),
          chroma_ab_correction:
            Enum.map(1..Zexray.Vr.vr_device_info_max_chroma_ab_correction(), fn n ->
              Float.round(1.0 + n / 100, 2)
            end)
        }

      :empty ->
        %{
          h_resolution: 0,
          v_resolution: 0,
          h_screen_size: 0.0,
          v_screen_size: 0.0,
          eye_to_screen_distance: 0.0,
          lens_separation_distance: 0.0,
          interpupillary_distance: 0.0,
          lens_distortion_values:
            Enum.map(1..Zexray.Vr.vr_device_info_max_lens_distortion_values(), fn _ -> 0.0 end),
          chroma_ab_correction:
            Enum.map(1..Zexray.Vr.vr_device_info_max_chroma_ab_correction(), fn _ -> 0.0 end)
        }
    end
    |> Map.merge(attrs)
    |> VrDeviceInfo.new()
  end

  def wave_fixture(type \\ :base, attrs \\ %{}) do
    frame_count = 24_000
    sample_rate = 16_000
    sample_size = 8
    channels = 1

    case type do
      t when t in [:base, :resource] ->
        %{
          frame_count: frame_count,
          sample_rate: sample_rate,
          sample_size: sample_size,
          channels: channels,
          data:
            Enum.map(1..Zexray.Audio.wave_data_size(frame_count, channels, sample_size), fn n ->
              rem(n, 0x100)
            end)
            |> :binary.list_to_bin()
        }

      :empty ->
        %{
          frame_count: 0,
          sample_rate: 0,
          sample_size: 0,
          channels: 0,
          data: <<>>
        }
    end
    |> Map.merge(attrs)
    |> Wave.new()
  end
end
