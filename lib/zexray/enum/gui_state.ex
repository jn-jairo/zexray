defmodule Zexray.Enum.GuiState do
  @moduledoc """
  Gui control state

  ## Values

  | id | name      | description |
  | -- | --------- | ----------- |
  |  0 | :normal   | Normal      |
  |  1 | :focused  | Focused     |
  |  2 | :pressed  | Pressed     |
  |  3 | :disabled | Disabled    |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_state",
    values: %{
      normal: 0,
      focused: 1,
      pressed: 2,
      disabled: 3
    }
end
