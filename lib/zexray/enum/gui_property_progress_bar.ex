defmodule Zexray.Enum.GuiPropertyProgressBar do
  @moduledoc """
  ProgressBar

  ## Values

  | id | name              | description                  |
  | -- | ----------------- | ---------------------------- |
  | 16 | :progress_padding | ProgressBar internal padding |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_property_progress_bar",
    values: %{
      progress_padding: 16
    }
end
