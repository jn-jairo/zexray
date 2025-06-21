defmodule Zexray.Math.Vector3 do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      #############
      #  Vector3  #
      #############

      @doc """
      Vector with components value 0.0f
      """
      @doc group: :vector3
      @spec vector3_zero :: Zexray.Type.Vector3.t()
      def vector3_zero do
        type_vector3(
          x: 0.0,
          y: 0.0,
          z: 0.0
        )
      end

      @doc """
      Vector with components value 1.0f
      """
      @doc group: :vector3
      @spec vector3_one :: Zexray.Type.Vector3.t()
      def vector3_one do
        type_vector3(
          x: 1.0,
          y: 1.0,
          z: 1.0
        )
      end

      @doc """
      Add two vectors
      """
      @doc group: :vector3
      @spec vector3_add(
              v1 :: Zexray.Type.Vector3.t(),
              v2 :: Zexray.Type.Vector3.t()
            ) :: Zexray.Type.Vector3.t()
      def vector3_add(v1, v2) do
        type_vector3(x: v1_x, y: v1_y, z: v1_z) = v1
        type_vector3(x: v2_x, y: v2_y, z: v2_z) = v2

        type_vector3(
          x: v1_x + v2_x,
          y: v1_y + v2_y,
          z: v1_z + v2_z
        )
      end

      @doc """
      Add vector and float value
      """
      @doc group: :vector3
      @spec vector3_add_value(
              v :: Zexray.Type.Vector3.t(),
              add :: number
            ) :: Zexray.Type.Vector3.t()
      def vector3_add_value(v, add) do
        type_vector3(x: v_x, y: v_y, z: v_z) = v

        type_vector3(
          x: v_x + add,
          y: v_y + add,
          z: v_z + add
        )
      end

      @doc """
      Subtract two vectors
      """
      @doc group: :vector3
      @spec vector3_subtract(
              v1 :: Zexray.Type.Vector3.t(),
              v2 :: Zexray.Type.Vector3.t()
            ) :: Zexray.Type.Vector3.t()
      def vector3_subtract(v1, v2) do
        type_vector3(x: v1_x, y: v1_y, z: v1_z) = v1
        type_vector3(x: v2_x, y: v2_y, z: v2_z) = v2

        type_vector3(
          x: v1_x - v2_x,
          y: v1_y - v2_y,
          z: v1_z - v2_z
        )
      end

      @doc """
      Subtract vector by float value
      """
      @doc group: :vector3
      @spec vector3_subtract_value(
              v :: Zexray.Type.Vector3.t(),
              sub :: number
            ) :: Zexray.Type.Vector3.t()
      def vector3_subtract_value(v, sub) do
        type_vector3(x: v_x, y: v_y, z: v_z) = v

        type_vector3(
          x: v_x - sub,
          y: v_y - sub,
          z: v_z - sub
        )
      end

      @doc """
      Multiply vector by scalar
      """
      @doc group: :vector3
      @spec vector3_scale(
              v :: Zexray.Type.Vector3.t(),
              scale :: number
            ) :: Zexray.Type.Vector3.t()
      def vector3_scale(v, scale) do
        type_vector3(x: v_x, y: v_y, z: v_z) = v

        type_vector3(
          x: v_x * scale,
          y: v_y * scale,
          z: v_z * scale
        )
      end

      @doc """
      Multiply vector by vector
      """
      @doc group: :vector3
      @spec vector3_multiply(
              v1 :: Zexray.Type.Vector3.t(),
              v2 :: Zexray.Type.Vector3.t()
            ) :: Zexray.Type.Vector3.t()
      def vector3_multiply(v1, v2) do
        type_vector3(x: v1_x, y: v1_y, z: v1_z) = v1
        type_vector3(x: v2_x, y: v2_y, z: v2_z) = v2

        type_vector3(
          x: v1_x * v2_x,
          y: v1_y * v2_y,
          z: v1_z * v2_z
        )
      end

      @doc """
      Calculate two vectors cross product
      """
      @doc group: :vector3
      @spec vector3_cross_product(
              v1 :: Zexray.Type.Vector3.t(),
              v2 :: Zexray.Type.Vector3.t()
            ) :: Zexray.Type.Vector3.t()
      def vector3_cross_product(v1, v2) do
        type_vector3(x: v1_x, y: v1_y, z: v1_z) = v1
        type_vector3(x: v2_x, y: v2_y, z: v2_z) = v2

        type_vector3(
          x: v1_y * v2_z - v1_z * v2_y,
          y: v1_z * v2_x - v1_x * v2_z,
          z: v1_x * v2_y - v1_y * v2_x
        )
      end

      @doc """
      Calculate one vector perpendicular vector
      """
      @doc group: :vector3
      @spec vector3_perpendicular(v :: Zexray.Type.Vector3.t()) :: Zexray.Type.Vector3.t()
      def vector3_perpendicular(v) do
        type_vector3(x: v_x, y: v_y, z: v_z) = v

        min = abs(v_x)
        cardinal_axis = type_vector3(x: 1.0, y: 0.0, z: 0.0)

        abs_y = abs(v_y)

        {min, cardinal_axis} =
          if abs_y < min,
            do: {abs_y, type_vector3(x: 0.0, y: 1.0, z: 0.0)},
            else: {min, cardinal_axis}

        cardinal_axis =
          if abs(v_z) < min,
            do: type_vector3(x: 0.0, y: 0.0, z: 1.0),
            else: cardinal_axis

        type_vector3(x: c_x, y: c_y, z: c_z) = cardinal_axis

        # Cross product between vectors
        type_vector3(
          x: v_y * c_z - v_z * c_y,
          y: v_z * c_x - v_x * c_z,
          z: v_x * c_y - v_y * c_x
        )
      end

      @doc """
      Calculate vector length
      """
      @doc group: :vector3
      @spec vector3_length(v :: Zexray.Type.Vector3.t()) :: number
      def vector3_length(v) do
        type_vector3(x: v_x, y: v_y, z: v_z) = v
        :math.sqrt(v_x * v_x + v_y * v_y + v_z * v_z)
      end

      @doc """
      Calculate vector square length
      """
      @doc group: :vector3
      @spec vector3_length_sqr(v :: Zexray.Type.Vector3.t()) :: number
      def vector3_length_sqr(v) do
        type_vector3(x: v_x, y: v_y, z: v_z) = v
        v_x * v_x + v_y * v_y + v_z * v_z
      end

      @doc """
      Calculate two vectors dot product
      """
      @doc group: :vector3
      @spec vector3_dot_product(
              v1 :: Zexray.Type.Vector3.t(),
              v2 :: Zexray.Type.Vector3.t()
            ) :: number
      def vector3_dot_product(v1, v2) do
        type_vector3(x: v1_x, y: v1_y, z: v1_z) = v1
        type_vector3(x: v2_x, y: v2_y, z: v2_z) = v2
        v1_x * v2_x + v1_y * v2_y + v1_z * v2_z
      end

      @doc """
      Calculate distance between two vectors
      """
      @doc group: :vector3
      @spec vector3_distance(
              v1 :: Zexray.Type.Vector3.t(),
              v2 :: Zexray.Type.Vector3.t()
            ) :: number
      def vector3_distance(v1, v2) do
        type_vector3(x: v1_x, y: v1_y, z: v1_z) = v1
        type_vector3(x: v2_x, y: v2_y, z: v2_z) = v2

        dx = v2_x - v1_x
        dy = v2_y - v1_y
        dz = v2_z - v1_z

        :math.sqrt(dx * dx + dy * dy + dz * dz)
      end

      @doc """
      Calculate square distance between two vectors
      """
      @doc group: :vector3
      @spec vector3_distance_sqr(
              v1 :: Zexray.Type.Vector3.t(),
              v2 :: Zexray.Type.Vector3.t()
            ) :: number
      def vector3_distance_sqr(v1, v2) do
        type_vector3(x: v1_x, y: v1_y, z: v1_z) = v1
        type_vector3(x: v2_x, y: v2_y, z: v2_z) = v2

        dx = v2_x - v1_x
        dy = v2_y - v1_y
        dz = v2_z - v1_z

        dx * dx + dy * dy + dz * dz
      end

      @doc """
      Calculate angle between two vectors
      """
      @doc group: :vector3
      @spec vector3_angle(
              v1 :: Zexray.Type.Vector3.t(),
              v2 :: Zexray.Type.Vector3.t()
            ) :: number
      def vector3_angle(v1, v2) do
        type_vector3(x: v1_x, y: v1_y, z: v1_z) = v1
        type_vector3(x: v2_x, y: v2_y, z: v2_z) = v2

        c_x = v1_y * v2_z - v1_z * v2_y
        c_y = v1_z * v2_x - v1_x * v2_z
        c_z = v1_x * v2_y - v1_y * v2_x

        len = :math.sqrt(c_x * c_x + c_y * c_y + c_z * c_z)
        dot = v1_x * v2_x + v1_y * v2_y + v1_z * v2_z

        :math.atan2(len, dot)
      end

      @doc """
      Negate provided vector (invert direction)
      """
      @doc group: :vector3
      @spec vector3_negate(v :: Zexray.Type.Vector3.t()) :: Zexray.Type.Vector3.t()
      def vector3_negate(v) do
        type_vector3(x: v_x, y: v_y, z: v_z) = v

        type_vector3(
          x: v_x * -1,
          y: v_y * -1,
          z: v_z * -1
        )
      end

      @doc """
      Divide vector by vector
      """
      @doc group: :vector3
      @spec vector3_divide(
              v1 :: Zexray.Type.Vector3.t(),
              v2 :: Zexray.Type.Vector3.t()
            ) :: Zexray.Type.Vector3.t()
      def vector3_divide(v1, v2) do
        type_vector3(x: v1_x, y: v1_y, z: v1_z) = v1
        type_vector3(x: v2_x, y: v2_y, z: v2_z) = v2

        type_vector3(
          x: v1_x / v2_x,
          y: v1_y / v2_y,
          z: v1_z / v2_z
        )
      end

      @doc """
      Normalize provided vector
      """
      @doc group: :vector3
      @spec vector3_normalize(v :: Zexray.Type.Vector3.t()) :: Zexray.Type.Vector3.t()
      def vector3_normalize(v) do
        type_vector3(x: v_x, y: v_y, z: v_z) = v

        length = :math.sqrt(v_x * v_x + v_y * v_y + v_z * v_z)

        if length != 0 do
          ilength = 1.0 / length

          type_vector3(
            x: v_x * ilength,
            y: v_y * ilength,
            z: v_z * ilength
          )
        else
          type_vector3(
            x: 0.0,
            y: 0.0,
            z: 0.0
          )
        end
      end

      @doc """
      Calculate the projection of the vector v1 on to v2
      """
      @doc group: :vector3
      @spec vector3_project(
              v1 :: Zexray.Type.Vector3.t(),
              v2 :: Zexray.Type.Vector3.t()
            ) :: Zexray.Type.Vector3.t()
      def vector3_project(v1, v2) do
        type_vector3(x: v1_x, y: v1_y, z: v1_z) = v1
        type_vector3(x: v2_x, y: v2_y, z: v2_z) = v2

        v1dv2 = v1_x * v2_x + v1_y * v2_y + v1_z * v2_z
        v2dv2 = v2_x * v2_x + v2_y * v2_y + v2_z * v2_z

        mag = v1dv2 / v2dv2

        type_vector3(
          x: v2_x * mag,
          y: v2_y * mag,
          z: v2_z * mag
        )
      end

      @doc """
      Calculate the rejection of the vector v1 on to v2
      """
      @doc group: :vector3
      @spec vector3_reject(
              v1 :: Zexray.Type.Vector3.t(),
              v2 :: Zexray.Type.Vector3.t()
            ) :: Zexray.Type.Vector3.t()
      def vector3_reject(v1, v2) do
        type_vector3(x: v1_x, y: v1_y, z: v1_z) = v1
        type_vector3(x: v2_x, y: v2_y, z: v2_z) = v2

        v1dv2 = v1_x * v2_x + v1_y * v2_y + v1_z * v2_z
        v2dv2 = v2_x * v2_x + v2_y * v2_y + v2_z * v2_z

        mag = v1dv2 / v2dv2

        type_vector3(
          x: v1_x - v2_x * mag,
          y: v1_y - v2_y * mag,
          z: v1_z - v2_z * mag
        )
      end

      @doc """
      Orthonormalize provided vectors

      Makes vectors normalized and orthogonal to each other

      Gram-Schmidt function implementation
      """
      @doc group: :vector3
      @spec vector3_ortho_normalize(
              v1 :: Zexray.Type.Vector3.t(),
              v2 :: Zexray.Type.Vector3.t()
            ) :: {v1 :: Zexray.Type.Vector3.t(), v2 :: Zexray.Type.Vector3.t()}
      def vector3_ortho_normalize(v1, v2) do
        type_vector3(x: v1_x, y: v1_y, z: v1_z) = v1
        type_vector3(x: v2_x, y: v2_y, z: v2_z) = v2

        # vector3_normalize(v1)
        length = :math.sqrt(v1_x * v1_x + v1_y * v1_y + v1_z * v1_z)

        {v1_x, v1_y, v1_z} =
          if length != 0 do
            ilength = 1.0 / length
            {v1_x * ilength, v1_y * ilength, v1_z * ilength}
          else
            {0.0, 0.0, 0.0}
          end

        # vector3_cross_product(v1, v2)
        vn1_x = v1_y * v2_z - v1_z * v2_y
        vn1_y = v1_z * v2_x - v1_x * v2_z
        vn1_z = v1_x * v2_y - v1_y * v2_x

        # vector3_normalize(vn1)
        length = :math.sqrt(vn1_x * vn1_x + vn1_y * vn1_y + vn1_z * vn1_z)

        {vn1_x, vn1_y, vn1_z} =
          if length != 0 do
            ilength = 1.0 / length
            {vn1_x * ilength, vn1_y * ilength, vn1_z * ilength}
          else
            {0.0, 0.0, 0.0}
          end

        # vector3_cross_product(vn1, v1)
        vn2_x = vn1_y * v1_z - vn1_z * v1_y
        vn2_y = vn1_z * v1_x - vn1_x * v1_z
        vn2_z = vn1_x * v1_y - vn1_y * v1_x

        {
          type_vector3(
            x: v1_x,
            y: v1_y,
            z: v1_z
          ),
          type_vector3(
            x: vn2_x,
            y: vn2_y,
            z: vn2_z
          )
        }
      end

      @doc """
      Transforms a Vector3 by a given Matrix
      """
      @doc group: :vector3
      @spec vector3_transform(
              v :: Zexray.Type.Vector3.t(),
              mat :: Zexray.Type.Matrix.t()
            ) :: Zexray.Type.Vector3.t()
      def vector3_transform(v, mat) do
        type_vector3(x: v_x, y: v_y, z: v_z) = v

        type_matrix(
          m0: mat_m0,
          m1: mat_m1,
          m2: mat_m2,
          m4: mat_m4,
          m5: mat_m5,
          m6: mat_m6,
          m8: mat_m8,
          m9: mat_m9,
          m10: mat_m10,
          m12: mat_m12,
          m13: mat_m13,
          m14: mat_m14
        ) = mat

        x = v_x
        y = v_y
        z = v_z

        type_vector3(
          x: mat_m0 * x + mat_m4 * y + mat_m8 * z + mat_m12,
          y: mat_m1 * x + mat_m5 * y + mat_m9 * z + mat_m13,
          z: mat_m2 * x + mat_m6 * y + mat_m10 * z + mat_m14
        )
      end

      @doc """
      Transform a vector by quaternion rotation
      """
      @doc group: :vector3
      @spec vector3_rotate_by_quaternion(
              v :: Zexray.Type.Vector3.t(),
              q :: Zexray.Type.Quaternion.t()
            ) :: Zexray.Type.Vector3.t()
      def vector3_rotate_by_quaternion(v, q) do
        type_vector3(x: v_x, y: v_y, z: v_z) = v
        type_quaternion(x: q_x, y: q_y, z: q_z, w: q_w) = q

        type_vector3(
          x:
            v_x * (q_x * q_x + q_w * q_w - q_y * q_y - q_z * q_z) +
              v_y * (2 * q_x * q_y - 2 * q_w * q_z) +
              v_z * (2 * q_x * q_z + 2 * q_w * q_y),
          y:
            v_x * (2 * q_w * q_z + 2 * q_x * q_y) +
              v_y * (q_w * q_w - q_x * q_x + q_y * q_y - q_z * q_z) +
              v_z * (-2 * q_w * q_x + 2 * q_y * q_z),
          z:
            v_x * (-2 * q_w * q_y + 2 * q_x * q_z) +
              v_y * (2 * q_w * q_x + 2 * q_y * q_z) +
              v_z * (q_w * q_w - q_x * q_x - q_y * q_y + q_z * q_z)
        )
      end

      @doc """
      Rotates a vector around an axis
      """
      @doc group: :vector3
      @spec vector3_rotate_by_axis_angle(
              v :: Zexray.Type.Vector3.t(),
              axis :: Zexray.Type.Vector3.t(),
              angle :: number
            ) :: Zexray.Type.Vector3.t()
      def vector3_rotate_by_axis_angle(v, axis, angle) do
        type_vector3(x: v_x, y: v_y, z: v_z) = v
        type_vector3(x: axis_x, y: axis_y, z: axis_z) = axis

        # Using Euler-Rodrigues Formula
        # Ref.: https://en.wikipedia.org/w/index.php?title=Euler%E2%80%93Rodrigues_formula

        # vector3_normalize(axis)
        length = :math.sqrt(axis_x * axis_x + axis_y * axis_y + axis_z * axis_z)

        {axis_x, axis_y, axis_z} =
          if length != 0 do
            ilength = 1.0 / length
            {axis_x * ilength, axis_y * ilength, axis_z * ilength}
          else
            {0.0, 0.0, 0.0}
          end

        angle = angle / 2.0
        a = :math.sin(angle)
        b = axis_x * a
        c = axis_y * a
        d = axis_z * a
        a = :math.cos(angle)
        {w_x, w_y, w_z} = {b, c, d}

        # vector3_cross_product(w, v)
        wv_x = w_y * v_z - w_z * v_y
        wv_y = w_z * v_x - w_x * v_z
        wv_z = w_x * v_y - w_y * v_x

        # vector3_cross_product(w, wv)
        wwv_x = w_y * wv_z - w_z * wv_y
        wwv_y = w_z * wv_x - w_x * wv_z
        wwv_z = w_x * wv_y - w_y * wv_x

        # vector3_scale(wv, 2*a)
        a = a * 2
        wv_x = wv_x * a
        wv_y = wv_y * a
        wv_z = wv_z * a

        # vector3_scale(wwv, 2)
        wwv_x = wwv_x * 2
        wwv_y = wwv_y * 2
        wwv_z = wwv_z * 2

        type_vector3(
          x: v_x + wv_x + wwv_x,
          y: v_y + wv_y + wwv_y,
          z: v_z + wv_z + wwv_z
        )
      end

      @doc """
      Move Vector towards target
      """
      @doc group: :vector3
      @spec vector3_move_towards(
              v :: Zexray.Type.Vector3.t(),
              target :: Zexray.Type.Vector3.t(),
              max_distance :: number
            ) :: Zexray.Type.Vector3.t()
      def vector3_move_towards(v, target, max_distance) do
        type_vector3(x: v_x, y: v_y, z: v_z) = v
        type_vector3(x: target_x, y: target_y, z: target_z) = target

        dx = target_x - v_x
        dy = target_y - v_y
        dz = target_z - v_z
        value = dx * dx + dy * dy + dz * dz

        if value == 0 or (max_distance >= 0 and value <= max_distance * max_distance) do
          target
        else
          dist = :math.sqrt(value)

          type_vector3(
            x: v_x + dx / dist * max_distance,
            y: v_y + dy / dist * max_distance,
            z: v_z + dz / dist * max_distance
          )
        end
      end

      @doc """
      Calculate linear interpolation between two vectors
      """
      @doc group: :vector3
      @spec vector3_lerp(
              v1 :: Zexray.Type.Vector3.t(),
              v2 :: Zexray.Type.Vector3.t(),
              amount :: number
            ) :: Zexray.Type.Vector3.t()
      def vector3_lerp(v1, v2, amount) do
        type_vector3(x: v1_x, y: v1_y, z: v1_z) = v1
        type_vector3(x: v2_x, y: v2_y, z: v2_z) = v2

        type_vector3(
          x: v1_x + amount * (v2_x - v1_x),
          y: v1_y + amount * (v2_y - v1_y),
          z: v1_z + amount * (v2_z - v1_z)
        )
      end

      @doc """
      Calculate cubic hermite interpolation between two vectors and their tangents
      as described in the GLTF 2.0 specification: https://registry.khronos.org/glTF/specs/2.0/glTF-2.0.html#interpolation-cubic
      """
      @doc group: :vector3
      @spec vector3_cubic_hermite(
              v1 :: Zexray.Type.Vector3.t(),
              tangent1 :: Zexray.Type.Vector3.t(),
              v2 :: Zexray.Type.Vector3.t(),
              tangent2 :: Zexray.Type.Vector3.t(),
              amount :: number
            ) :: Zexray.Type.Vector3.t()
      def vector3_cubic_hermite(v1, tangent1, v2, tangent2, amount) do
        type_vector3(x: v1_x, y: v1_y, z: v1_z) = v1
        type_vector3(x: tangent1_x, y: tangent1_y, z: tangent1_z) = tangent1
        type_vector3(x: v2_x, y: v2_y, z: v2_z) = v2
        type_vector3(x: tangent2_x, y: tangent2_y, z: tangent2_z) = tangent2

        amount_pow2 = amount * amount
        amount_pow3 = amount * amount * amount

        type_vector3(
          x:
            (2 * amount_pow3 - 3 * amount_pow2 + 1) * v1_x +
              (amount_pow3 - 2 * amount_pow2 + amount) * tangent1_x +
              (-2 * amount_pow3 + 3 * amount_pow2) * v2_x +
              (amount_pow3 - amount_pow2) * tangent2_x,
          y:
            (2 * amount_pow3 - 3 * amount_pow2 + 1) * v1_y +
              (amount_pow3 - 2 * amount_pow2 + amount) * tangent1_y +
              (-2 * amount_pow3 + 3 * amount_pow2) * v2_y +
              (amount_pow3 - amount_pow2) * tangent2_y,
          z:
            (2 * amount_pow3 - 3 * amount_pow2 + 1) * v1_z +
              (amount_pow3 - 2 * amount_pow2 + amount) * tangent1_z +
              (-2 * amount_pow3 + 3 * amount_pow2) * v2_z +
              (amount_pow3 - amount_pow2) * tangent2_z
        )
      end

      @doc """
      Calculate reflected vector to normal
      """
      @doc group: :vector3
      @spec vector3_reflect(
              v :: Zexray.Type.Vector3.t(),
              normal :: Zexray.Type.Vector3.t()
            ) :: Zexray.Type.Vector3.t()
      def vector3_reflect(v, normal) do
        type_vector3(x: v_x, y: v_y, z: v_z) = v
        type_vector3(x: normal_x, y: normal_y, z: normal_z) = normal

        # I is the original vector
        # N is the normal of the incident plane
        # R = I - (2*N*(DotProduct[I, N]))

        dot_product = v_x * normal_x + v_y * normal_y + v_z * normal_z

        type_vector3(
          x: v_x - 2.0 * normal_x * dot_product,
          y: v_y - 2.0 * normal_y * dot_product,
          z: v_z - 2.0 * normal_z * dot_product
        )
      end

      @doc """
      Get min value for each pair of components
      """
      @doc group: :vector3
      @spec vector3_min(
              v1 :: Zexray.Type.Vector3.t(),
              v2 :: Zexray.Type.Vector3.t()
            ) :: Zexray.Type.Vector3.t()
      def vector3_min(v1, v2) do
        type_vector3(x: v1_x, y: v1_y, z: v1_z) = v1
        type_vector3(x: v2_x, y: v2_y, z: v2_z) = v2

        type_vector3(
          x: min(v1_x, v2_x),
          y: min(v1_y, v2_y),
          z: min(v1_z, v2_z)
        )
      end

      @doc """
      Get max value for each pair of components
      """
      @doc group: :vector3
      @spec vector3_max(
              v1 :: Zexray.Type.Vector3.t(),
              v2 :: Zexray.Type.Vector3.t()
            ) :: Zexray.Type.Vector3.t()
      def vector3_max(v1, v2) do
        type_vector3(x: v1_x, y: v1_y, z: v1_z) = v1
        type_vector3(x: v2_x, y: v2_y, z: v2_z) = v2

        type_vector3(
          x: max(v1_x, v2_x),
          y: max(v1_y, v2_y),
          z: max(v1_z, v2_z)
        )
      end

      @doc """
      Compute barycenter coordinates (u, v, w) for point p with respect to triangle (a, b, c)

      NOTE: Assumes P is on the plane of the triangle
      """
      @doc group: :vector3
      @spec vector3_barycenter(
              p :: Zexray.Type.Vector3.t(),
              a :: Zexray.Type.Vector3.t(),
              b :: Zexray.Type.Vector3.t(),
              c :: Zexray.Type.Vector3.t()
            ) :: Zexray.Type.Vector3.t()
      def vector3_barycenter(p, a, b, c) do
        type_vector3(x: p_x, y: p_y, z: p_z) = p
        type_vector3(x: a_x, y: a_y, z: a_z) = a
        type_vector3(x: b_x, y: b_y, z: b_z) = b
        type_vector3(x: c_x, y: c_y, z: c_z) = c

        # vector3_subtract(b, a)
        v0_x = b_x - a_x
        v0_y = b_y - a_y
        v0_z = b_z - a_z

        # vector3_subtract(c, a)
        v1_x = c_x - a_x
        v1_y = c_y - a_y
        v1_z = c_z - a_z

        # vector3_subtract(p, a)
        v2_x = p_x - a_x
        v2_y = p_y - a_y
        v2_z = p_z - a_z

        # vector3_dot_product(v0, v0)
        d00 = v0_x * v0_x + v0_y * v0_y + v0_z * v0_z

        # vector3_dot_product(v0, v1)
        d01 = v0_x * v1_x + v0_y * v1_y + v0_z * v1_z

        # vector3_dot_product(v1, v1)
        d11 = v1_x * v1_x + v1_y * v1_y + v1_z * v1_z

        # vector3_dot_product(v2, v0)
        d20 = v2_x * v0_x + v2_y * v0_y + v2_z * v0_z

        # vector3_dot_product(v2, v1)
        d21 = v2_x * v1_x + v2_y * v1_y + v2_z * v1_z

        denom = d00 * d11 - d01 * d01

        r_y = (d11 * d20 - d01 * d21) / denom
        r_z = (d00 * d21 - d01 * d20) / denom
        r_x = 1.0 - (r_z + r_y)

        type_vector3(
          x: r_x,
          y: r_y,
          z: r_z
        )
      end

      @doc """
      Projects a Vector3 from screen space into object space

      NOTE: We are avoiding calling other raymath functions despite available
      """
      @doc group: :vector3
      @spec vector3_unproject(
              source :: Zexray.Type.Vector3.t(),
              projection :: Zexray.Type.Matrix.t(),
              view :: Zexray.Type.Matrix.t()
            ) :: Zexray.Type.Vector3.t()
      def vector3_unproject(source, projection, view) do
        type_vector3(x: source_x, y: source_y, z: source_z) = source

        type_matrix(
          m0: projection_m0,
          m1: projection_m1,
          m2: projection_m2,
          m3: projection_m3,
          m4: projection_m4,
          m5: projection_m5,
          m6: projection_m6,
          m7: projection_m7,
          m8: projection_m8,
          m9: projection_m9,
          m10: projection_m10,
          m11: projection_m11,
          m12: projection_m12,
          m13: projection_m13,
          m14: projection_m14,
          m15: projection_m15
        ) = projection

        type_matrix(
          m0: view_m0,
          m1: view_m1,
          m2: view_m2,
          m3: view_m3,
          m4: view_m4,
          m5: view_m5,
          m6: view_m6,
          m7: view_m7,
          m8: view_m8,
          m9: view_m9,
          m10: view_m10,
          m11: view_m11,
          m12: view_m12,
          m13: view_m13,
          m14: view_m14,
          m15: view_m15
        ) = view

        # Calculate unprojected matrix (multiply view matrix by projection matrix) and invert it
        # matrix_multiply(view, projection)
        mat_view_proj_m0 =
          view_m0 * projection_m0 +
            view_m1 * projection_m4 +
            view_m2 * projection_m8 +
            view_m3 * projection_m12

        mat_view_proj_m1 =
          view_m0 * projection_m1 +
            view_m1 * projection_m5 +
            view_m2 * projection_m9 +
            view_m3 * projection_m13

        mat_view_proj_m2 =
          view_m0 * projection_m2 +
            view_m1 * projection_m6 +
            view_m2 * projection_m10 +
            view_m3 * projection_m14

        mat_view_proj_m3 =
          view_m0 * projection_m3 +
            view_m1 * projection_m7 +
            view_m2 * projection_m11 +
            view_m3 * projection_m15

        mat_view_proj_m4 =
          view_m4 * projection_m0 +
            view_m5 * projection_m4 +
            view_m6 * projection_m8 +
            view_m7 * projection_m12

        mat_view_proj_m5 =
          view_m4 * projection_m1 +
            view_m5 * projection_m5 +
            view_m6 * projection_m9 +
            view_m7 * projection_m13

        mat_view_proj_m6 =
          view_m4 * projection_m2 +
            view_m5 * projection_m6 +
            view_m6 * projection_m10 +
            view_m7 * projection_m14

        mat_view_proj_m7 =
          view_m4 * projection_m3 +
            view_m5 * projection_m7 +
            view_m6 * projection_m11 +
            view_m7 * projection_m15

        mat_view_proj_m8 =
          view_m8 * projection_m0 +
            view_m9 * projection_m4 +
            view_m10 * projection_m8 +
            view_m11 * projection_m12

        mat_view_proj_m9 =
          view_m8 * projection_m1 +
            view_m9 * projection_m5 +
            view_m10 * projection_m9 +
            view_m11 * projection_m13

        mat_view_proj_m10 =
          view_m8 * projection_m2 +
            view_m9 * projection_m6 +
            view_m10 * projection_m10 +
            view_m11 * projection_m14

        mat_view_proj_m11 =
          view_m8 * projection_m3 +
            view_m9 * projection_m7 +
            view_m10 * projection_m11 +
            view_m11 * projection_m15

        mat_view_proj_m12 =
          view_m12 * projection_m0 +
            view_m13 * projection_m4 +
            view_m14 * projection_m8 +
            view_m15 * projection_m12

        mat_view_proj_m13 =
          view_m12 * projection_m1 +
            view_m13 * projection_m5 +
            view_m14 * projection_m9 +
            view_m15 * projection_m13

        mat_view_proj_m14 =
          view_m12 * projection_m2 +
            view_m13 * projection_m6 +
            view_m14 * projection_m10 +
            view_m15 * projection_m14

        mat_view_proj_m15 =
          view_m12 * projection_m3 +
            view_m13 * projection_m7 +
            view_m14 * projection_m11 +
            view_m15 * projection_m15

        # Calculate inverted matrix -> matrix_invert(mat_view_proj)
        # Cache the matrix values (speed optimization)
        a00 = mat_view_proj_m0
        a01 = mat_view_proj_m1
        a02 = mat_view_proj_m2
        a03 = mat_view_proj_m3
        a10 = mat_view_proj_m4
        a11 = mat_view_proj_m5
        a12 = mat_view_proj_m6
        a13 = mat_view_proj_m7
        a20 = mat_view_proj_m8
        a21 = mat_view_proj_m9
        a22 = mat_view_proj_m10
        a23 = mat_view_proj_m11
        a30 = mat_view_proj_m12
        a31 = mat_view_proj_m13
        a32 = mat_view_proj_m14
        a33 = mat_view_proj_m15

        b00 = a00 * a11 - a01 * a10
        b01 = a00 * a12 - a02 * a10
        b02 = a00 * a13 - a03 * a10
        b03 = a01 * a12 - a02 * a11
        b04 = a01 * a13 - a03 * a11
        b05 = a02 * a13 - a03 * a12
        b06 = a20 * a31 - a21 * a30
        b07 = a20 * a32 - a22 * a30
        b08 = a20 * a33 - a23 * a30
        b09 = a21 * a32 - a22 * a31
        b10 = a21 * a33 - a23 * a31
        b11 = a22 * a33 - a23 * a32

        # Calculate the invert determinant (inlined to avoid double-caching)
        inv_det = 1.0 / (b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 + b05 * b06)

        mat_view_proj_inv_m0 = (a11 * b11 - a12 * b10 + a13 * b09) * inv_det
        mat_view_proj_inv_m1 = (-a01 * b11 + a02 * b10 - a03 * b09) * inv_det
        mat_view_proj_inv_m2 = (a31 * b05 - a32 * b04 + a33 * b03) * inv_det
        mat_view_proj_inv_m3 = (-a21 * b05 + a22 * b04 - a23 * b03) * inv_det
        mat_view_proj_inv_m4 = (-a10 * b11 + a12 * b08 - a13 * b07) * inv_det
        mat_view_proj_inv_m5 = (a00 * b11 - a02 * b08 + a03 * b07) * inv_det
        mat_view_proj_inv_m6 = (-a30 * b05 + a32 * b02 - a33 * b01) * inv_det
        mat_view_proj_inv_m7 = (a20 * b05 - a22 * b02 + a23 * b01) * inv_det
        mat_view_proj_inv_m8 = (a10 * b10 - a11 * b08 + a13 * b06) * inv_det
        mat_view_proj_inv_m9 = (-a00 * b10 + a01 * b08 - a03 * b06) * inv_det
        mat_view_proj_inv_m10 = (a30 * b04 - a31 * b02 + a33 * b00) * inv_det
        mat_view_proj_inv_m11 = (-a20 * b04 + a21 * b02 - a23 * b00) * inv_det
        mat_view_proj_inv_m12 = (-a10 * b09 + a11 * b07 - a12 * b06) * inv_det
        mat_view_proj_inv_m13 = (a00 * b09 - a01 * b07 + a02 * b06) * inv_det
        mat_view_proj_inv_m14 = (-a30 * b03 + a31 * b01 - a32 * b00) * inv_det
        mat_view_proj_inv_m15 = (a20 * b03 - a21 * b01 + a22 * b00) * inv_det

        # Create quaternion from source point
        quat_x = source_x
        quat_y = source_y
        quat_z = source_z
        quat_w = 1_0

        # Multiply quat point by unprojecte matrix
        # quaternion_transform(quat, mat_view_proj_inv)
        qtransformed_x =
          mat_view_proj_inv_m0 * quat_x +
            mat_view_proj_inv_m4 * quat_y +
            mat_view_proj_inv_m8 * quat_z +
            mat_view_proj_inv_m12 * quat_w

        qtransformed_y =
          mat_view_proj_inv_m1 * quat_x +
            mat_view_proj_inv_m5 * quat_y +
            mat_view_proj_inv_m9 * quat_z +
            mat_view_proj_inv_m13 * quat_w

        qtransformed_z =
          mat_view_proj_inv_m2 * quat_x +
            mat_view_proj_inv_m6 * quat_y +
            mat_view_proj_inv_m10 * quat_z +
            mat_view_proj_inv_m14 * quat_w

        qtransformed_w =
          mat_view_proj_inv_m3 * quat_x +
            mat_view_proj_inv_m7 * quat_y +
            mat_view_proj_inv_m11 * quat_z +
            mat_view_proj_inv_m15 * quat_w

        # Normalized world points in vectors
        type_vector3(
          x: qtransformed_x / qtransformed_w,
          y: qtransformed_y / qtransformed_w,
          z: qtransformed_z / qtransformed_w
        )
      end

      @doc """
      Invert the given vector
      """
      @doc group: :vector3
      @spec vector3_invert(v :: Zexray.Type.Vector3.t()) :: Zexray.Type.Vector3.t()
      def vector3_invert(v) do
        type_vector3(x: v_x, y: v_y, z: v_z) = v

        type_vector3(
          x: 1.0 / v_x,
          y: 1.0 / v_y,
          z: 1.0 / v_z
        )
      end

      @doc """
      Clamp the components of the vector between
      min and max values specified by the given vectors
      """
      @doc group: :vector3
      @spec vector3_clamp(
              v :: Zexray.Type.Vector3.t(),
              min :: Zexray.Type.Vector3.t(),
              max :: Zexray.Type.Vector3.t()
            ) :: Zexray.Type.Vector3.t()
      def vector3_clamp(v, min, max) do
        type_vector3(x: v_x, y: v_y, z: v_z) = v
        type_vector3(x: min_x, y: min_y, z: min_z) = min
        type_vector3(x: max_x, y: max_y, z: max_z) = max

        type_vector3(
          x: min(max_x, max(min_x, v_x)),
          y: min(max_y, max(min_y, v_y)),
          z: min(max_z, max(min_z, v_z))
        )
      end

      @doc """
      Clamp the magnitude of the vector between two values
      """
      @doc group: :vector3
      @spec vector3_clamp_value(
              v :: Zexray.Type.Vector3.t(),
              min :: number,
              max :: number
            ) :: Zexray.Type.Vector3.t()
      def vector3_clamp_value(v, min, max) do
        type_vector3(x: v_x, y: v_y, z: v_z) = v

        length = v_x * v_x + v_y * v_y + v_z * v_z

        if length > 0.0 do
          length = :math.sqrt(length)

          scale =
            cond do
              length < min -> min / length
              length > max -> max / length
              # By default, 1 as the neutral element.
              true -> 1
            end

          type_vector3(
            x: v_x * scale,
            y: v_y * scale,
            z: v_z * scale
          )
        else
          v
        end
      end

      @doc """
      Check whether two given vectors are almost equal
      """
      @doc group: :vector3
      @spec vector3_equals?(
              p :: Zexray.Type.Vector3.t(),
              q :: Zexray.Type.Vector3.t()
            ) :: boolean
      def vector3_equals?(p, q) do
        type_vector3(x: p_x, y: p_y, z: p_z) = p
        type_vector3(x: q_x, y: q_y, z: q_z) = q

        abs(p_x - q_x) <= @epsilon * max(1.0, max(abs(p_x), abs(q_x))) and
          abs(p_y - q_y) <= @epsilon * max(1.0, max(abs(p_y), abs(q_y))) and
          abs(p_z - q_z) <= @epsilon * max(1.0, max(abs(p_z), abs(q_z)))
      end

      @doc """
      Compute the direction of a refracted ray

      v: normalized direction of the incoming ray

      n: normalized normal vector of the interface of two optical media

      r: ratio of the refractive index of the medium from where the ray comes
         to the refractive index of the medium on the other side of the surface
      """
      @doc group: :vector3
      @spec vector3_refract(
              v :: Zexray.Type.Vector3.t(),
              n :: Zexray.Type.Vector3.t(),
              r :: number
            ) :: Zexray.Type.Vector3.t()
      def vector3_refract(v, n, r) do
        type_vector3(x: v_x, y: v_y, z: v_z) = v
        type_vector3(x: n_x, y: n_y, z: n_z) = n

        dot = v_x * n_x + v_y * n_y + v_z * n_z

        d = 1.0 - r * r * (1.0 - dot * dot)

        if d >= 0.0 do
          d = :math.sqrt(d)

          type_vector3(
            x: r * v_x - (r * dot + d) * n_x,
            y: r * v_y - (r * dot + d) * n_y,
            z: r * v_z - (r * dot + d) * n_z
          )
        else
          type_vector3(
            x: 0.0,
            y: 0.0,
            z: 0.0
          )
        end
      end
    end
  end
end

# recompile
# import Zexray.Math
# v1 = {:vector3, 1.0, 2.0, 3.0}
# v2 = {:vector3, 3.0, 8.0, 5.0}
# mat = Zexray.TypeFixture.matrix_fixture()
# 
