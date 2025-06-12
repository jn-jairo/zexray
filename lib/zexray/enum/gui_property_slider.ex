defmodule Zexray.Enum.GuiPropertySlider do
  @moduledoc """
  Slider/SliderBar

  ## Values

  | id | name            | description                           |
  | -- | --------------- | ------------------------------------- |
  | 16 | :slider_width   | Slider size of internal bar           |
  | 17 | :slider_padding | Slider/SliderBar internal bar padding |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_property_slider",
    values: %{
      slider_width: 16,
      slider_padding: 17
    }
end
