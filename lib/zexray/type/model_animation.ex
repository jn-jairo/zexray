defmodule Zexray.Type.ModelAnimation do
  @moduledoc """
  Model Animation

  ## Fields

  |               |                              |
  | ------------- | ---------------------------- |
  | `bone_count`  | Number of bones              |
  | `frame_count` | Number of animation frames   |
  | `bones`       | Bones information (skeleton) |
  | `frame_poses` | Poses array by frame         |
  | `name`        | Animation name               |
  """

  require Record

  @type t ::
          record(:t,
            bone_count: integer,
            frame_count: integer,
            bones: [Zexray.Type.BoneInfo.t_nif()],
            frame_poses: [[Zexray.Type.Transform.t_nif()]],
            name: binary
          )

  Record.defrecord(:t, :model_animation,
    bone_count: 0,
    frame_count: 0,
    bones: [],
    frame_poses: [],
    name: ""
  )

  use Zexray.Type.TypeBase, prefix: "model_animation"

  @type t_all :: t | t_resource
end
