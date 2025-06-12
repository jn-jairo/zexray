defmodule Zexray.Enum.GuiPropertyDropdownBox do
  @moduledoc """
  DropdownBox

  ## Values

  | id | name                    | description                                        |
  | -- | ----------------------- | -------------------------------------------------- |
  | 16 | :arrow_padding          | DropdownBox arrow separation from border and items |
  | 17 | :dropdown_items_spacing | DropdownBox items separation                       |
  | 18 | :dropdown_arrow_hidden  | DropdownBox arrow hidden                           |
  | 19 | :dropdown_roll_up       | DropdownBox roll up flag (default rolls down)      |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_property_dropdown_box",
    values: %{
      arrow_padding: 16,
      dropdown_items_spacing: 17,
      dropdown_arrow_hidden: 18,
      dropdown_roll_up: 19
    }
end
