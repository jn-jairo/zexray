defmodule Zexray.Enum.Gesture do
  @moduledoc """
  Gesture

  NOTE: Provided as bit-wise flags to enable only desired gestures

  ## Values

  | id  | name         | description         |
  | --- | ------------ | ------------------- |
  |   0 | :none        | No gesture          |
  |   1 | :tap         | Tap gesture         |
  |   2 | :doubletap   | Double tap gesture  |
  |   4 | :hold        | Hold gesture        |
  |   8 | :drag        | Drag gesture        |
  |  16 | :swipe_right | Swipe right gesture |
  |  32 | :swipe_left  | Swipe left gesture  |
  |  64 | :swipe_up    | Swipe up gesture    |
  | 128 | :swipe_down  | Swipe down gesture  |
  | 256 | :pinch_in    | Pinch in gesture    |
  | 512 | :pinch_out   | Pinch out gesture   |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gesture",
    values: %{
      none: 0,
      tap: 1,
      doubletap: 2,
      hold: 4,
      drag: 8,
      swipe_right: 16,
      swipe_left: 32,
      swipe_up: 64,
      swipe_down: 128,
      pinch_in: 256,
      pinch_out: 512
    }
end
