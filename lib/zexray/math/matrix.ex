defmodule Zexray.Math.Matrix do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      ############
      #  Matrix  #
      ############

      @doc """
      Compute matrix determinant
      """
      @doc group: :matrix
      @spec matrix_determinant(mat :: Zexray.Type.Matrix.t()) :: number
      def matrix_determinant(mat) do
        type_matrix(
          m0: m0,
          m1: m1,
          m2: m2,
          m3: m3,
          m4: m4,
          m5: m5,
          m6: m6,
          m7: m7,
          m8: m8,
          m9: m9,
          m10: m10,
          m11: m11,
          m12: m12,
          m13: m13,
          m14: m14,
          m15: m15
        ) = mat

        # Using Laplace expansion (https://en.wikipedia.org/wiki/Laplace_expansion),
        # previous operation can be simplified to 40 multiplications, decreasing matrix 
        # size from 4x4 to 2x2 using minors

        m0 *
          (m5 * (m10 * m15 - m11 * m14) -
             m9 * (m6 * m15 - m7 * m14) +
             m13 * (m6 * m11 - m7 * m10)) -
          m4 *
            (m1 * (m10 * m15 - m11 * m14) -
               m9 * (m2 * m15 - m3 * m14) +
               m13 * (m2 * m11 - m3 * m10)) +
          m8 *
            (m1 * (m6 * m15 - m7 * m14) -
               m5 * (m2 * m15 - m3 * m14) +
               m13 * (m2 * m7 - m3 * m6)) -
          m12 *
            (m1 * (m6 * m11 - m7 * m10) -
               m5 * (m2 * m11 - m3 * m10) +
               m9 * (m2 * m7 - m3 * m6))
      end

      @doc """
      Get the trace of the matrix (sum of the values along the diagonal)
      """
      @doc group: :matrix
      @spec matrix_trace(mat :: Zexray.Type.Matrix.t()) :: number
      def matrix_trace(mat) do
        type_matrix(
          m0: mat_m0,
          m5: mat_m5,
          m10: mat_m10,
          m15: mat_m15
        ) = mat

        mat_m0 + mat_m5 + mat_m10 + mat_m15
      end

      @doc """
      Transposes provided matrix
      """
      @doc group: :matrix
      @spec matrix_transpose(mat :: Zexray.Type.Matrix.t()) :: Zexray.Type.Matrix.t()
      def matrix_transpose(mat) do
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

        type_matrix(
          m0: mat_m0,
          m1: mat_m4,
          m2: mat_m8,
          m3: mat_m12,
          m4: mat_m1,
          m5: mat_m5,
          m6: mat_m9,
          m7: mat_m13,
          m8: mat_m2,
          m9: mat_m6,
          m10: mat_m10,
          m11: mat_m14,
          m12: mat_m3,
          m13: mat_m7,
          m14: mat_m11,
          m15: mat_m15
        )
      end

      @doc """
      Invert provided matrix
      """
      @doc group: :matrix
      @spec matrix_invert(mat :: Zexray.Type.Matrix.t()) :: Zexray.Type.Matrix.t()
      def matrix_invert(mat) do
        type_matrix(
          m0: a00,
          m1: a01,
          m2: a02,
          m3: a03,
          m4: a10,
          m5: a11,
          m6: a12,
          m7: a13,
          m8: a20,
          m9: a21,
          m10: a22,
          m11: a23,
          m12: a30,
          m13: a31,
          m14: a32,
          m15: a33
        ) = mat

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

        type_matrix(
          m0: (a11 * b11 - a12 * b10 + a13 * b09) * inv_det,
          m1: (-a01 * b11 + a02 * b10 - a03 * b09) * inv_det,
          m2: (a31 * b05 - a32 * b04 + a33 * b03) * inv_det,
          m3: (-a21 * b05 + a22 * b04 - a23 * b03) * inv_det,
          m4: (-a10 * b11 + a12 * b08 - a13 * b07) * inv_det,
          m5: (a00 * b11 - a02 * b08 + a03 * b07) * inv_det,
          m6: (-a30 * b05 + a32 * b02 - a33 * b01) * inv_det,
          m7: (a20 * b05 - a22 * b02 + a23 * b01) * inv_det,
          m8: (a10 * b10 - a11 * b08 + a13 * b06) * inv_det,
          m9: (-a00 * b10 + a01 * b08 - a03 * b06) * inv_det,
          m10: (a30 * b04 - a31 * b02 + a33 * b00) * inv_det,
          m11: (-a20 * b04 + a21 * b02 - a23 * b00) * inv_det,
          m12: (-a10 * b09 + a11 * b07 - a12 * b06) * inv_det,
          m13: (a00 * b09 - a01 * b07 + a02 * b06) * inv_det,
          m14: (-a30 * b03 + a31 * b01 - a32 * b00) * inv_det,
          m15: (a20 * b03 - a21 * b01 + a22 * b00) * inv_det
        )
      end

      @doc """
      Get identity matrix
      """
      @doc group: :matrix
      @spec matrix_identity() :: Zexray.Type.Matrix.t()
      def matrix_identity() do
        type_matrix(
          m0: 1.0,
          m1: 0.0,
          m2: 0.0,
          m3: 0.0,
          m4: 0.0,
          m5: 1.0,
          m6: 0.0,
          m7: 0.0,
          m8: 0.0,
          m9: 0.0,
          m10: 1.0,
          m11: 0.0,
          m12: 0.0,
          m13: 0.0,
          m14: 0.0,
          m15: 1.0
        )
      end

      @doc """
      Add two matrices
      """
      @doc group: :matrix
      @spec matrix_add(
              left :: Zexray.Type.Matrix.t(),
              right :: Zexray.Type.Matrix.t()
            ) :: Zexray.Type.Matrix.t()
      def matrix_add(left, right) do
        type_matrix(
          m0: left_m0,
          m1: left_m1,
          m2: left_m2,
          m3: left_m3,
          m4: left_m4,
          m5: left_m5,
          m6: left_m6,
          m7: left_m7,
          m8: left_m8,
          m9: left_m9,
          m10: left_m10,
          m11: left_m11,
          m12: left_m12,
          m13: left_m13,
          m14: left_m14,
          m15: left_m15
        ) = left

        type_matrix(
          m0: right_m0,
          m1: right_m1,
          m2: right_m2,
          m3: right_m3,
          m4: right_m4,
          m5: right_m5,
          m6: right_m6,
          m7: right_m7,
          m8: right_m8,
          m9: right_m9,
          m10: right_m10,
          m11: right_m11,
          m12: right_m12,
          m13: right_m13,
          m14: right_m14,
          m15: right_m15
        ) = right

        type_matrix(
          m0: left_m0 + right_m0,
          m1: left_m1 + right_m1,
          m2: left_m2 + right_m2,
          m3: left_m3 + right_m3,
          m4: left_m4 + right_m4,
          m5: left_m5 + right_m5,
          m6: left_m6 + right_m6,
          m7: left_m7 + right_m7,
          m8: left_m8 + right_m8,
          m9: left_m9 + right_m9,
          m10: left_m10 + right_m10,
          m11: left_m11 + right_m11,
          m12: left_m12 + right_m12,
          m13: left_m13 + right_m13,
          m14: left_m14 + right_m14,
          m15: left_m15 + right_m15
        )
      end

      @doc """
      Subtract two matrices (left - right)
      """
      @doc group: :matrix
      @spec matrix_subtract(
              left :: Zexray.Type.Matrix.t(),
              right :: Zexray.Type.Matrix.t()
            ) :: Zexray.Type.Matrix.t()
      def matrix_subtract(left, right) do
        type_matrix(
          m0: left_m0,
          m1: left_m1,
          m2: left_m2,
          m3: left_m3,
          m4: left_m4,
          m5: left_m5,
          m6: left_m6,
          m7: left_m7,
          m8: left_m8,
          m9: left_m9,
          m10: left_m10,
          m11: left_m11,
          m12: left_m12,
          m13: left_m13,
          m14: left_m14,
          m15: left_m15
        ) = left

        type_matrix(
          m0: right_m0,
          m1: right_m1,
          m2: right_m2,
          m3: right_m3,
          m4: right_m4,
          m5: right_m5,
          m6: right_m6,
          m7: right_m7,
          m8: right_m8,
          m9: right_m9,
          m10: right_m10,
          m11: right_m11,
          m12: right_m12,
          m13: right_m13,
          m14: right_m14,
          m15: right_m15
        ) = right

        type_matrix(
          m0: left_m0 - right_m0,
          m1: left_m1 - right_m1,
          m2: left_m2 - right_m2,
          m3: left_m3 - right_m3,
          m4: left_m4 - right_m4,
          m5: left_m5 - right_m5,
          m6: left_m6 - right_m6,
          m7: left_m7 - right_m7,
          m8: left_m8 - right_m8,
          m9: left_m9 - right_m9,
          m10: left_m10 - right_m10,
          m11: left_m11 - right_m11,
          m12: left_m12 - right_m12,
          m13: left_m13 - right_m13,
          m14: left_m14 - right_m14,
          m15: left_m15 - right_m15
        )
      end

      @doc """
      Get two matrix multiplication

      NOTE: When multiplying matrices... the order matters!
      """
      @doc group: :matrix
      @spec matrix_multiply(
              left :: Zexray.Type.Matrix.t(),
              right :: Zexray.Type.Matrix.t()
            ) :: Zexray.Type.Matrix.t()
      def matrix_multiply(left, right) do
        type_matrix(
          m0: left_m0,
          m1: left_m1,
          m2: left_m2,
          m3: left_m3,
          m4: left_m4,
          m5: left_m5,
          m6: left_m6,
          m7: left_m7,
          m8: left_m8,
          m9: left_m9,
          m10: left_m10,
          m11: left_m11,
          m12: left_m12,
          m13: left_m13,
          m14: left_m14,
          m15: left_m15
        ) = left

        type_matrix(
          m0: right_m0,
          m1: right_m1,
          m2: right_m2,
          m3: right_m3,
          m4: right_m4,
          m5: right_m5,
          m6: right_m6,
          m7: right_m7,
          m8: right_m8,
          m9: right_m9,
          m10: right_m10,
          m11: right_m11,
          m12: right_m12,
          m13: right_m13,
          m14: right_m14,
          m15: right_m15
        ) = right

        type_matrix(
          m0:
            left_m0 * right_m0 +
              left_m1 * right_m4 +
              left_m2 * right_m8 +
              left_m3 * right_m12,
          m1:
            left_m0 * right_m1 +
              left_m1 * right_m5 +
              left_m2 * right_m9 +
              left_m3 * right_m13,
          m2:
            left_m0 * right_m2 +
              left_m1 * right_m6 +
              left_m2 * right_m10 +
              left_m3 * right_m14,
          m3:
            left_m0 * right_m3 +
              left_m1 * right_m7 +
              left_m2 * right_m11 +
              left_m3 * right_m15,
          m4:
            left_m4 * right_m0 +
              left_m5 * right_m4 +
              left_m6 * right_m8 +
              left_m7 * right_m12,
          m5:
            left_m4 * right_m1 +
              left_m5 * right_m5 +
              left_m6 * right_m9 +
              left_m7 * right_m13,
          m6:
            left_m4 * right_m2 +
              left_m5 * right_m6 +
              left_m6 * right_m10 +
              left_m7 * right_m14,
          m7:
            left_m4 * right_m3 +
              left_m5 * right_m7 +
              left_m6 * right_m11 +
              left_m7 * right_m15,
          m8:
            left_m8 * right_m0 +
              left_m9 * right_m4 +
              left_m10 * right_m8 +
              left_m11 * right_m12,
          m9:
            left_m8 * right_m1 +
              left_m9 * right_m5 +
              left_m10 * right_m9 +
              left_m11 * right_m13,
          m10:
            left_m8 * right_m2 +
              left_m9 * right_m6 +
              left_m10 * right_m10 +
              left_m11 * right_m14,
          m11:
            left_m8 * right_m3 +
              left_m9 * right_m7 +
              left_m10 * right_m11 +
              left_m11 * right_m15,
          m12:
            left_m12 * right_m0 +
              left_m13 * right_m4 +
              left_m14 * right_m8 +
              left_m15 * right_m12,
          m13:
            left_m12 * right_m1 +
              left_m13 * right_m5 +
              left_m14 * right_m9 +
              left_m15 * right_m13,
          m14:
            left_m12 * right_m2 +
              left_m13 * right_m6 +
              left_m14 * right_m10 +
              left_m15 * right_m14,
          m15:
            left_m12 * right_m3 +
              left_m13 * right_m7 +
              left_m14 * right_m11 +
              left_m15 * right_m15
        )
      end

      @doc """
      Get translation matrix
      """
      @doc group: :matrix
      @spec matrix_translate(
              x :: float,
              y :: float,
              z :: float
            ) :: Zexray.Type.Matrix.t()
      def matrix_translate(x, y, z) do
        type_matrix(
          m0: 1.0,
          m1: 0.0,
          m2: 0.0,
          m3: x,
          m4: 0.0,
          m5: 1.0,
          m6: 0.0,
          m7: y,
          m8: 0.0,
          m9: 0.0,
          m10: 1.0,
          m11: z,
          m12: 0.0,
          m13: 0.0,
          m14: 0.0,
          m15: 1.0
        )
      end

      @doc """
      Create rotation matrix from axis and angle

      NOTE: Angle should be provided in radians
      """
      @doc group: :matrix
      @spec matrix_rotate(
              axis :: Zexray.Type.Vector3.t(),
              angle :: number
            ) :: Zexray.Type.Matrix.t()
      def matrix_rotate(axis, angle) do
        type_vector3(x: axis_x, y: axis_y, z: axis_z) = axis

        length = :math.sqrt(axis_x * axis_x + axis_y * axis_y + axis_z * axis_z)

        {x, y, z} =
          if length != 0 do
            ilength = 1.0 / length
            {axis_x * ilength, axis_y * ilength, axis_z * ilength}
          else
            {0.0, 0.0, 0.0}
          end

        sinres = :math.sin(angle)
        cosres = :math.cos(angle)
        t = 1.0 - cosres

        type_matrix(
          m0: x * x * t + cosres,
          m1: y * x * t + z * sinres,
          m2: z * x * t - y * sinres,
          m3: 0.0,
          m4: x * y * t - z * sinres,
          m5: y * y * t + cosres,
          m6: z * y * t + x * sinres,
          m7: 0.0,
          m8: x * z * t + y * sinres,
          m9: y * z * t - x * sinres,
          m10: z * z * t + cosres,
          m11: 0.0,
          m12: 0.0,
          m13: 0.0,
          m14: 0.0,
          m15: 1.0
        )
      end

      @doc """
      Get x-rotation matrix

      NOTE: Angle must be provided in radians
      """
      @doc group: :matrix
      @spec matrix_rotate_x(angle :: number) :: Zexray.Type.Matrix.t()
      def matrix_rotate_x(angle) do
        cosres = :math.cos(angle)
        sinres = :math.sin(angle)

        type_matrix(
          m0: 1.0,
          m1: 0.0,
          m2: 0.0,
          m3: 0.0,
          m4: 0.0,
          m5: cosres,
          m6: sinres,
          m7: 0.0,
          m8: 0.0,
          m9: sinres * -1,
          m10: cosres,
          m11: 0.0,
          m12: 0.0,
          m13: 0.0,
          m14: 0.0,
          m15: 1.0
        )
      end

      @doc """
      Get y-rotation matrix

      NOTE: Angle must be provided in radians
      """
      @doc group: :matrix
      @spec matrix_rotate_y(angle :: number) :: Zexray.Type.Matrix.t()
      def matrix_rotate_y(angle) do
        cosres = :math.cos(angle)
        sinres = :math.sin(angle)

        type_matrix(
          m0: cosres,
          m1: 0.0,
          m2: sinres * -1,
          m3: 0.0,
          m4: 0.0,
          m5: 1.0,
          m6: 0.0,
          m7: 0.0,
          m8: sinres,
          m9: 0.0,
          m10: cosres,
          m11: 0.0,
          m12: 0.0,
          m13: 0.0,
          m14: 0.0,
          m15: 1.0
        )
      end

      @doc """
      Get z-rotation matrix

      NOTE: Angle must be provided in radians
      """
      @doc group: :matrix
      @spec matrix_rotate_z(angle :: number) :: Zexray.Type.Matrix.t()
      def matrix_rotate_z(angle) do
        cosres = :math.cos(angle)
        sinres = :math.sin(angle)

        type_matrix(
          m0: cosres,
          m1: sinres,
          m2: 0.0,
          m3: 0.0,
          m4: sinres * -1,
          m5: cosres,
          m6: 0.0,
          m7: 0.0,
          m8: 0.0,
          m9: 0.0,
          m10: 1.0,
          m11: 0.0,
          m12: 0.0,
          m13: 0.0,
          m14: 0.0,
          m15: 1.0
        )
      end

      @doc """
      Get xyz-rotation matrix

      NOTE: Angle must be provided in radians
      """
      @doc group: :matrix
      @spec matrix_rotate_xyz(angle :: Zexray.Type.Vector3.t()) :: Zexray.Type.Matrix.t()
      def matrix_rotate_xyz(angle) do
        type_vector3(x: angle_x, y: angle_y, z: angle_z) = angle

        cz = :math.cos(angle_z * -1)
        sz = :math.sin(angle_z * -1)
        cy = :math.cos(angle_y * -1)
        sy = :math.sin(angle_y * -1)
        cx = :math.cos(angle_x * -1)
        sx = :math.sin(angle_x * -1)

        type_matrix(
          m0: cz * cy,
          m1: cz * sy * sx - sz * cx,
          m2: cz * sy * cx + sz * sx,
          m3: 0.0,
          m4: sz * cy,
          m5: sz * sy * sx + cz * cx,
          m6: sz * sy * cx - cz * sx,
          m7: 0.0,
          m8: sy * -1,
          m9: cy * sx,
          m10: cy * cx,
          m11: 0.0,
          m12: 0.0,
          m13: 0.0,
          m14: 0.0,
          m15: 1.0
        )
      end

      @doc """
      Get zyx-rotation matrix

      NOTE: Angle must be provided in radians
      """
      @doc group: :matrix
      @spec matrix_rotate_zyx(angle :: Zexray.Type.Vector3.t()) :: Zexray.Type.Matrix.t()
      def matrix_rotate_zyx(angle) do
        type_vector3(x: angle_x, y: angle_y, z: angle_z) = angle

        cz = :math.cos(angle_z)
        sz = :math.sin(angle_z)
        cy = :math.cos(angle_y)
        sy = :math.sin(angle_y)
        cx = :math.cos(angle_x)
        sx = :math.sin(angle_x)

        type_matrix(
          m0: cz * cy,
          m1: cy * sz,
          m2: sy * -1,
          m3: 0.0,
          m4: cz * sy * sx - cx * sz,
          m5: cz * cx + sz * sy * sx,
          m6: cy * sx,
          m7: 0.0,
          m8: sz * sx + cz * cx * sy,
          m9: cx * sz * sy - cz * sx,
          m10: cy * cx,
          m11: 0.0,
          m12: 0.0,
          m13: 0.0,
          m14: 0.0,
          m15: 1.0
        )
      end

      @doc """
      Get scaling matrix
      """
      @doc group: :matrix
      @spec matrix_scale(
              x :: float,
              y :: float,
              z :: float
            ) :: Zexray.Type.Matrix.t()
      def matrix_scale(x, y, z) do
        type_matrix(
          m0: x,
          m1: 0.0,
          m2: 0.0,
          m3: 0.0,
          m4: 0.0,
          m5: y,
          m6: 0.0,
          m7: 0.0,
          m8: 0.0,
          m9: 0.0,
          m10: z,
          m11: 0.0,
          m12: 0.0,
          m13: 0.0,
          m14: 0.0,
          m15: 1.0
        )
      end

      @doc """
      Get perspective projection matrix
      """
      @doc group: :matrix
      @spec matrix_frustum(
              left :: number,
              right :: number,
              bottom :: number,
              top :: number,
              near_plane :: number,
              far_plane :: number
            ) :: Zexray.Type.Matrix.t()
      def matrix_frustum(left, right, bottom, top, near_plane, far_plane) do
        right_left = right - left
        top_bottom = top - bottom
        far_near = far_plane - near_plane

        type_matrix(
          m0: near_plane * 2.0 / right_left,
          m1: 0.0,
          m2: 0.0,
          m3: 0.0,
          m4: 0.0,
          m5: near_plane * 2.0 / top_bottom,
          m6: 0.0,
          m7: 0.0,
          m8: (right + left) / right_left,
          m9: (top + bottom) / top_bottom,
          m10: (far_plane + near_plane) / far_near * -1,
          m11: -1.0,
          m12: 0.0,
          m13: 0.0,
          m14: far_plane * near_plane * 2.0 / far_near * -1,
          m15: 0.0
        )
      end

      @doc """
      Get perspective projection matrix

      NOTE: Fovy angle must be provided in radians
      """
      @doc group: :matrix
      @spec matrix_perspective(
              fov_y :: number,
              aspect :: number,
              near_plane :: number,
              far_plane :: number
            ) :: Zexray.Type.Matrix.t()
      def matrix_perspective(fov_y, aspect, near_plane, far_plane) do
        top = near_plane * :math.tan(fov_y * 0.5)
        bottom = top * -1
        right = top * aspect
        left = right * -1

        # matrix_frustum(-right, right, -top, top, near, far)
        right_left = right - left
        top_bottom = top - bottom
        far_near = far_plane - near_plane

        type_matrix(
          m0: near_plane * 2.0 / right_left,
          m1: 0.0,
          m2: 0.0,
          m3: 0.0,
          m4: 0.0,
          m5: near_plane * 2.0 / top_bottom,
          m6: 0.0,
          m7: 0.0,
          m8: (right + left) / right_left,
          m9: (top + bottom) / top_bottom,
          m10: (far_plane + near_plane) / far_near * -1,
          m11: -1.0,
          m12: 0.0,
          m13: 0.0,
          m14: far_plane * near_plane * 2.0 / far_near * -1,
          m15: 0.0
        )
      end

      @doc """
      Get orthographic projection matrix
      """
      @doc group: :matrix
      @spec matrix_ortho(
              left :: number,
              right :: number,
              bottom :: number,
              top :: number,
              near_plane :: number,
              far_plane :: number
            ) :: Zexray.Type.Matrix.t()
      def matrix_ortho(left, right, bottom, top, near_plane, far_plane) do
        right_left = right - left
        top_bottom = top - bottom
        far_near = far_plane - near_plane

        type_matrix(
          m0: 2.0 / right_left,
          m1: 0.0,
          m2: 0.0,
          m3: 0.0,
          m4: 0.0,
          m5: 2.0 / top_bottom,
          m6: 0.0,
          m7: 0.0,
          m8: 0.0,
          m9: 0.0,
          m10: -2.0 / far_near,
          m11: 0.0,
          m12: (left + right) / right_left * -1,
          m13: (top + bottom) / top_bottom * -1,
          m14: (far_plane + near_plane) / far_near * -1,
          m15: 1.0
        )
      end

      @doc """
      Get camera look-at matrix (view matrix)
      """
      @doc group: :matrix
      @spec matrix_look_at(
              eye :: Zexray.Type.Vector3.t(),
              target :: Zexray.Type.Vector3.t(),
              up :: Zexray.Type.Vector3.t()
            ) :: Zexray.Type.Matrix.t()
      def matrix_look_at(eye, target, up) do
        type_vector3(x: eye_x, y: eye_y, z: eye_z) = eye
        type_vector3(x: target_x, y: target_y, z: target_z) = target
        type_vector3(x: up_x, y: up_y, z: up_z) = up

        # vector3_subtract(eye, target)
        vz_x = eye_x - target_x
        vz_y = eye_y - target_y
        vz_z = eye_z - target_z

        # vector3_normalize(vz)
        length = :math.sqrt(vz_x * vz_x + vz_y * vz_y + vz_z * vz_z)

        {vz_x, vz_y, vz_z} =
          if length != 0 do
            ilength = 1.0 / length
            {vz_x * ilength, vz_y * ilength, vz_z * ilength}
          else
            {0.0, 0.0, 0.0}
          end

        # vector3_cross_product(up, vz)
        vx_x = up_y * vz_z - up_z * vz_y
        vx_y = up_z * vz_x - up_x * vz_z
        vx_z = up_x * vz_y - up_y * vz_x

        # vector3_normalize(vx)
        length = :math.sqrt(vx_x * vx_x + vx_y * vx_y + vx_z * vx_z)

        {vx_x, vx_y, vx_z} =
          if length != 0 do
            ilength = 1.0 / length
            {vx_x * ilength, vx_y * ilength, vx_z * ilength}
          else
            {0.0, 0.0, 0.0}
          end

        # vector3_cross_product(vz, vx)
        vy_x = vz_y * vx_z - vz_z * vx_y
        vy_y = vz_z * vx_x - vz_x * vx_z
        vy_z = vz_x * vx_y - vz_y * vx_x

        type_matrix(
          m0: vx_x,
          m1: vy_x,
          m2: vz_x,
          m3: 0.0,
          m4: vx_y,
          m5: vy_y,
          m6: vz_y,
          m7: 0.0,
          m8: vx_z,
          m9: vy_z,
          m10: vz_z,
          m11: 0.0,
          # vector3_dot_product(vx, eye)
          m12: (vx_x * eye_x + vx_y * eye_y + vx_z * eye_z) * -1,
          # vector3_dot_product(vy, eye)
          m13: (vy_x * eye_x + vy_y * eye_y + vy_z * eye_z) * -1,
          # vector3_dot_product(vz, eye)
          m14: (vz_x * eye_x + vz_y * eye_y + vz_z * eye_z) * -1,
          m15: 1.0
        )
      end

      @doc """
      Decompose a transformation matrix into its rotational, translational and scaling components
      """
      @doc group: :matrix
      @spec matrix_decompose(mat :: Zexray.Type.Matrix.t()) :: {
              translation :: Zexray.Type.Vector3.t(),
              rotation :: Zexray.Type.Quaternion.t(),
              scale :: Zexray.Type.Vector3.t()
            }
      def matrix_decompose(mat) do
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

        # Extract translation.
        translation =
          type_vector3(
            x: mat_m12,
            y: mat_m13,
            z: mat_m14
          )

        # Extract upper-left for determinant computation
        a = mat_m0
        b = mat_m4
        c = mat_m8
        d = mat_m1
        e = mat_m5
        f = mat_m9
        g = mat_m2
        h = mat_m6
        i = mat_m10
        aa = e * i - f * h
        bb = f * g - d * i
        cc = d * h - e * g

        # Extract scale
        det = a * aa + b * bb + c * cc
        v_abc = type_vector3(x: a, y: b, z: c)
        v_def = type_vector3(x: d, y: e, z: f)
        v_ghi = type_vector3(x: g, y: h, z: i)

        scale_x = vector3_length(v_abc)
        scale_y = vector3_length(v_def)
        scale_z = vector3_length(v_ghi)
        s = type_vector3(x: scale_x, y: scale_y, z: scale_z)

        s = if det < 0, do: vector3_negate(s), else: s

        scale = s

        type_vector3(x: s_x, y: s_y, z: s_z) = s

        # Remove scale from the matrix if it is not close to zero
        rotation =
          if not number_equals?(det, 0) do
            # Extract rotation
            type_matrix(mat,
              m0: mat_m0 / s_x,
              m4: mat_m4 / s_x,
              m8: mat_m8 / s_x,
              m1: mat_m1 / s_y,
              m5: mat_m5 / s_y,
              m9: mat_m9 / s_y,
              m2: mat_m2 / s_z,
              m6: mat_m6 / s_z,
              m10: mat_m10 / s_z
            )
            |> quaternion_from_matrix()
          else
            # Set to identity if close to zero
            quaternion_identity()
          end

        {translation, rotation, scale}
      end
    end
  end
end
