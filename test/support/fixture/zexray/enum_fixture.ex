defmodule Zexray.EnumFixture do
  @moduledoc false

  alias Zexray.Enum.{
    CameraProjection,
    ConfigFlag,
    GamepadAxis,
    GamepadButton,
    KeyboardKey,
    MouseButton,
    MouseCursor,
    NPatchLayout,
    PixelFormat,
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
