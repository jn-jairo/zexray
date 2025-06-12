defmodule Zexray.Enum.GuiPropertyCheckBox do
  @moduledoc """
  CheckBox

  ## Values

  | id | name           | description                     |
  | -- | -------------- | ------------------------------- |
  | 16 | :check_padding | CheckBox internal check padding |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_property_check_box",
    values: %{
      check_padding: 16
    }
end
