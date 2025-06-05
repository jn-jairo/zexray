defmodule Zexray.NIF.FileSystem do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_file_system [
        # File system
        is_file_dropped: 0,
        load_dropped_files: 0
      ]

      #################
      #  File system  #
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
