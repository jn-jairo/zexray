defmodule Zexray.NIF.Font do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_font [
        # Font loading
        load_font: 1,
        load_font: 2
      ]

      ##################
      #  Font loading  #
      ##################

      @doc """
      Load font from file into GPU memory (VRAM)

      ```c
      // raylib.h
      RLAPI Font LoadFont(const char *fileName);
      ```
      """
      @doc group: :font_loading
      @spec load_font(
              file_name :: String.t(),
              return :: :value | :resource
            ) :: map | reference
      def load_font(_file_name, _return \\ :value),
        do: :erlang.nif_error(:undef)
    end
  end
end
