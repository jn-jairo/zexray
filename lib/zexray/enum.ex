defmodule Zexray.Enum do
  @moduledoc """
  Adds helper macros for enums with the format `enum_*(value)`

  ```
  defmodule Example do
    use Zexray.Enum

    def test do
      # From name to value
      color = enum_color(:white)
      camera_projection = enum_camera_projection(:perspective)

      # From value to name
      :white = enum_color(color)
      :perspective = enum_camera_projection(camera_projection)
    end
  end
  ```
  """

  defmacro __using__(_opts) do
    quote do
      require Zexray.Enum.{
        BlendMode,
        CameraMode,
        CameraProjection,
        Color,
        ConfigFlag,
        CubemapLayout,
        FontType,
        GamepadAxis,
        GamepadButton,
        Gesture,
        KeyboardKey,
        MaterialMapIndex,
        MouseButton,
        MouseCursor,
        NPatchLayout,
        PixelFormat,
        ShaderAttributeDataType,
        ShaderAttributeLocationIndex,
        ShaderLocationIndex,
        ShaderUniformDataType,
        TextureFilter,
        TextureWrap,
        TraceLogLevel
      }

      @doc false
      defmacro enum_blend_mode(value) do
        quote do
          Zexray.Enum.BlendMode.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_camera_mode(value) do
        quote do
          Zexray.Enum.CameraMode.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_camera_projection(value) do
        quote do
          Zexray.Enum.CameraProjection.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_color(value) do
        quote do
          Zexray.Enum.Color.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_config_flag(value) do
        quote do
          Zexray.Enum.ConfigFlag.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_cubemap_layout(value) do
        quote do
          Zexray.Enum.CubemapLayout.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_font_type(value) do
        quote do
          Zexray.Enum.FontType.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_gamepad_axis(value) do
        quote do
          Zexray.Enum.GamepadAxis.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_gamepad_button(value) do
        quote do
          Zexray.Enum.GamepadButton.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_gesture(value) do
        quote do
          Zexray.Enum.Gesture.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_keyboard_key(value) do
        quote do
          Zexray.Enum.KeyboardKey.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_material_map_index(value) do
        quote do
          Zexray.Enum.MaterialMapIndex.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_mouse_button(value) do
        quote do
          Zexray.Enum.MouseButton.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_mouse_cursor(value) do
        quote do
          Zexray.Enum.MouseCursor.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_n_patch_layout(value) do
        quote do
          Zexray.Enum.NPatchLayout.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_pixel_format(value) do
        quote do
          Zexray.Enum.PixelFormat.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_shader_attribute_data_type(value) do
        quote do
          Zexray.Enum.ShaderAttributeDataType.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_shader_attribute_location_index(value) do
        quote do
          Zexray.Enum.ShaderAttributeLocationIndex.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_shader_location_index(value) do
        quote do
          Zexray.Enum.ShaderLocationIndex.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_shader_uniform_data_type(value) do
        quote do
          Zexray.Enum.ShaderUniformDataType.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_texture_filter(value) do
        quote do
          Zexray.Enum.TextureFilter.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_texture_wrap(value) do
        quote do
          Zexray.Enum.TextureWrap.enum(unquote(value))
        end
      end

      @doc false
      defmacro enum_trace_log_level(value) do
        quote do
          Zexray.Enum.TraceLogLevel.enum(unquote(value))
        end
      end
    end
  end
end
