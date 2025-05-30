defmodule Zexray.Type.Color do
  @moduledoc """
  4 components, R8G8B8A8 (32bit)

  ## Fields

  |     |                   |
  | --- | ----------------- |
  | `r` | Color red value   |
  | `g` | Color green value |
  | `b` | Color blue value  |
  | `a` | Color alpha value |
  """

  require Record

  @type t ::
          record(:t,
            r: byte,
            g: byte,
            b: byte,
            a: byte
          )

  Record.defrecord(:t, :color,
    r: 0,
    g: 0,
    b: 0,
    a: 0xFF
  )

  use Zexray.Type.TypeBase, prefix: "color"

  @type t_all :: t | t_resource
end
