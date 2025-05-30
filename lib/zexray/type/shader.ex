defmodule Zexray.Type.Shader do
  @moduledoc """
  Shader

  ## Fields

  |        |                        |
  | ------ | ---------------------- |
  | `id`   | Shader program id      |
  | `locs` | Shader locations array |
  """

  require Record

  @type t ::
          record(:t,
            id: non_neg_integer,
            locs: [integer]
          )

  Record.defrecord(:t, :shader,
    id: 0,
    locs: []
  )

  use Zexray.Type.TypeBase, prefix: "shader"

  @type t_all :: t | t_resource
end
