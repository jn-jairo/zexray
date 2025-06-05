defmodule Zexray.NIF.Vr do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_vr [
        # VrStereoConfig
        load_vr_stereo_config: 1,
        load_vr_stereo_config: 2
      ]

      ####################
      #  VrStereoConfig  #
      ####################

      @doc """
      Load VR stereo config for VR simulator device parameters

      ```c
      // raylib.h
      RLAPI VrStereoConfig LoadVrStereoConfig(VrDeviceInfo device);
      ```
      """
      @doc group: :vr
      @spec load_vr_stereo_config(
              device :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def load_vr_stereo_config(
            _device,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)
    end
  end
end
