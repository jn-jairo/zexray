defmodule Zexray.NIF.Vr do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_vr [
        # VrDeviceInfo
        vr_device_info_get_max_lens_distortion_values: 0,
        vr_device_info_get_max_chroma_ab_correction: 0,

        # VrStereoConfig
        vr_stereo_config_get_max_projection: 0,
        vr_stereo_config_get_max_view_offset: 0,
        vr_stereo_config_get_max_left_lens_center: 0,
        vr_stereo_config_get_max_right_lens_center: 0,
        vr_stereo_config_get_max_left_screen_center: 0,
        vr_stereo_config_get_max_right_screen_center: 0,
        vr_stereo_config_get_max_scale: 0,
        vr_stereo_config_get_max_scale_in: 0,
        load_vr_stereo_config: 1,
        load_vr_stereo_config: 2
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

      ####################
      #  VrStereoConfig  #
      ####################

      @doc """
      Get vr stereo config max projection for VrStereoConfig.projection
      """
      @doc group: :vr
      @spec vr_stereo_config_get_max_projection() :: non_neg_integer
      def vr_stereo_config_get_max_projection(), do: :erlang.nif_error(:undef)

      @doc """
      Get vr stereo config max view offset for VrStereoConfig.viewOffset
      """
      @doc group: :vr
      @spec vr_stereo_config_get_max_view_offset() :: non_neg_integer
      def vr_stereo_config_get_max_view_offset(), do: :erlang.nif_error(:undef)

      @doc """
      Get vr stereo config max left lens center for VrStereoConfig.leftLensCenter
      """
      @doc group: :vr
      @spec vr_stereo_config_get_max_left_lens_center() :: non_neg_integer
      def vr_stereo_config_get_max_left_lens_center(), do: :erlang.nif_error(:undef)

      @doc """
      Get vr stereo config max right lens center for VrStereoConfig.rightLensCenter
      """
      @doc group: :vr
      @spec vr_stereo_config_get_max_right_lens_center() :: non_neg_integer
      def vr_stereo_config_get_max_right_lens_center(), do: :erlang.nif_error(:undef)

      @doc """
      Get vr stereo config max left screen center for VrStereoConfig.leftScreenCenter
      """
      @doc group: :vr
      @spec vr_stereo_config_get_max_left_screen_center() :: non_neg_integer
      def vr_stereo_config_get_max_left_screen_center(), do: :erlang.nif_error(:undef)

      @doc """
      Get vr stereo config max right screen center for VrStereoConfig.rightScreenCenter
      """
      @doc group: :vr
      @spec vr_stereo_config_get_max_right_screen_center() :: non_neg_integer
      def vr_stereo_config_get_max_right_screen_center(), do: :erlang.nif_error(:undef)

      @doc """
      Get vr stereo config max scale for VrStereoConfig.scale
      """
      @doc group: :vr
      @spec vr_stereo_config_get_max_scale() :: non_neg_integer
      def vr_stereo_config_get_max_scale(), do: :erlang.nif_error(:undef)

      @doc """
      Get vr stereo config max scale in for VrStereoConfig.scaleIn
      """
      @doc group: :vr
      @spec vr_stereo_config_get_max_scale_in() :: non_neg_integer
      def vr_stereo_config_get_max_scale_in(), do: :erlang.nif_error(:undef)

      @doc """
      Load VR stereo config for VR simulator device parameters

      ```c
      // raylib.h
      RLAPI VrStereoConfig LoadVrStereoConfig(VrDeviceInfo device);
      ```
      """
      @doc group: :vr
      @spec load_vr_stereo_config(
              device :: map | reference,
              return :: :value | :resource
            ) :: map | reference
      def load_vr_stereo_config(
            _device,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)
    end
  end
end
