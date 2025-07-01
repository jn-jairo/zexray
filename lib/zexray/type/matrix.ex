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
            m0: number,
            m1: number,
            m2: number,
            m3: number,
            m4: number,
            m5: number,
            m6: number,
            m7: number,
            m8: number,
            m9: number,
            m10: number,
            m11: number,
            m12: number,
            m13: number,
            m14: number,
            m15: number
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
