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

  @type t ::
          record(:t,
            position: Zexray.Type.Vector3.t_nif(),
            direction: Zexray.Type.Vector3.t_nif()
          )

  Record.defrecord(:t, :ray,
    position: nil,
    direction: nil
  )

  use Zexray.Type.TypeBase, prefix: "ray"

  @type t_all :: t | t_resource
end
