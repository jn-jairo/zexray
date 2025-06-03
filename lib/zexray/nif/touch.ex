defmodule Zexray.NIF.Touch do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_touch [
        # Touch
        get_touch_x: 0,
        get_touch_y: 0,
        get_touch_position: 1,
        get_touch_position: 2,
        get_touch_point_id: 1,
        get_touch_point_count: 0
      ]

      ###########
      #  Touch  #
      ###########

      @doc """
      Get touch position X for touch point 0 (relative to screen size)

      ```c
      // raylib.h
      RLAPI int GetTouchX(void);
      ```
      """
      @doc group: :input_touch
      @spec get_touch_x() :: integer
      def get_touch_x(), do: :erlang.nif_error(:undef)

      @doc """
      Get touch position Y for touch point 0 (relative to screen size)

      ```c
      // raylib.h
      RLAPI int GetTouchY(void);
      ```
      """
      @doc group: :input_touch
      @spec get_touch_y() :: integer
      def get_touch_y(), do: :erlang.nif_error(:undef)

      @doc """
      Get touch position XY for a touch point index (relative to screen size)

      ```c
      // raylib.h
      RLAPI Vector2 GetTouchPosition(int index);
      ```
      """
      @doc group: :input_touch
      @spec get_touch_position(
              index :: integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_touch_position(
            _index,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get touch point identifier for given index

      ```c
      // raylib.h
      RLAPI int GetTouchPointId(int index);
      ```
      """
      @doc group: :input_touch
      @spec get_touch_point_id(index :: integer) :: integer
      def get_touch_point_id(_index), do: :erlang.nif_error(:undef)

      @doc """
      Get number of touch points

      ```c
      // raylib.h
      RLAPI int GetTouchPointCount(void);
      ```
      """
      @doc group: :input_touch
      @spec get_touch_point_count() :: integer
      def get_touch_point_count(), do: :erlang.nif_error(:undef)
    end
  end
end
