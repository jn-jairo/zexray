defmodule Zexray.NIF.Random do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_random [
        # Random
        set_random_seed: 1,
        get_random_value: 2,
        load_random_sequence: 3
      ]

      ############
      #  Random  #
      ############

      @doc """
      Set the seed for the random number generator

      ```c
      // raylib.h
      RLAPI void SetRandomSeed(unsigned int seed);
      ```
      """
      @doc group: :random
      @spec set_random_seed(seed :: non_neg_integer) :: :ok
      def set_random_seed(_seed), do: :erlang.nif_error(:undef)

      @doc """
      Get a random value between min and max (both included)

      ```c
      // raylib.h
      RLAPI int GetRandomValue(int min, int max);
      ```
      """
      @doc group: :random
      @spec get_random_value(
              min :: integer,
              max :: integer
            ) :: integer
      def get_random_value(
            _min,
            _max
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load random values sequence, no values repeated

      ```c
      // raylib.h
      RLAPI int *LoadRandomSequence(unsigned int count, int min, int max);
      ```
      """
      @doc group: :random
      @spec load_random_sequence(
              count :: non_neg_integer,
              min :: integer,
              max :: integer
            ) :: [integer]
      def load_random_sequence(
            _count,
            _min,
            _max
          ),
          do: :erlang.nif_error(:undef)
    end
  end
end
