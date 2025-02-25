defmodule Zexray.Vr do
  alias Zexray.NIF

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
end
