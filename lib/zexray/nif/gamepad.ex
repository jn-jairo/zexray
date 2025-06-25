defmodule Zexray.NIF.Gamepad do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_gamepad [
        # Gamepad
        is_gamepad_available: 1,
        get_gamepad_name: 1,
        is_gamepad_button_pressed: 2,
        is_gamepad_button_down: 2,
        is_gamepad_button_released: 2,
        is_gamepad_button_up: 2,
        get_gamepad_button_pressed: 0,
        get_gamepad_axis_count: 1,
        get_gamepad_axis_movement: 2,
        set_gamepad_mappings: 1,
        set_gamepad_vibration: 4
      ]

      #############
      #  Gamepad  #
      #############

      @doc """
      Check if a gamepad is available

      ```c
      // raylib.h
      RLAPI bool IsGamepadAvailable(int gamepad);
      ```
      """
      @doc group: :input_gamepad
      @spec is_gamepad_available(gamepad :: integer) :: boolean
      def is_gamepad_available(_gamepad), do: :erlang.nif_error(:undef)

      @doc """
      Get gamepad internal name id

      ```c
      // raylib.h
      RLAPI const char *GetGamepadName(int gamepad);
      ```
      """
      @doc group: :input_gamepad
      @spec get_gamepad_name(gamepad :: integer) :: binary
      def get_gamepad_name(_gamepad), do: :erlang.nif_error(:undef)

      @doc """
      Check if a gamepad button has been pressed once

      ```c
      // raylib.h
      RLAPI bool IsGamepadButtonPressed(int gamepad, int button);
      ```
      """
      @doc group: :input_gamepad
      @spec is_gamepad_button_pressed(
              gamepad :: integer,
              button :: integer
            ) :: boolean
      def is_gamepad_button_pressed(
            _gamepad,
            _button
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check if a gamepad button is being pressed

      ```c
      // raylib.h
      RLAPI bool IsGamepadButtonDown(int gamepad, int button);
      ```
      """
      @doc group: :input_gamepad
      @spec is_gamepad_button_down(
              gamepad :: integer,
              button :: integer
            ) :: boolean
      def is_gamepad_button_down(
            _gamepad,
            _button
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check if a gamepad button has been released once

      ```c
      // raylib.h
      RLAPI bool IsGamepadButtonReleased(int gamepad, int button);
      ```
      """
      @doc group: :input_gamepad
      @spec is_gamepad_button_released(
              gamepad :: integer,
              button :: integer
            ) :: boolean
      def is_gamepad_button_released(
            _gamepad,
            _button
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check if a gamepad button is NOT being pressed

      ```c
      // raylib.h
      RLAPI bool IsGamepadButtonUp(int gamepad, int button);
      ```
      """
      @doc group: :input_gamepad
      @spec is_gamepad_button_up(
              gamepad :: integer,
              button :: integer
            ) :: boolean
      def is_gamepad_button_up(
            _gamepad,
            _button
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get the last gamepad button pressed

      ```c
      // raylib.h
      RLAPI int GetGamepadButtonPressed(void);
      ```
      """
      @doc group: :input_gamepad
      @spec get_gamepad_button_pressed() :: integer
      def get_gamepad_button_pressed(), do: :erlang.nif_error(:undef)

      @doc """
      Get axis count for a gamepad

      ```c
      // raylib.h
      RLAPI int GetGamepadAxisCount(int gamepad);
      ```
      """
      @doc group: :input_gamepad
      @spec get_gamepad_axis_count(gamepad :: integer) :: integer
      def get_gamepad_axis_count(_gamepad), do: :erlang.nif_error(:undef)

      @doc """
      Get movement value for a gamepad axis

      ```c
      // raylib.h
      RLAPI float GetGamepadAxisMovement(int gamepad, int axis);
      ```
      """
      @doc group: :input_gamepad
      @spec get_gamepad_axis_movement(
              gamepad :: integer,
              axis :: integer
            ) :: float
      def get_gamepad_axis_movement(
            _gamepad,
            _axis
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set internal gamepad mappings (SDL_GameControllerDB)

      ```c
      // raylib.h
      RLAPI int SetGamepadMappings(const char *mappings);
      ```
      """
      @doc group: :input_gamepad
      @spec set_gamepad_mappings(mappings :: binary) :: boolean
      def set_gamepad_mappings(_mappings), do: :erlang.nif_error(:undef)

      @doc """
      Set gamepad vibration for both motors (duration in seconds)

      ```c
      // raylib.h
      RLAPI void SetGamepadVibration(int gamepad, float leftMotor, float rightMotor, float duration);
      ```
      """
      @doc group: :input_gamepad
      @spec set_gamepad_vibration(
              gamepad :: integer,
              left_motor :: number,
              right_motor :: number,
              duration :: number
            ) :: :ok
      def set_gamepad_vibration(
            _gamepad,
            _left_motor,
            _right_motor,
            _duration
          ),
          do: :erlang.nif_error(:undef)
    end
  end
end
