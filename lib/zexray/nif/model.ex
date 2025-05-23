defmodule Zexray.NIF.Model do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_model [
        # BoneInfo
        bone_info_get_max_name: 0,
        # ModelAnimation
        model_animation_get_max_name: 0
      ]

      ##############
      #  BoneInfo  #
      ##############

      @doc """
      Get bone info max name for BoneInfo.name
      """
      @doc group: :model
      @spec bone_info_get_max_name() :: non_neg_integer
      def bone_info_get_max_name(), do: :erlang.nif_error(:undef)

      ####################
      #  ModelAnimation  #
      ####################

      @doc """
      Get model animation max name for ModelAnimation.name
      """
      @doc group: :model
      @spec model_animation_get_max_name() :: non_neg_integer
      def model_animation_get_max_name(), do: :erlang.nif_error(:undef)
    end
  end
end
