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

  #################
  #  File system  #
  #################

  @doc """
  Check if a file has been dropped into window
  """
  @spec file_dropped?() :: boolean
  def file_dropped?() do
    NIF.is_file_dropped()
  end

  @doc """
  Load dropped filepaths
  """
  @spec get_dropped_files() :: [binary]
  def get_dropped_files() do
    NIF.load_dropped_files()
  end
end
