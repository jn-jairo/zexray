defmodule Zexray.Type.Vector3 do
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
            x: float,
            y: float,
            z: float
          )

  Record.defrecord(:t, :vector3,
    x: 0.0,
    y: 0.0,
    z: 0.0
  )

  use Zexray.Type.TypeBase, prefix: "vector3"

  @type t_all :: t | t_resource
end
