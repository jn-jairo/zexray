defmodule Zexray.Model do
  @moduledoc """
  Model
  """

  alias Zexray.NIF

  @doc """
  Get bone info max name for BoneInfo.name
  """
  @spec bone_info_max_name() :: non_neg_integer
  defdelegate bone_info_max_name(), to: NIF, as: :bone_info_get_max_name

  @doc """
  Get model animation max name for ModelAnimation.name
  """
  @spec model_animation_max_name() :: non_neg_integer
  defdelegate model_animation_max_name(), to: NIF, as: :model_animation_get_max_name
end
