defmodule Zexray.Enum.GuiPropertyScrollBar do
  @moduledoc """
  ScrollBar

  ## Values

  | id | name                   | description                          |
  | -- | ---------------------- | ------------------------------------ |
  | 16 | :arrows_size           | ScrollBar arrows size                |
  | 17 | :arrows_visible        | ScrollBar arrows visible             |
  | 18 | :scroll_slider_padding | ScrollBar slider internal padding    |
  | 19 | :scroll_slider_size    | ScrollBar slider size                |
  | 20 | :scroll_padding        | ScrollBar scroll padding from arrows |
  | 21 | :scroll_speed          | ScrollBar scrolling speed            |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_property_scroll_bar",
    values: %{
      arrows_size: 16,
      arrows_visible: 17,
      scroll_slider_padding: 18,
      scroll_slider_size: 19,
      scroll_padding: 20,
      scroll_speed: 21
    }
end
