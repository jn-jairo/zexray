defmodule Zexray.Type.UIVector4 do
  @moduledoc """
  4 components

  ## Fields

  |     |                    |
  | --- | ------------------ |
  | `x` | Vector x component |
  | `y` | Vector y component |
  | `z` | Vector z component |
  | `w` | Vector w component |
  """

  require Record

  @type t ::
          record(:t,
            x: non_neg_integer,
            y: non_neg_integer,
            z: non_neg_integer,
            w: non_neg_integer
          )

  Record.defrecord(:t, :uivector4,
    x: 0,
    y: 0,
    z: 0,
    w: 0
  )

  use Zexray.Type.TypeBase, prefix: "uivector4"

  @type t_all :: t | t_resource
end
