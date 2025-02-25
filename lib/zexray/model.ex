defmodule Zexray.Model do
  alias Zexray.NIF

  @doc """
  Get bone info max name for BoneInfo.name
  """
  @spec bone_info_max_name() :: non_neg_integer
  def bone_info_max_name() do
    NIF.bone_info_get_max_name()
  end

  @doc """
  Get model animation max name for ModelAnimation.name
  """
  @spec model_animation_max_name() :: non_neg_integer
  def model_animation_max_name() do
    NIF.model_animation_get_max_name()
  end
end
