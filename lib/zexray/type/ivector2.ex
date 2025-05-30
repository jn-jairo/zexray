defmodule Zexray.Type.IVector2 do
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
            x: integer,
            y: integer
          )

  Record.defrecord(:t, :ivector2,
    x: 0,
    y: 0
  )

  use Zexray.Type.TypeBase, prefix: "ivector2"

  @type t_all :: t | t_resource
end
