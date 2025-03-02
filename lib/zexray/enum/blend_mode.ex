defmodule Zexray.Enum.BlendMode do
  @moduledoc """
  Color blending modes (pre-defined)

  ## Values

  | id | name               | description                                                                                      |
  | -- | ------------------ | ------------------------------------------------------------------------------------------------ |
  |  0 | :alpha             | Blend textures considering alpha (default)                                                       |
  |  1 | :additive          | Blend textures adding colors                                                                     |
  |  2 | :multiplied        | Blend textures multiplying colors                                                                |
  |  3 | :add_colors        | Blend textures adding colors (alternative)                                                       |
  |  4 | :subtract_colors   | Blend textures subtracting colors (alternative)                                                  |
  |  5 | :alpha_premultiply | Blend premultiplied textures considering alpha                                                   |
  |  6 | :custom            | Blend textures using custom src/dst factors (use rlSetBlendFactors())                            |
  |  7 | :custom_separate   | Blend textures using custom rgb/alpha separate src/dst factors (use rlSetBlendFactorsSeparate()) |
  """

  use Zexray.Enum.EnumBase,
    prefix: "blend_mode",
    values: %{
      alpha: 0,
      additive: 1,
      multiplied: 2,
      add_colors: 3,
      subtract_colors: 4,
      alpha_premultiply: 5,
      custom: 6,
      custom_separate: 7
    }
end
