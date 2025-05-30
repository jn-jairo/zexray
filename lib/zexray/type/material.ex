defmodule Zexray.Type.Material do
  @moduledoc """
  Material, includes shader and maps

  ## Fields

  |          |                             |
  | -------- | --------------------------- |
  | `shader` | Material shader             |
  | `maps`   | Material maps array         |
  | `params` | Material generic parameters |
  """

  require Record

  @type t ::
          record(:t,
            shader: Zexray.Type.Shader.t_nif(),
            maps: [Zexray.Type.MaterialMap.t_nif()],
            params: [float]
          )

  Record.defrecord(:t, :material,
    shader: nil,
    maps: [],
    params: []
  )

  use Zexray.Type.TypeBase, prefix: "material"

  @type t_all :: t | t_resource
end
