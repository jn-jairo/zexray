defmodule Zexray.Enum.GuiPropertyDefault do
  @moduledoc """
  Gui extended properties depend on control

  NOTE: RAYGUI_MAX_PROPS_EXTENDED properties (by default, max 8 properties)

  DEFAULT extended properties

  NOTE: Those properties are common to all controls or global

  WARNING: We only have 8 slots for those properties by default!!! -> New global control: TEXT?

  ## Values

  | id | name                     | description                                                           |
  | -- | ------------------------ | --------------------------------------------------------------------- |
  | 16 | :text_size               | Text size (glyphs max height)                                         |
  | 17 | :text_spacing            | Text spacing between glyphs                                           |
  | 18 | :line_color              | Line control color                                                    |
  | 19 | :background_color        | Background color                                                      |
  | 20 | :text_line_spacing       | Text spacing between lines                                            |
  | 21 | :text_alignment_vertical | Text vertical alignment inside text bounds (after border and padding) |
  | 22 | :text_wrap_mode          | Text wrap-mode inside text bounds                                     |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_property_control",
    values: %{
      text_size: 16,
      text_spacing: 17,
      line_color: 18,
      background_color: 19,
      text_line_spacing: 20,
      text_alignment_vertical: 21,
      text_wrap_mode: 22
    }
end
