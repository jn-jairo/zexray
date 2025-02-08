defmodule Zexray.Enum.CameraProjection do
  @moduledoc """
  Camera projection

  ## Values

  | id | name          | description             |
  | -- | ------------- | ----------------------- |
  |  0 | :perspective  | Perspective projection  |
  |  1 | :orthographic | Orthographic projection |
  """

  use Zexray.Enum.EnumBase,
    name: "camera projection",
    values: %{
      perspective: 0,
      orthographic: 1
    }
end
