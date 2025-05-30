defmodule Zexray.NIF.Gesture do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_gesture [
        # Gesture
        set_gestures_enabled: 1,
        is_gesture_detected: 1,
        get_gesture_detected: 0,
        get_gesture_hold_duration: 0,
        get_gesture_drag_vector: 0,
        get_gesture_drag_vector: 1,
        get_gesture_drag_angle: 0,
        get_gesture_pinch_vector: 0,
        get_gesture_pinch_vector: 1,
        get_gesture_pinch_angle: 0
      ]

      #############
      #  Gesture  #
      #############

      @doc """
      Enable a set of gestures using flags

      ```c
      // raylib.h
      RLAPI void SetGesturesEnabled(unsigned int flags);
      ```
      """
      @doc group: :gesture
      @spec set_gestures_enabled(flags :: non_neg_integer) :: :ok
      def set_gestures_enabled(_flags), do: :erlang.nif_error(:undef)

      @doc """
      Check if a gesture have been detected

      ```c
      // raylib.h
      RLAPI bool IsGestureDetected(unsigned int gesture);
      ```
      """
      @doc group: :gesture
      @spec is_gesture_detected(gesture :: non_neg_integer) :: boolean
      def is_gesture_detected(_gesture), do: :erlang.nif_error(:undef)

      @doc """
      Get latest detected gesture

      ```c
      // raylib.h
      RLAPI int GetGestureDetected(void);
      ```
      """
      @doc group: :gesture
      @spec get_gesture_detected() :: integer
      def get_gesture_detected(), do: :erlang.nif_error(:undef)

      @doc """
      Get gesture hold time in seconds

      ```c
      // raylib.h
      RLAPI float GetGestureHoldDuration(void);
      ```
      """
      @doc group: :gesture
      @spec get_gesture_hold_duration() :: float
      def get_gesture_hold_duration(), do: :erlang.nif_error(:undef)

      @doc """
      Get gesture drag vector

      ```c
      // raylib.h
      RLAPI Vector2 GetGestureDragVector(void);
      ```
      """
      @doc group: :gesture
      @spec get_gesture_drag_vector(return :: :value | :resource) :: tuple
      def get_gesture_drag_vector(_return \\ :value), do: :erlang.nif_error(:undef)

      @doc """
      Get gesture drag angle

      ```c
      // raylib.h
      RLAPI float GetGestureDragAngle(void);
      ```
      """
      @doc group: :gesture
      @spec get_gesture_drag_angle() :: float
      def get_gesture_drag_angle(), do: :erlang.nif_error(:undef)

      @doc """
      Get gesture pinch delta

      ```c
      // raylib.h
      RLAPI Vector2 GetGesturePinchVector(void);
      ```
      """
      @doc group: :gesture
      @spec get_gesture_pinch_vector(return :: :value | :resource) :: tuple
      def get_gesture_pinch_vector(_return \\ :value), do: :erlang.nif_error(:undef)

      @doc """
      Get gesture pinch angle

      ```c
      // raylib.h
      RLAPI float GetGesturePinchAngle(void);
      ```
      """
      @doc group: :gesture
      @spec get_gesture_pinch_angle() :: float
      def get_gesture_pinch_angle(), do: :erlang.nif_error(:undef)
    end
  end
end
