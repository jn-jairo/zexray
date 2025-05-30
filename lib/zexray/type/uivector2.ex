defmodule Zexray.Type.UIVector2 do
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
            x: non_neg_integer,
            y: non_neg_integer
          )

  Record.defrecord(:t, :uivector2,
    x: 0,
    y: 0
  )

  use Zexray.Type.TypeBase, prefix: "uivector2"

  @type t_all :: t | t_resource
end
