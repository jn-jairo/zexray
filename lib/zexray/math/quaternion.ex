defmodule Zexray.Math.Quaternion do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      ################
      #  Quaternion  #
      ################

      @doc """
      Add two quaternions
      """
      @doc group: :quaternion
      @spec quaternion_add(
              q1 :: Zexray.Type.Quaternion.t(),
              q2 :: Zexray.Type.Quaternion.t()
            ) :: Zexray.Type.Quaternion.t()
      def quaternion_add(q1, q2) do
        type_quaternion(x: q1_x, y: q1_y, z: q1_z, w: q1_w) = q1
        type_quaternion(x: q2_x, y: q2_y, z: q2_z, w: q2_w) = q2

        type_quaternion(
          x: q1_x + q2_x,
          y: q1_y + q2_y,
          z: q1_z + q2_z,
          w: q1_w + q2_w
        )
      end

      @doc """
      Add quaternion and float value
      """
      @doc group: :quaternion
      @spec quaternion_add_value(
              q :: Zexray.Type.Quaternion.t(),
              add :: number
            ) :: Zexray.Type.Quaternion.t()
      def quaternion_add_value(q, add) do
        type_quaternion(x: q_x, y: q_y, z: q_z, w: q_w) = q

        type_quaternion(
          x: q_x + add,
          y: q_y + add,
          z: q_z + add,
          w: q_z + add
        )
      end

      @doc """
      Subtract two quaternions
      """
      @doc group: :quaternion
      @spec quaternion_subtract(
              q1 :: Zexray.Type.Quaternion.t(),
              q2 :: Zexray.Type.Quaternion.t()
            ) :: Zexray.Type.Quaternion.t()
      def quaternion_subtract(q1, q2) do
        type_quaternion(x: q1_x, y: q1_y, z: q1_z, w: q1_w) = q1
        type_quaternion(x: q2_x, y: q2_y, z: q2_z, w: q2_w) = q2

        type_quaternion(
          x: q1_x - q2_x,
          y: q1_y - q2_y,
          z: q1_z - q2_z,
          w: q1_w - q2_w
        )
      end

      @doc """
      Subtract quaternion and float value
      """
      @doc group: :quaternion
      @spec quaternion_subtract_value(
              q :: Zexray.Type.Quaternion.t(),
              sub :: number
            ) :: Zexray.Type.Quaternion.t()
      def quaternion_subtract_value(q, sub) do
        type_quaternion(x: q_x, y: q_y, z: q_z, w: q_w) = q

        type_quaternion(
          x: q_x - sub,
          y: q_y - sub,
          z: q_z - sub,
          w: q_w - sub
        )
      end

      @doc """
      Get identity quaternion
      """
      @doc group: :quaternion
      @spec quaternion_identity :: Zexray.Type.Quaternion.t()
      def quaternion_identity do
        type_quaternion(
          x: 0.0,
          y: 0.0,
          z: 0.0,
          w: 1.0
        )
      end

      @doc """
      Computes the length of a quaternion
      """
      @doc group: :quaternion
      @spec quaternion_length(q :: Zexray.Type.Quaternion.t()) :: number
      def quaternion_length(q) do
        type_quaternion(x: q_x, y: q_y, z: q_z, w: q_w) = q
        :math.sqrt(q_x * q_x + q_y * q_y + q_z * q_z + q_w * q_w)
      end

      @doc """
      Normalize provided quaternion
      """
      @doc group: :quaternion
      @spec quaternion_normalize(q :: Zexray.Type.Quaternion.t()) :: Zexray.Type.Quaternion.t()
      def quaternion_normalize(q) do
        type_quaternion(x: q_x, y: q_y, z: q_z, w: q_w) = q

        length = :math.sqrt(q_x * q_x + q_y * q_y + q_z * q_z + q_w * q_w)

        if length != 0 do
          ilength = 1.0 / length

          type_quaternion(
            x: q_x * ilength,
            y: q_y * ilength,
            z: q_z * ilength,
            w: q_w * ilength
          )
        else
          type_quaternion(
            x: 0.0,
            y: 0.0,
            z: 0.0,
            w: 0.0
          )
        end
      end

      @doc """
      Invert provided quaternion
      """
      @doc group: :quaternion
      @spec quaternion_invert(q :: Zexray.Type.Quaternion.t()) :: Zexray.Type.Quaternion.t()
      def quaternion_invert(q) do
        type_quaternion(x: q_x, y: q_y, z: q_z, w: q_w) = q

        length = q_x * q_x + q_y * q_y + q_z * q_z + q_w * q_w

        if length != 0 do
          ilength = 1.0 / length

          type_quaternion(
            x: q_x * ilength * -1,
            y: q_y * ilength * -1,
            z: q_z * ilength * -1,
            w: q_w * ilength
          )
        else
          type_quaternion(
            x: 0.0,
            y: 0.0,
            z: 0.0,
            w: 0.0
          )
        end
      end

      @doc """
      Calculate two quaternion multiplication
      """
      @doc group: :quaternion
      @spec quaternion_multiply(
              q1 :: Zexray.Type.Quaternion.t(),
              q2 :: Zexray.Type.Quaternion.t()
            ) :: Zexray.Type.Quaternion.t()
      def quaternion_multiply(q1, q2) do
        type_quaternion(x: q1_x, y: q1_y, z: q1_z, w: q1_w) = q1
        type_quaternion(x: q2_x, y: q2_y, z: q2_z, w: q2_w) = q2

        type_quaternion(
          x: q1_x * q2_w + q1_w * q2_x + q1_y * q2_z - q1_z * q2_y,
          y: q1_y * q2_w + q1_w * q2_y + q1_z * q2_x - q1_x * q2_z,
          z: q1_z * q2_w + q1_w * q2_z + q1_x * q2_y - q1_y * q2_x,
          w: q1_w * q2_w - q1_x * q2_x - q1_y * q2_y - q1_z * q2_z
        )
      end

      @doc """
      Scale quaternion by float value
      """
      @doc group: :quaternion
      @spec quaternion_scale(
              q :: Zexray.Type.Quaternion.t(),
              mul :: number
            ) :: Zexray.Type.Quaternion.t()
      def quaternion_scale(q, mul) do
        type_quaternion(x: q_x, y: q_y, z: q_z, w: q_w) = q

        type_quaternion(
          x: q_x * mul,
          y: q_y * mul,
          z: q_z * mul,
          w: q_w * mul
        )
      end

      @doc """
      Divide two quaternions
      """
      @doc group: :quaternion
      @spec quaternion_divide(
              q1 :: Zexray.Type.Quaternion.t(),
              q2 :: Zexray.Type.Quaternion.t()
            ) :: Zexray.Type.Quaternion.t()
      def quaternion_divide(q1, q2) do
        type_quaternion(x: q1_x, y: q1_y, z: q1_z, w: q1_w) = q1
        type_quaternion(x: q2_x, y: q2_y, z: q2_z, w: q2_w) = q2

        type_quaternion(
          x: q1_x / q2_x,
          y: q1_y / q2_y,
          z: q1_z / q2_z,
          w: q1_w / q2_w
        )
      end

      @doc """
      Calculate linear interpolation between two quaternions
      """
      @doc group: :quaternion
      @spec quaternion_lerp(
              q1 :: Zexray.Type.Quaternion.t(),
              q2 :: Zexray.Type.Quaternion.t(),
              amount :: number
            ) :: Zexray.Type.Quaternion.t()
      def quaternion_lerp(q1, q2, amount) do
        type_quaternion(x: q1_x, y: q1_y, z: q1_z, w: q1_w) = q1
        type_quaternion(x: q2_x, y: q2_y, z: q2_z, w: q2_w) = q2

        type_quaternion(
          x: q1_x + amount * (q2_x - q1_x),
          y: q1_y + amount * (q2_y - q1_y),
          z: q1_z + amount * (q2_z - q1_z),
          w: q1_w + amount * (q2_w - q1_w)
        )
      end

      @doc """
      Calculate slerp-optimized interpolation between two quaternions
      """
      @doc group: :quaternion
      @spec quaternion_nlerp(
              q1 :: Zexray.Type.Quaternion.t(),
              q2 :: Zexray.Type.Quaternion.t(),
              amount :: number
            ) :: Zexray.Type.Quaternion.t()
      def quaternion_nlerp(q1, q2, amount) do
        type_quaternion(x: q1_x, y: q1_y, z: q1_z, w: q1_w) = q1
        type_quaternion(x: q2_x, y: q2_y, z: q2_z, w: q2_w) = q2

        # quaternion_lerp(q1, q2, amount)
        q_x = q1_x + amount * (q2_x - q1_x)
        q_y = q1_y + amount * (q2_y - q1_y)
        q_z = q1_z + amount * (q2_z - q1_z)
        q_w = q1_w + amount * (q2_w - q1_w)

        # quaternion_normalize(q)
        length = :math.sqrt(q_x * q_x + q_y * q_y + q_z * q_z + q_w * q_w)

        if length != 0 do
          ilength = 1.0 / length

          type_quaternion(
            x: q_x * ilength,
            y: q_y * ilength,
            z: q_z * ilength,
            w: q_w * ilength
          )
        else
          type_quaternion(
            x: 0.0,
            y: 0.0,
            z: 0.0,
            w: 0.0
          )
        end
      end

      @doc """
      Calculates spherical linear interpolation between two quaternions
      """
      @doc group: :quaternion
      @spec quaternion_slerp(
              q1 :: Zexray.Type.Quaternion.t(),
              q2 :: Zexray.Type.Quaternion.t(),
              amount :: number
            ) :: Zexray.Type.Quaternion.t()
      def quaternion_slerp(q1, q2, amount) do
        type_quaternion(x: q1_x, y: q1_y, z: q1_z, w: q1_w) = q1
        type_quaternion(x: q2_x, y: q2_y, z: q2_z, w: q2_w) = q2

        cos_half_theta = q1_x * q2_x + q1_y * q2_y + q1_z * q2_z + q1_w * q2_w

        {q2_x, q2_y, q2_z, q2_w, cos_half_theta} =
          if cos_half_theta < 0 do
            {
              q2_x * -1,
              q2_y * -1,
              q2_z * -1,
              q2_w * -1,
              cos_half_theta * -1
            }
          else
            {
              q2_x,
              q2_y,
              q2_z,
              q2_w,
              cos_half_theta
            }
          end

        cond do
          abs(cos_half_theta) >= 1.0 ->
            q1

          cos_half_theta > 0.95 ->
            quaternion_nlerp(q1, q2, amount)

          true ->
            half_theta = :math.acos(cos_half_theta)
            sin_half_theta = :math.sqrt(1.0 - cos_half_theta * cos_half_theta)

            if abs(sin_half_theta) < @epsilon do
              type_quaternion(
                x: q1_x * 0.5 + q2_x * 0.5,
                y: q1_y * 0.5 + q2_y * 0.5,
                z: q1_z * 0.5 + q2_z * 0.5,
                w: q1_w * 0.5 + q2_w * 0.5
              )
            else
              ratio_a = :math.sin((1 - amount) * half_theta) / sin_half_theta
              ratio_b = :math.sin(amount * half_theta) / sin_half_theta

              type_quaternion(
                x: q1_x * ratio_a + q2_x * ratio_b,
                y: q1_y * ratio_a + q2_y * ratio_b,
                z: q1_z * ratio_a + q2_z * ratio_b,
                w: q1_w * ratio_a + q2_w * ratio_b
              )
            end
        end
      end

      @doc """
      Calculate quaternion cubic spline interpolation using Cubic Hermite Spline algorithm
      as described in the GLTF 2.0 specification: https://registry.khronos.org/glTF/specs/2.0/glTF-2.0.html#interpolation-cubic
      """
      @doc group: :quaternion
      @spec quaternion_cubic_hermite_spline(
              q1 :: Zexray.Type.Quaternion.t(),
              tangent1 :: Zexray.Type.Quaternion.t(),
              q2 :: Zexray.Type.Quaternion.t(),
              tangent2 :: Zexray.Type.Quaternion.t(),
              t :: number
            ) :: Zexray.Type.Quaternion.t()
      def quaternion_cubic_hermite_spline(q1, tangent1, q2, tangent2, t) do
        t2 = t * t
        t3 = t2 * t
        h00 = 2 * t3 - 3 * t2 + 1
        h10 = t3 - 2 * t2 + t
        h01 = -2 * t3 + 3 * t2
        h11 = t3 - t2

        p0 = quaternion_scale(q1, h00)
        m0 = quaternion_scale(tangent1, h10)
        p1 = quaternion_scale(q2, h01)
        m1 = quaternion_scale(tangent2, h11)

        p0
        |> quaternion_add(m0)
        |> quaternion_add(p1)
        |> quaternion_add(m1)
        |> quaternion_normalize()
      end

      @doc """
      Calculate quaternion based on the rotation from one vector to another
      """
      @doc group: :quaternion
      @spec quaternion_from_vector3_to_vector3(
              from :: Zexray.Type.Vector3.t(),
              to :: Zexray.Type.Vector3.t()
            ) :: Zexray.Type.Quaternion.t()
      def quaternion_from_vector3_to_vector3(from, to) do
        type_vector3(x: from_x, y: from_y, z: from_z) = from
        type_vector3(x: to_x, y: to_y, z: to_z) = to

        # vector3_dot_product(from, to)
        cos2_theta = from_x * to_x + from_y * to_y + from_z * to_z

        # vector3_cross_product(from, to)
        q_x = from_y * to_z - from_z * to_y
        q_y = from_z * to_x - from_x * to_z
        q_z = from_x * to_y - from_y * to_x
        q_w = 1.0 + cos2_theta

        # quaternion_normalize(q)
        # NOTE: Normalize to essentially nlerp the original and identity to 0.5
        length = :math.sqrt(q_x * q_x + q_y * q_y + q_z * q_z + q_w * q_w)

        if length != 0 do
          ilength = 1.0 / length

          type_quaternion(
            x: q_x * ilength,
            y: q_y * ilength,
            z: q_z * ilength,
            w: q_w * ilength
          )
        else
          type_quaternion(
            x: 0.0,
            y: 0.0,
            z: 0.0,
            w: 0.0
          )
        end
      end

      @doc """
      Get a quaternion for a given rotation matrix
      """
      @doc group: :quaternion
      @spec quaternion_from_matrix(mat :: Zexray.Type.Matrix.t()) :: Zexray.Type.Quaternion.t()
      def quaternion_from_matrix(mat) do
        type_matrix(
          m0: mat_m0,
          m1: mat_m1,
          m2: mat_m2,
          m4: mat_m4,
          m5: mat_m5,
          m6: mat_m6,
          m8: mat_m8,
          m9: mat_m9,
          m10: mat_m10
        ) = mat

        four_w_squared_minus1 = mat_m0 + mat_m5 + mat_m10
        four_x_squared_minus1 = mat_m0 - mat_m5 - mat_m10
        four_y_squared_minus1 = mat_m5 - mat_m0 - mat_m10
        four_z_squared_minus1 = mat_m10 - mat_m0 - mat_m5

        biggest_index = 0
        four_biggest_squared_minus1 = four_w_squared_minus1

        {biggest_index, four_biggest_squared_minus1} =
          if four_x_squared_minus1 > four_biggest_squared_minus1 do
            {1, four_x_squared_minus1}
          else
            {biggest_index, four_biggest_squared_minus1}
          end

        {biggest_index, four_biggest_squared_minus1} =
          if four_y_squared_minus1 > four_biggest_squared_minus1 do
            {2, four_y_squared_minus1}
          else
            {biggest_index, four_biggest_squared_minus1}
          end

        {biggest_index, four_biggest_squared_minus1} =
          if four_z_squared_minus1 > four_biggest_squared_minus1 do
            {3, four_z_squared_minus1}
          else
            {biggest_index, four_biggest_squared_minus1}
          end

        biggest_val = :math.sqrt(four_biggest_squared_minus1 + 1.0) * 0.5
        mult = 0.25 / biggest_val

        case biggest_index do
          0 ->
            type_quaternion(
              w: biggest_val,
              x: (mat_m6 - mat_m9) * mult,
              y: (mat_m8 - mat_m2) * mult,
              z: (mat_m1 - mat_m4) * mult
            )

          1 ->
            type_quaternion(
              x: biggest_val,
              w: (mat_m6 - mat_m9) * mult,
              y: (mat_m1 + mat_m4) * mult,
              z: (mat_m8 + mat_m2) * mult
            )

          2 ->
            type_quaternion(
              y: biggest_val,
              w: (mat_m8 - mat_m2) * mult,
              x: (mat_m1 + mat_m4) * mult,
              z: (mat_m6 + mat_m9) * mult
            )

          3 ->
            type_quaternion(
              z: biggest_val,
              w: (mat_m1 - mat_m4) * mult,
              x: (mat_m8 + mat_m2) * mult,
              y: (mat_m6 + mat_m9) * mult
            )
        end
      end

      @doc """
      Get a matrix for a given quaternion
      """
      @doc group: :quaternion
      @spec quaternion_to_matrix(q :: Zexray.Type.Quaternion.t()) :: Zexray.Type.Matrix.t()
      def quaternion_to_matrix(q) do
        type_quaternion(x: q_x, y: q_y, z: q_z, w: q_w) = q

        a2 = q_x * q_x
        b2 = q_y * q_y
        c2 = q_z * q_z
        ac = q_x * q_z
        ab = q_x * q_y
        bc = q_y * q_z
        ad = q_w * q_x
        bd = q_w * q_y
        cd = q_w * q_z

        type_matrix(
          m0: 1 - 2 * (b2 + c2),
          m1: 2 * (ab + cd),
          m2: 2 * (ac - bd),
          m3: 0.0,
          m4: 2 * (ab - cd),
          m5: 1 - 2 * (a2 + c2),
          m6: 2 * (bc + ad),
          m7: 0.0,
          m8: 2 * (ac + bd),
          m9: 2 * (bc - ad),
          m10: 1 - 2 * (a2 + b2),
          m11: 0.0,
          m12: 0.0,
          m13: 0.0,
          m14: 0.0,
          m15: 1.0
        )
      end

      @doc """
      Get rotation quaternion for an angle and axis

      NOTE: Angle must be provided in radians
      """
      @doc group: :quaternion
      @spec quaternion_from_axis_angle(
              axis :: Zexray.Type.Vector3.t(),
              angle :: number
            ) :: Zexray.Type.Quaternion.t()
      def quaternion_from_axis_angle(axis, angle) do
        type_vector3(x: axis_x, y: axis_y, z: axis_z) = axis

        length = :math.sqrt(axis_x * axis_x + axis_y * axis_y + axis_z * axis_z)

        if length != 0 do
          # vector3_normalize(axis)
          ilength = 1.0 / length

          axis_x = axis_x * ilength
          axis_y = axis_y * ilength
          axis_z = axis_z * ilength

          sinres = :math.sin(angle)
          cosres = :math.cos(angle)

          q_x = axis_x * sinres
          q_y = axis_y * sinres
          q_z = axis_z * sinres
          q_w = cosres

          # quaternion_normalize(q)
          length = :math.sqrt(q_x * q_x + q_y * q_y + q_z * q_z + q_w * q_w)

          if length != 0 do
            ilength = 1.0 / length

            type_quaternion(
              x: q_x * ilength,
              y: q_y * ilength,
              z: q_z * ilength,
              w: q_w * ilength
            )
          else
            type_quaternion(
              x: 0.0,
              y: 0.0,
              z: 0.0,
              w: 0.0
            )
          end
        else
          type_quaternion(
            x: 0.0,
            y: 0.0,
            z: 0.0,
            w: 1.0
          )
        end
      end

      @doc """
      Get the rotation angle and axis for a given quaternion
      """
      @doc group: :quaternion
      @spec quaternion_to_axis_angle(q :: Zexray.Type.Quaternion.t()) ::
              {axis :: Zexray.Type.Vector3.t(), angle :: number}
      def quaternion_to_axis_angle(q) do
        type_quaternion(x: q_x, y: q_y, z: q_z, w: q_w) = q

        {q_x, q_y, q_z, q_w} =
          if abs(q_w) > 1.0 do
            # quaternion_normalize(q)
            length = :math.sqrt(q_x * q_x + q_y * q_y + q_z * q_z + q_w * q_w)

            if length != 0 do
              ilength = 1.0 / length

              {
                q_x * ilength,
                q_y * ilength,
                q_z * ilength,
                q_w * ilength
              }
            else
              {0.0, 0.0, 0.0, 0.0}
            end
          else
            {q_x, q_y, q_z, q_w}
          end

        angle = 2.0 * :math.cos(q_w)
        den = :math.sqrt(1.0 - q_w * q_w)

        if den > @epsilon do
          {
            type_vector3(
              x: q_x / den,
              y: q_y / den,
              z: q_z / den
            ),
            angle
          }
        else
          # This occurs when the angle is zero.
          # Not a problem: just set an arbitrary normalized axis.
          {
            type_vector3(
              x: 1.0,
              y: 0.0,
              z: 0.0
            ),
            angle
          }
        end
      end

      @doc """
      Get the quaternion equivalent to Euler angles

      NOTE: Rotation order is ZYX
      """
      @doc group: :quaternion
      @spec quaternion_from_euler(
              pitch :: number,
              yaw :: number,
              roll :: number
            ) :: Zexray.Type.Quaternion.t()
      def quaternion_from_euler(pitch, yaw, roll) do
        x0 = :math.cos(pitch * 0.5)
        x1 = :math.sin(pitch * 0.5)
        y0 = :math.cos(yaw * 0.5)
        y1 = :math.sin(yaw * 0.5)
        z0 = :math.cos(roll * 0.5)
        z1 = :math.sin(roll * 0.5)

        type_quaternion(
          x: x1 * y0 * z0 - x0 * y1 * z1,
          y: x0 * y1 * z0 + x1 * y0 * z1,
          z: x0 * y0 * z1 - x1 * y1 * z0,
          w: x0 * y0 * z0 + x1 * y1 * z1
        )
      end

      @doc """
      Get the Euler angles equivalent to quaternion (roll, pitch, yaw)

      NOTE: Angles are returned in a Vector3 struct in radians
      """
      @doc group: :quaternion
      @spec quaternion_to_euler(q :: Zexray.Type.Quaternion.t()) :: Zexray.Type.Vector3.t()
      def quaternion_to_euler(q) do
        type_quaternion(x: q_x, y: q_y, z: q_z, w: q_w) = q

        # Roll (x-axis rotation)
        x0 = 2.0 * (q_w * q_x + q_y * q_z)
        x1 = 1.0 - 2.0 * (q_x * q_x + q_y * q_y)

        # Pitch (y-axis rotation)
        y0 = 2.0 * (q_w * q_y - q_z * q_x)
        y0 = if y0 > 1.0, do: 1.0, else: y0
        y0 = if y0 < -1.0, do: -1.0, else: y0

        # Yaw (z-axis rotation)
        z0 = 2.0 * (q_w * q_z + q_x * q_y)
        z1 = 1.0 - 2.0 * (q_y * q_y + q_z * q_z)

        type_vector3(
          x: :math.atan2(x0, x1),
          y: :math.asin(y0),
          z: :math.atan2(z0, z1)
        )
      end

      @doc """
      Transform a quaternion given a transformation matrix
      """
      @doc group: :quaternion
      @spec quaternion_transform(
              q :: Zexray.Type.Quaternion.t(),
              mat :: Zexray.Type.Matrix.t()
            ) :: Zexray.Type.Quaternion.t()
      def quaternion_transform(q, mat) do
        type_quaternion(x: q_x, y: q_y, z: q_z, w: q_w) = q

        type_matrix(
          m0: mat_m0,
          m1: mat_m1,
          m2: mat_m2,
          m3: mat_m3,
          m4: mat_m4,
          m5: mat_m5,
          m6: mat_m6,
          m7: mat_m7,
          m8: mat_m8,
          m9: mat_m9,
          m10: mat_m10,
          m11: mat_m11,
          m12: mat_m12,
          m13: mat_m13,
          m14: mat_m14,
          m15: mat_m15
        ) = mat

        type_quaternion(
          x: mat_m0 * q_x + mat_m4 * q_y + mat_m8 * q_z + mat_m12 * q_w,
          y: mat_m1 * q_x + mat_m5 * q_y + mat_m9 * q_z + mat_m13 * q_w,
          z: mat_m2 * q_x + mat_m6 * q_y + mat_m10 * q_z + mat_m14 * q_w,
          w: mat_m3 * q_x + mat_m7 * q_y + mat_m11 * q_z + mat_m15 * q_w
        )
      end

      @doc """
      Check whether two given quaternions are almost equal
      """
      @doc group: :quaternion
      @spec quaternion_equals?(
              p :: Zexray.Type.Quaternion.t(),
              q :: Zexray.Type.Quaternion.t()
            ) :: boolean
      def quaternion_equals?(p, q) do
        type_quaternion(x: p_x, y: p_y, z: p_z, w: p_w) = p
        type_quaternion(x: q_x, y: q_y, z: q_z, w: q_w) = q

        (abs(p_x - q_x) <= @epsilon * max(1.0, max(abs(p_x), abs(q_x))) and
           abs(p_y - q_y) <= @epsilon * max(1.0, max(abs(p_y), abs(q_y))) and
           abs(p_z - q_z) <= @epsilon * max(1.0, max(abs(p_z), abs(q_z))) and
           abs(p_w - q_w) <= @epsilon * max(1.0, max(abs(p_w), abs(q_w)))) or
          (abs(p_x + q_x) <= @epsilon * max(1.0, max(abs(p_x), abs(q_x))) and
             abs(p_y + q_y) <= @epsilon * max(1.0, max(abs(p_y), abs(q_y))) and
             abs(p_z + q_z) <= @epsilon * max(1.0, max(abs(p_z), abs(q_z))) and
             abs(p_w + q_w) <= @epsilon * max(1.0, max(abs(p_w), abs(q_w))))
      end
    end
  end
end
