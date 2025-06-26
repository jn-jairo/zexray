defmodule Zexray.Enum.CullMode do
  @moduledoc """
  Face culling mode

  ## Values

  | id | name        | description |
  | -- | ----------- | ----------- |
  |  0 | :face_front | Face front  |
  |  1 | :face_back  | Face back   |
  """

  use Zexray.Enum.EnumBase,
    prefix: "framebuffer_attach_texture_type",
    values: %{
      face_front: 0,
      face_back: 1
    }
end
