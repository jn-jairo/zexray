defmodule Zexray.Type.RayCollision do
  @moduledoc """
  Ray hit information

  ## Fields

  |            |                             |
  | ---------- | --------------------------- |
  | `hit`      | Did the ray hit something?  |
  | `distance` | Distance to the nearest hit |
  | `point`    | Point of the nearest hit    |
  | `normal`   | Surface normal of hit       |
  """

  require Record

  require Zexray.Type.Vector3

  @type t ::
          record(:t,
            hit: boolean,
            distance: float,
            point: Zexray.Type.Vector3.t_nif(),
            normal: Zexray.Type.Vector3.t_nif()
          )

  Record.defrecord(:t, :ray_collision,
    hit: false,
    distance: 0.0,
    point: Zexray.Type.Vector3.t(),
    normal: Zexray.Type.Vector3.t()
  )

  use Zexray.Type.TypeBase, prefix: "ray_collision"

  @type t_all :: t | t_resource
end
