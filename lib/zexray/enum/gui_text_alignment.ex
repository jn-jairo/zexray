defmodule Zexray.Enum.GuiTextAlignment do
  @moduledoc """
  Gui control text alignment

  ## Values

  | id | name    | description |
  | -- | ------- | ----------- |
  |  0 | :left   | Left        |
  |  1 | :center | Center      |
  |  2 | :right  | Right       |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_text_alignment",
    values: %{
      left: 0,
      center: 1,
      right: 2
    }
end
