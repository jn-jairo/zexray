defmodule Zexray.Gesture do
  @moduledoc """
  Gesture
  """

  alias Zexray.NIF

  #############
  #  Gesture  #
  #############

  @doc """
  Enable a set of gestures using flags
  """
  @spec set_enabled(flags :: Zexray.Enum.Gesture.t_free()) :: :ok
  defdelegate set_enabled(flags), to: NIF, as: :set_gestures_enabled

  @doc """
  Check if a gesture have been detected
  """
  @spec detected?(gesture :: Zexray.Enum.Gesture.t()) :: boolean
  defdelegate detected?(gesture), to: NIF, as: :is_gesture_detected

  @doc """
  Get latest detected gesture
  """
  @spec get_detected() :: Zexray.Enum.Gesture.t_free()
  defdelegate get_detected(), to: NIF, as: :get_gesture_detected

  @doc """
  Get gesture hold time in seconds
  """
  @spec get_hold_duration() :: float
  defdelegate get_hold_duration(), to: NIF, as: :get_gesture_hold_duration

  @doc """
  Get gesture drag vector
  """
  @spec get_drag_vector(return :: :value | :resource) :: Zexray.Type.Vector2.t_nif()
  defdelegate get_drag_vector(return \\ :value), to: NIF, as: :get_gesture_drag_vector

  @doc """
  Get gesture drag angle
  """
  @spec get_drag_angle() :: float
  defdelegate get_drag_angle(), to: NIF, as: :get_gesture_drag_angle

  @doc """
  Get gesture pinch delta
  """
  @spec get_pinch_vector(return :: :value | :resource) :: Zexray.Type.Vector2.t_nif()
  defdelegate get_pinch_vector(return \\ :value), to: NIF, as: :get_gesture_pinch_vector

  @doc """
  Get gesture pinch angle
  """
  @spec get_pinch_angle() :: float
  defdelegate get_pinch_angle(), to: NIF, as: :get_gesture_pinch_angle
end
