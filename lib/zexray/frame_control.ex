defmodule Zexray.FrameControl do
  alias Zexray.NIF

  ###################
  #  Frame control  #
  ###################

  @doc """
  Swap back buffer with front buffer (screen drawing)
  """
  @spec swap_screen_buffer() :: :ok
  def swap_screen_buffer() do
    NIF.swap_screen_buffer()
  end

  @doc """
  Register all input events
  """
  @spec poll_input_events() :: :ok
  def poll_input_events() do
    NIF.poll_input_events()
  end

  @doc """
  Wait for some time (halt program execution)
  """
  @spec wait_time(seconds :: float) :: :ok
  def wait_time(seconds) do
    NIF.wait_time(seconds)
  end
end
