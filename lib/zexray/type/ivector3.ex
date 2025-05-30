defmodule Zexray.Type.IVector3 do
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
            x: integer,
            y: integer,
            z: integer
          )

  Record.defrecord(:t, :ivector3,
    x: 0,
    y: 0,
    z: 0
  )

  use Zexray.Type.TypeBase, prefix: "ivector3"

  @type t_all :: t | t_resource
end
