defmodule Zexray.NIF.Shader do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_shader [
        # Shader
        shader_get_max_locations: 0
      ]

      ############
      #  Shader  #
      ############

      @doc """
      Get shader max locations for Shader.locs

      ```c
      // config.h
      RL_MAX_SHADER_LOCATIONS
      ```
      """
      @doc group: :shader
      @spec shader_get_max_locations() :: non_neg_integer
      def shader_get_max_locations(), do: :erlang.nif_error(:undef)
    end
  end
end
