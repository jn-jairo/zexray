defmodule Zexray.Type.Camera2D do
  @moduledoc """
  Defines position/orientation in 2d space

  ## Fields

  |            |                                                  |
  | ---------- | ------------------------------------------------ |
  | `offset`   | Camera offset (displacement from target)         |
  | `target`   | Camera target (rotation and zoom origin)         |
  | `rotation` | Camera rotation in degrees                       |
  | `zoom`     | Camera zoom (scaling), should be 1.0f by default |
  """

  require Record

  require Zexray.Type.Vector2

  @type t ::
          record(:t,
            offset: Zexray.Type.Vector2.t_nif(),
            target: Zexray.Type.Vector2.t_nif(),
            rotation: number,
            zoom: number
          )

  Record.defrecord(:t, :camera_2d,
    offset: Zexray.Type.Vector2.t(),
    target: Zexray.Type.Vector2.t(),
    rotation: 0.0,
    zoom: 1.0
  )

  use Zexray.Type.TypeBase, prefix: "camera_2d"

  @type t_all :: t | t_resource
end
