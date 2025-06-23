defmodule Zexray.Type.Ray do
  @moduledoc """
  Ray for raycasting

  ## Fields

  |             |                            |
  | ----------- | -------------------------- |
  | `position`  | Ray position (origin)      |
  | `direction` | Ray direction (normalized) |
  """

  require Record

  require Zexray.Type.Vector3

  @type t ::
          record(:t,
            position: Zexray.Type.Vector3.t_nif(),
            direction: Zexray.Type.Vector3.t_nif()
          )

  Record.defrecord(:t, :ray,
    position: Zexray.Type.Vector3.t(),
    direction: Zexray.Type.Vector3.t()
  )

  use Zexray.Type.TypeBase, prefix: "ray"

  @type t_all :: t | t_resource
end
