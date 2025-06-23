defmodule Zexray.Type.BoneInfo do
  @moduledoc """
  Skeletal animation bone

  ## Fields

  |          |             |
  | -------- | ----------- |
  | `name`   | Bone name   |
  | `parent` | Bone parent |
  """

  require Record

  @type t ::
          record(:t,
            name: binary,
            parent: integer
          )

  Record.defrecord(:t, :bone_info,
    name: "",
    parent: 0
  )

  use Zexray.Type.TypeBase, prefix: "bone_info"

  @type t_all :: t | t_resource
end
