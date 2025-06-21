defmodule Zexray.Math.Vector2 do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      #############
      #  Vector2  #
      #############

      @doc """
      Vector with components value 0.0f
      """
      @doc group: :vector2
      @spec vector2_zero :: Zexray.Type.Vector2.t()
      def vector2_zero do
        type_vector2(
          x: 0.0,
          y: 0.0
        )
      end

      @doc """
      Vector with components value 1.0f
      """
      @doc group: :vector2
      @spec vector2_one :: Zexray.Type.Vector2.t()
      def vector2_one do
        type_vector2(
          x: 1.0,
          y: 1.0
        )
      end

      @doc """
      Add two vectors (v1 + v2)
      """
      @doc group: :vector2
      @spec vector2_add(
              v1 :: Zexray.Type.Vector2.t(),
              v2 :: Zexray.Type.Vector2.t()
            ) :: Zexray.Type.Vector2.t()
      def vector2_add(v1, v2) do
        type_vector2(x: v1_x, y: v1_y) = v1
        type_vector2(x: v2_x, y: v2_y) = v2

        type_vector2(
          x: v1_x + v2_x,
          y: v1_y + v2_y
        )
      end

      @doc """
      Add vector and float value
      """
      @doc group: :vector2
      @spec vector2_add_value(
              v :: Zexray.Type.Vector2.t(),
              add :: number
            ) :: Zexray.Type.Vector2.t()
      def vector2_add_value(v, add) do
        type_vector2(x: v_x, y: v_y) = v

        type_vector2(
          x: v_x + add,
          y: v_y + add
        )
      end

      @doc """
      Subtract two vectors (v1 - v2)
      """
      @doc group: :vector2
      @spec vector2_subtract(
              v1 :: Zexray.Type.Vector2.t(),
              v2 :: Zexray.Type.Vector2.t()
            ) :: Zexray.Type.Vector2.t()
      def vector2_subtract(v1, v2) do
        type_vector2(x: v1_x, y: v1_y) = v1
        type_vector2(x: v2_x, y: v2_y) = v2

        type_vector2(
          x: v1_x - v2_x,
          y: v1_y - v2_y
        )
      end

      @doc """
      Subtract vector by float value
      """
      @doc group: :vector2
      @spec vector2_subtract_value(
              v :: Zexray.Type.Vector2.t(),
              sub :: number
            ) :: Zexray.Type.Vector2.t()
      def vector2_subtract_value(v, sub) do
        type_vector2(x: v_x, y: v_y) = v

        type_vector2(
          x: v_x - sub,
          y: v_y - sub
        )
      end

      @doc """
      Calculate vector length
      """
      @doc group: :vector2
      @spec vector2_length(v :: Zexray.Type.Vector2.t()) :: number
      def vector2_length(v) do
        type_vector2(x: v_x, y: v_y) = v
        :math.sqrt(v_x * v_x + v_y * v_y)
      end

      @doc """
      Calculate vector square length
      """
      @doc group: :vector2
      @spec vector2_length_sqr(v :: Zexray.Type.Vector2.t()) :: number
      def vector2_length_sqr(v) do
        type_vector2(x: v_x, y: v_y) = v
        v_x * v_x + v_y * v_y
      end

      @doc """
      Calculate two vectors dot product
      """
      @doc group: :vector2
      @spec vector2_dot_product(
              v1 :: Zexray.Type.Vector2.t(),
              v2 :: Zexray.Type.Vector2.t()
            ) :: number
      def vector2_dot_product(v1, v2) do
        type_vector2(x: v1_x, y: v1_y) = v1
        type_vector2(x: v2_x, y: v2_y) = v2
        v1_x * v2_x + v1_y * v2_y
      end

      @doc """
      Calculate two vectors cross product
      """
      @doc group: :vector2
      @spec vector2_cross_product(
              v1 :: Zexray.Type.Vector2.t(),
              v2 :: Zexray.Type.Vector2.t()
            ) :: number
      def vector2_cross_product(v1, v2) do
        type_vector2(x: v1_x, y: v1_y) = v1
        type_vector2(x: v2_x, y: v2_y) = v2
        v1_x * v2_y - v1_y * v2_x
      end

      @doc """
      Calculate distance between two vectors
      """
      @doc group: :vector2
      @spec vector2_distance(
              v1 :: Zexray.Type.Vector2.t(),
              v2 :: Zexray.Type.Vector2.t()
            ) :: number
      def vector2_distance(v1, v2) do
        type_vector2(x: v1_x, y: v1_y) = v1
        type_vector2(x: v2_x, y: v2_y) = v2
        :math.sqrt((v1_x - v2_x) * (v1_x - v2_x) + (v1_y - v2_y) * (v1_y - v2_y))
      end

      @doc """
      Calculate square distance between two vectors
      """
      @doc group: :vector2
      @spec vector2_distance_sqr(
              v1 :: Zexray.Type.Vector2.t(),
              v2 :: Zexray.Type.Vector2.t()
            ) :: number
      def vector2_distance_sqr(v1, v2) do
        type_vector2(x: v1_x, y: v1_y) = v1
        type_vector2(x: v2_x, y: v2_y) = v2
        (v1_x - v2_x) * (v1_x - v2_x) + (v1_y - v2_y) * (v1_y - v2_y)
      end

      @doc """
      Calculate the signed angle from v1 to v2, relative to the origin (0, 0)

      NOTE: Coordinate system convention: positive X right, positive Y down,
      positive angles appear clockwise, and negative angles appear counterclockwise
      """
      @doc group: :vector2
      @spec vector2_angle(
              v1 :: Zexray.Type.Vector2.t(),
              v2 :: Zexray.Type.Vector2.t()
            ) :: number
      def vector2_angle(v1, v2) do
        type_vector2(x: v1_x, y: v1_y) = v1
        type_vector2(x: v2_x, y: v2_y) = v2
        dot = v1_x * v2_x + v1_y * v2_y
        det = v1_x * v2_y - v1_y * v2_x
        :math.atan2(det, dot)
      end

      @doc """
      Calculate angle defined by a two vectors line

      NOTE: Parameters need to be normalized

      Current implementation should be aligned with glm::angle
      """
      @doc group: :vector2
      @spec vector2_line_angle(
              from :: Zexray.Type.Vector2.t(),
              to :: Zexray.Type.Vector2.t()
            ) :: number
      def vector2_line_angle(from, to) do
        type_vector2(x: from_x, y: from_y) = from
        type_vector2(x: to_x, y: to_y) = to
        # TODO: Currently angles move clockwise, determine if this is wanted behavior
        -1.0 * :math.atan2(to_y - from_y, to_x - from_x)
      end

      @doc """
      Scale vector (multiply by value)
      """
      @doc group: :vector2
      @spec vector2_scale(
              v :: Zexray.Type.Vector2.t(),
              scale :: number
            ) :: Zexray.Type.Vector2.t()
      def vector2_scale(v, scale) do
        type_vector2(x: v_x, y: v_y) = v

        type_vector2(
          x: v_x * scale,
          y: v_y * scale
        )
      end

      @doc """
      Multiply vector by vector
      """
      @doc group: :vector2
      @spec vector2_multiply(
              v1 :: Zexray.Type.Vector2.t(),
              v2 :: Zexray.Type.Vector2.t()
            ) :: number
      def vector2_multiply(v1, v2) do
        type_vector2(x: v1_x, y: v1_y) = v1
        type_vector2(x: v2_x, y: v2_y) = v2
        v1_x * v2_x + v1_y * v2_y
      end

      @doc """
      Negate vector
      """
      @doc group: :vector2
      @spec vector2_negate(v :: Zexray.Type.Vector2.t()) :: Zexray.Type.Vector2.t()
      def vector2_negate(v) do
        type_vector2(x: v_x, y: v_y) = v

        type_vector2(
          x: v_x * -1,
          y: v_y * -1
        )
      end

      @doc """
      Divide vector by vector
      """
      @doc group: :vector2
      @spec vector2_divide(
              v1 :: Zexray.Type.Vector2.t(),
              v2 :: Zexray.Type.Vector2.t()
            ) :: number
      def vector2_divide(v1, v2) do
        type_vector2(x: v1_x, y: v1_y) = v1
        type_vector2(x: v2_x, y: v2_y) = v2
        v1_x / v2_x + v1_y / v2_y
      end

      @doc """
      Normalize provided vector
      """
      @doc group: :vector2
      @spec vector2_normalize(v :: Zexray.Type.Vector2.t()) :: Zexray.Type.Vector2.t()
      def vector2_normalize(v) do
        type_vector2(x: v_x, y: v_y) = v

        length = :math.sqrt(v_x * v_x + v_y * v_y)

        if length != 0 do
          ilength = 1.0 / length

          type_vector2(
            x: v_x * ilength,
            y: v_y * ilength
          )
        else
          type_vector2(
            x: 0.0,
            y: 0.0
          )
        end
      end

      @doc """
      Transforms a Vector2 by a given Matrix
      """
      @doc group: :vector2
      @spec vector2_transform(
              v :: Zexray.Type.Vector2.t(),
              mat :: Zexray.Type.Matrix.t()
            ) :: Zexray.Type.Vector2.t()
      def vector2_transform(v, mat) do
        type_vector2(x: v_x, y: v_y) = v

        type_matrix(
          m0: mat_m0,
          m1: mat_m1,
          m4: mat_m4,
          m5: mat_m5,
          m8: mat_m8,
          m9: mat_m9,
          m12: mat_m12,
          m13: mat_m13
        ) = mat

        x = v_x
        y = v_y
        z = 0

        type_vector2(
          x: mat_m0 * x + mat_m4 * y + mat_m8 * z + mat_m12,
          y: mat_m1 * x + mat_m5 * y + mat_m9 * z + mat_m13
        )
      end

      @doc """
      Calculate linear interpolation between two vectors
      """
      @doc group: :vector2
      @spec vector2_lerp(
              v1 :: Zexray.Type.Vector2.t(),
              v2 :: Zexray.Type.Vector2.t(),
              amount :: number
            ) :: Zexray.Type.Vector2.t()
      def vector2_lerp(v1, v2, amount) do
        type_vector2(x: v1_x, y: v1_y) = v1
        type_vector2(x: v2_x, y: v2_y) = v2

        type_vector2(
          x: v1_x + amount * (v2_x - v1_x),
          y: v1_y + amount * (v2_y - v1_y)
        )
      end

      @doc """
      Calculate reflected vector to normal
      """
      @doc group: :vector2
      @spec vector2_reflect(
              v :: Zexray.Type.Vector2.t(),
              normal :: Zexray.Type.Vector2.t()
            ) :: Zexray.Type.Vector2.t()
      def vector2_reflect(v, normal) do
        type_vector2(x: v_x, y: v_y) = v
        type_vector2(x: normal_x, y: normal_y) = normal

        dot_product = v_x * normal_x + v_y * normal_y

        type_vector2(
          x: v_x - 2.0 * normal_x * dot_product,
          y: v_y - 2.0 * normal_y * dot_product
        )
      end

      @doc """
      Get min value for each pair of components
      """
      @doc group: :vector2
      @spec vector2_min(
              v1 :: Zexray.Type.Vector2.t(),
              v2 :: Zexray.Type.Vector2.t()
            ) :: Zexray.Type.Vector2.t()
      def vector2_min(v1, v2) do
        type_vector2(x: v1_x, y: v1_y) = v1
        type_vector2(x: v2_x, y: v2_y) = v2

        type_vector2(
          x:
            min(
              v1_x,
              v2_x
            ),
          y:
            min(
              v1_y,
              v2_y
            )
        )
      end

      @doc """
      Get max value for each pair of components
      """
      @doc group: :vector2
      @spec vector2_max(
              v1 :: Zexray.Type.Vector2.t(),
              v2 :: Zexray.Type.Vector2.t()
            ) :: Zexray.Type.Vector2.t()
      def vector2_max(v1, v2) do
        type_vector2(x: v1_x, y: v1_y) = v1
        type_vector2(x: v2_x, y: v2_y) = v2

        type_vector2(
          x:
            max(
              v1_x,
              v2_x
            ),
          y:
            max(
              v1_y,
              v2_y
            )
        )
      end

      @doc """
      Rotate vector by angle
      """
      @doc group: :vector2
      @spec vector2_rotate(
              v :: Zexray.Type.Vector2.t(),
              angle :: number
            ) :: Zexray.Type.Vector2.t()
      def vector2_rotate(v, angle) do
        type_vector2(x: v_x, y: v_y) = v

        cosres = :math.cos(angle)
        sinres = :math.sin(angle)

        type_vector2(
          x: v_x * cosres - v_y * sinres,
          y: v_x * sinres + v_y * cosres
        )
      end

      @doc """
      Move Vector towards target
      """
      @doc group: :vector2
      @spec vector2_move_towards(
              v :: Zexray.Type.Vector2.t(),
              target :: Zexray.Type.Vector2.t(),
              max_distance :: number
            ) :: Zexray.Type.Vector2.t()
      def vector2_move_towards(v, target, max_distance) do
        type_vector2(x: v_x, y: v_y) = v
        type_vector2(x: target_x, y: target_y) = target

        dx = target_x - v_x
        dy = target_y - v_y
        value = dx * dx + dy * dy

        if value == 0 or (max_distance >= 0 and value <= max_distance * max_distance) do
          target
        else
          dist = :math.sqrt(value)

          type_vector2(
            x: v_x + dx / dist * max_distance,
            y: v_y + dy / dist * max_distance
          )
        end
      end

      @doc """
      Invert the given vector
      """
      @doc group: :vector2
      @spec vector2_invert(v :: Zexray.Type.Vector2.t()) :: Zexray.Type.Vector2.t()
      def vector2_invert(v) do
        type_vector2(x: v_x, y: v_y) = v

        type_vector2(
          x: 1.0 / v_x,
          y: 1.0 / v_y
        )
      end

      @doc """
      Clamp the components of the vector between
      min and max values specified by the given vectors
      """
      @doc group: :vector2
      @spec vector2_clamp(
              v :: Zexray.Type.Vector2.t(),
              min :: Zexray.Type.Vector2.t(),
              max :: Zexray.Type.Vector2.t()
            ) :: Zexray.Type.Vector2.t()
      def vector2_clamp(v, min, max) do
        type_vector2(x: v_x, y: v_y) = v
        type_vector2(x: min_x, y: min_y) = min
        type_vector2(x: max_x, y: max_y) = max

        type_vector2(
          x: min(max_x, max(min_x, v_x)),
          y: min(max_y, max(min_y, v_y))
        )
      end

      @doc """
      Clamp the magnitude of the vector between two min and max values
      """
      @doc group: :vector2
      @spec vector2_clamp_value(
              v :: Zexray.Type.Vector2.t(),
              min :: number,
              max :: number
            ) :: Zexray.Type.Vector2.t()
      def vector2_clamp_value(v, min, max) do
        type_vector2(x: v_x, y: v_y) = v

        length = v_x * v_x + v_y * v_y

        if length > 0.0 do
          length = :math.sqrt(length)

          scale =
            cond do
              length < min -> min / length
              length > max -> max / length
              # By default, 1 as the neutral element.
              true -> 1
            end

          type_vector2(
            x: v_x * scale,
            y: v_y * scale
          )
        else
          v
        end
      end

      @doc """
      Check whether two given vectors are almost equal
      """
      @doc group: :vector2
      @spec vector2_equals?(
              p :: Zexray.Type.Vector2.t(),
              q :: Zexray.Type.Vector2.t()
            ) :: boolean
      def vector2_equals?(p, q) do
        type_vector2(x: p_x, y: p_y) = p
        type_vector2(x: q_x, y: q_y) = q

        abs(p_x - q_x) <= @epsilon * max(1.0, max(abs(p_x), abs(q_x))) and
          abs(p_y - q_y) <= @epsilon * max(1.0, max(abs(p_y), abs(q_y)))
      end

      @doc """
      Compute the direction of a refracted ray

      v: normalized direction of the incoming ray

      n: normalized normal vector of the interface of two optical media

      r: ratio of the refractive index of the medium from where the ray comes
         to the refractive index of the medium on the other side of the surface
      """
      @doc group: :vector2
      @spec vector2_refract(
              v :: Zexray.Type.Vector2.t(),
              n :: Zexray.Type.Vector2.t(),
              r :: number
            ) :: Zexray.Type.Vector2.t()
      def vector2_refract(v, n, r) do
        type_vector2(x: v_x, y: v_y) = v
        type_vector2(x: n_x, y: n_y) = n

        dot = v_x * n_x + v_y * n_y

        d = 1.0 - r * r * (1.0 - dot * dot)

        if d >= 0.0 do
          d = :math.sqrt(d)

          type_vector2(
            x: r * v_x - (r * dot + d) * n_x,
            y: r * v_y - (r * dot + d) * n_y
          )
        else
          type_vector2(
            x: 0.0,
            y: 0.0
          )
        end
      end
    end
  end
end

# recompile
# import Zexray.Math
# v1 = {:vector2, 1.0, 2.0}
# v2 = {:vector2, 3.0, 8.0}
# mat = Zexray.TypeFixture.matrix_fixture()
# 
