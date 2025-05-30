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

  @type t ::
          record(:t,
            min: Zexray.Type.Vector3.t_nif(),
            max: Zexray.Type.Vector3.t_nif()
          )

  Record.defrecord(:t, :bounding_box,
    min: nil,
    max: nil
  )

  use Zexray.Type.TypeBase, prefix: "bounding_box"

  @type t_all :: t | t_resource
end
