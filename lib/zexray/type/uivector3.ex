defmodule Zexray.Type.UIVector3 do
  @moduledoc """
  3 components

  ## Fields

  |     |                    |
  | --- | ------------------ |
  | `x` | Vector x component |
  | `y` | Vector y component |
  | `z` | Vector z component |
  """

  require Record

  @type t ::
          record(:t,
            x: non_neg_integer,
            y: non_neg_integer,
            z: non_neg_integer
          )

  Record.defrecord(:t, :uivector3,
    x: 0,
    y: 0,
    z: 0
  )

  use Zexray.Type.TypeBase, prefix: "uivector3"

  @type t_all :: t | t_resource
end
