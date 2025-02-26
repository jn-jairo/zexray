defmodule Zexray.Vr do
  alias Zexray.NIF

  ##################
  #  VrDeviceInfo  #
  ##################

  @doc """
  Get vr device info max lens distortion values for VrDeviceInfo.lensDistortionValues
  """
  @spec vr_device_info_max_lens_distortion_values() :: non_neg_integer
  def vr_device_info_max_lens_distortion_values() do
    NIF.vr_device_info_get_max_lens_distortion_values()
  end

  @doc """
  Get vr device info max chroma ab correction for VrDeviceInfo.chromaAbCorrection
  """
  @spec vr_device_info_max_chroma_ab_correction() :: non_neg_integer
  def vr_device_info_max_chroma_ab_correction() do
    NIF.vr_device_info_get_max_chroma_ab_correction()
  end

  ####################
  #  VrStereoConfig  #
  ####################

  @doc """
  Get vr stereo config max projection for VrStereoConfig.projection
  """
  @spec vr_stereo_config_max_projection() :: non_neg_integer
  def vr_stereo_config_max_projection() do
    NIF.vr_stereo_config_get_max_projection()
  end

  @doc """
  Get vr stereo config max view offset for VrStereoConfig.viewOffset
  """
  @spec vr_stereo_config_max_view_offset() :: non_neg_integer
  def vr_stereo_config_max_view_offset() do
    NIF.vr_stereo_config_get_max_view_offset()
  end

  @doc """
  Get vr stereo config max left lens center for VrStereoConfig.leftLensCenter
  """
  @spec vr_stereo_config_max_left_lens_center() :: non_neg_integer
  def vr_stereo_config_max_left_lens_center() do
    NIF.vr_stereo_config_get_max_left_lens_center()
  end

  @doc """
  Get vr stereo config max right lens center for VrStereoConfig.rightLensCenter
  """
  @spec vr_stereo_config_max_right_lens_center() :: non_neg_integer
  def vr_stereo_config_max_right_lens_center() do
    NIF.vr_stereo_config_get_max_right_lens_center()
  end

  @doc """
  Get vr stereo config max left screen center for VrStereoConfig.leftScreenCenter
  """
  @spec vr_stereo_config_max_left_screen_center() :: non_neg_integer
  def vr_stereo_config_max_left_screen_center() do
    NIF.vr_stereo_config_get_max_left_screen_center()
  end

  @doc """
  Get vr stereo config max right screen center for VrStereoConfig.rightScreenCenter
  """
  @spec vr_stereo_config_max_right_screen_center() :: non_neg_integer
  def vr_stereo_config_max_right_screen_center() do
    NIF.vr_stereo_config_get_max_right_screen_center()
  end

  @doc """
  Get vr stereo config max scale for VrStereoConfig.scale
  """
  @spec vr_stereo_config_max_scale() :: non_neg_integer
  def vr_stereo_config_max_scale() do
    NIF.vr_stereo_config_get_max_scale()
  end

  @doc """
  Get vr stereo config max scale in for VrStereoConfig.scaleIn
  """
  @spec vr_stereo_config_max_scale_in() :: non_neg_integer
  def vr_stereo_config_max_scale_in() do
    NIF.vr_stereo_config_get_max_scale_in()
  end
end
