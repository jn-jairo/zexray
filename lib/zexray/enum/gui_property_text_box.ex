defmodule Zexray.Enum.GuiPropertyTextBox do
  @moduledoc """
  TextBox/TextBoxMulti/ValueBox/Spinner

  ## Values

  | id | name           | description                                                    |
  | -- | -------------- | -------------------------------------------------------------- |
  | 16 | :text_readonly | TextBox in read-only mode: 0-text editable, 1-text no-editable |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_property_text_box",
    values: %{
      text_readonly: 16
    }
end
