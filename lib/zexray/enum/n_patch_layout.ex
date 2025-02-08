defmodule Zexray.Enum.NPatchLayout do
  @moduledoc """
  N-patch layout

  ## Values

  | id | name                    | description |
  | -- | ----------------------- | ----------- |
  |  0 | :nine_patch             | 3x3 tiles   |
  |  1 | :three_patch_vertical   | 1x3 tiles   |
  |  2 | :three_patch_horizontal | 3x1 tiles   |
  """

  use Zexray.Enum.EnumBase,
    name: "n patch layout",
    values: %{
      nine_patch: 0,
      three_patch_vertical: 1,
      three_patch_horizontal: 2
    }
end
