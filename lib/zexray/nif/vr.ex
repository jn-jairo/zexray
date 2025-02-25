defmodule Zexray.NIF.Vr do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_vr [
        # VrDeviceInfo
        vr_device_info_get_max_lens_distortion_values: 0,
        vr_device_info_get_max_chroma_ab_correction: 0
      ]

      ##################
      #  VrDeviceInfo  #
      ##################

      @doc """
      Get vr device info max lens distortion values for VrDeviceInfo.lensDistortionValues
      """
      @doc group: :vr
      @spec vr_device_info_get_max_lens_distortion_values() :: non_neg_integer
      def vr_device_info_get_max_lens_distortion_values(), do: :erlang.nif_error(:undef)

      @doc """
      Get vr device info max chroma ab correction for VrDeviceInfo.chromaAbCorrection
      """
      @doc group: :vr
      @spec vr_device_info_get_max_chroma_ab_correction() :: non_neg_integer
      def vr_device_info_get_max_chroma_ab_correction(), do: :erlang.nif_error(:undef)
    end
  end
end
