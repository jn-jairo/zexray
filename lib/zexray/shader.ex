defmodule Zexray.Shader do
  alias Zexray.NIF

  @doc """
  Get shader max locations for Shader.locs
  """
  @spec max_locations() :: non_neg_integer
  def max_locations() do
    NIF.shader_get_max_locations()
  end
end
