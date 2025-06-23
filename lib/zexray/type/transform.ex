defmodule Zexray.Type.Transform do
  @moduledoc """
  Vertex transformation data

  ## Fields

  |               |             |
  | ------------- | ----------- |
  | `translation` | Translation |
  | `rotation`    | Rotation    |
  | `scale`       | Scale       |
  """

  require Record

  require Zexray.Type.Quaternion
  require Zexray.Type.Vector3

  @type t ::
          record(:t,
            translation: Zexray.Type.Vector3.t_nif(),
            rotation: Zexray.Type.Quaternion.t_nif(),
            scale: Zexray.Type.Vector3.t_nif()
          )

  Record.defrecord(:t, :transform,
    translation: Zexray.Type.Vector3.t(),
    rotation: Zexray.Type.Quaternion.t(),
    scale: Zexray.Type.Vector3.t()
  )

  use Zexray.Type.TypeBase, prefix: "transform"

  @type t_all :: t | t_resource
end
