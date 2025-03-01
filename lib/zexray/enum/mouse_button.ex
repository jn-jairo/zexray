defmodule Zexray.Enum.MouseButton do
  @moduledoc """
  Mouse buttons

  ## Values

  | id | name     | description                                  |
  | -- | -------- | -------------------------------------------- |
  |  0 | :left    | Mouse button left                            |
  |  1 | :right   | Mouse button right                           |
  |  2 | :middle  | Mouse button middle (pressed wheel)          |
  |  3 | :side    | Mouse button side (advanced mouse device)    |
  |  4 | :extra   | Mouse button extra (advanced mouse device)   |
  |  5 | :forward | Mouse button forward (advanced mouse device) |
  |  6 | :back    | Mouse button back (advanced mouse device)    |
  """

  use Zexray.Enum.EnumBase,
    prefix: "mouse_button",
    values: %{
      left: 0,
      right: 1,
      middle: 2,
      side: 3,
      extra: 4,
      forward: 5,
      back: 6
    }
end
