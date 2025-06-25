defmodule Zexray.FrameControl do
  @moduledoc """
  Frame Control
  """

  alias Zexray.NIF

  ###################
  #  Frame control  #
  ###################

  @doc """
  Swap back buffer with front buffer (screen drawing)
  """
  @spec swap_screen_buffer() :: :ok
  defdelegate swap_screen_buffer(), to: NIF, as: :swap_screen_buffer

  @doc """
  Register all input events
  """
  @spec poll_input_events() :: :ok
  defdelegate poll_input_events(), to: NIF, as: :poll_input_events

  @doc """
  Wait for some time (halt program execution)
  """
  @spec wait_time(seconds :: number) :: :ok
  defdelegate wait_time(seconds), to: NIF, as: :wait_time
end
