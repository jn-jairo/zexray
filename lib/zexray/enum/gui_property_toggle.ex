defmodule Zexray.Enum.GuiPropertyToggle do
  @moduledoc """
  Toggle/ToggleGroup

  ## Values

  | id | name           | description                            |
  | -- | -------------- | -------------------------------------- |
  | 16 | :group_padding | ToggleGroup separation between toggles |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_property_toggle",
    values: %{
      group_padding: 16
    }
end
