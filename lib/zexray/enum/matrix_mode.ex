defmodule Zexray.Enum.MatrixMode do
  @moduledoc """
  Matrix modes (equivalent to OpenGL)

  ## Values

  |     id | name        | description   |
  | ------ | ----------- | ------------- |
  | 0x1700 | :modelview  | GL_MODELVIEW  |
  | 0x1701 | :projection | GL_PROJECTION |
  | 0x1702 | :texture    | GL_TEXTURE    |
  """

  use Zexray.Enum.EnumBase,
    prefix: "matrix_mode",
    values: %{
      modelview: 0x1700,
      projection: 0x1701,
      texture: 0x1702
    }
end
