defmodule Zexray.NIF.Text do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_text [
        # Text Drawing
        draw_fps: 2,
        draw_text: 5
      ]

      ##################
      #  Text Drawing  #
      ##################

      @doc """
      Draw current FPS

      ```c
      // raylib.h
      RLAPI void DrawFPS(int posX, int posY);
      ```
      """
      @doc group: :text_drawing
      @spec draw_fps(
              pos_x :: integer,
              pos_y :: integer
            ) :: :ok
      def draw_fps(
            _pos_x,
            _pos_y
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw text (using default font)

      ```c
      // raylib.h
      RLAPI void DrawText(const char *text, int posX, int posY, int fontSize, Color color);
      ```
      """
      @doc group: :text_drawing
      @spec draw_text(
              text :: binary,
              pos_x :: integer,
              pos_y :: integer,
              font_size :: integer,
              color :: map | reference
            ) :: :ok
      def draw_text(
            _text,
            _pos_x,
            _pos_y,
            _font_size,
            _color
          ),
          do: :erlang.nif_error(:undef)
    end
  end
end
