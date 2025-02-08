defmodule Zexray.NIF.Material do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_material [
        # Material
        material_get_max_maps: 0,
        material_get_max_params: 0
      ]

      ##############
      #  Material  #
      ##############

      @doc """
      Get material max maps for Material.maps

      ```c
      // config.h
      MAX_MATERIAL_MAPS
      ```
      """
      @doc group: :material
      @spec material_get_max_maps() :: integer
      def material_get_max_maps(), do: :erlang.nif_error(:undef)

      @doc """
      Get material max params for Material.params
      """
      @doc group: :material
      @spec material_get_max_params() :: integer
      def material_get_max_params(), do: :erlang.nif_error(:undef)
    end
  end
end
