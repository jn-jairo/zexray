defmodule Zexray.Vr do
  @moduledoc """
  VR
  """

  alias Zexray.NIF

  ##################
  #  VrDeviceInfo  #
  ##################

  @doc """
  Get vr device info max lens distortion values for VrDeviceInfo.lensDistortionValues
  """
  @spec vr_device_info_max_lens_distortion_values() :: non_neg_integer
  defdelegate vr_device_info_max_lens_distortion_values(),
    to: NIF,
    as: :vr_device_info_get_max_lens_distortion_values

  @doc """
  Get vr device info max chroma ab correction for VrDeviceInfo.chromaAbCorrection
  """
  @spec vr_device_info_max_chroma_ab_correction() :: non_neg_integer
  defdelegate vr_device_info_max_chroma_ab_correction(),
    to: NIF,
    as: :vr_device_info_get_max_chroma_ab_correction

  ####################
  #  VrStereoConfig  #
  ####################

  @doc """
  Get vr stereo config max projection for VrStereoConfig.projection
  """
  @spec vr_stereo_config_max_projection() :: non_neg_integer
  defdelegate vr_stereo_config_max_projection(), to: NIF, as: :vr_stereo_config_get_max_projection

  @doc """
  Get vr stereo config max view offset for VrStereoConfig.viewOffset
  """
  @spec vr_stereo_config_max_view_offset() :: non_neg_integer
  defdelegate vr_stereo_config_max_view_offset(),
    to: NIF,
    as: :vr_stereo_config_get_max_view_offset

  @doc """
  Get vr stereo config max left lens center for VrStereoConfig.leftLensCenter
  """
  @spec vr_stereo_config_max_left_lens_center() :: non_neg_integer
  defdelegate vr_stereo_config_max_left_lens_center(),
    to: NIF,
    as: :vr_stereo_config_get_max_left_lens_center

  @doc """
  Get vr stereo config max right lens center for VrStereoConfig.rightLensCenter
  """
  @spec vr_stereo_config_max_right_lens_center() :: non_neg_integer
  defdelegate vr_stereo_config_max_right_lens_center(),
    to: NIF,
    as: :vr_stereo_config_get_max_right_lens_center

  @doc """
  Get vr stereo config max left screen center for VrStereoConfig.leftScreenCenter
  """
  @spec vr_stereo_config_max_left_screen_center() :: non_neg_integer
  defdelegate vr_stereo_config_max_left_screen_center(),
    to: NIF,
    as: :vr_stereo_config_get_max_left_screen_center

  @doc """
  Get vr stereo config max right screen center for VrStereoConfig.rightScreenCenter
  """
  @spec vr_stereo_config_max_right_screen_center() :: non_neg_integer
  defdelegate vr_stereo_config_max_right_screen_center(),
    to: NIF,
    as: :vr_stereo_config_get_max_right_screen_center

  @doc """
  Get vr stereo config max scale for VrStereoConfig.scale
  """
  @spec vr_stereo_config_max_scale() :: non_neg_integer
  defdelegate vr_stereo_config_max_scale(), to: NIF, as: :vr_stereo_config_get_max_scale

  @doc """
  Get vr stereo config max scale in for VrStereoConfig.scaleIn
  """
  @spec vr_stereo_config_max_scale_in() :: non_neg_integer
  defdelegate vr_stereo_config_max_scale_in(), to: NIF, as: :vr_stereo_config_get_max_scale_in

  @doc """
  Load VR stereo config for VR simulator device parameters
  """
  @spec load_vr_stereo_config(
          device :: Zexray.Type.VrDeviceInfo.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.VrStereoConfig.t_nif()
  defdelegate load_vr_stereo_config(
                device,
                return \\ :auto
              ),
              to: NIF,
              as: :load_vr_stereo_config
end
