defmodule Zexray.Math.Util do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      ###########
      #  Utils  #
      ###########

      @doc """
      Clamp float value
      """
      @doc group: :utils
      @spec clamp(value :: number, min :: number, max :: number) :: number
      def clamp(value, min, max) do
        max(min, min(max, value))
      end

      @doc """
      Calculate linear interpolation between two floats
      """
      @doc group: :utils
      @spec lerp(from :: number, to :: number, amount :: number) :: number
      def lerp(from, to, amount) do
        from + amount * (to - from)
      end

      @doc """
      Normalize input value within input range
      """
      @doc group: :utils
      @spec normalize(value :: number, from :: number, to :: number) :: number
      def normalize(value, from, to) do
        (value - from) / (to - from)
      end

      @doc """
      Remap input value within input range to output range
      """
      @doc group: :utils
      @spec remap(
              value :: number,
              input_from :: number,
              input_to :: number,
              output_from :: number,
              output_to :: number
            ) :: number
      def remap(value, input_from, input_to, output_from, output_to) do
        (value - input_from) / (input_to - input_from) * (output_to - output_from) + output_from
      end

      @doc """
      Wrap input value from min to max
      """
      @doc group: :utils
      @spec wrap(value :: number, min :: number, max :: number) :: number
      def wrap(value, min, max) do
        value - (max - min) * :math.floor((value - min) / (max - min))
      end

      @doc """
      Check whether two given floats are almost equal
      """
      @doc group: :utils
      @spec number_equals?(x :: number, y :: number) :: boolean
      def number_equals?(x, y) do
        abs(x - y) <= @epsilon * max(1.0, max(abs(x), abs(y)))
      end

      @doc """
      Degrees to radians
      """
      @doc group: :utils
      @spec deg2rad(value :: number) :: number
      def deg2rad(value) do
        value * @deg2rad
      end

      @doc """
      Radians to degrees
      """
      @doc group: :utils
      @spec rad2deg(value :: number) :: number
      def rad2deg(value) do
        value * @rad2deg
      end
    end
  end
end
