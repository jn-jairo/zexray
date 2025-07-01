defmodule Zexray.Type.VrDeviceInfo do
  @moduledoc """
  Head-Mounted-Display device parameters

  ## Fields

  |                            |                                            |
  | -------------------------- | ------------------------------------------ |
  | `h_resolution`             | Horizontal resolution in pixels            |
  | `v_resolution`             | Vertical resolution in pixels              |
  | `h_screen_size`            | Horizontal size in meters                  |
  | `v_screen_size`            | Vertical size in meters                    |
  | `eye_to_screen_distance`   | Distance between eye and display in meters |
  | `lens_separation_distance` | Lens separation distance in meters         |
  | `interpupillary_distance`  | IPD (distance between pupils) in meters    |
  | `lens_distortion_values`   | Lens distortion constant parameters        |
  | `chroma_ab_correction`     | Chromatic aberration correction parameters |
  """

  require Record

  @type t ::
          record(:t,
            h_resolution: number,
            v_resolution: number,
            h_screen_size: number,
            v_screen_size: number,
            eye_to_screen_distance: number,
            lens_separation_distance: number,
            interpupillary_distance: number,
            lens_distortion_values: [number],
            chroma_ab_correction: [number]
          )

  Record.defrecord(:t, :vr_device_info,
    h_resolution: 0,
    v_resolution: 0,
    h_screen_size: 0.0,
    v_screen_size: 0.0,
    eye_to_screen_distance: 0.0,
    lens_separation_distance: 0.0,
    interpupillary_distance: 0.0,
    lens_distortion_values: [],
    chroma_ab_correction: []
  )

  use Zexray.Type.TypeBase, prefix: "vr_device_info"

  @type t_all :: t | t_resource
end
