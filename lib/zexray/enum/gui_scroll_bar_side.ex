defmodule Zexray.Enum.GuiScrollBarSide do
  @moduledoc """
  ListView

  ## Values

  | id | name   | description |
  | -- | ------ | ----------- |
  |  0 | :left  | Left        |
  |  1 | :right | Right       |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_scroll_bar_side",
    values: %{
      left: 0,
      right: 1
    }
end
