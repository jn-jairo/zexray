defmodule Zexray.Type.Vector2 do
  @moduledoc """
  2 components

  ## Fields

  |     |                    |
  | --- | ------------------ |
  | `x` | Vector x component |
  | `y` | Vector y component |
  """

  require Record

  @type t ::
          record(:t,
            x: float,
            y: float
          )

  Record.defrecord(:t, :vector2,
    x: 0.0,
    y: 0.0
  )

  use Zexray.Type.TypeBase, prefix: "vector2"

  @type t_all :: t | t_resource
end
