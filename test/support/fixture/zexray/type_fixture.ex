defmodule Zexray.TypeFixture do
  @moduledoc false

  require Zexray.Type.{
    AudioInfo,
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
    SoundAlias,
    SoundStream,
    SoundStreamAlias,
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

  alias Zexray.Type.{
    AudioInfo,
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
    SoundAlias,
    SoundStream,
    SoundStreamAlias,
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

  def audio_info_fixture(type \\ :base) do
    frame_count = 24_000
    sample_rate = 16_000
    sample_size = 8
    channels = 1

    case type do
      t when t in [:base, :resource] ->
        AudioInfo.t(
          frame_count: frame_count,
          sample_rate: sample_rate,
          sample_size: sample_size,
          channels: channels
        )

      :empty ->
        AudioInfo.t(
          frame_count: 0,
          sample_rate: 0,
          sample_size: 0,
          channels: 0
        )
    end
  end

  def audio_stream_fixture(type \\ :base) do
    sample_rate = 16_000
    sample_size = 8
    channels = 1

    case type do
      :base ->
        AudioStream.t(
          buffer: nil,
          processor: nil,
          sample_rate: sample_rate,
          sample_size: sample_size,
          channels: channels
        )

      :resource ->
        AudioStream.t(
          buffer: {:audio_buffer_resource, make_ref()},
          processor: {:audio_processor_resource, make_ref()},
          sample_rate: sample_rate,
          sample_size: sample_size,
          channels: channels
        )

      :empty ->
        AudioStream.t(
          buffer: nil,
          processor: nil,
          sample_rate: 0,
          sample_size: 0,
          channels: 0
        )
    end
  end

  def automation_event_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        AutomationEvent.t(
          frame: 1,
          type: 1,
          params: Enum.map(1..Zexray.AutomationEvent.max_params(), fn n -> n end)
        )

      :empty ->
        AutomationEvent.t(
          frame: 0,
          type: 0,
          params: Enum.map(1..Zexray.AutomationEvent.max_params(), fn _ -> 0 end)
        )
    end
  end

  def automation_event_list_fixture(type \\ :base) do
    capacity = min(4, Zexray.AutomationEvent.automation_event_list_max_automation_events())
    count = capacity

    case type do
      :base ->
        AutomationEventList.t(
          capacity: capacity,
          count: count,
          events: Enum.map(1..capacity, fn _ -> automation_event_fixture(type) end)
        )

      :resource ->
        AutomationEventList.t(
          capacity: capacity,
          count: count,
          events:
            Enum.map(1..capacity, fn _ -> AutomationEvent.t_resource(reference: make_ref()) end)
        )

      :empty ->
        AutomationEventList.t(
          capacity: 0,
          count: 0,
          events: []
        )
    end
  end

  def bone_info_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        BoneInfo.t(
          name:
            Enum.map(1..Zexray.Model.bone_info_max_name(), fn n -> "#{rem(n, 10)}" end)
            |> Enum.join(),
          parent: 1
        )

      :empty ->
        BoneInfo.t(
          name: "",
          parent: 0
        )
    end
  end

  def bounding_box_fixture(type \\ :base) do
    case type do
      :base ->
        BoundingBox.t(
          min: vector3_fixture(type),
          max: vector3_fixture(type)
        )

      :resource ->
        BoundingBox.t(
          min: Vector3.t_resource(reference: make_ref()),
          max: Vector3.t_resource(reference: make_ref())
        )

      :empty ->
        BoundingBox.t(
          min: vector3_fixture(type),
          max: vector3_fixture(type)
        )
    end
  end

  def camera_fixture(type \\ :base) do
    case type do
      :base ->
        Camera.t(
          position: vector3_fixture(type),
          target: vector3_fixture(type),
          up: vector3_fixture(type),
          fovy: 1.5,
          projection: 0
        )

      :resource ->
        Camera.t(
          position: Vector3.t_resource(reference: make_ref()),
          target: Vector3.t_resource(reference: make_ref()),
          up: Vector3.t_resource(reference: make_ref()),
          fovy: 1.5,
          projection: 0
        )

      :empty ->
        Camera.t(
          position: vector3_fixture(type),
          target: vector3_fixture(type),
          up: vector3_fixture(type),
          fovy: 0.0,
          projection: 0
        )
    end
  end

  def camera_2d_fixture(type \\ :base) do
    case type do
      :base ->
        Camera2D.t(
          offset: vector2_fixture(type),
          target: vector2_fixture(type),
          rotation: 0.0,
          zoom: 1.0
        )

      :resource ->
        Camera2D.t(
          offset: Vector2.t_resource(reference: make_ref()),
          target: Vector2.t_resource(reference: make_ref()),
          rotation: 0.0,
          zoom: 1.0
        )

      :empty ->
        Camera2D.t(
          offset: vector2_fixture(type),
          target: vector2_fixture(type),
          rotation: 0.0,
          zoom: 0.0
        )
    end
  end

  def camera_3d_fixture(type \\ :base) do
    case type do
      :base ->
        Camera3D.t(
          position: vector3_fixture(type),
          target: vector3_fixture(type),
          up: vector3_fixture(type),
          fovy: 1.5,
          projection: 0
        )

      :resource ->
        Camera3D.t(
          position: Vector3.t_resource(reference: make_ref()),
          target: Vector3.t_resource(reference: make_ref()),
          up: Vector3.t_resource(reference: make_ref()),
          fovy: 1.5,
          projection: 0
        )

      :empty ->
        Camera3D.t(
          position: vector3_fixture(type),
          target: vector3_fixture(type),
          up: vector3_fixture(type),
          fovy: 0.0,
          projection: 0
        )
    end
  end

  def color_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        Color.t(
          r: 0x87,
          g: 0x3C,
          b: 0xBE,
          a: 0xFF
        )

      :empty ->
        Color.t(
          r: 0,
          g: 0,
          b: 0,
          a: 0
        )
    end
  end

  def file_path_list_fixture(type \\ :base) do
    capacity = min(4, Zexray.FileSystem.file_path_list_max_filepath_capacity())
    count = capacity

    case type do
      t when t in [:base, :resource] ->
        FilePathList.t(
          capacity: capacity,
          count: count,
          paths:
            Enum.map(1..capacity, fn i ->
              Enum.map(
                1..max(
                  1,
                  trunc(Zexray.FileSystem.file_path_list_max_filepath_length() * i / capacity)
                ),
                fn n -> "#{rem(n, 10)}" end
              )
              |> Enum.join()
            end)
        )

      :empty ->
        FilePathList.t(
          capacity: 0,
          count: 0,
          paths: []
        )
    end
  end

  def font_fixture(type \\ :base) do
    case type do
      :base ->
        Font.t(
          base_size: 32,
          glyph_count: 3,
          glyph_padding: 4,
          texture: texture_fixture(type),
          recs: Enum.map(1..3, fn _ -> rectangle_fixture(type) end),
          glyphs: Enum.map(1..3, fn _ -> glyph_info_fixture(type) end)
        )

      :resource ->
        Font.t(
          base_size: 32,
          glyph_count: 3,
          glyph_padding: 4,
          texture: Texture.t_resource(reference: make_ref()),
          recs: Enum.map(1..3, fn _ -> Rectangle.t_resource(reference: make_ref()) end),
          glyphs: Enum.map(1..3, fn _ -> GlyphInfo.t_resource(reference: make_ref()) end)
        )

      :empty ->
        Font.t(
          base_size: 0,
          glyph_count: 0,
          glyph_padding: 0,
          texture: texture_fixture(type),
          recs: [],
          glyphs: []
        )
    end
  end

  def glyph_info_fixture(type \\ :base) do
    case type do
      :base ->
        GlyphInfo.t(
          value: 65,
          offset_x: 1,
          offset_y: 2,
          advance_x: 3,
          image: image_fixture(type)
        )

      :resource ->
        GlyphInfo.t(
          value: 65,
          offset_x: 1,
          offset_y: 2,
          advance_x: 3,
          image: Image.t_resource(reference: make_ref())
        )

      :empty ->
        GlyphInfo.t(
          value: 0,
          offset_x: 0,
          offset_y: 0,
          advance_x: 0,
          image: image_fixture(type)
        )
    end
  end

  def image_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        Image.t(
          data:
            <<18, 35, 52, 255, 18, 35, 52, 255, 18, 35, 52, 255, 18, 35, 52, 255, 18, 35, 52, 255,
              18, 35, 52, 255, 18, 35, 52, 255, 18, 35, 52, 255>>,
          width: 4,
          height: 2,
          mipmaps: 1,
          format: 7
        )

      :empty ->
        Image.t(
          data: <<>>,
          width: 0,
          height: 0,
          mipmaps: 0,
          format: 0
        )
    end
  end

  def material_fixture(type \\ :base) do
    case type do
      :base ->
        Material.t(
          shader: shader_fixture(type),
          maps: Enum.map(1..Zexray.Material.max_maps(), fn _ -> material_map_fixture(type) end),
          params:
            Enum.map(1..Zexray.Material.max_params(), fn n -> Float.round(1.0 + n / 100, 2) end)
        )

      :resource ->
        Material.t(
          shader: Shader.t_resource(reference: make_ref()),
          maps:
            Enum.map(1..Zexray.Material.max_maps(), fn _ ->
              MaterialMap.t_resource(reference: make_ref())
            end),
          params:
            Enum.map(1..Zexray.Material.max_params(), fn n -> Float.round(1.0 + n / 100, 2) end)
        )

      :empty ->
        Material.t(
          shader: shader_fixture(type),
          maps: Enum.map(1..Zexray.Material.max_maps(), fn _ -> material_map_fixture(type) end),
          params: Enum.map(1..Zexray.Material.max_params(), fn _ -> 0.0 end)
        )
    end
  end

  def material_map_fixture(type \\ :base) do
    case type do
      :base ->
        MaterialMap.t(
          texture: texture_2d_fixture(type),
          color: color_fixture(type),
          value: 1.23
        )

      :resource ->
        MaterialMap.t(
          texture: Texture2D.t_resource(reference: make_ref()),
          color: Color.t_resource(reference: make_ref()),
          value: 1.23
        )

      :empty ->
        MaterialMap.t(
          texture: texture_2d_fixture(type),
          color: color_fixture(type),
          value: 0.0
        )
    end
  end

  def matrix_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        Matrix.t(
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
        )

      :empty ->
        Matrix.t(
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
        )
    end
  end

  def mesh_fixture(type \\ :base) do
    vertex_count = 4
    triangle_count = 2
    bone_count = 3

    case type do
      :base ->
        Mesh.t(
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
        )

      :resource ->
        Mesh.t(
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
          bone_matrices:
            Enum.map(1..bone_count, fn _ -> Matrix.t_resource(reference: make_ref()) end),
          bone_count: bone_count,
          vao_id: 0,
          vbo_id: Enum.map(1..Zexray.Mesh.max_vertex_buffers(), fn _ -> 0 end)
        )

      :empty ->
        Mesh.t(
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
        )
    end
  end

  def model_fixture(type \\ :base) do
    mesh_count = 2
    material_count = 2
    bone_count = 3

    case type do
      :base ->
        Model.t(
          transform: matrix_fixture(type),
          mesh_count: mesh_count,
          material_count: material_count,
          meshes: Enum.map(1..mesh_count, fn _ -> mesh_fixture(type) end),
          materials: Enum.map(1..material_count, fn _ -> material_fixture(type) end),
          mesh_material: Enum.map(0..(mesh_count - 1), fn n -> n end),
          bone_count: bone_count,
          bones: Enum.map(1..bone_count, fn _ -> bone_info_fixture(type) end),
          bind_pose: Enum.map(1..bone_count, fn _ -> transform_fixture(type) end)
        )

      :resource ->
        Model.t(
          transform: Matrix.t_resource(reference: make_ref()),
          mesh_count: mesh_count,
          material_count: material_count,
          meshes: Enum.map(1..mesh_count, fn _ -> Mesh.t_resource(reference: make_ref()) end),
          materials:
            Enum.map(1..material_count, fn _ -> Material.t_resource(reference: make_ref()) end),
          mesh_material: Enum.map(0..(mesh_count - 1), fn n -> n end),
          bone_count: bone_count,
          bones: Enum.map(1..bone_count, fn _ -> BoneInfo.t_resource(reference: make_ref()) end),
          bind_pose:
            Enum.map(1..bone_count, fn _ -> Transform.t_resource(reference: make_ref()) end)
        )

      :empty ->
        Model.t(
          transform: matrix_fixture(type),
          mesh_count: 0,
          material_count: 0,
          meshes: [],
          materials: [],
          mesh_material: [],
          bone_count: 0,
          bones: [],
          bind_pose: []
        )
    end
  end

  def model_animation_fixture(type \\ :base) do
    bone_count = 3
    frame_count = 2

    case type do
      :base ->
        ModelAnimation.t(
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
        )

      :resource ->
        ModelAnimation.t(
          bone_count: bone_count,
          frame_count: frame_count,
          bones: Enum.map(1..bone_count, fn _ -> BoneInfo.t_resource(reference: make_ref()) end),
          frame_poses:
            Enum.map(1..frame_count, fn _ ->
              Enum.map(1..bone_count, fn _ ->
                Transform.t_resource(reference: make_ref())
              end)
            end),
          name:
            Enum.map(1..Zexray.Model.model_animation_max_name(), fn n -> "#{rem(n, 10)}" end)
            |> Enum.join()
        )

      :empty ->
        ModelAnimation.t(
          bone_count: 0,
          frame_count: 0,
          bones: [],
          frame_poses: [],
          name: ""
        )
    end
  end

  def music_fixture(type \\ :base) do
    frame_count = 24_000
    looping = true

    case type do
      :base ->
        Music.t(
          stream: audio_stream_fixture(type),
          frame_count: frame_count,
          looping: looping,
          ctx_type: 0,
          ctx_data: nil
        )

      :resource ->
        Music.t(
          stream: AudioStream.t_resource(reference: make_ref()),
          frame_count: frame_count,
          looping: looping,
          ctx_type: 0,
          ctx_data: {:music_context_data_resource, make_ref()}
        )

      :empty ->
        Music.t(
          stream: audio_stream_fixture(type),
          frame_count: 0,
          looping: false,
          ctx_type: 0,
          ctx_data: nil
        )
    end
  end

  def n_patch_info_fixture(type \\ :base) do
    case type do
      :base ->
        NPatchInfo.t(
          source: rectangle_fixture(type),
          left: 0,
          top: 1,
          right: 2,
          bottom: 3,
          layout: 0
        )

      :resource ->
        NPatchInfo.t(
          source: Rectangle.t_resource(reference: make_ref()),
          left: 0,
          top: 1,
          right: 2,
          bottom: 3,
          layout: 0
        )

      :empty ->
        NPatchInfo.t(
          source: rectangle_fixture(type),
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          layout: 0
        )
    end
  end

  def quaternion_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        Quaternion.t(
          x: 1.23,
          y: 2.34,
          z: 3.45,
          w: 4.56
        )

      :empty ->
        Quaternion.t(
          x: 0.0,
          y: 0.0,
          z: 0.0,
          w: 0.0
        )
    end
  end

  def ray_fixture(type \\ :base) do
    case type do
      :base ->
        Ray.t(
          position: vector3_fixture(type),
          direction: vector3_fixture(type)
        )

      :resource ->
        Ray.t(
          position: Vector3.t_resource(reference: make_ref()),
          direction: Vector3.t_resource(reference: make_ref())
        )

      :empty ->
        Ray.t(
          position: vector3_fixture(type),
          direction: vector3_fixture(type)
        )
    end
  end

  def ray_collision_fixture(type \\ :base) do
    case type do
      :base ->
        RayCollision.t(
          hit: true,
          distance: 2.34,
          point: vector3_fixture(type),
          normal: vector3_fixture(type)
        )

      :resource ->
        RayCollision.t(
          hit: true,
          distance: 2.34,
          point: Vector3.t_resource(reference: make_ref()),
          normal: Vector3.t_resource(reference: make_ref())
        )

      :empty ->
        RayCollision.t(
          hit: false,
          distance: 0.0,
          point: vector3_fixture(type),
          normal: vector3_fixture(type)
        )
    end
  end

  def rectangle_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        Rectangle.t(
          x: 1.23,
          y: 2.34,
          width: 123.45,
          height: 234.56
        )

      :empty ->
        Rectangle.t(
          x: 0.0,
          y: 0.0,
          width: 0.0,
          height: 0.0
        )
    end
  end

  def render_texture_fixture(type \\ :base) do
    case type do
      :base ->
        RenderTexture.t(
          id: 0,
          texture: texture_fixture(type),
          depth: texture_fixture(type)
        )

      :resource ->
        RenderTexture.t(
          id: 0,
          texture: Texture.t_resource(reference: make_ref()),
          depth: Texture.t_resource(reference: make_ref())
        )

      :empty ->
        RenderTexture.t(
          id: 0,
          texture: texture_fixture(type),
          depth: texture_fixture(type)
        )
    end
  end

  def render_texture_2d_fixture(type \\ :base) do
    case type do
      :base ->
        RenderTexture2D.t(
          id: 0,
          texture: texture_fixture(type),
          depth: texture_fixture(type)
        )

      :resource ->
        RenderTexture2D.t(
          id: 0,
          texture: Texture.t_resource(reference: make_ref()),
          depth: Texture.t_resource(reference: make_ref())
        )

      :empty ->
        RenderTexture2D.t(
          id: 0,
          texture: texture_fixture(type),
          depth: texture_fixture(type)
        )
    end
  end

  def shader_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        Shader.t(
          id: 0,
          locs: Enum.map(1..Zexray.Shader.max_locations(), fn _ -> -1 end)
        )

      :empty ->
        Shader.t(
          id: 0,
          locs: []
        )
    end
  end

  def sound_fixture(type \\ :base) do
    frame_count = 24_000

    case type do
      :base ->
        Sound.t(
          stream: audio_stream_fixture(type),
          frame_count: frame_count
        )

      :resource ->
        Sound.t(
          stream: AudioStream.t_resource(reference: make_ref()),
          frame_count: frame_count
        )

      :empty ->
        Sound.t(
          stream: audio_stream_fixture(type),
          frame_count: 0
        )
    end
  end

  def sound_alias_fixture(type \\ :base) do
    frame_count = 24_000

    case type do
      :base ->
        SoundAlias.t(
          stream: audio_stream_fixture(type),
          frame_count: frame_count
        )

      :resource ->
        SoundAlias.t(
          stream: AudioStream.t_resource(reference: make_ref()),
          frame_count: frame_count
        )

      :empty ->
        SoundAlias.t(
          stream: audio_stream_fixture(type),
          frame_count: 0
        )
    end
  end

  def sound_stream_fixture(type \\ :base) do
    frame_count = 24_000
    sample_size = 8
    channels = 1
    looping = true

    case type do
      :base ->
        SoundStream.t(
          stream: audio_stream_fixture(type),
          frame_count: frame_count,
          looping: looping,
          data:
            Enum.map(
              1..Zexray.Audio.get_wave_data_size(frame_count, channels, sample_size),
              fn n ->
                rem(n, 0x100)
              end
            )
        )

      :resource ->
        SoundStream.t(
          stream: AudioStream.t_resource(reference: make_ref()),
          frame_count: frame_count,
          looping: looping,
          data:
            Enum.map(
              1..Zexray.Audio.get_wave_data_size(frame_count, channels, sample_size),
              fn n ->
                rem(n, 0x100)
              end
            )
        )

      :empty ->
        SoundStream.t(
          stream: audio_stream_fixture(type),
          frame_count: 0,
          looping: false,
          data: <<>>
        )
    end
  end

  def sound_stream_alias_fixture(type \\ :base) do
    frame_count = 24_000
    sample_size = 8
    channels = 1
    looping = true

    case type do
      :base ->
        SoundStreamAlias.t(
          stream: audio_stream_fixture(type),
          frame_count: frame_count,
          looping: looping,
          data:
            Enum.map(
              1..Zexray.Audio.get_wave_data_size(frame_count, channels, sample_size),
              fn n ->
                rem(n, 0x100)
              end
            )
        )

      :resource ->
        SoundStreamAlias.t(
          stream: AudioStream.t_resource(reference: make_ref()),
          frame_count: frame_count,
          looping: looping,
          data:
            Enum.map(
              1..Zexray.Audio.get_wave_data_size(frame_count, channels, sample_size),
              fn n ->
                rem(n, 0x100)
              end
            )
        )

      :empty ->
        SoundStreamAlias.t(
          stream: audio_stream_fixture(type),
          frame_count: 0,
          looping: false,
          data: <<>>
        )
    end
  end

  def texture_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        Texture.t(
          id: 0,
          width: 800,
          height: 600,
          mipmaps: 1,
          format: 7
        )

      :empty ->
        Texture.t(
          id: 0,
          width: 0,
          height: 0,
          mipmaps: 0,
          format: 0
        )
    end
  end

  def texture_2d_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        Texture2D.t(
          id: 0,
          width: 800,
          height: 600,
          mipmaps: 1,
          format: 7
        )

      :empty ->
        Texture2D.t(
          id: 0,
          width: 0,
          height: 0,
          mipmaps: 0,
          format: 0
        )
    end
  end

  def texture_cubemap_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        TextureCubemap.t(
          id: 0,
          width: 800,
          height: 600,
          mipmaps: 1,
          format: 7
        )

      :empty ->
        TextureCubemap.t(
          id: 0,
          width: 0,
          height: 0,
          mipmaps: 0,
          format: 0
        )
    end
  end

  def transform_fixture(type \\ :base) do
    case type do
      :base ->
        Transform.t(
          translation: vector3_fixture(type),
          rotation: quaternion_fixture(type),
          scale: vector3_fixture(type)
        )

      :resource ->
        Transform.t(
          translation: Vector3.t_resource(reference: make_ref()),
          rotation: Quaternion.t_resource(reference: make_ref()),
          scale: Vector3.t_resource(reference: make_ref())
        )

      :empty ->
        Transform.t(
          translation: vector3_fixture(type),
          rotation: quaternion_fixture(type),
          scale: vector3_fixture(type)
        )
    end
  end

  def vector2_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        Vector2.t(
          x: 1.23,
          y: 2.34
        )

      :empty ->
        Vector2.t(
          x: 0.0,
          y: 0.0
        )
    end
  end

  def ivector2_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        IVector2.t(
          x: 123,
          y: -234
        )

      :empty ->
        IVector2.t(
          x: 0,
          y: 0
        )
    end
  end

  def uivector2_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        UIVector2.t(
          x: 123,
          y: 234
        )

      :empty ->
        UIVector2.t(
          x: 0,
          y: 0
        )
    end
  end

  def vector3_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        Vector3.t(
          x: 1.23,
          y: 2.34,
          z: 3.45
        )

      :empty ->
        Vector3.t(
          x: 0.0,
          y: 0.0,
          z: 0.0
        )
    end
  end

  def ivector3_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        IVector3.t(
          x: 123,
          y: -234,
          z: 345
        )

      :empty ->
        IVector3.t(
          x: 0,
          y: 0,
          z: 0
        )
    end
  end

  def uivector3_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        UIVector3.t(
          x: 123,
          y: 234,
          z: 345
        )

      :empty ->
        UIVector3.t(
          x: 0,
          y: 0,
          z: 0
        )
    end
  end

  def vector4_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        Vector4.t(
          x: 1.23,
          y: 2.34,
          z: 3.45,
          w: 4.56
        )

      :empty ->
        Vector4.t(
          x: 0.0,
          y: 0.0,
          z: 0.0,
          w: 0.0
        )
    end
  end

  def ivector4_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        IVector4.t(
          x: 123,
          y: -234,
          z: 345,
          w: -456
        )

      :empty ->
        IVector4.t(
          x: 0,
          y: 0,
          z: 0,
          w: 0
        )
    end
  end

  def uivector4_fixture(type \\ :base) do
    case type do
      t when t in [:base, :resource] ->
        UIVector4.t(
          x: 123,
          y: 234,
          z: 345,
          w: 456
        )

      :empty ->
        UIVector4.t(
          x: 0,
          y: 0,
          z: 0,
          w: 0
        )
    end
  end

  def vr_device_info_fixture(type \\ :base) do
    h_resolution = 800
    v_resolution = 600
    h_screen_size = 1920.0
    v_screen_size = 1440.0
    eye_to_screen_distance = 123.45
    lens_separation_distance = 1.23
    interpupillary_distance = 0.12

    case type do
      t when t in [:base, :resource] ->
        VrDeviceInfo.t(
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
        )

      :empty ->
        VrDeviceInfo.t(
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
        )
    end
  end

  def vr_stereo_config_fixture(type \\ :base) do
    case type do
      :base ->
        VrStereoConfig.t(
          projection:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_projection(), fn _ ->
              matrix_fixture(type)
            end),
          view_offset:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_view_offset(), fn _ ->
              matrix_fixture(type)
            end),
          left_lens_center:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_left_lens_center(), fn n ->
              Float.round(1.0 + n / 100, 2)
            end),
          right_lens_center:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_right_lens_center(), fn n ->
              Float.round(1.0 + n / 100, 2)
            end),
          left_screen_center:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_left_screen_center(), fn n ->
              Float.round(1.0 + n / 100, 2)
            end),
          right_screen_center:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_right_screen_center(), fn n ->
              Float.round(1.0 + n / 100, 2)
            end),
          scale:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_scale(), fn n ->
              Float.round(1.0 + n / 100, 2)
            end),
          scale_in:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_scale_in(), fn n ->
              Float.round(1.0 + n / 100, 2)
            end)
        )

      :resource ->
        VrStereoConfig.t(
          projection:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_projection(), fn _ ->
              Matrix.t_resource(reference: make_ref())
            end),
          view_offset:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_view_offset(), fn _ ->
              Matrix.t_resource(reference: make_ref())
            end),
          left_lens_center:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_left_lens_center(), fn n ->
              Float.round(1.0 + n / 100, 2)
            end),
          right_lens_center:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_right_lens_center(), fn n ->
              Float.round(1.0 + n / 100, 2)
            end),
          left_screen_center:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_left_screen_center(), fn n ->
              Float.round(1.0 + n / 100, 2)
            end),
          right_screen_center:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_right_screen_center(), fn n ->
              Float.round(1.0 + n / 100, 2)
            end),
          scale:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_scale(), fn n ->
              Float.round(1.0 + n / 100, 2)
            end),
          scale_in:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_scale_in(), fn n ->
              Float.round(1.0 + n / 100, 2)
            end)
        )

      :empty ->
        VrStereoConfig.t(
          projection:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_projection(), fn _ ->
              matrix_fixture(type)
            end),
          view_offset:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_view_offset(), fn _ ->
              matrix_fixture(type)
            end),
          left_lens_center:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_left_lens_center(), fn _ -> 0.0 end),
          right_lens_center:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_right_lens_center(), fn _ -> 0.0 end),
          left_screen_center:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_left_screen_center(), fn _ -> 0.0 end),
          right_screen_center:
            Enum.map(1..Zexray.Vr.vr_stereo_config_max_right_screen_center(), fn _ -> 0.0 end),
          scale: Enum.map(1..Zexray.Vr.vr_stereo_config_max_scale(), fn _ -> 0.0 end),
          scale_in: Enum.map(1..Zexray.Vr.vr_stereo_config_max_scale_in(), fn _ -> 0.0 end)
        )
    end
  end

  def wave_fixture(type \\ :base) do
    frame_count = 24_000
    sample_rate = 16_000
    sample_size = 8
    channels = 1

    case type do
      t when t in [:base, :resource] ->
        Wave.t(
          frame_count: frame_count,
          sample_rate: sample_rate,
          sample_size: sample_size,
          channels: channels,
          data:
            Enum.map(
              1..Zexray.Audio.get_wave_data_size(frame_count, channels, sample_size),
              fn n ->
                rem(n, 0x100)
              end
            )
        )

      :empty ->
        Wave.t(
          frame_count: 0,
          sample_rate: 0,
          sample_size: 0,
          channels: 0,
          data: <<>>
        )
    end
  end
end
