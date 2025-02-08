defmodule Zexray.Material do
  alias Zexray.NIF

  @doc """
  Get material max maps for Material.maps
  """
  @spec max_maps() :: integer
  def max_maps() do
    NIF.material_get_max_maps()
  end

  @doc """
  Get material max params for Material.params
  """
  @spec max_params() :: integer
  def max_params() do
    NIF.material_get_max_params()
  end
end
