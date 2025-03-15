defmodule Zexray.NIF.Audio do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_audio [
        # Wave
        wave_get_data_size: 3
      ]

      ##########
      #  Wave  #
      ##########

      @doc """
      Get wave data size in bytes

      ```zig
      pub fn get_data_size(frame_count: c_uint, channels: c_uint, sample_size: c_uint) usize
      ```
      """
      @doc group: :wave
      @spec wave_get_data_size(
              frame_count :: non_neg_integer,
              channels :: non_neg_integer,
              sample_size :: non_neg_integer
            ) :: non_neg_integer
      def wave_get_data_size(
            _frame_count,
            _channels,
            _sample_size
          ),
          do: :erlang.nif_error(:undef)
    end
  end
end
