defmodule Zexray.Model do
  alias Zexray.NIF

  @doc """
  Get bone info max name for BoneInfo.name
  """
  @spec bone_info_max_name() :: integer
  def bone_info_max_name() do
    NIF.bone_info_get_max_name()
  end
end
