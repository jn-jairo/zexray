defmodule Zexray.Random do
  @moduledoc """
  Random
  """

  alias Zexray.NIF

  ############
  #  Random  #
  ############

  @doc """
  Set the seed for the random number generator
  """
  @spec set_seed(seed :: non_neg_integer) :: :ok
  defdelegate set_seed(seed), to: NIF, as: :set_random_seed

  @doc """
  Get a random value between min and max (both included)
  """
  @spec get_value(
          min :: number,
          max :: number
        ) :: integer
  defdelegate get_value(
                min,
                max
              ),
              to: NIF,
              as: :get_random_value

  @doc """
  Load random values sequence, no values repeated
  """
  @spec get_sequence(
          count :: non_neg_integer,
          min :: number,
          max :: number
        ) :: [integer]
  defdelegate get_sequence(
                count,
                min,
                max
              ),
              to: NIF,
              as: :load_random_sequence
end
