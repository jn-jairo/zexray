defmodule Zexray.Random do
  @moduledoc """
  Random
  """

  import Zexray.Guard
  alias Zexray.NIF

  ############
  #  Random  #
  ############

  @doc """
  Set the seed for the random number generator
  """
  @spec set_seed(seed :: non_neg_integer) :: :ok
  def set_seed(seed)
      when is_non_neg_integer(seed) do
    NIF.set_random_seed(seed)
  end

  @doc """
  Get a random value between min and max (both included)
  """
  @spec get_value(
          min :: integer,
          max :: integer
        ) :: integer
  def get_value(
        min,
        max
      )
      when is_integer(min) and
             is_integer(max) do
    NIF.get_random_value(min, max)
  end

  @doc """
  Load random values sequence, no values repeated
  """
  @spec get_sequence(
          count :: non_neg_integer,
          min :: integer,
          max :: integer
        ) :: [integer]
  def get_sequence(
        count,
        min,
        max
      )
      when is_non_neg_integer(count) and
             is_integer(min) and
             is_integer(max) do
    NIF.load_random_sequence(count, min, max)
  end
end
