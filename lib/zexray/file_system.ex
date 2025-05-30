defmodule Zexray.FileSystem do
  @moduledoc """
  File System
  """

  alias Zexray.NIF

  ##################
  #  FilePathList  #
  ##################

  @doc """
  Get file path list max filepath capacity for FilePathList.paths
  """
  @spec file_path_list_max_filepath_capacity() :: non_neg_integer
  defdelegate file_path_list_max_filepath_capacity(),
    to: NIF,
    as: :file_path_list_get_max_filepath_capacity

  @doc """
  Get file path list max filepath length for FilePathList.paths
  """
  @spec file_path_list_max_filepath_length() :: non_neg_integer
  defdelegate file_path_list_max_filepath_length(),
    to: NIF,
    as: :file_path_list_get_max_filepath_length

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
