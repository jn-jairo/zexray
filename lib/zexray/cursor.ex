defmodule Zexray.Cursor do
  alias Zexray.NIF

  ############
  #  Cursor  #
  ############

  @doc """
  Shows cursor
  """
  @spec show_cursor() :: :ok
  def show_cursor() do
    NIF.show_cursor()
  end

  @doc """
  Hides cursor
  """
  @spec hide_cursor() :: :ok
  def hide_cursor() do
    NIF.hide_cursor()
  end

  @doc """
  Check if cursor is not visible
  """
  @spec cursor_hidden?() :: boolean
  def cursor_hidden?() do
    NIF.is_cursor_hidden()
  end

  @doc """
  Enables cursor (unlock cursor)
  """
  @spec enable_cursor() :: :ok
  def enable_cursor() do
    NIF.enable_cursor()
  end

  @doc """
  Disables cursor (lock cursor)
  """
  @spec disable_cursor() :: :ok
  def disable_cursor() do
    NIF.disable_cursor()
  end

  @doc """
  Check if cursor is on the screen
  """
  @spec cursor_on_screen?() :: boolean
  def cursor_on_screen?() do
    NIF.is_cursor_on_screen()
  end
end
