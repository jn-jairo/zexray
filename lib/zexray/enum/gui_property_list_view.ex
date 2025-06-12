defmodule Zexray.Enum.GuiPropertyListView do
  @moduledoc """
  ListView

  ## Values

  | id | name                      | description                                   |
  | -- | ------------------------- | --------------------------------------------- |
  | 16 | :list_items_height        | ListView items height                         |
  | 17 | :list_items_spacing       | ListView items separation                     |
  | 18 | :scrollbar_width          | ListView scrollbar size (usually width)       |
  | 19 | :scrollbar_side           | ListView scrollbar side (:left, :right)       |
  | 20 | :list_items_border_normal | ListView items border enabled in normal state |
  | 21 | :list_items_border_width  | ListView items border width                   |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_property_list_view",
    values: %{
      list_items_height: 16,
      list_items_spacing: 17,
      scrollbar_width: 18,
      scrollbar_side: 19,
      list_items_border_normal: 20,
      list_items_border_width: 21
    }
end
