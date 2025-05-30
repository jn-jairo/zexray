defmodule Zexray.Type.Rectangle do
  @moduledoc """
  4 components

  ## Fields

  |          |                                      |
  | -------- | ------------------------------------ |
  | `x`      | Rectangle top-left corner position x |
  | `y`      | Rectangle top-left corner position y |
  | `width`  | Rectangle width                      |
  | `height` | Rectangle height                     |
  """

  require Record

  @type t ::
          record(:t,
            x: float,
            y: float,
            width: float,
            height: float
          )

  Record.defrecord(:t, :rectangle,
    x: 0.0,
    y: 0.0,
    width: 0.0,
    height: 0.0
  )

  use Zexray.Type.TypeBase, prefix: "rectangle"

  @type t_all :: t | t_resource
end
