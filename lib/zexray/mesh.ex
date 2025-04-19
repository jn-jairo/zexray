defmodule Zexray.Mesh do
  @moduledoc """
  Mesh
  """

  alias Zexray.NIF

  @doc """
  Get mesh max vertex buffers for Mesh.vbo_id
  """
  @spec max_vertex_buffers() :: non_neg_integer
  def max_vertex_buffers() do
    NIF.mesh_get_max_vertex_buffers()
  end
end
