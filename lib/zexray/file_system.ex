defmodule Zexray.FileSystem do
  @moduledoc """
  File System
  """

  alias Zexray.NIF

  #################
  #  File system  #
  #################

  @doc """
  Check if a file has been dropped into window
  """
  @spec file_dropped?() :: boolean
  defdelegate file_dropped?(), to: NIF, as: :is_file_dropped

  @doc """
  Load dropped filepaths
  """
  @spec get_dropped_files() :: [binary]
  defdelegate get_dropped_files(), to: NIF, as: :load_dropped_files
end
