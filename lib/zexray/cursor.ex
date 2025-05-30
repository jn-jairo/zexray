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
  @spec show_cursor() :: :ok
  defdelegate show_cursor(), to: NIF, as: :show_cursor

  @doc """
  Hides cursor
  """
  @spec hide_cursor() :: :ok
  defdelegate hide_cursor(), to: NIF, as: :hide_cursor

  @doc """
  Check if cursor is not visible
  """
  @spec cursor_hidden?() :: boolean
  defdelegate cursor_hidden?(), to: NIF, as: :is_cursor_hidden

  @doc """
  Enables cursor (unlock cursor)
  """
  @spec enable_cursor() :: :ok
  defdelegate enable_cursor(), to: NIF, as: :enable_cursor

  @doc """
  Disables cursor (lock cursor)
  """
  @spec disable_cursor() :: :ok
  defdelegate disable_cursor(), to: NIF, as: :disable_cursor

  @doc """
  Check if cursor is on the screen
  """
  @spec cursor_on_screen?() :: boolean
  defdelegate cursor_on_screen?(), to: NIF, as: :is_cursor_on_screen
end
