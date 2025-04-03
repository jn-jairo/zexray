defmodule Zexray.Keyboard do
  import Zexray.Guard
  alias Zexray.NIF

  ##############
  #  Keyboard  #
  ##############

  @doc """
  Check if a key has been pressed once
  """
  @spec pressed?(key :: Zexray.Enum.KeyboardKey.t_all_free()) :: boolean
  def pressed?(key)
      when is_like_keyboard_key(key) do
    NIF.is_key_pressed(Zexray.Enum.KeyboardKey.value_free(key))
  end

  @doc """
  Check if a key has been pressed again
  """
  @spec pressed_repeat?(key :: Zexray.Enum.KeyboardKey.t_all_free()) :: boolean
  def pressed_repeat?(key)
      when is_like_keyboard_key(key) do
    NIF.is_key_pressed_repeat(Zexray.Enum.KeyboardKey.value_free(key))
  end

  @doc """
  Check if a key is being pressed
  """
  @spec down?(key :: Zexray.Enum.KeyboardKey.t_all_free()) :: boolean
  def down?(key)
      when is_like_keyboard_key(key) do
    NIF.is_key_down(Zexray.Enum.KeyboardKey.value_free(key))
  end

  @doc """
  Check if a key has been released once
  """
  @spec released?(key :: Zexray.Enum.KeyboardKey.t_all_free()) :: boolean
  def released?(key)
      when is_like_keyboard_key(key) do
    NIF.is_key_released(Zexray.Enum.KeyboardKey.value_free(key))
  end

  @doc """
  Check if a key is NOT being pressed
  """
  @spec up?(key :: Zexray.Enum.KeyboardKey.t_all_free()) :: boolean
  def up?(key)
      when is_like_keyboard_key(key) do
    NIF.is_key_up(Zexray.Enum.KeyboardKey.value_free(key))
  end

  @doc """
  Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
  """
  @spec get_pressed() :: Zexray.Enum.KeyboardKey.t_name_free()
  def get_pressed() do
    NIF.get_key_pressed()
    |> Zexray.Enum.KeyboardKey.name_free()
  end

  @doc """
  Get all key pressed (keycode)
  """
  @spec get_all_pressed() :: [Zexray.Enum.KeyboardKey.t_name_free()]
  def get_all_pressed() do
    do_get_all_pressed()
  end

  @spec do_get_all_pressed([Zexray.Enum.KeyboardKey.t_name_free()]) :: [
          Zexray.Enum.KeyboardKey.t_name_free()
        ]
  defp do_get_all_pressed(keys \\ []) do
    key = get_pressed()

    if key != :null do
      do_get_all_pressed([key | keys])
    else
      keys
      |> Enum.reverse()
    end
  end

  @doc """
  Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
  """
  @spec get_char_pressed() :: binary
  def get_char_pressed() do
    NIF.get_char_pressed()
    |> :binary.encode_unsigned()
  end

  @doc """
  Get all char pressed (unicode)
  """
  @spec get_all_char_pressed() :: [binary]
  def get_all_char_pressed() do
    do_get_all_char_pressed()
  end

  @spec do_get_all_char_pressed([binary]) :: [binary]
  def do_get_all_char_pressed(chars \\ []) do
    char = get_char_pressed()

    if char != <<0>> do
      do_get_all_char_pressed([char | chars])
    else
      chars
      |> Enum.reverse()
    end
  end

  @doc """
  Get name of a QWERTY key on the current keyboard layout (eg returns string 'q' for KEY_A on an AZERTY keyboard)
  """
  @spec get_name(key :: Zexray.Enum.KeyboardKey.t_all_free()) :: binary
  def get_name(key)
      when is_like_keyboard_key(key) do
    NIF.get_key_name(Zexray.Enum.KeyboardKey.value_free(key))
  end

  @doc """
  Set a custom key to exit program (default is ESC)
  """
  @spec set_exit(key :: Zexray.Enum.KeyboardKey.t_all_free()) :: :ok
  def set_exit(key)
      when is_like_keyboard_key(key) do
    NIF.set_exit_key(Zexray.Enum.KeyboardKey.value_free(key))
  end
end
