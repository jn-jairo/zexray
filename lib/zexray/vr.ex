defmodule Zexray.Vr do
  @moduledoc """
  VR
  """

  alias Zexray.NIF

  ####################
  #  VrStereoConfig  #
  ####################

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
