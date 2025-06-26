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

  defmacro __using__(opts) do
    do_import = Keyword.get(opts, :import, true)

    base =
      quote do
        require Zexray.Enum.{
          BlendMode,
          CameraMode,
          CameraProjection,
          Color,
          ConfigFlag,
          CubemapLayout,
          CullMode,
          DrawMode,
          FontType,
          FramebufferAttachTextureType,
          FramebufferAttachType,
          GamepadAxis,
          GamepadButton,
          Gesture,
          GlVersion,
          GuiControl,
          GuiIcon,
          GuiPropertyCheckBox,
          GuiPropertyColorPicker,
          GuiPropertyComboBox,
          GuiPropertyControl,
          GuiPropertyDefault,
          GuiPropertyDropdownBox,
          GuiPropertyListView,
          GuiPropertyProgressBar,
          GuiPropertyScrollBar,
          GuiPropertySlider,
          GuiPropertyTextBox,
          GuiPropertyToggle,
          GuiPropertyValueBox,
          GuiScrollBarSide,
          GuiState,
          GuiTextAlignment,
          GuiTextAlignmentVertical,
          GuiTextWrapMode,
          KeyboardKey,
          MaterialMapIndex,
          MatrixMode,
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

        require Zexray.Enum
      end

    maybe_import =
      if do_import do
        quote do
          import Zexray.Enum
        end
      else
        quote do
        end
      end

    quote do
      unquote(base)
      unquote(maybe_import)
    end
  end

  defmacro enum_blend_mode(value) do
    quote do
      Zexray.Enum.BlendMode.enum(unquote(value))
    end
  end

  defmacro enum_camera_mode(value) do
    quote do
      Zexray.Enum.CameraMode.enum(unquote(value))
    end
  end

  defmacro enum_camera_projection(value) do
    quote do
      Zexray.Enum.CameraProjection.enum(unquote(value))
    end
  end

  defmacro enum_color(value) do
    quote do
      Zexray.Enum.Color.enum(unquote(value))
    end
  end

  defmacro enum_config_flag(value) do
    quote do
      Zexray.Enum.ConfigFlag.enum(unquote(value))
    end
  end

  defmacro enum_cubemap_layout(value) do
    quote do
      Zexray.Enum.CubemapLayout.enum(unquote(value))
    end
  end

  defmacro enum_cull_mode(value) do
    quote do
      Zexray.Enum.CullMode.enum(unquote(value))
    end
  end

  defmacro enum_draw_mode(value) do
    quote do
      Zexray.Enum.DrawMode.enum(unquote(value))
    end
  end

  defmacro enum_font_type(value) do
    quote do
      Zexray.Enum.FontType.enum(unquote(value))
    end
  end

  defmacro enum_framebuffer_attach_texture_type(value) do
    quote do
      Zexray.Enum.FramebufferAttachTextureType.enum(unquote(value))
    end
  end

  defmacro enum_framebuffer_attach_type(value) do
    quote do
      Zexray.Enum.FramebufferAttachType.enum(unquote(value))
    end
  end

  defmacro enum_gamepad_axis(value) do
    quote do
      Zexray.Enum.GamepadAxis.enum(unquote(value))
    end
  end

  defmacro enum_gamepad_button(value) do
    quote do
      Zexray.Enum.GamepadButton.enum(unquote(value))
    end
  end

  defmacro enum_gesture(value) do
    quote do
      Zexray.Enum.Gesture.enum(unquote(value))
    end
  end

  defmacro enum_gl_version(value) do
    quote do
      Zexray.Enum.GlVersion.enum(unquote(value))
    end
  end

  defmacro enum_gui_control(value) do
    quote do
      Zexray.Enum.GuiControl.enum(unquote(value))
    end
  end

  defmacro enum_gui_icon(value) do
    quote do
      Zexray.Enum.GuiIcon.enum(unquote(value))
    end
  end

  defmacro enum_gui_property_check_box(value) do
    quote do
      Zexray.Enum.GuiPropertyCheckBox.enum(unquote(value))
    end
  end

  defmacro enum_gui_property_color_picker(value) do
    quote do
      Zexray.Enum.GuiPropertyColorPicker.enum(unquote(value))
    end
  end

  defmacro enum_gui_property_combo_box(value) do
    quote do
      Zexray.Enum.GuiPropertyComboBox.enum(unquote(value))
    end
  end

  defmacro enum_gui_property_control(value) do
    quote do
      Zexray.Enum.GuiPropertyControl.enum(unquote(value))
    end
  end

  defmacro enum_gui_property_default(value) do
    quote do
      Zexray.Enum.GuiPropertyDefault.enum(unquote(value))
    end
  end

  defmacro enum_gui_property_dropdown_box(value) do
    quote do
      Zexray.Enum.GuiPropertyDropdownBox.enum(unquote(value))
    end
  end

  defmacro enum_gui_property_list_view(value) do
    quote do
      Zexray.Enum.GuiPropertyListView.enum(unquote(value))
    end
  end

  defmacro enum_gui_property_progress_bar(value) do
    quote do
      Zexray.Enum.GuiPropertyProgressBar.enum(unquote(value))
    end
  end

  defmacro enum_gui_property_scroll_bar(value) do
    quote do
      Zexray.Enum.GuiPropertyScrollBar.enum(unquote(value))
    end
  end

  defmacro enum_gui_property_slider(value) do
    quote do
      Zexray.Enum.GuiPropertySlider.enum(unquote(value))
    end
  end

  defmacro enum_gui_property_text_box(value) do
    quote do
      Zexray.Enum.GuiPropertyTextBox.enum(unquote(value))
    end
  end

  defmacro enum_gui_property_toggle(value) do
    quote do
      Zexray.Enum.GuiPropertyToggle.enum(unquote(value))
    end
  end

  defmacro enum_gui_property_value_box(value) do
    quote do
      Zexray.Enum.GuiPropertyValueBox.enum(unquote(value))
    end
  end

  defmacro enum_gui_scroll_bar_side(value) do
    quote do
      Zexray.Enum.GuiScrollBarSide.enum(unquote(value))
    end
  end

  defmacro enum_gui_state(value) do
    quote do
      Zexray.Enum.GuiState.enum(unquote(value))
    end
  end

  defmacro enum_gui_text_alignment(value) do
    quote do
      Zexray.Enum.GuiTextAlignment.enum(unquote(value))
    end
  end

  defmacro enum_gui_text_alignment_vertical(value) do
    quote do
      Zexray.Enum.GuiTextAlignmentVertical.enum(unquote(value))
    end
  end

  defmacro enum_gui_text_wrap_mode(value) do
    quote do
      Zexray.Enum.GuiTextWrapMode.enum(unquote(value))
    end
  end

  defmacro enum_keyboard_key(value) do
    quote do
      Zexray.Enum.KeyboardKey.enum(unquote(value))
    end
  end

  defmacro enum_material_map_index(value) do
    quote do
      Zexray.Enum.MaterialMapIndex.enum(unquote(value))
    end
  end

  defmacro enum_matrix_mode(value) do
    quote do
      Zexray.Enum.MatrixMode.enum(unquote(value))
    end
  end

  defmacro enum_mouse_button(value) do
    quote do
      Zexray.Enum.MouseButton.enum(unquote(value))
    end
  end

  defmacro enum_mouse_cursor(value) do
    quote do
      Zexray.Enum.MouseCursor.enum(unquote(value))
    end
  end

  defmacro enum_n_patch_layout(value) do
    quote do
      Zexray.Enum.NPatchLayout.enum(unquote(value))
    end
  end

  defmacro enum_pixel_format(value) do
    quote do
      Zexray.Enum.PixelFormat.enum(unquote(value))
    end
  end

  defmacro enum_shader_attribute_data_type(value) do
    quote do
      Zexray.Enum.ShaderAttributeDataType.enum(unquote(value))
    end
  end

  defmacro enum_shader_attribute_location_index(value) do
    quote do
      Zexray.Enum.ShaderAttributeLocationIndex.enum(unquote(value))
    end
  end

  defmacro enum_shader_location_index(value) do
    quote do
      Zexray.Enum.ShaderLocationIndex.enum(unquote(value))
    end
  end

  defmacro enum_shader_uniform_data_type(value) do
    quote do
      Zexray.Enum.ShaderUniformDataType.enum(unquote(value))
    end
  end

  defmacro enum_texture_filter(value) do
    quote do
      Zexray.Enum.TextureFilter.enum(unquote(value))
    end
  end

  defmacro enum_texture_wrap(value) do
    quote do
      Zexray.Enum.TextureWrap.enum(unquote(value))
    end
  end

  defmacro enum_trace_log_level(value) do
    quote do
      Zexray.Enum.TraceLogLevel.enum(unquote(value))
    end
  end
end
