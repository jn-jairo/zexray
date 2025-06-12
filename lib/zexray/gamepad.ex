defmodule Zexray.Gamepad do
  @moduledoc """
  Gamepad
  """

  alias Zexray.NIF

  #############
  #  Gamepad  #
  #############

  @doc """
  Check if a gamepad is available
  """
  @spec available?(gamepad :: integer) :: boolean
  defdelegate available?(gamepad), to: NIF, as: :is_gamepad_available

  @doc """
  Get gamepad internal name id
  """
  @spec get_name(gamepad :: integer) :: binary
  defdelegate get_name(gamepad), to: NIF, as: :get_gamepad_name

  @doc """
  Check if a gamepad button has been pressed once
  """
  @spec pressed?(
          gamepad :: integer,
          button :: Zexray.Enum.GamepadButton.t_free()
        ) :: boolean
  defdelegate pressed?(
                gamepad,
                button
              ),
              to: NIF,
              as: :is_gamepad_button_pressed

  @doc """
  Check if a gamepad button is being pressed
  """
  @spec down?(
          gamepad :: integer,
          button :: Zexray.Enum.GamepadButton.t_free()
        ) :: boolean
  defdelegate down?(
                gamepad,
                button
              ),
              to: NIF,
              as: :is_gamepad_button_down

  @doc """
  Check if a gamepad button has been released once
  """
  @spec released?(
          gamepad :: integer,
          button :: Zexray.Enum.GamepadButton.t_free()
        ) :: boolean
  defdelegate released?(
                gamepad,
                button
              ),
              to: NIF,
              as: :is_gamepad_button_released

  @doc """
  Check if a gamepad button is NOT being pressed
  """
  @spec up?(
          gamepad :: integer,
          button :: Zexray.Enum.GamepadButton.t_free()
        ) :: boolean
  defdelegate up?(
                gamepad,
                button
              ),
              to: NIF,
              as: :is_gamepad_button_up

  @doc """
  Get the last gamepad button pressed
  """
  @spec get_pressed() :: Zexray.Enum.GamepadButton.t_free()
  defdelegate get_pressed(), to: NIF, as: :get_gamepad_button_pressed

  @doc """
  Get axis count for a gamepad
  """
  @spec get_axis_count(gamepad :: integer) :: integer
  defdelegate get_axis_count(gamepad), to: NIF, as: :get_gamepad_axis_count

  @doc """
  Get movement value for a gamepad axis
  """
  @spec get_axis_movement(
          gamepad :: integer,
          axis :: Zexray.Enum.GamepadAxis.t_free()
        ) :: float
  defdelegate get_axis_movement(
                gamepad,
                axis
              ),
              to: NIF,
              as: :get_gamepad_axis_movement

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
  defdelegate set_mappings(mappings), to: NIF, as: :set_gamepad_mappings

  @doc """
  Set gamepad vibration for both motors (duration in seconds)
  """
  @spec set_vibration(
          gamepad :: integer,
          left_motor :: float,
          right_motor :: float,
          duration :: float
        ) :: :ok
  defdelegate set_vibration(
                gamepad,
                left_motor,
                right_motor,
                duration
              ),
              to: NIF,
              as: :set_gamepad_vibration
end
