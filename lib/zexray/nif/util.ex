defmodule Zexray.NIF.Util do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_util [
        # Util
        open_url: 1
      ]

      ##########
      #  Util  #
      ##########

      @doc """
      Open URL with default system browser (if available)

      ```c
      // raylib.h
      RLAPI void OpenURL(const char *url);
      ```
      """
      @doc group: :util
      @spec open_url(url :: binary) :: :ok
      def open_url(_url), do: :erlang.nif_error(:undef)
    end
  end
end
