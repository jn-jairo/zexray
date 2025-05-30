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

  require Record

  @type t ::
          record(:t,
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
          )

  Record.defrecord(:t, :matrix,
    m0: 0.0,
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
  )

  use Zexray.Type.TypeBase, prefix: "matrix"

  @type t_all :: t | t_resource
end
