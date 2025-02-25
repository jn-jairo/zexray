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

  defstruct h_resolution: 0,
            v_resolution: 0,
            h_screen_size: 0.0,
            v_screen_size: 0.0,
            eye_to_screen_distance: 0.0,
            lens_separation_distance: 0.0,
            interpupillary_distance: 0.0,
            lens_distortion_values: [],
            chroma_ab_correction: []

  use Zexray.Type.TypeBase, prefix: "vr_device_info"

  @type t ::
          %__MODULE__{
            h_resolution: integer,
            v_resolution: integer,
            h_screen_size: float,
            v_screen_size: float,
            eye_to_screen_distance: float,
            lens_separation_distance: float,
            interpupillary_distance: float,
            lens_distortion_values: [float],
            chroma_ab_correction: [float]
          }

  @type t_all ::
          t
          | {
              integer,
              integer,
              float,
              float,
              float,
              float,
              float,
              [float],
              [float]
            }
          | map
          | keyword
          | Resource.t()

  @doc """
  Creates a new `t:t/0`.
  """
  def new(vr_device_info)

  @spec new({
          h_resolution :: integer,
          v_resolution :: integer,
          h_screen_size :: float,
          v_screen_size :: float,
          eye_to_screen_distance :: float,
          lens_separation_distance :: float,
          interpupillary_distance :: float,
          lens_distortion_values :: [float],
          chroma_ab_correction :: [float]
        }) :: t()
  def new({
        h_resolution,
        v_resolution,
        h_screen_size,
        v_screen_size,
        eye_to_screen_distance,
        lens_separation_distance,
        interpupillary_distance,
        lens_distortion_values,
        chroma_ab_correction
      })
      when is_integer(h_resolution) and
             is_integer(v_resolution) and
             is_float(h_screen_size) and
             is_float(v_screen_size) and
             is_float(eye_to_screen_distance) and
             is_float(lens_separation_distance) and
             is_float(interpupillary_distance) and
             is_list(lens_distortion_values) and
             (lens_distortion_values == [] or is_float(hd(lens_distortion_values))) and
             is_list(chroma_ab_correction) and
             (chroma_ab_correction == [] or is_float(hd(chroma_ab_correction))) do
    new(
      h_resolution: h_resolution,
      v_resolution: v_resolution,
      h_screen_size: h_screen_size,
      v_screen_size: v_screen_size,
      eye_to_screen_distance: eye_to_screen_distance,
      lens_separation_distance: lens_separation_distance,
      interpupillary_distance: interpupillary_distance,
      lens_distortion_values: lens_distortion_values,
      chroma_ab_correction: chroma_ab_correction
    )
  end

  @spec new(vr_device_info :: struct) :: t()
  def new(vr_device_info) when is_struct(vr_device_info) do
    vr_device_info =
      if String.ends_with?(Atom.to_string(vr_device_info.__struct__), ".Resource") do
        apply(vr_device_info.__struct__, :content, [vr_device_info])
      else
        vr_device_info
      end

    case vr_device_info do
      %__MODULE__{} = vr_device_info -> vr_device_info
      _ -> new(Map.from_struct(vr_device_info))
    end
  end

  @spec new(fields :: Enumerable.t()) :: t()
  def new(fields) do
    if Enumerable.impl_for(fields) != nil do
      struct!(
        __MODULE__,
        fields
      )
    else
      raise_argument_error(fields)
    end
  end
end
