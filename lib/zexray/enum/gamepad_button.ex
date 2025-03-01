defmodule Zexray.Enum.GamepadButton do
  @moduledoc """
  Gamepad buttons

  ## Values

  | id | name              | description                                                            |
  | -- | ----------------- | ---------------------------------------------------------------------- |
  | 0  | :unknown          | Unknown button, just for error checking                                |
  | 1  | :left_face_up     | Gamepad left DPAD up button                                            |
  | 2  | :left_face_right  | Gamepad left DPAD right button                                         |
  | 3  | :left_face_down   | Gamepad left DPAD down button                                          |
  | 4  | :left_face_left   | Gamepad left DPAD left button                                          |
  | 5  | :right_face_up    | Gamepad right button up (i.e. PS3: Triangle, Xbox: Y)                  |
  | 6  | :right_face_right | Gamepad right button right (i.e. PS3: Circle, Xbox: B)                 |
  | 7  | :right_face_down  | Gamepad right button down (i.e. PS3: Cross, Xbox: A)                   |
  | 8  | :right_face_left  | Gamepad right button left (i.e. PS3: Square, Xbox: X)                  |
  | 9  | :left_trigger_1   | Gamepad top/back trigger left (first), it could be a trailing button   |
  | 10 | :left_trigger_2   | Gamepad top/back trigger left (second), it could be a trailing button  |
  | 11 | :right_trigger_1  | Gamepad top/back trigger right (first), it could be a trailing button  |
  | 12 | :right_trigger_2  | Gamepad top/back trigger right (second), it could be a trailing button |
  | 13 | :middle_left      | Gamepad center buttons, left one (i.e. PS3: Select)                    |
  | 14 | :middle           | Gamepad center buttons, middle one (i.e. PS3: PS, Xbox: XBOX)          |
  | 15 | :middle_right     | Gamepad center buttons, right one (i.e. PS3: Start)                    |
  | 16 | :left_thumb       | Gamepad joystick pressed button left                                   |
  | 17 | :right_thumb      | Gamepad joystick pressed button right                                  |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gamepad_button",
    values: %{
      unknown: 0,
      left_face_up: 1,
      left_face_right: 2,
      left_face_down: 3,
      left_face_left: 4,
      right_face_up: 5,
      right_face_right: 6,
      right_face_down: 7,
      right_face_left: 8,
      left_trigger_1: 9,
      left_trigger_2: 10,
      right_trigger_1: 11,
      right_trigger_2: 12,
      middle_left: 13,
      middle: 14,
      middle_right: 15,
      left_thumb: 16,
      right_thumb: 17
    }
end
