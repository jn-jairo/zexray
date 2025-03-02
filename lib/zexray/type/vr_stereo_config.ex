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

  defstruct projection: [],
            view_offset: [],
            left_lens_center: [],
            right_lens_center: [],
            left_screen_center: [],
            right_screen_center: [],
            scale: [],
            scale_in: []

  use Zexray.Type.TypeBase, prefix: "vr_stereo_config"

  @type t ::
          %__MODULE__{
            projection: [Zexray.Type.Matrix.t_nif()],
            view_offset: [Zexray.Type.Matrix.t_nif()],
            left_lens_center: [float],
            right_lens_center: [float],
            left_screen_center: [float],
            right_screen_center: [float],
            scale: [float],
            scale_in: [float]
          }

  @type t_all ::
          t
          | {
              [Zexray.Type.Matrix.t_all()],
              [Zexray.Type.Matrix.t_all()],
              [float],
              [float],
              [float],
              [float],
              [float],
              [float]
            }
          | map
          | keyword
          | Resource.t()

  import Zexray.Guard

  @doc """
  Creates a new `t:t/0`.
  """
  def new(vr_stereo_config)

  @spec new({
          projection :: [Zexray.Type.Matrix.t_all()],
          view_offset :: [Zexray.Type.Matrix.t_all()],
          left_lens_center :: [float],
          right_lens_center :: [float],
          left_screen_center :: [float],
          right_screen_center :: [float],
          scale :: [float],
          scale_in :: [float]
        }) :: t()
  def new({
        projection,
        view_offset,
        left_lens_center,
        right_lens_center,
        left_screen_center,
        right_screen_center,
        scale,
        scale_in
      })
      when is_list(projection) and (projection == [] or is_like_matrix(hd(projection))) and
             is_list(view_offset) and (view_offset == [] or is_like_matrix(hd(view_offset))) and
             is_list(left_lens_center) and
             (left_lens_center == [] or is_float(hd(left_lens_center))) and
             is_list(right_lens_center) and
             (right_lens_center == [] or is_float(hd(right_lens_center))) and
             is_list(left_screen_center) and
             (left_screen_center == [] or is_float(hd(left_screen_center))) and
             is_list(right_screen_center) and
             (right_screen_center == [] or is_float(hd(right_screen_center))) and
             is_list(scale) and (scale == [] or is_float(hd(scale))) and
             is_list(scale_in) and (scale_in == [] or is_float(hd(scale_in))) do
    new(
      projection: projection,
      view_offset: view_offset,
      left_lens_center: left_lens_center,
      right_lens_center: right_lens_center,
      left_screen_center: left_screen_center,
      right_screen_center: right_screen_center,
      scale: scale,
      scale_in: scale_in
    )
  end

  @spec new(vr_stereo_config :: struct) :: t()
  def new(vr_stereo_config) when is_struct(vr_stereo_config) do
    vr_stereo_config =
      if String.ends_with?(Atom.to_string(vr_stereo_config.__struct__), ".Resource") do
        apply(vr_stereo_config.__struct__, :content, [vr_stereo_config])
      else
        vr_stereo_config
      end

    case vr_stereo_config do
      %__MODULE__{} = vr_stereo_config -> vr_stereo_config
      _ -> new(Map.from_struct(vr_stereo_config))
    end
  end

  @spec new(fields :: Enumerable.t()) :: t()
  def new(fields) do
    if Enumerable.impl_for(fields) != nil do
      struct!(
        __MODULE__,
        fields
        |> Enum.map(fn {key, value} ->
          value =
            cond do
              is_nil(value) ->
                value

              key in [:projection, :view_offset] and is_list(value) ->
                Enum.map(value, fn v ->
                  cond do
                    is_struct(v, Zexray.Type.Matrix.Resource) -> v
                    is_reference(v) -> Zexray.Type.Matrix.Resource.new(v)
                    true -> Zexray.Type.Matrix.new(v)
                  end
                end)

              true ->
                value
            end

          {key, value}
        end)
      )
    else
      raise_argument_error(fields)
    end
  end
end
