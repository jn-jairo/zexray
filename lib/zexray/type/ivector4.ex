defmodule Zexray.Type.IVector4 do
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
            x: integer,
            y: integer,
            z: integer,
            w: integer
          )

  Record.defrecord(:t, :ivector4,
    x: 0,
    y: 0,
    z: 0,
    w: 0
  )

  use Zexray.Type.TypeBase, prefix: "ivector4"

  @type t_all :: t | t_resource
end
