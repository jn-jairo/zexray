defmodule Zexray.Timing do
  @moduledoc """
  Timing
  """

  alias Zexray.NIF

  ############
  #  Timing  #
  ############

  @doc """
  Set target FPS (maximum)
  """
  @spec set_target_fps(fps :: number) :: :ok
  defdelegate set_target_fps(fps), to: NIF, as: :set_target_fps

  @doc """
  Get time in seconds for last frame drawn (delta time)
  """
  @spec get_frame_time() :: float
  defdelegate get_frame_time(), to: NIF, as: :get_frame_time

  @doc """
  Get elapsed time in seconds since InitWindow()
  """
  @spec get_time() :: float
  defdelegate get_time(), to: NIF, as: :get_time

  @doc """
  Get current FPS
  """
  @spec get_fps() :: integer
  defdelegate get_fps(), to: NIF, as: :get_fps
end
