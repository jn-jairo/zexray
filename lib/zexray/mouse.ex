defmodule Zexray.Mouse do
  @moduledoc """
  Mouse
  """

  import Zexray.Guard
  alias Zexray.NIF

  ###########
  #  Mouse  #
  ###########

  @doc """
  Check if a mouse button has been pressed once
  """
  @spec pressed?(button :: Zexray.Enum.MouseButton.t_all()) :: boolean
  def pressed?(button)
      when is_like_mouse_button(button) do
    NIF.is_mouse_button_pressed(Zexray.Enum.MouseButton.value(button))
  end

  @doc """
  Check if a mouse button is being pressed
  """
  @spec down?(button :: Zexray.Enum.MouseButton.t_all()) :: boolean
  def down?(button)
      when is_like_mouse_button(button) do
    NIF.is_mouse_button_down(Zexray.Enum.MouseButton.value(button))
  end

  @doc """
  Check if a mouse button has been released once
  """
  @spec released?(button :: Zexray.Enum.MouseButton.t_all()) :: boolean
  def released?(button)
      when is_like_mouse_button(button) do
    NIF.is_mouse_button_released(Zexray.Enum.MouseButton.value(button))
  end

  @doc """
  Check if a mouse button is NOT being pressed
  """
  @spec up?(button :: Zexray.Enum.MouseButton.t_all()) :: boolean
  def up?(button)
      when is_like_mouse_button(button) do
    NIF.is_mouse_button_up(Zexray.Enum.MouseButton.value(button))
  end

  @doc """
  Get mouse position X
  """
  @spec get_x() :: integer
  def get_x() do
    NIF.get_mouse_x()
  end

  @doc """
  Get mouse position Y
  """
  @spec get_y() :: integer
  def get_y() do
    NIF.get_mouse_y()
  end

  @doc """
  Get mouse position XY
  """
  @spec get_position(return :: :value | :resource) :: Zexray.Type.Vector2.t_nif()
  def get_position(return \\ :value)
      when is_nif_return(return) do
    NIF.get_mouse_position(return)
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Get mouse delta between frames
  """
  @spec get_delta(return :: :value | :resource) :: Zexray.Type.Vector2.t_nif()
  def get_delta(return \\ :value)
      when is_nif_return(return) do
    NIF.get_mouse_delta(return)
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Set mouse position XY
  """
  @spec set_position(
          x :: integer,
          y :: integer
        ) :: :ok
  def set_position(
        x,
        y
      )
      when is_integer(x) and
             is_integer(y) do
    NIF.set_mouse_position(
      x,
      y
    )
  end

  @doc """
  Set mouse offset
  """
  @spec set_offset(
          offset_x :: integer,
          offset_y :: integer
        ) :: :ok
  def set_offset(
        offset_x,
        offset_y
      )
      when is_integer(offset_x) and
             is_integer(offset_y) do
    NIF.set_mouse_offset(
      offset_x,
      offset_y
    )
  end

  @doc """
  Set mouse scaling
  """
  @spec set_scale(
          scale_x :: float,
          scale_y :: float
        ) :: :ok
  def set_scale(
        scale_x,
        scale_y
      )
      when is_float(scale_x) and
             is_float(scale_y) do
    NIF.set_mouse_scale(
      scale_x,
      scale_y
    )
  end

  @doc """
  Get mouse wheel movement for X or Y, whichever is larger
  """
  @spec get_wheel_move() :: float
  def get_wheel_move() do
    NIF.get_mouse_wheel_move()
  end

  @doc """
  Get mouse wheel movement for both X and Y
  """
  @spec get_wheel_move_v(return :: :value | :resource) :: Zexray.Type.Vector2.t_nif()
  def get_wheel_move_v(return \\ :value)
      when is_nif_return(return) do
    NIF.get_mouse_wheel_move_v(return)
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Set mouse cursor
  """
  @spec set_cursor(cursor :: Zexray.Enum.MouseCursor.t_all()) :: :ok
  def set_cursor(cursor)
      when is_like_mouse_cursor(cursor) do
    NIF.set_mouse_cursor(Zexray.Enum.MouseButton.value(cursor))
  end
end
