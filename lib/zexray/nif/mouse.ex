defmodule Zexray.NIF.Mouse do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_mouse [
        # Mouse
        is_mouse_button_pressed: 1,
        is_mouse_button_down: 1,
        is_mouse_button_released: 1,
        is_mouse_button_up: 1,
        get_mouse_x: 0,
        get_mouse_y: 0,
        get_mouse_position: 0,
        get_mouse_position: 1,
        get_mouse_delta: 0,
        get_mouse_delta: 1,
        set_mouse_position: 2,
        set_mouse_offset: 2,
        set_mouse_scale: 2,
        get_mouse_wheel_move: 0,
        get_mouse_wheel_move_v: 0,
        get_mouse_wheel_move_v: 1,
        set_mouse_cursor: 1
      ]

      ###########
      #  Mouse  #
      ###########

      @doc """
      Check if a mouse button has been pressed once

      ```c
      // raylib.h
      RLAPI bool IsMouseButtonPressed(int button);
      ```
      """
      @doc group: :input_mouse
      @spec is_mouse_button_pressed(button :: integer) :: boolean
      def is_mouse_button_pressed(_button), do: :erlang.nif_error(:undef)

      @doc """
      Check if a mouse button is being pressed

      ```c
      // raylib.h
      RLAPI bool IsMouseButtonDown(int button);
      ```
      """
      @doc group: :input_mouse
      @spec is_mouse_button_down(button :: integer) :: boolean
      def is_mouse_button_down(_button), do: :erlang.nif_error(:undef)

      @doc """
      Check if a mouse button has been released once

      ```c
      // raylib.h
      RLAPI bool IsMouseButtonReleased(int button);
      ```
      """
      @doc group: :input_mouse
      @spec is_mouse_button_released(button :: integer) :: boolean
      def is_mouse_button_released(_button), do: :erlang.nif_error(:undef)

      @doc """
      Check if a mouse button is NOT being pressed

      ```c
      // raylib.h
      RLAPI bool IsMouseButtonUp(int button);
      ```
      """
      @doc group: :input_mouse
      @spec is_mouse_button_up(button :: integer) :: boolean
      def is_mouse_button_up(_button), do: :erlang.nif_error(:undef)

      @doc """
      Get mouse position X

      ```c
      // raylib.h
      RLAPI int GetMouseX(void);
      ```
      """
      @doc group: :input_mouse
      @spec get_mouse_x() :: integer
      def get_mouse_x(), do: :erlang.nif_error(:undef)

      @doc """
      Get mouse position Y

      ```c
      // raylib.h
      RLAPI int GetMouseY(void);
      ```
      """
      @doc group: :input_mouse
      @spec get_mouse_y() :: integer
      def get_mouse_y(), do: :erlang.nif_error(:undef)

      @doc """
      Get mouse position XY

      ```c
      // raylib.h
      RLAPI Vector2 GetMousePosition(void);
      ```
      """
      @doc group: :input_mouse
      @spec get_mouse_position(return :: :auto | :value | :resource) :: tuple
      def get_mouse_position(_return \\ :auto), do: :erlang.nif_error(:undef)

      @doc """
      Get mouse delta between frames

      ```c
      // raylib.h
      RLAPI Vector2 GetMouseDelta(void);
      ```
      """
      @doc group: :input_mouse
      @spec get_mouse_delta(return :: :auto | :value | :resource) :: tuple
      def get_mouse_delta(_return \\ :auto), do: :erlang.nif_error(:undef)

      @doc """
      Set mouse position XY

      ```c
      // raylib.h
      RLAPI void SetMousePosition(int x, int y);
      ```
      """
      @doc group: :input_mouse
      @spec set_mouse_position(
              x :: integer,
              y :: integer
            ) :: :ok
      def set_mouse_position(
            _x,
            _y
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set mouse offset

      ```c
      // raylib.h
      RLAPI void SetMouseOffset(int offsetX, int offsetY);
      ```
      """
      @doc group: :input_mouse
      @spec set_mouse_offset(
              offset_x :: integer,
              offset_y :: integer
            ) :: :ok
      def set_mouse_offset(
            _offset_x,
            _offset_y
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set mouse scaling

      ```c
      // raylib.h
      RLAPI void SetMouseScale(float scaleX, float scaleY);
      ```
      """
      @doc group: :input_mouse
      @spec set_mouse_scale(
              scale_x :: float,
              scale_y :: float
            ) :: :ok
      def set_mouse_scale(
            _scale_x,
            _scale_y
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get mouse wheel movement for X or Y, whichever is larger

      ```c
      // raylib.h
      RLAPI float GetMouseWheelMove(void);
      ```
      """
      @doc group: :input_mouse
      @spec get_mouse_wheel_move() :: float
      def get_mouse_wheel_move(), do: :erlang.nif_error(:undef)

      @doc """
      Get mouse wheel movement for both X and Y

      ```c
      // raylib.h
      RLAPI Vector2 GetMouseWheelMoveV(void);
      ```
      """
      @doc group: :input_mouse
      @spec get_mouse_wheel_move_v(return :: :auto | :value | :resource) :: tuple
      def get_mouse_wheel_move_v(_return \\ :auto), do: :erlang.nif_error(:undef)

      @doc """
      Set mouse cursor

      ```c
      // raylib.h
      RLAPI void SetMouseCursor(int cursor);
      ```
      """
      @doc group: :input_mouse
      @spec set_mouse_cursor(cursor :: integer) :: :ok
      def set_mouse_cursor(_cursor), do: :erlang.nif_error(:undef)
    end
  end
end
