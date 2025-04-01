defmodule Zexray.NIF.FileSystem do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_file_system [
        # FilePathList
        file_path_list_get_max_filepath_capacity: 0,
        file_path_list_get_max_filepath_length: 0,
        is_file_dropped: 0,
        load_dropped_files: 0
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

      #################
      #  File System  #
      #################

      @doc """
      Check if a file has been dropped into window

      ```c
      // raylib.h
      RLAPI bool IsFileDropped(void);
      ```
      """
      @doc group: :file_system
      @spec is_file_dropped() :: boolean
      def is_file_dropped(), do: :erlang.nif_error(:undef)

      @doc """
      Load dropped filepaths

      ```c
      // raylib.h
      RLAPI FilePathList LoadDroppedFiles(void);
      ```
      """
      @doc group: :file_system
      @spec load_dropped_files() :: [binary]
      def load_dropped_files(), do: :erlang.nif_error(:undef)
    end
  end
end
