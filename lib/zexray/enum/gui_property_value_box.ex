defmodule Zexray.Enum.GuiPropertyValueBox do
  @moduledoc """
  ValueBox/Spinner

  ## Values

  | id | name                    | description                      |
  | -- | ----------------------- | -------------------------------- |
  | 16 | :spinner_button_width   | Spinner left/right buttons width |
  | 17 | :spinner_button_spacing | Spinner buttons separation       |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_property_value_box",
    values: %{
      spinner_button_width: 16,
      spinner_button_spacing: 17
    }
end
