defmodule Zexray.Enum.CubemapLayout do
  @moduledoc """
  Cubemap layouts

  ## Values

  | id | name                 | description                                         |
  | -- | -------------------- | --------------------------------------------------- |
  |  0 | :auto_detect         | Automatically detect layout type                    |
  |  1 | :line_vertical       | Layout is defined by a vertical line with faces     |
  |  2 | :line_horizontal     | Layout is defined by a horizontal line with faces   |
  |  3 | :cross_three_by_four | Layout is defined by a 3x4 cross with cubemap faces |
  |  4 | :cross_four_by_three | Layout is defined by a 4x3 cross with cubemap faces |
  """

  use Zexray.Enum.EnumBase,
    prefix: "cubemap_layout",
    values: %{
      auto_detect: 0,
      line_vertical: 1,
      line_horizontal: 2,
      cross_three_by_four: 3,
      cross_four_by_three: 4
    }
end
