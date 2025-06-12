defmodule Zexray.Enum.GuiTextWrapMode do
  @moduledoc """
  Gui control text wrap mode

  NOTE: Useful for multiline text

  ## Values

  | id | name  | description |
  | -- | ----- | ----------- |
  |  0 | :none | none        |
  |  1 | :char | char        |
  |  2 | :word | word        |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_text_wrap_mode",
    values: %{
      none: 0,
      char: 1,
      word: 2
    }
end
