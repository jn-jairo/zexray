defmodule Zexray.NIF.Mesh do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_mesh [
        # Mesh
        mesh_get_max_vertex_buffers: 0
      ]

      ##########
      #  Mesh  #
      ##########

      @doc """
      Get mesh max vertex buffers for Mesh.vbo_id

      ```c
      // config.h
      MAX_MESH_VERTEX_BUFFERS
      ```
      """
      @doc group: :mesh
      @spec mesh_get_max_vertex_buffers() :: integer
      def mesh_get_max_vertex_buffers(), do: :erlang.nif_error(:undef)
    end
  end
end
