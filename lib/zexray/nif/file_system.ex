defmodule Zexray.NIF.FileSystem do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_file_system [
        # FilePathList
        file_path_list_get_max_filepath_capacity: 0,
        file_path_list_get_max_filepath_length: 0
      ]

      ##################
      #  FilePathList  #
      ##################

      @doc """
      Get file path list max filepath capacity for FilePathList.paths
      """
      @doc group: :file_system
      @spec file_path_list_get_max_filepath_capacity() :: non_neg_integer
      def file_path_list_get_max_filepath_capacity(), do: :erlang.nif_error(:undef)

      @doc """
      Get file path list max filepath length for FilePathList.paths
      """
      @doc group: :file_system
      @spec file_path_list_get_max_filepath_length() :: non_neg_integer
      def file_path_list_get_max_filepath_length(), do: :erlang.nif_error(:undef)
    end
  end
end
