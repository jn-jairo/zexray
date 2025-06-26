defmodule Zexray.Enum.DrawMode do
  @moduledoc """
  Primitive assembly draw modes

  ## Values

  |     id | name       | description  |
  | ------ | ---------- | ------------ |
  | 0x0001 | :lines     | GL_LINES     |
  | 0x0004 | :triangles | GL_TRIANGLES |
  | 0x0007 | :quads     | GL_QUADS     |
  """

  use Zexray.Enum.EnumBase,
    prefix: "draw_mode",
    values: %{
      lines: 0x0001,
      triangles: 0x0004,
      quads: 0x0007
    }
end
