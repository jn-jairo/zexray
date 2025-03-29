defmodule Zexray.NIF.Cursor do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_cursor [
        # Cursor
        show_cursor: 0,
        hide_cursor: 0,
        is_cursor_hidden: 0,
        enable_cursor: 0,
        disable_cursor: 0,
        is_cursor_on_screen: 0
      ]

      ############
      #  Cursor  #
      ############

      @doc """
      Shows cursor

      ```c
      // raylib.h
      RLAPI void ShowCursor(void);
      ```
      """
      @doc group: :cursor
      @spec show_cursor() :: :ok
      def show_cursor(), do: :erlang.nif_error(:undef)

      @doc """
      Hides cursor

      ```c
      // raylib.h
      RLAPI void HideCursor(void);
      ```
      """
      @doc group: :cursor
      @spec hide_cursor() :: :ok
      def hide_cursor(), do: :erlang.nif_error(:undef)

      @doc """
      Check if cursor is not visible

      ```c
      // raylib.h
      RLAPI bool IsCursorHidden(void);
      ```
      """
      @doc group: :cursor
      @spec is_cursor_hidden() :: boolean
      def is_cursor_hidden(), do: :erlang.nif_error(:undef)

      @doc """
      Enables cursor (unlock cursor)

      ```c
      // raylib.h
      RLAPI void EnableCursor(void);
      ```
      """
      @doc group: :cursor
      @spec enable_cursor() :: :ok
      def enable_cursor(), do: :erlang.nif_error(:undef)

      @doc """
      Disables cursor (lock cursor)

      ```c
      // raylib.h
      RLAPI void DisableCursor(void);
      ```
      """
      @doc group: :cursor
      @spec disable_cursor() :: :ok
      def disable_cursor(), do: :erlang.nif_error(:undef)

      @doc """
      Check if cursor is on the screen

      ```c
      // raylib.h
      RLAPI bool IsCursorOnScreen(void);
      ```
      """
      @doc group: :cursor
      @spec is_cursor_on_screen() :: boolean
      def is_cursor_on_screen(), do: :erlang.nif_error(:undef)
    end
  end
end
