defmodule Zexray.Mesh do
  alias Zexray.NIF

  @doc """
  Get mesh max vertex buffers for Mesh.vbo_id
  """
  @spec max_vertex_buffers() :: integer
  def max_vertex_buffers() do
    NIF.mesh_get_max_vertex_buffers()
  end
end
