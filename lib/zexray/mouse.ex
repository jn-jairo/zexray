defmodule Zexray.Mouse do
  @moduledoc """
  Mouse
  """

  alias Zexray.NIF

  ###########
  #  Mouse  #
  ###########

  @doc """
  Check if a mouse button has been pressed once
  """
  @spec pressed?(button :: Zexray.Enum.MouseButton.t()) :: boolean
  defdelegate pressed?(button), to: NIF, as: :is_mouse_button_pressed

  @doc """
  Check if a mouse button is being pressed
  """
  @spec down?(button :: Zexray.Enum.MouseButton.t()) :: boolean
  defdelegate down?(button), to: NIF, as: :is_mouse_button_down

  @doc """
  Check if a mouse button has been released once
  """
  @spec released?(button :: Zexray.Enum.MouseButton.t()) :: boolean
  defdelegate released?(button), to: NIF, as: :is_mouse_button_released

  @doc """
  Check if a mouse button is NOT being pressed
  """
  @spec up?(button :: Zexray.Enum.MouseButton.t()) :: boolean
  defdelegate up?(button), to: NIF, as: :is_mouse_button_up

  @doc """
  Get mouse position X
  """
  @spec get_x() :: integer
  defdelegate get_x(), to: NIF, as: :get_mouse_x

  @doc """
  Get mouse position Y
  """
  @spec get_y() :: integer
  defdelegate get_y(), to: NIF, as: :get_mouse_y

  @doc """
  Get mouse position XY
  """
  @spec get_position(return :: :auto | :value | :resource) :: Zexray.Type.Vector2.t_nif()
  defdelegate get_position(return \\ :auto), to: NIF, as: :get_mouse_position

  @doc """
  Get mouse delta between frames
  """
  @spec get_delta(return :: :auto | :value | :resource) :: Zexray.Type.Vector2.t_nif()
  defdelegate get_delta(return \\ :auto), to: NIF, as: :get_mouse_delta

  @doc """
  Set mouse position XY
  """
  @spec set_position(
          x :: integer,
          y :: integer
        ) :: :ok
  defdelegate set_position(
                x,
                y
              ),
              to: NIF,
              as: :set_mouse_position

  @doc """
  Set mouse offset
  """
  @spec set_offset(
          offset_x :: integer,
          offset_y :: integer
        ) :: :ok
  defdelegate set_offset(
                offset_x,
                offset_y
              ),
              to: NIF,
              as: :set_mouse_offset

  @doc """
  Set mouse scaling
  """
  @spec set_scale(
          scale_x :: float,
          scale_y :: float
        ) :: :ok
  defdelegate set_scale(
                scale_x,
                scale_y
              ),
              to: NIF,
              as: :set_mouse_scale

  @doc """
  Get mouse wheel movement for X or Y, whichever is larger
  """
  @spec get_wheel_move() :: float
  defdelegate get_wheel_move(), to: NIF, as: :get_mouse_wheel_move

  @doc """
  Get mouse wheel movement for both X and Y
  """
  @spec get_wheel_move_v(return :: :auto | :value | :resource) :: Zexray.Type.Vector2.t_nif()
  defdelegate get_wheel_move_v(return \\ :auto), to: NIF, as: :get_mouse_wheel_move_v

  @doc """
  Set mouse cursor
  """
  @spec set_cursor(cursor :: Zexray.Enum.MouseCursor.t()) :: :ok
  defdelegate set_cursor(cursor), to: NIF, as: :set_mouse_cursor
end
