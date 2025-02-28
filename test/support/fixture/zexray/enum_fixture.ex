defmodule Zexray.EnumFixture do
  @moduledoc false

  alias Zexray.Enum.{
    CameraProjection,
    ConfigFlag,
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
