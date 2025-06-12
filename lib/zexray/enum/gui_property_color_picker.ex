defmodule Zexray.Enum.GuiPropertyColorPicker do
  @moduledoc """
  ColorPicker

  ## Values

  | id | name                      | description                                     |
  | -- | ------------------------- | ----------------------------------------------- |
  | 16 | :color_selector_size      |                                                 |
  | 17 | :huebar_width             | ColorPicker right hue bar width                 |
  | 18 | :huebar_padding           | ColorPicker right hue bar separation from panel |
  | 19 | :huebar_selector_height   | ColorPicker right hue bar selector height       |
  | 20 | :huebar_selector_overflow | ColorPicker right hue bar selector overflow     |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_property_color_picker",
    values: %{
      color_selector_size: 16,
      huebar_width: 17,
      huebar_padding: 18,
      huebar_selector_height: 19,
      huebar_selector_overflow: 20
    }
end
