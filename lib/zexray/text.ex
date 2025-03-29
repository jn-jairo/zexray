defmodule Zexray.Text do
  alias Zexray.NIF

  import Zexray.Guard

  ##################
  #  Text Drawing  #
  ##################

  @doc """
  Draw current FPS
  """
  @spec draw_fps(
          pos_x :: integer,
          pos_y :: integer
        ) :: :ok
  def draw_fps(
        pos_x,
        pos_y
      )
      when is_integer(pos_x) and
             is_integer(pos_y) do
    NIF.draw_fps(
      pos_x,
      pos_y
    )
  end

  @doc """
  Draw text (using default font)
  """
  @spec draw(
          text :: binary,
          pos_x :: integer,
          pos_y :: integer,
          font_size :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw(
        text,
        pos_x,
        pos_y,
        font_size,
        color
      )
      when is_binary(text) and
             is_integer(pos_x) and
             is_integer(pos_y) and
             is_integer(font_size) and
             is_like_color(color) do
    NIF.draw_text(
      text,
      pos_x,
      pos_y,
      font_size,
      color |> Zexray.Type.Color.to_nif()
    )
  end
end
