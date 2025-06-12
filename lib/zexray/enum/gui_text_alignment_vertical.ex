defmodule Zexray.Enum.GuiTextAlignmentVertical do
  @moduledoc """
  Gui control text alignment vertical

  NOTE: Text vertical position inside the text bounds

  ## Values

  | id | name    | description |
  | -- | ------- | ----------- |
  |  0 | :top    | Top         |
  |  1 | :middle | Middle      |
  |  2 | :bottom | Bottom      |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_text_alignment_vertical",
    values: %{
      top: 0,
      middle: 1,
      bottom: 2
    }
end
