defmodule Zexray.Enum.GuiPropertyComboBox do
  @moduledoc """
  ComboBox

  ## Values

  | id | name                  | description                 |
  | -- | --------------------- | --------------------------- |
  | 16 | :combo_button_width   | ComboBox right button width |
  | 17 | :combo_button_spacing | ComboBox button separation  |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_property_combo_box",
    values: %{
      combo_button_width: 16,
      combo_button_spacing: 17
    }
end
