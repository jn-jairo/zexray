defmodule Zexray.Cursor do
  @moduledoc """
  Cursor
  """

  alias Zexray.NIF

  ############
  #  Cursor  #
  ############

  @doc """
  Shows cursor
  """
  @spec show() :: :ok
  defdelegate show(), to: NIF, as: :show_cursor

  @doc """
  Hides cursor
  """
  @spec hide() :: :ok
  defdelegate hide(), to: NIF, as: :hide_cursor

  @doc """
  Check if cursor is not visible
  """
  @spec hidden?() :: boolean
  defdelegate hidden?(), to: NIF, as: :is_cursor_hidden

  @doc """
  Enables cursor (unlock cursor)
  """
  @spec enable() :: :ok
  defdelegate enable(), to: NIF, as: :enable_cursor

  @doc """
  Disables cursor (lock cursor)
  """
  @spec disable() :: :ok
  defdelegate disable(), to: NIF, as: :disable_cursor

  @doc """
  Check if cursor is on the screen
  """
  @spec on_screen?() :: boolean
  defdelegate on_screen?(), to: NIF, as: :is_cursor_on_screen
end
