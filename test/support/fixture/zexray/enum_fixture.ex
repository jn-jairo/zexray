defmodule Zexray.EnumFixture do
  @moduledoc false

  alias Zexray.Enum.{
    CameraProjection,
    ConfigFlag,
    CubemapLayout,
    GamepadAxis,
    GamepadButton,
    KeyboardKey,
    MaterialMapIndex,
    MouseButton,
    MouseCursor,
    NPatchLayout,
    PixelFormat,
    ShaderAttributeDataType,
    ShaderLocationIndex,
    ShaderUniformDataType,
    TextureFilter,
    TextureWrap,
    TraceLogLevel
  }

  def camera_projection_fixture(attrs \\ %{}) do
    {name, value} =
      CameraProjection.values_by_name()
      |> Enum.to_list()
      |> List.first()

    %{
      name: name,
      value: value
    }
    |> Map.merge(attrs)
  end

  def config_flag_fixture(attrs \\ %{}) do
    {name, value} =
      ConfigFlag.values_by_name()
      |> Enum.to_list()
      |> List.first()

    %{
      name: name,
      value: value
    }
    |> Map.merge(attrs)
  end

  def cubemap_layout_fixture(attrs \\ %{}) do
    {name, value} =
      CubemapLayout.values_by_name()
      |> Enum.to_list()
      |> List.first()

    %{
      name: name,
      value: value
    }
    |> Map.merge(attrs)
  end

  def gamepad_axis_fixture(attrs \\ %{}) do
    {name, value} =
      GamepadAxis.values_by_name()
      |> Enum.to_list()
      |> List.first()

    %{
      name: name,
      value: value
    }
    |> Map.merge(attrs)
  end

  def gamepad_button_fixture(attrs \\ %{}) do
    {name, value} =
      GamepadButton.values_by_name()
      |> Enum.to_list()
      |> List.first()

    %{
      name: name,
      value: value
    }
    |> Map.merge(attrs)
  end

  def keyboard_key_fixture(attrs \\ %{}) do
    {name, value} =
      KeyboardKey.values_by_name()
      |> Enum.to_list()
      |> List.first()

    %{
      name: name,
      value: value
    }
    |> Map.merge(attrs)
  end

  def material_map_index_fixture(attrs \\ %{}) do
    {name, value} =
      MaterialMapIndex.values_by_name()
      |> Enum.to_list()
      |> List.first()

    %{
      name: name,
      value: value
    }
    |> Map.merge(attrs)
  end

  def mouse_button_fixture(attrs \\ %{}) do
    {name, value} =
      MouseButton.values_by_name()
      |> Enum.to_list()
      |> List.first()

    %{
      name: name,
      value: value
    }
    |> Map.merge(attrs)
  end

  def mouse_cursor_fixture(attrs \\ %{}) do
    {name, value} =
      MouseCursor.values_by_name()
      |> Enum.to_list()
      |> List.first()

    %{
      name: name,
      value: value
    }
    |> Map.merge(attrs)
  end

  def n_patch_layout_fixture(attrs \\ %{}) do
    {name, value} =
      NPatchLayout.values_by_name()
      |> Enum.to_list()
      |> List.first()

    %{
      name: name,
      value: value
    }
    |> Map.merge(attrs)
  end

  def pixel_format_fixture(attrs \\ %{}) do
    {name, value} =
      PixelFormat.values_by_name()
      |> Enum.to_list()
      |> List.first()

    %{
      name: name,
      value: value
    }
    |> Map.merge(attrs)
  end

  def shader_attribute_data_type_fixture(attrs \\ %{}) do
    {name, value} =
      ShaderAttributeDataType.values_by_name()
      |> Enum.to_list()
      |> List.first()

    %{
      name: name,
      value: value
    }
    |> Map.merge(attrs)
  end

  def shader_location_index_fixture(attrs \\ %{}) do
    {name, value} =
      ShaderLocationIndex.values_by_name()
      |> Enum.to_list()
      |> List.first()

    %{
      name: name,
      value: value
    }
    |> Map.merge(attrs)
  end

  def shader_uniform_data_type_fixture(attrs \\ %{}) do
    {name, value} =
      ShaderUniformDataType.values_by_name()
      |> Enum.to_list()
      |> List.first()

    %{
      name: name,
      value: value
    }
    |> Map.merge(attrs)
  end

  def texture_filter_fixture(attrs \\ %{}) do
    {name, value} =
      TextureFilter.values_by_name()
      |> Enum.to_list()
      |> List.first()

    %{
      name: name,
      value: value
    }
    |> Map.merge(attrs)
  end

  def texture_wrap_fixture(attrs \\ %{}) do
    {name, value} =
      TextureWrap.values_by_name()
      |> Enum.to_list()
      |> List.first()

    %{
      name: name,
      value: value
    }
    |> Map.merge(attrs)
  end

  def trace_log_level_fixture(attrs \\ %{}) do
    {name, value} =
      TraceLogLevel.values_by_name()
      |> Enum.to_list()
      |> List.first()

    %{
      name: name,
      value: value
    }
    |> Map.merge(attrs)
  end
end
