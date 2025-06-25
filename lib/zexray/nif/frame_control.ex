defmodule Zexray.NIF.FrameControl do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_frame_control [
        # Frame control
        swap_screen_buffer: 0,
        poll_input_events: 0,
        wait_time: 1
      ]

      ###################
      #  Frame control  #
      ###################

      @doc """
      Swap back buffer with front buffer (screen drawing)

      ```c
      // raylib.h
      RLAPI void SwapScreenBuffer(void);
      ```
      """
      @doc group: :frame_control
      @spec swap_screen_buffer() :: :ok
      def swap_screen_buffer(), do: :erlang.nif_error(:undef)

      @doc """
      Register all input events

      ```c
      // raylib.h
      RLAPI void PollInputEvents(void);
      ```
      """
      @doc group: :frame_control
      @spec poll_input_events() :: :ok
      def poll_input_events(), do: :erlang.nif_error(:undef)

      @doc """
      Wait for some time (halt program execution)

      ```c
      // raylib.h
      RLAPI void WaitTime(double seconds);
      ```
      """
      @doc group: :frame_control
      @spec wait_time(seconds :: number) :: :ok
      def wait_time(_seconds), do: :erlang.nif_error(:undef)
    end
  end
end
