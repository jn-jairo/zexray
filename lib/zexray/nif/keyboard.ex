defmodule Zexray.NIF.Keyboard do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_keyboard [
        # Keyboard
        is_key_pressed: 1,
        is_key_pressed_repeat: 1,
        is_key_down: 1,
        is_key_released: 1,
        is_key_up: 1,
        get_key_pressed: 0,
        get_char_pressed: 0,
        get_key_name: 1,
        set_exit_key: 1
      ]

      ##############
      #  Keyboard  #
      ##############

      @doc """
      Check if a key has been pressed once

      ```c
      // raylib.h
      RLAPI bool IsKeyPressed(int key);
      ```
      """
      @doc group: :input_keyboard
      @spec is_key_pressed(key :: integer) :: boolean
      def is_key_pressed(_key), do: :erlang.nif_error(:undef)

      @doc """
      Check if a key has been pressed again

      ```c
      // raylib.h
      RLAPI bool IsKeyPressedRepeat(int key);
      ```
      """
      @doc group: :input_keyboard
      @spec is_key_pressed_repeat(key :: integer) :: boolean
      def is_key_pressed_repeat(_key), do: :erlang.nif_error(:undef)

      @doc """
      Check if a key is being pressed

      ```c
      // raylib.h
      RLAPI bool IsKeyDown(int key);
      ```
      """
      @doc group: :input_keyboard
      @spec is_key_down(key :: integer) :: boolean
      def is_key_down(_key), do: :erlang.nif_error(:undef)

      @doc """
      Check if a key has been released once

      ```c
      // raylib.h
      RLAPI bool IsKeyReleased(int key);
      ```
      """
      @doc group: :input_keyboard
      @spec is_key_released(key :: integer) :: boolean
      def is_key_released(_key), do: :erlang.nif_error(:undef)

      @doc """
      Check if a key is NOT being pressed

      ```c
      // raylib.h
      RLAPI bool IsKeyUp(int key);
      ```
      """
      @doc group: :input_keyboard
      @spec is_key_up(key :: integer) :: boolean
      def is_key_up(_key), do: :erlang.nif_error(:undef)

      @doc """
      Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty

      ```c
      // raylib.h
      RLAPI int GetKeyPressed(void);
      ```
      """
      @doc group: :input_keyboard
      @spec get_key_pressed() :: integer
      def get_key_pressed(), do: :erlang.nif_error(:undef)

      @doc """
      Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty

      ```c
      // raylib.h
      RLAPI int GetCharPressed(void);
      ```
      """
      @doc group: :input_keyboard
      @spec get_char_pressed() :: integer
      def get_char_pressed(), do: :erlang.nif_error(:undef)

      @doc """
      Get name of a QWERTY key on the current keyboard layout (eg returns string 'q' for KEY_A on an AZERTY keyboard)

      ```c
      // raylib.h
      RLAPI const char *GetKeyName(int key);
      ```
      """
      @doc group: :input_keyboard
      @spec get_key_name(key :: integer) :: binary
      def get_key_name(_key), do: :erlang.nif_error(:undef)

      @doc """
      Set a custom key to exit program (default is ESC)

      ```c
      // raylib.h
      RLAPI void SetExitKey(int key);
      ```
      """
      @doc group: :input_keyboard
      @spec set_exit_key(key :: integer) :: :ok
      def set_exit_key(_key), do: :erlang.nif_error(:undef)
    end
  end
end
