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

  @type t ::
          record(:t,
            translation: Zexray.Type.Vector3.t_nif(),
            rotation: Zexray.Type.Quaternion.t_nif(),
            scale: Zexray.Type.Vector3.t_nif()
          )

  Record.defrecord(:t, :transform,
    translation: nil,
    rotation: nil,
    scale: nil
  )

  use Zexray.Type.TypeBase, prefix: "transform"

  @type t_all :: t | t_resource
end
