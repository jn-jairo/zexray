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

  @type t ::
          record(:t,
            offset: Zexray.Type.Vector2.t_nif(),
            target: Zexray.Type.Vector2.t_nif(),
            rotation: float,
            zoom: float
          )

  Record.defrecord(:t, :camera_2d,
    offset: nil,
    target: nil,
    rotation: nil,
    zoom: 1.0
  )

  use Zexray.Type.TypeBase, prefix: "camera_2d"

  @type t_all :: t | t_resource
end
