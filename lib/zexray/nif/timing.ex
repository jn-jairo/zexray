defmodule Zexray.NIF.Timing do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_timing [
        # Timing
        set_target_fps: 1,
        get_frame_time: 0,
        get_time: 0,
        get_fps: 0
      ]

      ############
      #  Timing  #
      ############

      @doc """
      Set target FPS (maximum)

      ```c
      // raylib.h
      RLAPI void SetTargetFPS(int fps);
      ```
      """
      @doc group: :timing
      @spec set_target_fps(fps :: number) :: :ok
      def set_target_fps(_fps), do: :erlang.nif_error(:undef)

      @doc """
      Get time in seconds for last frame drawn (delta time)

      ```c
      // raylib.h
      RLAPI float GetFrameTime(void);
      ```
      """
      @doc group: :timing
      @spec get_frame_time() :: float
      def get_frame_time(), do: :erlang.nif_error(:undef)

      @doc """
      Get elapsed time in seconds since InitWindow()

      ```c
      // raylib.h
      RLAPI double GetTime(void);
      ```
      """
      @doc group: :timing
      @spec get_time() :: float
      def get_time(), do: :erlang.nif_error(:undef)

      @doc """
      Get current FPS

      ```c
      // raylib.h
      RLAPI int GetFPS(void);
      ```
      """
      @doc group: :timing
      @spec get_fps() :: integer
      def get_fps(), do: :erlang.nif_error(:undef)
    end
  end
end
