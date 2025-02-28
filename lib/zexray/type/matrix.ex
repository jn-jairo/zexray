defmodule Zexray.Type.Matrix do
  @moduledoc """
  4x4 components, column major, OpenGL style, right-handed

  ## Fields

  |      |      |       |       |                                  |
  | ---- | ---- | ----- | ----- | -------------------------------- |
  | `m0` | `m4` | `m8`  | `m12` | Matrix first row (4 components)  |
  | `m1` | `m5` | `m9`  | `m13` | Matrix second row (4 components) |
  | `m2` | `m6` | `m10` | `m14` | Matrix third row (4 components)  |
  | `m3` | `m7` | `m11` | `m15` | Matrix fourth row (4 components) |
  """

  defstruct m0: 0.0,
            m1: 0.0,
            m2: 0.0,
            m3: 0.0,
            m4: 0.0,
            m5: 0.0,
            m6: 0.0,
            m7: 0.0,
            m8: 0.0,
            m9: 0.0,
            m10: 0.0,
            m11: 0.0,
            m12: 0.0,
            m13: 0.0,
            m14: 0.0,
            m15: 0.0

  use Zexray.Type.TypeBase, prefix: "matrix"

  @type t ::
          %__MODULE__{
            m0: float,
            m1: float,
            m2: float,
            m3: float,
            m4: float,
            m5: float,
            m6: float,
            m7: float,
            m8: float,
            m9: float,
            m10: float,
            m11: float,
            m12: float,
            m13: float,
            m14: float,
            m15: float
          }

  @type t_all ::
          t
          | {float, float, float, float, float, float, float, float, float, float, float, float,
             float, float, float, float}
          | {{float, float, float, float}, {float, float, float, float},
             {float, float, float, float}, {float, float, float, float}}
          | map
          | keyword
          | Resource.t()

  @doc """
  Creates a new `t:t/0`.
  """
  def new(matrix)

  @spec new({
          {m0 :: float, m4 :: float, m8 :: float, m12 :: float},
          {m1 :: float, m5 :: float, m9 :: float, m13 :: float},
          {m2 :: float, m6 :: float, m10 :: float, m14 :: float},
          {m3 :: float, m7 :: float, m11 :: float, m15 :: float}
        }) :: t()
  def new({
        {m0, m4, m8, m12},
        {m1, m5, m9, m13},
        {m2, m6, m10, m14},
        {m3, m7, m11, m15}
      })
      when is_float(m0) and
             is_float(m1) and
             is_float(m2) and
             is_float(m3) and
             is_float(m4) and
             is_float(m5) and
             is_float(m6) and
             is_float(m7) and
             is_float(m8) and
             is_float(m9) and
             is_float(m10) and
             is_float(m11) and
             is_float(m12) and
             is_float(m13) and
             is_float(m14) and
             is_float(m15) do
    new(
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
    )
  end

  @spec new({
          m0 :: float,
          m1 :: float,
          m2 :: float,
          m3 :: float,
          m4 :: float,
          m5 :: float,
          m6 :: float,
          m7 :: float,
          m8 :: float,
          m9 :: float,
          m10 :: float,
          m11 :: float,
          m12 :: float,
          m13 :: float,
          m14 :: float,
          m15 :: float
        }) :: t()
  def new({
        m0,
        m1,
        m2,
        m3,
        m4,
        m5,
        m6,
        m7,
        m8,
        m9,
        m10,
        m11,
        m12,
        m13,
        m14,
        m15
      })
      when is_float(m0) and
             is_float(m1) and
             is_float(m2) and
             is_float(m3) and
             is_float(m4) and
             is_float(m5) and
             is_float(m6) and
             is_float(m7) and
             is_float(m8) and
             is_float(m9) and
             is_float(m10) and
             is_float(m11) and
             is_float(m12) and
             is_float(m13) and
             is_float(m14) and
             is_float(m15) do
    new(
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
    )
  end

  @spec new(matrix :: struct) :: t()
  def new(matrix) when is_struct(matrix) do
    matrix =
      if String.ends_with?(Atom.to_string(matrix.__struct__), ".Resource") do
        apply(matrix.__struct__, :content, [matrix])
      else
        matrix
      end

    case matrix do
      %__MODULE__{} = matrix -> matrix
      _ -> new(Map.from_struct(matrix))
    end
  end

  @spec new(fields :: Enumerable.t()) :: t()
  def new(fields) do
    if Enumerable.impl_for(fields) != nil do
      struct!(
        __MODULE__,
        fields
      )
    else
      raise_argument_error(fields)
    end
  end
end
