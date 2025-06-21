defmodule Zexray.Math.Vector4 do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      #############
      #  Vector4  #
      #############

      @doc """
      Vector with components value 0.0f
      """
      @doc group: :vector4
      @spec vector4_zero :: Zexray.Type.Vector4.t()
      def vector4_zero do
        type_vector4(
          x: 0.0,
          y: 0.0,
          z: 0.0,
          w: 0.0
        )
      end

      @doc """
      Vector with components value 1.0f
      """
      @doc group: :vector4
      @spec vector4_one :: Zexray.Type.Vector4.t()
      def vector4_one do
        type_vector4(
          x: 1.0,
          y: 1.0,
          z: 1.0,
          w: 1.0
        )
      end

      @doc """
      Add two vectors
      """
      @doc group: :vector4
      @spec vector4_add(
              v1 :: Zexray.Type.Vector4.t(),
              v2 :: Zexray.Type.Vector4.t()
            ) :: Zexray.Type.Vector4.t()
      def vector4_add(v1, v2) do
        type_vector4(x: v1_x, y: v1_y, z: v1_z, w: v1_w) = v1
        type_vector4(x: v2_x, y: v2_y, z: v2_z, w: v2_w) = v2

        type_vector4(
          x: v1_x + v2_x,
          y: v1_y + v2_y,
          z: v1_z + v2_z,
          w: v1_w + v2_w
        )
      end

      @doc """
      Add vector and float value
      """
      @doc group: :vector4
      @spec vector4_add_value(
              v :: Zexray.Type.Vector4.t(),
              add :: number
            ) :: Zexray.Type.Vector4.t()
      def vector4_add_value(v, add) do
        type_vector4(x: v_x, y: v_y, z: v_z, w: v_w) = v

        type_vector4(
          x: v_x + add,
          y: v_y + add,
          z: v_z + add,
          w: v_z + add
        )
      end

      @doc """
      Subtract two vectors
      """
      @doc group: :vector4
      @spec vector4_subtract(
              v1 :: Zexray.Type.Vector4.t(),
              v2 :: Zexray.Type.Vector4.t()
            ) :: Zexray.Type.Vector4.t()
      def vector4_subtract(v1, v2) do
        type_vector4(x: v1_x, y: v1_y, z: v1_z, w: v1_w) = v1
        type_vector4(x: v2_x, y: v2_y, z: v2_z, w: v2_w) = v2

        type_vector4(
          x: v1_x - v2_x,
          y: v1_y - v2_y,
          z: v1_z - v2_z,
          w: v1_w - v2_w
        )
      end

      @doc """
      Subtract vector by float value
      """
      @doc group: :vector4
      @spec vector4_subtract_value(
              v :: Zexray.Type.Vector4.t(),
              sub :: number
            ) :: Zexray.Type.Vector4.t()
      def vector4_subtract_value(v, sub) do
        type_vector4(x: v_x, y: v_y, z: v_z, w: v_w) = v

        type_vector4(
          x: v_x - sub,
          y: v_y - sub,
          z: v_z - sub,
          w: v_w - sub
        )
      end

      @doc """
      Calculate vector length
      """
      @doc group: :vector4
      @spec vector4_length(v :: Zexray.Type.Vector4.t()) :: number
      def vector4_length(v) do
        type_vector4(x: v_x, y: v_y, z: v_z, w: v_w) = v
        :math.sqrt(v_x * v_x + v_y * v_y + v_z * v_z + v_w * v_w)
      end

      @doc """
      Calculate vector square length
      """
      @doc group: :vector4
      @spec vector4_length_sqr(v :: Zexray.Type.Vector4.t()) :: number
      def vector4_length_sqr(v) do
        type_vector4(x: v_x, y: v_y, z: v_z, w: v_w) = v
        v_x * v_x + v_y * v_y + v_z * v_z + v_w * v_w
      end

      @doc """
      Calculate two vectors dot product
      """
      @doc group: :vector4
      @spec vector4_dot_product(
              v1 :: Zexray.Type.Vector4.t(),
              v2 :: Zexray.Type.Vector4.t()
            ) :: number
      def vector4_dot_product(v1, v2) do
        type_vector4(x: v1_x, y: v1_y, z: v1_z, w: v1_w) = v1
        type_vector4(x: v2_x, y: v2_y, z: v2_z, w: v2_w) = v2
        v1_x * v2_x + v1_y * v2_y + v1_z * v2_z + v1_w * v2_w
      end

      @doc """
      Calculate distance between two vectors
      """
      @doc group: :vector4
      @spec vector4_distance(
              v1 :: Zexray.Type.Vector4.t(),
              v2 :: Zexray.Type.Vector4.t()
            ) :: number
      def vector4_distance(v1, v2) do
        type_vector4(x: v1_x, y: v1_y, z: v1_z, w: v1_w) = v1
        type_vector4(x: v2_x, y: v2_y, z: v2_z, w: v2_w) = v2

        dx = v2_x - v1_x
        dy = v2_y - v1_y
        dz = v2_z - v1_z
        dw = v2_w - v1_w

        :math.sqrt(dx * dx + dy * dy + dz * dz + dw * dw)
      end

      @doc """
      Calculate square distance between two vectors
      """
      @doc group: :vector4
      @spec vector4_distance_sqr(
              v1 :: Zexray.Type.Vector4.t(),
              v2 :: Zexray.Type.Vector4.t()
            ) :: number
      def vector4_distance_sqr(v1, v2) do
        type_vector4(x: v1_x, y: v1_y, z: v1_z, w: v1_w) = v1
        type_vector4(x: v2_x, y: v2_y, z: v2_z, w: v2_w) = v2

        dx = v2_x - v1_x
        dy = v2_y - v1_y
        dz = v2_z - v1_z
        dw = v2_w - v1_w

        dx * dx + dy * dy + dz * dz + dw * dw
      end

      @doc """
      Multiply vector by scalar
      """
      @doc group: :vector4
      @spec vector4_scale(
              v :: Zexray.Type.Vector4.t(),
              scale :: number
            ) :: Zexray.Type.Vector4.t()
      def vector4_scale(v, scale) do
        type_vector4(x: v_x, y: v_y, z: v_z, w: v_w) = v

        type_vector4(
          x: v_x * scale,
          y: v_y * scale,
          z: v_z * scale,
          w: v_w * scale
        )
      end

      @doc """
      Multiply vector by vector
      """
      @doc group: :vector4
      @spec vector4_multiply(
              v1 :: Zexray.Type.Vector4.t(),
              v2 :: Zexray.Type.Vector4.t()
            ) :: Zexray.Type.Vector4.t()
      def vector4_multiply(v1, v2) do
        type_vector4(x: v1_x, y: v1_y, z: v1_z, w: v1_w) = v1
        type_vector4(x: v2_x, y: v2_y, z: v2_z, w: v2_w) = v2

        type_vector4(
          x: v1_x * v2_x,
          y: v1_y * v2_y,
          z: v1_z * v2_z,
          w: v1_w * v2_w
        )
      end

      @doc """
      Negate provided vector (invert direction)
      """
      @doc group: :vector4
      @spec vector4_negate(v :: Zexray.Type.Vector4.t()) :: Zexray.Type.Vector4.t()
      def vector4_negate(v) do
        type_vector4(x: v_x, y: v_y, z: v_z, w: v_w) = v

        type_vector4(
          x: v_x * -1,
          y: v_y * -1,
          z: v_z * -1,
          w: v_w * -1
        )
      end

      @doc """
      Divide vector by vector
      """
      @doc group: :vector4
      @spec vector4_divide(
              v1 :: Zexray.Type.Vector4.t(),
              v2 :: Zexray.Type.Vector4.t()
            ) :: Zexray.Type.Vector4.t()
      def vector4_divide(v1, v2) do
        type_vector4(x: v1_x, y: v1_y, z: v1_z, w: v1_w) = v1
        type_vector4(x: v2_x, y: v2_y, z: v2_z, w: v2_w) = v2

        type_vector4(
          x: v1_x / v2_x,
          y: v1_y / v2_y,
          z: v1_z / v2_z,
          w: v1_w / v2_w
        )
      end

      @doc """
      Normalize provided vector
      """
      @doc group: :vector4
      @spec vector4_normalize(v :: Zexray.Type.Vector4.t()) :: Zexray.Type.Vector4.t()
      def vector4_normalize(v) do
        type_vector4(x: v_x, y: v_y, z: v_z, w: v_w) = v

        length = :math.sqrt(v_x * v_x + v_y * v_y + v_z * v_z + v_w * v_w)

        if length != 0 do
          ilength = 1.0 / length

          type_vector4(
            x: v_x * ilength,
            y: v_y * ilength,
            z: v_z * ilength,
            w: v_w * ilength
          )
        else
          type_vector4(
            x: 0.0,
            y: 0.0,
            z: 0.0,
            w: 0.0
          )
        end
      end

      @doc """
      Get min value for each pair of components
      """
      @doc group: :vector4
      @spec vector4_min(
              v1 :: Zexray.Type.Vector4.t(),
              v2 :: Zexray.Type.Vector4.t()
            ) :: Zexray.Type.Vector4.t()
      def vector4_min(v1, v2) do
        type_vector4(x: v1_x, y: v1_y, z: v1_z, w: v1_w) = v1
        type_vector4(x: v2_x, y: v2_y, z: v2_z, w: v2_w) = v2

        type_vector4(
          x: min(v1_x, v2_x),
          y: min(v1_y, v2_y),
          z: min(v1_z, v2_z),
          w: min(v1_w, v2_w)
        )
      end

      @doc """
      Get max value for each pair of components
      """
      @doc group: :vector4
      @spec vector4_max(
              v1 :: Zexray.Type.Vector4.t(),
              v2 :: Zexray.Type.Vector4.t()
            ) :: Zexray.Type.Vector4.t()
      def vector4_max(v1, v2) do
        type_vector4(x: v1_x, y: v1_y, z: v1_z, w: v1_w) = v1
        type_vector4(x: v2_x, y: v2_y, z: v2_z, w: v2_w) = v2

        type_vector4(
          x: max(v1_x, v2_x),
          y: max(v1_y, v2_y),
          z: max(v1_z, v2_z),
          w: max(v1_w, v2_w)
        )
      end

      @doc """
      Calculate linear interpolation between two vectors
      """
      @doc group: :vector4
      @spec vector4_lerp(
              v1 :: Zexray.Type.Vector4.t(),
              v2 :: Zexray.Type.Vector4.t(),
              amount :: number
            ) :: Zexray.Type.Vector4.t()
      def vector4_lerp(v1, v2, amount) do
        type_vector4(x: v1_x, y: v1_y, z: v1_z, w: v1_w) = v1
        type_vector4(x: v2_x, y: v2_y, z: v2_z, w: v2_w) = v2

        type_vector4(
          x: v1_x + amount * (v2_x - v1_x),
          y: v1_y + amount * (v2_y - v1_y),
          z: v1_z + amount * (v2_z - v1_z),
          w: v1_w + amount * (v2_w - v1_w)
        )
      end

      @doc """
      Move Vector towards target
      """
      @doc group: :vector4
      @spec vector4_move_towards(
              v :: Zexray.Type.Vector4.t(),
              target :: Zexray.Type.Vector4.t(),
              max_distance :: number
            ) :: Zexray.Type.Vector4.t()
      def vector4_move_towards(v, target, max_distance) do
        type_vector4(x: v_x, y: v_y, z: v_z, w: v_w) = v
        type_vector4(x: target_x, y: target_y, z: target_z, w: target_w) = target

        dx = target_x - v_x
        dy = target_y - v_y
        dz = target_z - v_z
        dw = target_w - v_w
        value = dx * dx + dy * dy + dz * dz + dw * dw

        if value == 0 or (max_distance >= 0 and value <= max_distance * max_distance) do
          target
        else
          dist = :math.sqrt(value)

          type_vector4(
            x: v_x + dx / dist * max_distance,
            y: v_y + dy / dist * max_distance,
            z: v_z + dz / dist * max_distance,
            w: v_w + dw / dist * max_distance
          )
        end
      end

      @doc """
      Invert the given vector
      """
      @doc group: :vector4
      @spec vector4_invert(v :: Zexray.Type.Vector4.t()) :: Zexray.Type.Vector4.t()
      def vector4_invert(v) do
        type_vector4(x: v_x, y: v_y, z: v_z, w: v_w) = v

        type_vector4(
          x: 1.0 / v_x,
          y: 1.0 / v_y,
          z: 1.0 / v_z,
          w: 1.0 / v_w
        )
      end

      @doc """
      Check whether two given vectors are almost equal
      """
      @doc group: :vector4
      @spec vector4_equals?(
              p :: Zexray.Type.Vector4.t(),
              q :: Zexray.Type.Vector4.t()
            ) :: boolean
      def vector4_equals?(p, q) do
        type_vector4(x: p_x, y: p_y, z: p_z, w: p_w) = p
        type_vector4(x: q_x, y: q_y, z: q_z, w: q_w) = q

        abs(p_x - q_x) <= @epsilon * max(1.0, max(abs(p_x), abs(q_x))) and
          abs(p_y - q_y) <= @epsilon * max(1.0, max(abs(p_y), abs(q_y))) and
          abs(p_z - q_z) <= @epsilon * max(1.0, max(abs(p_z), abs(q_z))) and
          abs(p_w - q_w) <= @epsilon * max(1.0, max(abs(p_w), abs(q_w)))
      end
    end
  end
end

# recompile
# import Zexray.Math
# v1 = {:vector4, 1.0, 2.0, 3.0, 4.0}
# v2 = {:vector4, 3.0, 8.0, 5.0, 6.0}
# mat = Zexray.TypeFixture.matrix_fixture()
# 
