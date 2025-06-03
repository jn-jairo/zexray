defmodule Zexray.Type do
  @moduledoc """
  Adds helper macros for types `Record` with the format `type_*(args \\\\ [])` and `type_*(record, args)`

  ```
  defmodule Example do
    use Zexray.Type

    def test do
      # Create
      position = type_vector2(x: 1.0, y: 2.0)

      # Access
      x = type_vector2(position, :x)
      type_vector2(y: y) = position

      # Update
      position = type_vector2(position, y: 3.0)
    end
  end
  ```
  """

  defmacro __using__(_opts) do
    quote do
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

      @doc false
      defmacro type_audio_info(args \\ []) do
        quote do
          Zexray.Type.AudioInfo.t(unquote(args))
        end
      end

      @doc false
      defmacro type_audio_info(record, args) do
        quote do
          Zexray.Type.AudioInfo.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_audio_stream(args \\ []) do
        quote do
          Zexray.Type.AudioStream.t(unquote(args))
        end
      end

      @doc false
      defmacro type_audio_stream(record, args) do
        quote do
          Zexray.Type.AudioStream.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_automation_event(args \\ []) do
        quote do
          Zexray.Type.AutomationEvent.t(unquote(args))
        end
      end

      @doc false
      defmacro type_automation_event(record, args) do
        quote do
          Zexray.Type.AutomationEvent.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_automation_event_list(args \\ []) do
        quote do
          Zexray.Type.AutomationEventList.t(unquote(args))
        end
      end

      @doc false
      defmacro type_automation_event_list(record, args) do
        quote do
          Zexray.Type.AutomationEventList.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_bone_info(args \\ []) do
        quote do
          Zexray.Type.BoneInfo.t(unquote(args))
        end
      end

      @doc false
      defmacro type_bone_info(record, args) do
        quote do
          Zexray.Type.BoneInfo.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_bounding_box(args \\ []) do
        quote do
          Zexray.Type.BoundingBox.t(unquote(args))
        end
      end

      @doc false
      defmacro type_bounding_box(record, args) do
        quote do
          Zexray.Type.BoundingBox.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_camera(args \\ []) do
        quote do
          Zexray.Type.Camera.t(unquote(args))
        end
      end

      @doc false
      defmacro type_camera(record, args) do
        quote do
          Zexray.Type.Camera.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_camera_2d(args \\ []) do
        quote do
          Zexray.Type.Camera2D.t(unquote(args))
        end
      end

      @doc false
      defmacro type_camera_2d(record, args) do
        quote do
          Zexray.Type.Camera2D.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_camera_3d(args \\ []) do
        quote do
          Zexray.Type.Camera3D.t(unquote(args))
        end
      end

      @doc false
      defmacro type_camera_3d(record, args) do
        quote do
          Zexray.Type.Camera3D.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_color(args \\ []) do
        quote do
          Zexray.Type.Color.t(unquote(args))
        end
      end

      @doc false
      defmacro type_color(record, args) do
        quote do
          Zexray.Type.Color.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_file_path_list(args \\ []) do
        quote do
          Zexray.Type.FilePathList.t(unquote(args))
        end
      end

      @doc false
      defmacro type_file_path_list(record, args) do
        quote do
          Zexray.Type.FilePathList.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_font(args \\ []) do
        quote do
          Zexray.Type.Font.t(unquote(args))
        end
      end

      @doc false
      defmacro type_font(record, args) do
        quote do
          Zexray.Type.Font.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_glyph_info(args \\ []) do
        quote do
          Zexray.Type.GlyphInfo.t(unquote(args))
        end
      end

      @doc false
      defmacro type_glyph_info(record, args) do
        quote do
          Zexray.Type.GlyphInfo.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_image(args \\ []) do
        quote do
          Zexray.Type.Image.t(unquote(args))
        end
      end

      @doc false
      defmacro type_image(record, args) do
        quote do
          Zexray.Type.Image.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_material(args \\ []) do
        quote do
          Zexray.Type.Material.t(unquote(args))
        end
      end

      @doc false
      defmacro type_material(record, args) do
        quote do
          Zexray.Type.Material.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_material_map(args \\ []) do
        quote do
          Zexray.Type.MaterialMap.t(unquote(args))
        end
      end

      @doc false
      defmacro type_material_map(record, args) do
        quote do
          Zexray.Type.MaterialMap.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_matrix(args \\ []) do
        quote do
          Zexray.Type.Matrix.t(unquote(args))
        end
      end

      @doc false
      defmacro type_matrix(record, args) do
        quote do
          Zexray.Type.Matrix.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_mesh(args \\ []) do
        quote do
          Zexray.Type.Mesh.t(unquote(args))
        end
      end

      @doc false
      defmacro type_mesh(record, args) do
        quote do
          Zexray.Type.Mesh.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_model(args \\ []) do
        quote do
          Zexray.Type.Model.t(unquote(args))
        end
      end

      @doc false
      defmacro type_model(record, args) do
        quote do
          Zexray.Type.Model.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_model_animation(args \\ []) do
        quote do
          Zexray.Type.ModelAnimation.t(unquote(args))
        end
      end

      @doc false
      defmacro type_model_animation(record, args) do
        quote do
          Zexray.Type.ModelAnimation.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_music(args \\ []) do
        quote do
          Zexray.Type.Music.t(unquote(args))
        end
      end

      @doc false
      defmacro type_music(record, args) do
        quote do
          Zexray.Type.Music.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_n_patch_info(args \\ []) do
        quote do
          Zexray.Type.NPatchInfo.t(unquote(args))
        end
      end

      @doc false
      defmacro type_n_patch_info(record, args) do
        quote do
          Zexray.Type.NPatchInfo.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_quaternion(args \\ []) do
        quote do
          Zexray.Type.Quaternion.t(unquote(args))
        end
      end

      @doc false
      defmacro type_quaternion(record, args) do
        quote do
          Zexray.Type.Quaternion.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_ray(args \\ []) do
        quote do
          Zexray.Type.Ray.t(unquote(args))
        end
      end

      @doc false
      defmacro type_ray(record, args) do
        quote do
          Zexray.Type.Ray.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_ray_collision(args \\ []) do
        quote do
          Zexray.Type.RayCollision.t(unquote(args))
        end
      end

      @doc false
      defmacro type_ray_collision(record, args) do
        quote do
          Zexray.Type.RayCollision.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_rectangle(args \\ []) do
        quote do
          Zexray.Type.Rectangle.t(unquote(args))
        end
      end

      @doc false
      defmacro type_rectangle(record, args) do
        quote do
          Zexray.Type.Rectangle.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_render_texture(args \\ []) do
        quote do
          Zexray.Type.RenderTexture.t(unquote(args))
        end
      end

      @doc false
      defmacro type_render_texture(record, args) do
        quote do
          Zexray.Type.RenderTexture.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_render_texture_2d(args \\ []) do
        quote do
          Zexray.Type.RenderTexture2D.t(unquote(args))
        end
      end

      @doc false
      defmacro type_render_texture_2d(record, args) do
        quote do
          Zexray.Type.RenderTexture2D.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_shader(args \\ []) do
        quote do
          Zexray.Type.Shader.t(unquote(args))
        end
      end

      @doc false
      defmacro type_shader(record, args) do
        quote do
          Zexray.Type.Shader.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_sound(args \\ []) do
        quote do
          Zexray.Type.Sound.t(unquote(args))
        end
      end

      @doc false
      defmacro type_sound(record, args) do
        quote do
          Zexray.Type.Sound.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_sound_alias(args \\ []) do
        quote do
          Zexray.Type.SoundAlias.t(unquote(args))
        end
      end

      @doc false
      defmacro type_sound_alias(record, args) do
        quote do
          Zexray.Type.SoundAlias.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_sound_stream(args \\ []) do
        quote do
          Zexray.Type.SoundStream.t(unquote(args))
        end
      end

      @doc false
      defmacro type_sound_stream(record, args) do
        quote do
          Zexray.Type.SoundStream.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_sound_stream_alias(args \\ []) do
        quote do
          Zexray.Type.SoundStreamAlias.t(unquote(args))
        end
      end

      @doc false
      defmacro type_sound_stream_alias(record, args) do
        quote do
          Zexray.Type.SoundStreamAlias.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_texture(args \\ []) do
        quote do
          Zexray.Type.Texture.t(unquote(args))
        end
      end

      @doc false
      defmacro type_texture(record, args) do
        quote do
          Zexray.Type.Texture.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_texture_2d(args \\ []) do
        quote do
          Zexray.Type.Texture2D.t(unquote(args))
        end
      end

      @doc false
      defmacro type_texture_2d(record, args) do
        quote do
          Zexray.Type.Texture2D.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_texture_cubemap(args \\ []) do
        quote do
          Zexray.Type.TextureCubemap.t(unquote(args))
        end
      end

      @doc false
      defmacro type_texture_cubemap(record, args) do
        quote do
          Zexray.Type.TextureCubemap.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_transform(args \\ []) do
        quote do
          Zexray.Type.Transform.t(unquote(args))
        end
      end

      @doc false
      defmacro type_transform(record, args) do
        quote do
          Zexray.Type.Transform.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_vector2(args \\ []) do
        quote do
          Zexray.Type.Vector2.t(unquote(args))
        end
      end

      @doc false
      defmacro type_vector2(record, args) do
        quote do
          Zexray.Type.Vector2.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_ivector2(args \\ []) do
        quote do
          Zexray.Type.IVector2.t(unquote(args))
        end
      end

      @doc false
      defmacro type_ivector2(record, args) do
        quote do
          Zexray.Type.IVector2.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_uivector2(args \\ []) do
        quote do
          Zexray.Type.UIVector2.t(unquote(args))
        end
      end

      @doc false
      defmacro type_uivector2(record, args) do
        quote do
          Zexray.Type.UIVector2.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_vector3(args \\ []) do
        quote do
          Zexray.Type.Vector3.t(unquote(args))
        end
      end

      @doc false
      defmacro type_vector3(record, args) do
        quote do
          Zexray.Type.Vector3.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_ivector3(args \\ []) do
        quote do
          Zexray.Type.IVector3.t(unquote(args))
        end
      end

      @doc false
      defmacro type_ivector3(record, args) do
        quote do
          Zexray.Type.IVector3.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_uivector3(args \\ []) do
        quote do
          Zexray.Type.UIVector3.t(unquote(args))
        end
      end

      @doc false
      defmacro type_uivector3(record, args) do
        quote do
          Zexray.Type.UIVector3.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_vector4(args \\ []) do
        quote do
          Zexray.Type.Vector4.t(unquote(args))
        end
      end

      @doc false
      defmacro type_vector4(record, args) do
        quote do
          Zexray.Type.Vector4.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_ivector4(args \\ []) do
        quote do
          Zexray.Type.IVector4.t(unquote(args))
        end
      end

      @doc false
      defmacro type_ivector4(record, args) do
        quote do
          Zexray.Type.IVector4.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_uivector4(args \\ []) do
        quote do
          Zexray.Type.UIVector4.t(unquote(args))
        end
      end

      @doc false
      defmacro type_uivector4(record, args) do
        quote do
          Zexray.Type.UIVector4.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_vr_device_info(args \\ []) do
        quote do
          Zexray.Type.VrDeviceInfo.t(unquote(args))
        end
      end

      @doc false
      defmacro type_vr_device_info(record, args) do
        quote do
          Zexray.Type.VrDeviceInfo.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_vr_stereo_config(args \\ []) do
        quote do
          Zexray.Type.VrStereoConfig.t(unquote(args))
        end
      end

      @doc false
      defmacro type_vr_stereo_config(record, args) do
        quote do
          Zexray.Type.VrStereoConfig.t(unquote(record), unquote(args))
        end
      end

      @doc false
      defmacro type_wave(args \\ []) do
        quote do
          Zexray.Type.Wave.t(unquote(args))
        end
      end

      @doc false
      defmacro type_wave(record, args) do
        quote do
          Zexray.Type.Wave.t(unquote(record), unquote(args))
        end
      end
    end
  end
end
