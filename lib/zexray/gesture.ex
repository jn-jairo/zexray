defmodule Zexray.Gesture do
  import Zexray.Guard
  alias Zexray.NIF

  #############
  #  Gesture  #
  #############

  @doc """
  Enable a set of gestures using flags
  """
  @spec set_enabled(flags :: Zexray.Enum.Gesture.t_all_flag()) :: :ok
  def set_enabled(flags)
      when is_like_gesture(flags) or
             (is_list(flags) and (flags == [] or is_like_config_flag(hd(flags)))) do
    NIF.set_gestures_enabled(Zexray.Enum.Gesture.value_flag(flags))
  end

  @doc """
  Check if a gesture have been detected
  """
  @spec detected?(gesture :: Zexray.Enum.Gesture.t_all()) :: boolean
  def detected?(gesture)
      when is_like_gesture(gesture) do
    NIF.is_gesture_detected(Zexray.Enum.Gesture.value(gesture))
  end

  @doc """
  Get latest detected gesture
  """
  @spec get_detected() :: Zexray.Enum.Gesture.t_name_free()
  def get_detected() do
    NIF.get_gesture_detected()
    |> Zexray.Enum.Gesture.name_free()
  end

  @doc """
  Get gesture hold time in seconds
  """
  @spec get_hold_duration() :: float
  def get_hold_duration() do
    NIF.get_gesture_hold_duration()
  end

  @doc """
  Get gesture drag vector
  """
  @spec get_drag_vector(return :: :value | :resource) :: Zexray.Type.Vector2.t_nif()
  def get_drag_vector(return \\ :value)
      when is_nif_return(return) do
    NIF.get_gesture_drag_vector(return)
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Get gesture drag angle
  """
  @spec get_drag_angle() :: float
  def get_drag_angle() do
    NIF.get_gesture_drag_angle()
  end

  @doc """
  Get gesture pinch delta
  """
  @spec get_pinch_vector(return :: :value | :resource) :: Zexray.Type.Vector2.t_nif()
  def get_pinch_vector(return \\ :value)
      when is_nif_return(return) do
    NIF.get_gesture_pinch_vector(return)
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Get gesture pinch angle
  """
  @spec get_pinch_angle() :: float
  def get_pinch_angle() do
    NIF.get_gesture_pinch_angle()
  end
end
