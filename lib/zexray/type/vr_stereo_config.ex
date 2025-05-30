defmodule Zexray.Type.VrStereoConfig do
  @moduledoc """
  VR stereo rendering configuration for simulator

  ## Fields

  |                       |                                   |
  | --------------------- | --------------------------------- |
  | `projection`          | VR projection matrices (per eye)  |
  | `view_offset`         | VR view offset matrices (per eye) |
  | `left_lens_center`    | VR left lens center               |
  | `right_lens_center`   | VR right lens center              |
  | `left_screen_center`  | VR left screen center             |
  | `right_screen_center` | VR right screen center            |
  | `scale`               | VR distortion scale               |
  | `scale_in`            | VR distortion scale in            |
  """

  require Record

  @type t ::
          record(:t,
            projection: [Zexray.Type.Matrix.t_nif()],
            view_offset: [Zexray.Type.Matrix.t_nif()],
            left_lens_center: [float],
            right_lens_center: [float],
            left_screen_center: [float],
            right_screen_center: [float],
            scale: [float],
            scale_in: [float]
          )

  Record.defrecord(:t, :vr_stereo_config,
    projection: [],
    view_offset: [],
    left_lens_center: [],
    right_lens_center: [],
    left_screen_center: [],
    right_screen_center: [],
    scale: [],
    scale_in: []
  )

  use Zexray.Type.TypeBase, prefix: "vr_stereo_config"

  @type t_all :: t | t_resource
end
