defmodule Zexray.Audio do
  alias Zexray.NIF

  @doc """
  Get wave data size in bytes
  """
  @spec wave_data_size(
          frame_count :: non_neg_integer,
          channels :: non_neg_integer,
          sample_size :: non_neg_integer
        ) :: non_neg_integer
  def wave_data_size(
        frame_count,
        channels,
        sample_size
      )
      when is_integer(frame_count) and
             is_integer(channels) and
             is_integer(sample_size) do
    NIF.wave_get_data_size(
      frame_count,
      channels,
      sample_size
    )
  end
end
