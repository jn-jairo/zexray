defmodule Zexray.Gamepad do
  @moduledoc """
  Gamepad
  """

  import Zexray.Guard
  alias Zexray.NIF

  #############
  #  Gamepad  #
  #############

  @doc """
  Check if a gamepad is available
  """
  @spec available?(gamepad :: integer) :: boolean
  def available?(gamepad)
      when is_integer(gamepad) do
    NIF.is_gamepad_available(gamepad)
  end

  @doc """
  Get gamepad internal name id
  """
  @spec get_name(gamepad :: integer) :: binary
  def get_name(gamepad)
      when is_integer(gamepad) do
    NIF.get_gamepad_name(gamepad)
  end

  @doc """
  Check if a gamepad button has been pressed once
  """
  @spec pressed?(
          gamepad :: integer,
          button :: Zexray.Enum.GamepadButton.t_all_free()
        ) :: boolean
  def pressed?(
        gamepad,
        button
      )
      when is_integer(gamepad) and
             is_like_gamepad_button(button) do
    NIF.is_gamepad_button_pressed(
      gamepad,
      Zexray.Enum.GamepadButton.value_free(button)
    )
  end

  @doc """
  Check if a gamepad button is being pressed
  """
  @spec down?(
          gamepad :: integer,
          button :: Zexray.Enum.GamepadButton.t_all_free()
        ) :: boolean
  def down?(
        gamepad,
        button
      )
      when is_integer(gamepad) and
             is_like_gamepad_button(button) do
    NIF.is_gamepad_button_down(
      gamepad,
      Zexray.Enum.GamepadButton.value_free(button)
    )
  end

  @doc """
  Check if a gamepad button has been released once
  """
  @spec released?(
          gamepad :: integer,
          button :: Zexray.Enum.GamepadButton.t_all_free()
        ) :: boolean
  def released?(
        gamepad,
        button
      )
      when is_integer(gamepad) and
             is_like_gamepad_button(button) do
    NIF.is_gamepad_button_released(
      gamepad,
      Zexray.Enum.GamepadButton.value_free(button)
    )
  end

  @doc """
  Check if a gamepad button is NOT being pressed
  """
  @spec up?(
          gamepad :: integer,
          button :: Zexray.Enum.GamepadButton.t_all_free()
        ) :: boolean
  def up?(
        gamepad,
        button
      )
      when is_integer(gamepad) and
             is_like_gamepad_button(button) do
    NIF.is_gamepad_button_up(
      gamepad,
      Zexray.Enum.GamepadButton.value_free(button)
    )
  end

  @doc """
  Get the last gamepad button pressed
  """
  @spec get_pressed() :: Zexray.Enum.GamepadButton.t_name_free()
  def get_pressed() do
    NIF.get_gamepad_button_pressed()
    |> Zexray.Enum.GamepadButton.name_free()
  end

  @doc """
  Get gamepad axis count for a gamepad
  """
  @spec get_axis_count(gamepad :: integer) :: integer
  def get_axis_count(gamepad)
      when is_integer(gamepad) do
    NIF.get_gamepad_axis_count(gamepad)
  end

  @doc """
  Get axis movement value for a gamepad axis
  """
  @spec get_axis_movement(
          gamepad :: integer,
          axis :: Zexray.Enum.GamepadAxis.t_all_free()
        ) :: float
  def get_axis_movement(
        gamepad,
        axis
      )
      when is_integer(gamepad) and
             is_like_gamepad_axis(axis) do
    NIF.get_gamepad_axis_movement(
      gamepad,
      Zexray.Enum.GamepadAxis.value_free(axis)
    )
  end

  @doc """
  Set the default internal gamepad mappings
  """
  @spec set_default_mappings() :: :ok
  def set_default_mappings() do
    "#{:code.priv_dir(:zexray)}/gamecontrollerdb.txt"
    |> File.read!()
    |> set_mappings()

    System.get_env("SDL_GAMECONTROLLERCONFIG", "")
    |> set_mappings()

    :ok
  end

  @doc """
  Set internal gamepad mappings (SDL_GameControllerDB)
  """
  @spec set_mappings(mappings :: binary) :: boolean
  def set_mappings(mappings)
      when is_binary(mappings) do
    NIF.set_gamepad_mappings(mappings)
  end

  @doc """
  Set gamepad vibration for both motors (duration in seconds)
  """
  @spec set_vibration(
          gamepad :: integer,
          left_motor :: float,
          right_motor :: float,
          duration :: float
        ) :: :ok
  def set_vibration(
        gamepad,
        left_motor,
        right_motor,
        duration
      )
      when is_integer(gamepad) and
             is_float(left_motor) and
             is_float(right_motor) and
             is_float(duration) do
    NIF.set_gamepad_vibration(
      gamepad,
      left_motor,
      right_motor,
      duration
    )
  end
end
