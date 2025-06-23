defmodule Zexray.Type.BoundingBox do
  @moduledoc """
  Bounding Box

  ## Fields

  |       |                           |
  | ----- | ------------------------- |
  | `min` | Minimum vertex box-corner |
  | `max` | Maximum vertex box-corner |
  """

  require Record

  require Zexray.Type.Vector3

  @type t ::
          record(:t,
            min: Zexray.Type.Vector3.t_nif(),
            max: Zexray.Type.Vector3.t_nif()
          )

  Record.defrecord(:t, :bounding_box,
    min: Zexray.Type.Vector3.t(),
    max: Zexray.Type.Vector3.t()
  )

  use Zexray.Type.TypeBase, prefix: "bounding_box"

  @type t_all :: t | t_resource
end
