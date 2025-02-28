defmodule Zexray.FileSystem do
  alias Zexray.NIF

  ##################
  #  FilePathList  #
  ##################

  @doc """
  Get file path list max filepath capacity for FilePathList.paths
  """
  @spec file_path_list_max_filepath_capacity() :: non_neg_integer
  def file_path_list_max_filepath_capacity() do
    NIF.file_path_list_get_max_filepath_capacity()
  end

  @doc """
  Get file path list max filepath length for FilePathList.paths
  """
  @spec file_path_list_max_filepath_length() :: non_neg_integer
  def file_path_list_max_filepath_length() do
    NIF.file_path_list_get_max_filepath_length()
  end
end
