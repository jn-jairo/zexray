defmodule Zexray.Type.MaterialMap do
  @moduledoc """
  Material Map

  ## Fields

  |           |                      |
  | --------- | -------------------- |
  | `texture` | Material map texture |
  | `color`   | Material map color   |
  | `value`   | Material map value   |
  """

  require Record

  require Zexray.Type.Color
  require Zexray.Type.Texture2D

  @type t ::
          record(:t,
            texture: Zexray.Type.Texture2D.t_nif(),
            color: Zexray.Type.Color.t_nif(),
            value: float
          )

  Record.defrecord(:t, :material_map,
    texture: Zexray.Type.Texture2D.t(),
    color: Zexray.Type.Color.t(),
    value: 0.0
  )

  use Zexray.Type.TypeBase, prefix: "material_map"

  @type t_all :: t | t_resource
end
