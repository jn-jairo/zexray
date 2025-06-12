defmodule Zexray.Enum.GuiControl do
  @moduledoc """
  Gui controls

  ## Values

  | id | name         | description                                       |
  | -- | ------------ | ------------------------------------------------- |
  |  0 | :default     | Default (Populates to all controls when set)      |
  |  1 | :label       | Label (Used also for: :labelbutton)               |
  |  2 | :button      | Button                                            |
  |  3 | :toggle      | Toggle (Used also for: :togglegroup)              |
  |  4 | :slider      | Slider (Used also for: :sliderbar, :toggleslider) |
  |  5 | :progressbar | Progress bar                                      |
  |  6 | :checkbox    | Check box                                         |
  |  7 | :combobox    | Combo box                                         |
  |  8 | :dropdownbox | Drop down box                                     |
  |  9 | :textbox     | Text box (Used also for: :textboxmulti)           |
  | 10 | :valuebox    | Value box                                         |
  | 11 | :control11   | Control 11                                        |
  | 12 | :listview    | List view                                         |
  | 13 | :colorpicker | Color picker                                      |
  | 14 | :scrollbar   | Scroll bar                                        |
  | 15 | :statusbar   | Status bar                                        |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_control",
    values: %{
      default: 0,
      label: 1,
      button: 2,
      toggle: 3,
      slider: 4,
      progressbar: 5,
      checkbox: 6,
      combobox: 7,
      dropdownbox: 8,
      textbox: 9,
      valuebox: 10,
      control11: 11,
      listview: 12,
      colorpicker: 13,
      scrollbar: 14,
      statusbar: 15
    }
end
