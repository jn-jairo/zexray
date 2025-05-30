defmodule Zexray.Keyboard do
  @moduledoc """
  Keyboard
  """

  use Zexray.Enum

  alias Zexray.NIF

  ##############
  #  Keyboard  #
  ##############

  @doc """
  Check if a key has been pressed once
  """
  @spec pressed?(key :: Zexray.Enum.KeyboardKey.t_free()) :: boolean
  defdelegate pressed?(key), to: NIF, as: :is_key_pressed

  @doc """
  Check if a key has been pressed again
  """
  @spec pressed_repeat?(key :: Zexray.Enum.KeyboardKey.t_free()) :: boolean
  defdelegate pressed_repeat?(key), to: NIF, as: :is_key_pressed_repeat

  @doc """
  Check if a key is being pressed
  """
  @spec down?(key :: Zexray.Enum.KeyboardKey.t_free()) :: boolean
  defdelegate down?(key), to: NIF, as: :is_key_down

  @doc """
  Check if a key has been released once
  """
  @spec released?(key :: Zexray.Enum.KeyboardKey.t_free()) :: boolean
  defdelegate released?(key), to: NIF, as: :is_key_released

  @doc """
  Check if a key is NOT being pressed
  """
  @spec up?(key :: Zexray.Enum.KeyboardKey.t_free()) :: boolean
  defdelegate up?(key), to: NIF, as: :is_key_up

  @doc """
  Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
  """
  @spec get_pressed() :: Zexray.Enum.KeyboardKey.t_free()
  defdelegate get_pressed(), to: NIF, as: :get_key_pressed

  @doc """
  Get all key pressed (keycode)
  """
  @spec get_all_pressed() :: [Zexray.Enum.KeyboardKey.t_free()]
  def get_all_pressed() do
    do_get_all_pressed()
  end

  @spec do_get_all_pressed([Zexray.Enum.KeyboardKey.t_free()]) :: [
          Zexray.Enum.KeyboardKey.t_free()
        ]
  defp do_get_all_pressed(keys \\ []) do
    key = get_pressed()

    if key != enum_keyboard_key(:null) do
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
  defp do_get_all_char_pressed(chars \\ []) do
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
  @spec get_name(key :: Zexray.Enum.KeyboardKey.t_free()) :: binary
  defdelegate get_name(key), to: NIF, as: :get_key_name

  @doc """
  Set a custom key to exit program (default is ESC)
  """
  @spec set_exit(key :: Zexray.Enum.KeyboardKey.t_free()) :: :ok
  defdelegate set_exit(key), to: NIF, as: :set_exit_key
end
