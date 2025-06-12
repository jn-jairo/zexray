defmodule Zexray.Enum.GamepadAxis do
  @moduledoc """
  Gamepad axes

  ## Values

  | id | name           | description                                         |
  | -- | -------------- | --------------------------------------------------- |
  |  0 | :left_x        | Gamepad left stick X axis                           |
  |  1 | :left_y        | Gamepad left stick Y axis                           |
  |  2 | :right_x       | Gamepad right stick X axis                          |
  |  3 | :right_y       | Gamepad right stick Y axis                          |
  |  4 | :left_trigger  | Gamepad back trigger left, pressure level: [1..-1]  |
  |  5 | :right_trigger | Gamepad back trigger right, pressure level: [1..-1] |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gamepad_axis",
    values: %{
      left_x: 0,
      left_y: 1,
      right_x: 2,
      right_y: 3,
      left_trigger: 4,
      right_trigger: 5
    }
end
