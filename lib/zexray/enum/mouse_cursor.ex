defmodule Zexray.Enum.MouseCursor do
  @moduledoc """
  Mouse cursor

  ## Values

  | id | name           | description                                                   |
  | -- | -------------- | ------------------------------------------------------------- |
  | 0  | :default       | Default pointer shape                                         |
  | 1  | :arrow         | Arrow shape                                                   |
  | 2  | :ibeam         | Text writing cursor shape                                     |
  | 3  | :crosshair     | Cross shape                                                   |
  | 4  | :pointing_hand | Pointing hand cursor                                          |
  | 5  | :resize_ew     | Horizontal resize/move arrow shape                            |
  | 6  | :resize_ns     | Vertical resize/move arrow shape                              |
  | 7  | :resize_nwse   | Top-left to bottom-right diagonal resize/move arrow shape     |
  | 8  | :resize_nesw   | The top-right to bottom-left diagonal resize/move arrow shape |
  | 9  | :resize_all    | The omnidirectional resize/move cursor shape                  |
  | 10 | :not_allowed   | The operation-not-allowed shape                               |
  """

  use Zexray.Enum.EnumBase,
    prefix: "mouse_cursor",
    values: %{
      default: 0,
      arrow: 1,
      ibeam: 2,
      crosshair: 3,
      pointing_hand: 4,
      resize_ew: 5,
      resize_ns: 6,
      resize_nwse: 7,
      resize_nesw: 8,
      resize_all: 9,
      not_allowed: 10
    }
end
