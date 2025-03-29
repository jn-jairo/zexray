defmodule Zexray.Timing do
  alias Zexray.NIF

  ############
  #  Timing  #
  ############

  @doc """
  Set target FPS (maximum)
  """
  @spec set_target_fps(fps :: integer) :: :ok
  def set_target_fps(fps)
      when is_integer(fps) do
    NIF.set_target_fps(fps)
  end

  @doc """
  Get time in seconds for last frame drawn (delta time)
  """
  @spec get_frame_time() :: float
  def get_frame_time() do
    NIF.get_frame_time()
  end

  @doc """
  Get elapsed time in seconds since InitWindow()
  """
  @spec get_time() :: float
  def get_time() do
    NIF.get_time()
  end

  @doc """
  Get current FPS
  """
  @spec get_fps() :: integer
  def get_fps() do
    NIF.get_fps()
  end
end
