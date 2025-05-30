defmodule Zexray.Material do
  @moduledoc """
  Material
  """

  alias Zexray.NIF

  @doc """
  Get material max maps for Material.maps
  """
  @spec max_maps() :: non_neg_integer
  defdelegate max_maps(), to: NIF, as: :material_get_max_maps

  @doc """
  Get material max params for Material.params
  """
  @spec max_params() :: non_neg_integer
  defdelegate max_params(), to: NIF, as: :material_get_max_params
end
