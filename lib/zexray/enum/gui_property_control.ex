defmodule Zexray.Enum.GuiPropertyControl do
  @moduledoc """
  Gui base properties for every control

  NOTE: RAYGUI_MAX_PROPS_BASE properties (by default 16 properties)

  ## Values

  | id | name                   | description                                                                            |
  | -- | ---------------------- | -------------------------------------------------------------------------------------- |
  |  0 | :border_color_normal   | Control border color in state :normal                                                  |
  |  1 | :base_color_normal     | Control base color in state :normal                                                    |
  |  2 | :text_color_normal     | Control text color in state :normal                                                    |
  |  3 | :border_color_focused  | Control border color in state :focused                                                 |
  |  4 | :base_color_focused    | Control base color in state :focused                                                   |
  |  5 | :text_color_focused    | Control text color in state :focused                                                   |
  |  6 | :border_color_pressed  | Control border color in state :pressed                                                 |
  |  7 | :base_color_pressed    | Control base color in state :pressed                                                   |
  |  8 | :text_color_pressed    | Control text color in state :pressed                                                   |
  |  9 | :border_color_disabled | Control border color in state :disabled                                                |
  | 10 | :base_color_disabled   | Control base color in state :disabled                                                  |
  | 11 | :text_color_disabled   | Control text color in state :disabled                                                  |
  | 12 | :border_width          | Control border size, 0 for no border                                                   |
  | 13 | :text_padding          | Control text padding, not considering border                                           |
  | 14 | :text_alignment        | Control text horizontal alignment inside control text bound (after border and padding) |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_property_control",
    values: %{
      border_color_normal: 0,
      base_color_normal: 1,
      text_color_normal: 2,
      border_color_focused: 3,
      base_color_focused: 4,
      text_color_focused: 5,
      border_color_pressed: 6,
      base_color_pressed: 7,
      text_color_pressed: 8,
      border_color_disabled: 9,
      base_color_disabled: 10,
      text_color_disabled: 11,
      border_width: 12,
      text_padding: 13,
      text_alignment: 14
    }
end
