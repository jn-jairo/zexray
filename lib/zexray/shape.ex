defmodule Zexray.Shape do
  @moduledoc """
  Shape
  """

  import Zexray.Guard
  alias Zexray.NIF

  ##########################
  #  Shapes configuration  #
  ##########################

  @doc """
  Set texture and rectangle to be used on shapes drawing
  """
  @doc group: :configuration
  @spec set_texture(
          texture :: Zexray.Type.Texture2D.t_all(),
          source :: Zexray.Type.Rectangle.t_all()
        ) :: :ok
  def set_texture(
        texture,
        source
      )
      when is_like_texture_2d(texture) and
             is_like_rectangle(source) do
    NIF.set_shapes_texture(
      texture |> Zexray.Type.Texture2D.to_nif(),
      source |> Zexray.Type.Rectangle.to_nif()
    )
  end

  @doc """
  Get texture that is used for shapes drawing
  """
  @doc group: :configuration
  @spec get_texture(return :: :value | :resource) :: Zexray.Type.Texture2D.t_nif()
  def get_texture(return \\ :value)
      when is_nif_return(return) do
    NIF.get_shapes_texture(return)
    |> Zexray.Type.Texture2D.from_nif()
  end

  @doc """
  Get texture source rectangle that is used for shapes drawing
  """
  @doc group: :configuration
  @spec get_texture_rectangle(return :: :value | :resource) :: Zexray.Type.Rectangle.t_nif()
  def get_texture_rectangle(return \\ :value)
      when is_nif_return(return) do
    NIF.get_shapes_texture_rectangle(return)
    |> Zexray.Type.Rectangle.from_nif()
  end

  ##########################
  #  Basic shapes drawing  #
  ##########################

  @doc """
  Draw a pixel using geometry [Can be slow, use with care]
  """
  @doc group: :basic_drawing
  @spec draw_pixel(
          pos_x :: integer,
          pos_y :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_pixel(
        pos_x,
        pos_y,
        color
      )
      when is_integer(pos_x) and
             is_integer(pos_y) and
             is_like_color(color) do
    NIF.draw_pixel(
      pos_x,
      pos_y,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a pixel using geometry (Vector version) [Can be slow, use with care]
  """
  @doc group: :basic_drawing
  @spec draw_pixel_v(
          position :: Zexray.Type.Vector2.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_pixel_v(
        position,
        color
      )
      when is_like_vector2(position) and
             is_like_color(color) do
    NIF.draw_pixel_v(
      position |> Zexray.Type.Vector2.to_nif(),
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a line
  """
  @doc group: :basic_drawing
  @spec draw_line(
          start_pos_x :: integer,
          start_pos_y :: integer,
          end_pos_x :: integer,
          end_pos_y :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_line(
        start_pos_x,
        start_pos_y,
        end_pos_x,
        end_pos_y,
        color
      )
      when is_integer(start_pos_x) and
             is_integer(start_pos_y) and
             is_integer(end_pos_x) and
             is_integer(end_pos_y) and
             is_like_color(color) do
    NIF.draw_line(
      start_pos_x,
      start_pos_y,
      end_pos_x,
      end_pos_y,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a line (using gl lines)
  """
  @doc group: :basic_drawing
  @spec draw_line_v(
          start_pos :: Zexray.Type.Vector2.t_all(),
          end_pos :: Zexray.Type.Vector2.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_line_v(
        start_pos,
        end_pos,
        color
      )
      when is_like_vector2(start_pos) and
             is_like_vector2(end_pos) and
             is_like_color(color) do
    NIF.draw_line_v(
      start_pos |> Zexray.Type.Vector2.to_nif(),
      end_pos |> Zexray.Type.Vector2.to_nif(),
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a line (using triangles/quads)
  """
  @doc group: :basic_drawing
  @spec draw_line_ex(
          start_pos :: Zexray.Type.Vector2.t_all(),
          end_pos :: Zexray.Type.Vector2.t_all(),
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_line_ex(
        start_pos,
        end_pos,
        thick,
        color
      )
      when is_like_vector2(start_pos) and
             is_like_vector2(end_pos) and
             is_float(thick) and
             is_like_color(color) do
    NIF.draw_line_ex(
      start_pos |> Zexray.Type.Vector2.to_nif(),
      end_pos |> Zexray.Type.Vector2.to_nif(),
      thick,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw lines sequence (using gl lines)
  """
  @doc group: :basic_drawing
  @spec draw_line_strip(
          points :: [Zexray.Type.Vector2.t_all()],
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_line_strip(
        points,
        color
      )
      when is_list(points) and (points == [] or is_like_vector2(hd(points))) and
             is_like_color(color) do
    NIF.draw_line_strip(
      points |> Zexray.Type.Vector2.to_nif(),
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw line segment cubic-bezier in-out interpolation
  """
  @doc group: :basic_drawing
  @spec draw_line_bezier(
          start_pos :: Zexray.Type.Vector2.t_all(),
          end_pos :: Zexray.Type.Vector2.t_all(),
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_line_bezier(
        start_pos,
        end_pos,
        thick,
        color
      )
      when is_like_vector2(start_pos) and
             is_like_vector2(end_pos) and
             is_float(thick) and
             is_like_color(color) do
    NIF.draw_line_bezier(
      start_pos |> Zexray.Type.Vector2.to_nif(),
      end_pos |> Zexray.Type.Vector2.to_nif(),
      thick,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a color-filled circle
  """
  @doc group: :basic_drawing
  @spec draw_circle(
          center_x :: integer,
          center_y :: integer,
          radius :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_circle(
        center_x,
        center_y,
        radius,
        color
      )
      when is_integer(center_x) and
             is_integer(center_y) and
             is_float(radius) and
             is_like_color(color) do
    NIF.draw_circle(
      center_x,
      center_y,
      radius,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a piece of a circle
  """
  @doc group: :basic_drawing
  @spec draw_circle_sector(
          center :: Zexray.Type.Vector2.t_all(),
          radius :: float,
          start_angle :: float,
          end_angle :: float,
          segments :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_circle_sector(
        center,
        radius,
        start_angle,
        end_angle,
        segments,
        color
      )
      when is_like_vector2(center) and
             is_float(radius) and
             is_float(start_angle) and
             is_float(end_angle) and
             is_integer(segments) and
             is_like_color(color) do
    NIF.draw_circle_sector(
      center |> Zexray.Type.Vector2.to_nif(),
      radius,
      start_angle,
      end_angle,
      segments,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw circle sector outline
  """
  @doc group: :basic_drawing
  @spec draw_circle_sector_lines(
          center :: Zexray.Type.Vector2.t_all(),
          radius :: float,
          start_angle :: float,
          end_angle :: float,
          segments :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_circle_sector_lines(
        center,
        radius,
        start_angle,
        end_angle,
        segments,
        color
      )
      when is_like_vector2(center) and
             is_float(radius) and
             is_float(start_angle) and
             is_float(end_angle) and
             is_integer(segments) and
             is_like_color(color) do
    NIF.draw_circle_sector_lines(
      center |> Zexray.Type.Vector2.to_nif(),
      radius,
      start_angle,
      end_angle,
      segments,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a gradient-filled circle
  """
  @doc group: :basic_drawing
  @spec draw_circle_gradient(
          center_x :: integer,
          center_y :: integer,
          radius :: float,
          inner :: Zexray.Type.Color.t_all(),
          outer :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_circle_gradient(
        center_x,
        center_y,
        radius,
        inner,
        outer
      )
      when is_integer(center_x) and
             is_integer(center_y) and
             is_float(radius) and
             is_like_color(inner) and
             is_like_color(outer) do
    NIF.draw_circle_gradient(
      center_x,
      center_y,
      radius,
      inner |> Zexray.Type.Color.to_nif(),
      outer |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a color-filled circle (Vector version)
  """
  @doc group: :basic_drawing
  @spec draw_circle_v(
          center :: Zexray.Type.Vector2.t_all(),
          radius :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_circle_v(
        center,
        radius,
        color
      )
      when is_like_vector2(center) and
             is_float(radius) and
             is_like_color(color) do
    NIF.draw_circle_v(
      center |> Zexray.Type.Vector2.to_nif(),
      radius,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw circle outline
  """
  @doc group: :basic_drawing
  @spec draw_circle_lines(
          center_x :: integer,
          center_y :: integer,
          radius :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_circle_lines(
        center_x,
        center_y,
        radius,
        color
      )
      when is_integer(center_x) and
             is_integer(center_y) and
             is_float(radius) and
             is_like_color(color) do
    NIF.draw_circle_lines(
      center_x,
      center_y,
      radius,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw circle outline (Vector version)
  """
  @doc group: :basic_drawing
  @spec draw_circle_lines_v(
          center :: Zexray.Type.Vector2.t_all(),
          radius :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_circle_lines_v(
        center,
        radius,
        color
      )
      when is_like_vector2(center) and
             is_float(radius) and
             is_like_color(color) do
    NIF.draw_circle_lines_v(
      center |> Zexray.Type.Vector2.to_nif(),
      radius,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw ellipse
  """
  @doc group: :basic_drawing
  @spec draw_ellipse(
          center_x :: integer,
          center_y :: integer,
          radius_h :: float,
          radius_v :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_ellipse(
        center_x,
        center_y,
        radius_h,
        radius_v,
        color
      )
      when is_integer(center_x) and
             is_integer(center_y) and
             is_float(radius_h) and
             is_float(radius_v) and
             is_like_color(color) do
    NIF.draw_ellipse(
      center_x,
      center_y,
      radius_h,
      radius_v,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw ellipse outline
  """
  @doc group: :basic_drawing
  @spec draw_ellipse_lines(
          center_x :: integer,
          center_y :: integer,
          radius_h :: float,
          radius_v :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_ellipse_lines(
        center_x,
        center_y,
        radius_h,
        radius_v,
        color
      )
      when is_integer(center_x) and
             is_integer(center_y) and
             is_float(radius_h) and
             is_float(radius_v) and
             is_like_color(color) do
    NIF.draw_ellipse_lines(
      center_x,
      center_y,
      radius_h,
      radius_v,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw ring
  """
  @doc group: :basic_drawing
  @spec draw_ring(
          center :: Zexray.Type.Vector2.t_all(),
          inner_radius :: float,
          outer_radius :: float,
          start_angle :: float,
          end_angle :: float,
          segments :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_ring(
        center,
        inner_radius,
        outer_radius,
        start_angle,
        end_angle,
        segments,
        color
      )
      when is_like_vector2(center) and
             is_float(inner_radius) and
             is_float(outer_radius) and
             is_float(start_angle) and
             is_float(end_angle) and
             is_integer(segments) and
             is_like_color(color) do
    NIF.draw_ring(
      center |> Zexray.Type.Vector2.to_nif(),
      inner_radius,
      outer_radius,
      start_angle,
      end_angle,
      segments,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw ring outline
  """
  @doc group: :basic_drawing
  @spec draw_ring_lines(
          center :: Zexray.Type.Vector2.t_all(),
          inner_radius :: float,
          outer_radius :: float,
          start_angle :: float,
          end_angle :: float,
          segments :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_ring_lines(
        center,
        inner_radius,
        outer_radius,
        start_angle,
        end_angle,
        segments,
        color
      )
      when is_like_vector2(center) and
             is_float(inner_radius) and
             is_float(outer_radius) and
             is_float(start_angle) and
             is_float(end_angle) and
             is_integer(segments) and
             is_like_color(color) do
    NIF.draw_ring_lines(
      center |> Zexray.Type.Vector2.to_nif(),
      inner_radius,
      outer_radius,
      start_angle,
      end_angle,
      segments,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a color-filled rectangle
  """
  @doc group: :basic_drawing
  @spec draw_rectangle(
          pos_x :: integer,
          pos_y :: integer,
          width :: integer,
          height :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_rectangle(
        pos_x,
        pos_y,
        width,
        height,
        color
      )
      when is_integer(pos_x) and
             is_integer(pos_y) and
             is_integer(width) and
             is_integer(height) and
             is_like_color(color) do
    NIF.draw_rectangle(
      pos_x,
      pos_y,
      width,
      height,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a color-filled rectangle (Vector version)
  """
  @doc group: :basic_drawing
  @spec draw_rectangle_v(
          position :: Zexray.Type.Vector2.t_all(),
          size :: Zexray.Type.Vector2.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_rectangle_v(
        position,
        size,
        color
      )
      when is_like_vector2(position) and
             is_like_vector2(size) and
             is_like_color(color) do
    NIF.draw_rectangle_v(
      position |> Zexray.Type.Vector2.to_nif(),
      size |> Zexray.Type.Vector2.to_nif(),
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a color-filled rectangle
  """
  @doc group: :basic_drawing
  @spec draw_rectangle_rec(
          rec :: Zexray.Type.Rectangle.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_rectangle_rec(
        rec,
        color
      )
      when is_like_rectangle(rec) and
             is_like_color(color) do
    NIF.draw_rectangle_rec(
      rec |> Zexray.Type.Rectangle.to_nif(),
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a color-filled rectangle with pro parameters
  """
  @doc group: :basic_drawing
  @spec draw_rectangle_pro(
          rec :: Zexray.Type.Rectangle.t_all(),
          origin :: Zexray.Type.Vector2.t_all(),
          rotation :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_rectangle_pro(
        rec,
        origin,
        rotation,
        color
      )
      when is_like_rectangle(rec) and
             is_like_vector2(origin) and
             is_float(rotation) and
             is_like_color(color) do
    NIF.draw_rectangle_pro(
      rec |> Zexray.Type.Rectangle.to_nif(),
      origin |> Zexray.Type.Vector2.to_nif(),
      rotation,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a vertical-gradient-filled rectangle
  """
  @doc group: :basic_drawing
  @spec draw_rectangle_gradient_v(
          pos_x :: integer,
          pos_y :: integer,
          width :: integer,
          height :: integer,
          top :: Zexray.Type.Color.t_all(),
          bottom :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_rectangle_gradient_v(
        pos_x,
        pos_y,
        width,
        height,
        top,
        bottom
      )
      when is_integer(pos_x) and
             is_integer(pos_y) and
             is_integer(width) and
             is_integer(height) and
             is_like_color(top) and
             is_like_color(bottom) do
    NIF.draw_rectangle_gradient_v(
      pos_x,
      pos_y,
      width,
      height,
      top |> Zexray.Type.Color.to_nif(),
      bottom |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a horizontal-gradient-filled rectangle
  """
  @doc group: :basic_drawing
  @spec draw_rectangle_gradient_h(
          pos_x :: integer,
          pos_y :: integer,
          width :: integer,
          height :: integer,
          left :: Zexray.Type.Color.t_all(),
          right :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_rectangle_gradient_h(
        pos_x,
        pos_y,
        width,
        height,
        left,
        right
      )
      when is_integer(pos_x) and
             is_integer(pos_y) and
             is_integer(width) and
             is_integer(height) and
             is_like_color(left) and
             is_like_color(right) do
    NIF.draw_rectangle_gradient_h(
      pos_x,
      pos_y,
      width,
      height,
      left |> Zexray.Type.Color.to_nif(),
      right |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a gradient-filled rectangle with custom vertex colors
  """
  @doc group: :basic_drawing
  @spec draw_rectangle_gradient_ex(
          rec :: Zexray.Type.Rectangle.t_all(),
          top_left :: Zexray.Type.Color.t_all(),
          bottom_left :: Zexray.Type.Color.t_all(),
          top_right :: Zexray.Type.Color.t_all(),
          bottom_right :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_rectangle_gradient_ex(
        rec,
        top_left,
        bottom_left,
        top_right,
        bottom_right
      )
      when is_like_rectangle(rec) and
             is_like_color(top_left) and
             is_like_color(bottom_left) and
             is_like_color(top_right) and
             is_like_color(bottom_right) do
    NIF.draw_rectangle_gradient_ex(
      rec |> Zexray.Type.Rectangle.to_nif(),
      top_left |> Zexray.Type.Color.to_nif(),
      bottom_left |> Zexray.Type.Color.to_nif(),
      top_right |> Zexray.Type.Color.to_nif(),
      bottom_right |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw rectangle outline
  """
  @doc group: :basic_drawing
  @spec draw_rectangle_lines(
          pos_x :: integer,
          pos_y :: integer,
          width :: integer,
          height :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_rectangle_lines(
        pos_x,
        pos_y,
        width,
        height,
        color
      )
      when is_integer(pos_x) and
             is_integer(pos_y) and
             is_integer(width) and
             is_integer(height) and
             is_like_color(color) do
    NIF.draw_rectangle_lines(
      pos_x,
      pos_y,
      width,
      height,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw rectangle outline with extended parameters
  """
  @doc group: :basic_drawing
  @spec draw_rectangle_lines_ex(
          rec :: Zexray.Type.Rectangle.t_all(),
          line_thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_rectangle_lines_ex(
        rec,
        line_thick,
        color
      )
      when is_like_rectangle(rec) and
             is_float(line_thick) and
             is_like_color(color) do
    NIF.draw_rectangle_lines_ex(
      rec |> Zexray.Type.Rectangle.to_nif(),
      line_thick,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw rectangle with rounded edges
  """
  @doc group: :basic_drawing
  @spec draw_rectangle_rounded(
          rec :: Zexray.Type.Rectangle.t_all(),
          roundness :: float,
          segments :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_rectangle_rounded(
        rec,
        roundness,
        segments,
        color
      )
      when is_like_rectangle(rec) and
             is_float(roundness) and
             is_integer(segments) and
             is_like_color(color) do
    NIF.draw_rectangle_rounded(
      rec |> Zexray.Type.Rectangle.to_nif(),
      roundness,
      segments,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw rectangle lines with rounded edges
  """
  @doc group: :basic_drawing
  @spec draw_rectangle_rounded_lines(
          rec :: Zexray.Type.Rectangle.t_all(),
          roundness :: float,
          segments :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_rectangle_rounded_lines(
        rec,
        roundness,
        segments,
        color
      )
      when is_like_rectangle(rec) and
             is_float(roundness) and
             is_integer(segments) and
             is_like_color(color) do
    NIF.draw_rectangle_rounded_lines(
      rec |> Zexray.Type.Rectangle.to_nif(),
      roundness,
      segments,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw rectangle with rounded edges outline
  """
  @doc group: :basic_drawing
  @spec draw_rectangle_rounded_lines_ex(
          rec :: Zexray.Type.Rectangle.t_all(),
          roundness :: float,
          segments :: integer,
          line_thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_rectangle_rounded_lines_ex(
        rec,
        roundness,
        segments,
        line_thick,
        color
      )
      when is_like_rectangle(rec) and
             is_float(roundness) and
             is_integer(segments) and
             is_float(line_thick) and
             is_like_color(color) do
    NIF.draw_rectangle_rounded_lines_ex(
      rec |> Zexray.Type.Rectangle.to_nif(),
      roundness,
      segments,
      line_thick,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a color-filled triangle (vertex in counter-clockwise order!)
  """
  @doc group: :basic_drawing
  @spec draw_triangle(
          v1 :: Zexray.Type.Vector2.t_all(),
          v2 :: Zexray.Type.Vector2.t_all(),
          v3 :: Zexray.Type.Vector2.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_triangle(
        v1,
        v2,
        v3,
        color
      )
      when is_like_vector2(v1) and
             is_like_vector2(v2) and
             is_like_vector2(v3) and
             is_like_color(color) do
    NIF.draw_triangle(
      v1 |> Zexray.Type.Vector2.to_nif(),
      v2 |> Zexray.Type.Vector2.to_nif(),
      v3 |> Zexray.Type.Vector2.to_nif(),
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw triangle outline (vertex in counter-clockwise order!)
  """
  @doc group: :basic_drawing
  @spec draw_triangle_lines(
          v1 :: Zexray.Type.Vector2.t_all(),
          v2 :: Zexray.Type.Vector2.t_all(),
          v3 :: Zexray.Type.Vector2.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_triangle_lines(
        v1,
        v2,
        v3,
        color
      )
      when is_like_vector2(v1) and
             is_like_vector2(v2) and
             is_like_vector2(v3) and
             is_like_color(color) do
    NIF.draw_triangle_lines(
      v1 |> Zexray.Type.Vector2.to_nif(),
      v2 |> Zexray.Type.Vector2.to_nif(),
      v3 |> Zexray.Type.Vector2.to_nif(),
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a triangle fan defined by points (first vertex is the center)
  """
  @doc group: :basic_drawing
  @spec draw_triangle_fan(
          points :: [Zexray.Type.Vector2.t_all()],
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_triangle_fan(
        points,
        color
      )
      when is_list(points) and (points == [] or is_like_vector2(hd(points))) and
             is_like_color(color) do
    NIF.draw_triangle_fan(
      points |> Zexray.Type.Vector2.to_nif(),
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a triangle strip defined by points
  """
  @doc group: :basic_drawing
  @spec draw_triangle_strip(
          points :: [Zexray.Type.Vector2.t_all()],
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_triangle_strip(
        points,
        color
      )
      when is_list(points) and (points == [] or is_like_vector2(hd(points))) and
             is_like_color(color) do
    NIF.draw_triangle_strip(
      points |> Zexray.Type.Vector2.to_nif(),
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a regular polygon (Vector version)
  """
  @doc group: :basic_drawing
  @spec draw_poly(
          center :: Zexray.Type.Vector2.t_all(),
          sides :: integer,
          radius :: float,
          rotation :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_poly(
        center,
        sides,
        radius,
        rotation,
        color
      )
      when is_like_vector2(center) and
             is_integer(sides) and
             is_float(radius) and
             is_float(rotation) and
             is_like_color(color) do
    NIF.draw_poly(
      center |> Zexray.Type.Vector2.to_nif(),
      sides,
      radius,
      rotation,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a polygon outline of n sides
  """
  @doc group: :basic_drawing
  @spec draw_poly_lines(
          center :: Zexray.Type.Vector2.t_all(),
          sides :: integer,
          radius :: float,
          rotation :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_poly_lines(
        center,
        sides,
        radius,
        rotation,
        color
      )
      when is_like_vector2(center) and
             is_integer(sides) and
             is_float(radius) and
             is_float(rotation) and
             is_like_color(color) do
    NIF.draw_poly_lines(
      center |> Zexray.Type.Vector2.to_nif(),
      sides,
      radius,
      rotation,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw a polygon outline of n sides with extended parameters
  """
  @doc group: :basic_drawing
  @spec draw_poly_lines_ex(
          center :: Zexray.Type.Vector2.t_all(),
          sides :: integer,
          radius :: float,
          rotation :: float,
          line_thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_poly_lines_ex(
        center,
        sides,
        radius,
        rotation,
        line_thick,
        color
      )
      when is_like_vector2(center) and
             is_integer(sides) and
             is_float(radius) and
             is_float(rotation) and
             is_float(line_thick) and
             is_like_color(color) do
    NIF.draw_poly_lines_ex(
      center |> Zexray.Type.Vector2.to_nif(),
      sides,
      radius,
      rotation,
      line_thick,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  #####################
  #  Splines drawing  #
  #####################

  @doc """
  Draw spline: Linear, minimum 2 points
  """
  @doc group: :splines_drawing
  @spec draw_spline_linear(
          points :: [Zexray.Type.Vector2.t_all()],
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_spline_linear(
        points,
        thick,
        color
      )
      when is_list(points) and (points == [] or is_like_vector2(hd(points))) and
             is_float(thick) and
             is_like_color(color) do
    NIF.draw_spline_linear(
      points |> Zexray.Type.Vector2.to_nif(),
      thick,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw spline: B-Spline, minimum 4 points
  """
  @doc group: :splines_drawing
  @spec draw_spline_basis(
          points :: [Zexray.Type.Vector2.t_all()],
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_spline_basis(
        points,
        thick,
        color
      )
      when is_list(points) and (points == [] or is_like_vector2(hd(points))) and
             is_float(thick) and
             is_like_color(color) do
    NIF.draw_spline_basis(
      points |> Zexray.Type.Vector2.to_nif(),
      thick,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw spline: Catmull-Rom, minimum 4 points
  """
  @doc group: :splines_drawing
  @spec draw_spline_catmull_rom(
          points :: [Zexray.Type.Vector2.t_all()],
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_spline_catmull_rom(
        points,
        thick,
        color
      )
      when is_list(points) and (points == [] or is_like_vector2(hd(points))) and
             is_float(thick) and
             is_like_color(color) do
    NIF.draw_spline_catmull_rom(
      points |> Zexray.Type.Vector2.to_nif(),
      thick,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]
  """
  @doc group: :splines_drawing
  @spec draw_spline_bezier_quadratic(
          points :: [Zexray.Type.Vector2.t_all()],
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_spline_bezier_quadratic(
        points,
        thick,
        color
      )
      when is_list(points) and (points == [] or is_like_vector2(hd(points))) and
             is_float(thick) and
             is_like_color(color) do
    NIF.draw_spline_bezier_quadratic(
      points |> Zexray.Type.Vector2.to_nif(),
      thick,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]
  """
  @doc group: :splines_drawing
  @spec draw_spline_bezier_cubic(
          points :: [Zexray.Type.Vector2.t_all()],
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_spline_bezier_cubic(
        points,
        thick,
        color
      )
      when is_list(points) and (points == [] or is_like_vector2(hd(points))) and
             is_float(thick) and
             is_like_color(color) do
    NIF.draw_spline_bezier_cubic(
      points |> Zexray.Type.Vector2.to_nif(),
      thick,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw spline segment: Linear, 2 points
  """
  @doc group: :splines_drawing
  @spec draw_spline_segment_linear(
          p1 :: Zexray.Type.Vector2.t_all(),
          p2 :: Zexray.Type.Vector2.t_all(),
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_spline_segment_linear(
        p1,
        p2,
        thick,
        color
      )
      when is_like_vector2(p1) and
             is_like_vector2(p2) and
             is_float(thick) and
             is_like_color(color) do
    NIF.draw_spline_segment_linear(
      p1 |> Zexray.Type.Vector2.to_nif(),
      p2 |> Zexray.Type.Vector2.to_nif(),
      thick,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw spline segment: B-Spline, 4 points
  """
  @doc group: :splines_drawing
  @spec draw_spline_segment_basis(
          p1 :: Zexray.Type.Vector2.t_all(),
          p2 :: Zexray.Type.Vector2.t_all(),
          p3 :: Zexray.Type.Vector2.t_all(),
          p4 :: Zexray.Type.Vector2.t_all(),
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_spline_segment_basis(
        p1,
        p2,
        p3,
        p4,
        thick,
        color
      )
      when is_like_vector2(p1) and
             is_like_vector2(p2) and
             is_like_vector2(p3) and
             is_like_vector2(p4) and
             is_float(thick) and
             is_like_color(color) do
    NIF.draw_spline_segment_basis(
      p1 |> Zexray.Type.Vector2.to_nif(),
      p2 |> Zexray.Type.Vector2.to_nif(),
      p3 |> Zexray.Type.Vector2.to_nif(),
      p4 |> Zexray.Type.Vector2.to_nif(),
      thick,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw spline segment: Catmull-Rom, 4 points
  """
  @doc group: :splines_drawing
  @spec draw_spline_segment_catmull_rom(
          p1 :: Zexray.Type.Vector2.t_all(),
          p2 :: Zexray.Type.Vector2.t_all(),
          p3 :: Zexray.Type.Vector2.t_all(),
          p4 :: Zexray.Type.Vector2.t_all(),
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_spline_segment_catmull_rom(
        p1,
        p2,
        p3,
        p4,
        thick,
        color
      )
      when is_like_vector2(p1) and
             is_like_vector2(p2) and
             is_like_vector2(p3) and
             is_like_vector2(p4) and
             is_float(thick) and
             is_like_color(color) do
    NIF.draw_spline_segment_catmull_rom(
      p1 |> Zexray.Type.Vector2.to_nif(),
      p2 |> Zexray.Type.Vector2.to_nif(),
      p3 |> Zexray.Type.Vector2.to_nif(),
      p4 |> Zexray.Type.Vector2.to_nif(),
      thick,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw spline segment: Quadratic Bezier, 2 points, 1 control point
  """
  @doc group: :splines_drawing
  @spec draw_spline_segment_bezier_quadratic(
          p1 :: Zexray.Type.Vector2.t_all(),
          c2 :: Zexray.Type.Vector2.t_all(),
          p3 :: Zexray.Type.Vector2.t_all(),
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_spline_segment_bezier_quadratic(
        p1,
        c2,
        p3,
        thick,
        color
      )
      when is_like_vector2(p1) and
             is_like_vector2(c2) and
             is_like_vector2(p3) and
             is_float(thick) and
             is_like_color(color) do
    NIF.draw_spline_segment_bezier_quadratic(
      p1 |> Zexray.Type.Vector2.to_nif(),
      c2 |> Zexray.Type.Vector2.to_nif(),
      p3 |> Zexray.Type.Vector2.to_nif(),
      thick,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  @doc """
  Draw spline segment: Cubic Bezier, 2 points, 2 control points
  """
  @doc group: :splines_drawing
  @spec draw_spline_segment_bezier_cubic(
          p1 :: Zexray.Type.Vector2.t_all(),
          c2 :: Zexray.Type.Vector2.t_all(),
          c3 :: Zexray.Type.Vector2.t_all(),
          p4 :: Zexray.Type.Vector2.t_all(),
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  def draw_spline_segment_bezier_cubic(
        p1,
        c2,
        c3,
        p4,
        thick,
        color
      )
      when is_like_vector2(p1) and
             is_like_vector2(c2) and
             is_like_vector2(c3) and
             is_like_vector2(p4) and
             is_float(thick) and
             is_like_color(color) do
    NIF.draw_spline_segment_bezier_cubic(
      p1 |> Zexray.Type.Vector2.to_nif(),
      c2 |> Zexray.Type.Vector2.to_nif(),
      c3 |> Zexray.Type.Vector2.to_nif(),
      p4 |> Zexray.Type.Vector2.to_nif(),
      thick,
      color |> Zexray.Type.Color.to_nif()
    )
  end

  #####################################
  #  Spline segment point evaluation  #
  #####################################

  @doc """
  Get (evaluate) spline point: Linear
  """
  @doc group: :spline_segment_point_evaluation
  @spec get_spline_point_linear(
          start_pos :: Zexray.Type.Vector2.t_all(),
          end_pos :: Zexray.Type.Vector2.t_all(),
          t :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  def get_spline_point_linear(
        start_pos,
        end_pos,
        t,
        return \\ :value
      )
      when is_like_vector2(start_pos) and
             is_like_vector2(end_pos) and
             is_float(t) and
             is_nif_return(return) do
    NIF.get_spline_point_linear(
      start_pos |> Zexray.Type.Vector2.to_nif(),
      end_pos |> Zexray.Type.Vector2.to_nif(),
      t,
      return
    )
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Get (evaluate) spline point: B-Spline
  """
  @doc group: :spline_segment_point_evaluation
  @spec get_spline_point_basis(
          p1 :: Zexray.Type.Vector2.t_all(),
          p2 :: Zexray.Type.Vector2.t_all(),
          p3 :: Zexray.Type.Vector2.t_all(),
          p4 :: Zexray.Type.Vector2.t_all(),
          t :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  def get_spline_point_basis(
        p1,
        p2,
        p3,
        p4,
        t,
        return \\ :value
      )
      when is_like_vector2(p1) and
             is_like_vector2(p2) and
             is_like_vector2(p3) and
             is_like_vector2(p4) and
             is_float(t) and
             is_nif_return(return) do
    NIF.get_spline_point_basis(
      p1 |> Zexray.Type.Vector2.to_nif(),
      p2 |> Zexray.Type.Vector2.to_nif(),
      p3 |> Zexray.Type.Vector2.to_nif(),
      p4 |> Zexray.Type.Vector2.to_nif(),
      t,
      return
    )
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Get (evaluate) spline point: Catmull-Rom
  """
  @doc group: :spline_segment_point_evaluation
  @spec get_spline_point_catmull_rom(
          p1 :: Zexray.Type.Vector2.t_all(),
          p2 :: Zexray.Type.Vector2.t_all(),
          p3 :: Zexray.Type.Vector2.t_all(),
          p4 :: Zexray.Type.Vector2.t_all(),
          t :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  def get_spline_point_catmull_rom(
        p1,
        p2,
        p3,
        p4,
        t,
        return \\ :value
      )
      when is_like_vector2(p1) and
             is_like_vector2(p2) and
             is_like_vector2(p3) and
             is_like_vector2(p4) and
             is_float(t) and
             is_nif_return(return) do
    NIF.get_spline_point_catmull_rom(
      p1 |> Zexray.Type.Vector2.to_nif(),
      p2 |> Zexray.Type.Vector2.to_nif(),
      p3 |> Zexray.Type.Vector2.to_nif(),
      p4 |> Zexray.Type.Vector2.to_nif(),
      t,
      return
    )
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Get (evaluate) spline point: Quadratic Bezier
  """
  @doc group: :spline_segment_point_evaluation
  @spec get_spline_point_bezier_quad(
          p1 :: Zexray.Type.Vector2.t_all(),
          c2 :: Zexray.Type.Vector2.t_all(),
          p3 :: Zexray.Type.Vector2.t_all(),
          t :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  def get_spline_point_bezier_quad(
        p1,
        c2,
        p3,
        t,
        return \\ :value
      )
      when is_like_vector2(p1) and
             is_like_vector2(c2) and
             is_like_vector2(p3) and
             is_float(t) and
             is_nif_return(return) do
    NIF.get_spline_point_bezier_quad(
      p1 |> Zexray.Type.Vector2.to_nif(),
      c2 |> Zexray.Type.Vector2.to_nif(),
      p3 |> Zexray.Type.Vector2.to_nif(),
      t,
      return
    )
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Get (evaluate) spline point: Cubic Bezier
  """
  @doc group: :spline_segment_point_evaluation
  @spec get_spline_point_bezier_cubic(
          p1 :: Zexray.Type.Vector2.t_all(),
          c2 :: Zexray.Type.Vector2.t_all(),
          c3 :: Zexray.Type.Vector2.t_all(),
          p4 :: Zexray.Type.Vector2.t_all(),
          t :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  def get_spline_point_bezier_cubic(
        p1,
        c2,
        c3,
        p4,
        t,
        return \\ :value
      )
      when is_like_vector2(p1) and
             is_like_vector2(c2) and
             is_like_vector2(c3) and
             is_like_vector2(p4) and
             is_float(t) and
             is_nif_return(return) do
    NIF.get_spline_point_bezier_cubic(
      p1 |> Zexray.Type.Vector2.to_nif(),
      c2 |> Zexray.Type.Vector2.to_nif(),
      c3 |> Zexray.Type.Vector2.to_nif(),
      p4 |> Zexray.Type.Vector2.to_nif(),
      t,
      return
    )
    |> Zexray.Type.Vector2.from_nif()
  end

  ######################################
  #  Basic shapes collision detection  #
  ######################################

  @doc """
  Check collision between two rectangles
  """
  @doc group: :basic_collision_detection
  @spec collision_recs?(
          rec1 :: Zexray.Type.Rectangle.t_all(),
          rec2 :: Zexray.Type.Rectangle.t_all()
        ) :: boolean
  def collision_recs?(
        rec1,
        rec2
      )
      when is_like_rectangle(rec1) and
             is_like_rectangle(rec2) do
    NIF.check_collision_recs(
      rec1 |> Zexray.Type.Rectangle.to_nif(),
      rec2 |> Zexray.Type.Rectangle.to_nif()
    )
  end

  @doc """
  Check collision between two circles
  """
  @doc group: :basic_collision_detection
  @spec collision_circles?(
          center1 :: Zexray.Type.Vector2.t_all(),
          radius1 :: float,
          center2 :: Zexray.Type.Vector2.t_all(),
          radius2 :: float
        ) :: boolean
  def collision_circles?(
        center1,
        radius1,
        center2,
        radius2
      )
      when is_like_vector2(center1) and
             is_float(radius1) and
             is_like_vector2(center2) and
             is_float(radius2) do
    NIF.check_collision_circles(
      center1 |> Zexray.Type.Vector2.to_nif(),
      radius1,
      center2 |> Zexray.Type.Vector2.to_nif(),
      radius2
    )
  end

  @doc """
  Check collision between circle and rectangle
  """
  @doc group: :basic_collision_detection
  @spec collision_circle_rec?(
          center :: Zexray.Type.Vector2.t_all(),
          radius :: float,
          rec :: Zexray.Type.Rectangle.t_all()
        ) :: boolean
  def collision_circle_rec?(
        center,
        radius,
        rec
      )
      when is_like_vector2(center) and
             is_float(radius) and
             is_like_rectangle(rec) do
    NIF.check_collision_circle_rec(
      center |> Zexray.Type.Vector2.to_nif(),
      radius,
      rec |> Zexray.Type.Rectangle.to_nif()
    )
  end

  @doc """
  Check if circle collides with a line created betweeen two points [p1] and [p2]
  """
  @doc group: :basic_collision_detection
  @spec collision_circle_line?(
          center :: Zexray.Type.Vector2.t_all(),
          radius :: float,
          p1 :: Zexray.Type.Vector2.t_all(),
          p2 :: Zexray.Type.Vector2.t_all()
        ) :: boolean
  def collision_circle_line?(
        center,
        radius,
        p1,
        p2
      )
      when is_like_vector2(center) and
             is_float(radius) and
             is_like_vector2(p1) and
             is_like_vector2(p2) do
    NIF.check_collision_circle_line(
      center |> Zexray.Type.Vector2.to_nif(),
      radius,
      p1 |> Zexray.Type.Vector2.to_nif(),
      p2 |> Zexray.Type.Vector2.to_nif()
    )
  end

  @doc """
  Check if point is inside rectangle
  """
  @doc group: :basic_collision_detection
  @spec collision_point_rec?(
          point :: Zexray.Type.Vector2.t_all(),
          rec :: Zexray.Type.Rectangle.t_all()
        ) :: boolean
  def collision_point_rec?(
        point,
        rec
      )
      when is_like_vector2(point) and
             is_like_rectangle(rec) do
    NIF.check_collision_point_rec(
      point |> Zexray.Type.Vector2.to_nif(),
      rec |> Zexray.Type.Rectangle.to_nif()
    )
  end

  @doc """
  Check if point is inside circle
  """
  @doc group: :basic_collision_detection
  @spec collision_point_circle?(
          point :: Zexray.Type.Vector2.t_all(),
          center :: Zexray.Type.Vector2.t_all(),
          radius :: float
        ) :: boolean
  def collision_point_circle?(
        point,
        center,
        radius
      )
      when is_like_vector2(point) and
             is_like_vector2(center) and
             is_float(radius) do
    NIF.check_collision_point_circle(
      point |> Zexray.Type.Vector2.to_nif(),
      center |> Zexray.Type.Vector2.to_nif(),
      radius
    )
  end

  @doc """
  Check if point is inside a triangle
  """
  @doc group: :basic_collision_detection
  @spec collision_point_triangle?(
          point :: Zexray.Type.Vector2.t_all(),
          p1 :: Zexray.Type.Vector2.t_all(),
          p2 :: Zexray.Type.Vector2.t_all(),
          p3 :: Zexray.Type.Vector2.t_all()
        ) :: boolean
  def collision_point_triangle?(
        point,
        p1,
        p2,
        p3
      )
      when is_like_vector2(point) and
             is_like_vector2(p1) and
             is_like_vector2(p2) and
             is_like_vector2(p3) do
    NIF.check_collision_point_triangle(
      point |> Zexray.Type.Vector2.to_nif(),
      p1 |> Zexray.Type.Vector2.to_nif(),
      p2 |> Zexray.Type.Vector2.to_nif(),
      p3 |> Zexray.Type.Vector2.to_nif()
    )
  end

  @doc """
  Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
  """
  @doc group: :basic_collision_detection
  @spec collision_point_line?(
          point :: Zexray.Type.Vector2.t_all(),
          p1 :: Zexray.Type.Vector2.t_all(),
          p2 :: Zexray.Type.Vector2.t_all(),
          threshold :: integer
        ) :: boolean
  def collision_point_line?(
        point,
        p1,
        p2,
        threshold
      )
      when is_like_vector2(point) and
             is_like_vector2(p1) and
             is_like_vector2(p2) and
             is_integer(threshold) do
    NIF.check_collision_point_line(
      point |> Zexray.Type.Vector2.to_nif(),
      p1 |> Zexray.Type.Vector2.to_nif(),
      p2 |> Zexray.Type.Vector2.to_nif(),
      threshold
    )
  end

  @doc """
  Check if point is within a polygon described by array of vertices
  """
  @doc group: :basic_collision_detection
  @spec collision_point_poly?(
          point :: Zexray.Type.Vector2.t_all(),
          points :: [Zexray.Type.Vector2.t_all()]
        ) :: boolean
  def collision_point_poly?(
        point,
        points
      )
      when is_like_vector2(point) and
             is_list(points) and (points == [] or is_like_vector2(hd(points))) do
    NIF.check_collision_point_poly(
      point |> Zexray.Type.Vector2.to_nif(),
      points |> Zexray.Type.Vector2.to_nif()
    )
  end

  @doc """
  Check the collision between two lines defined by two points each, returns collision point by reference
  """
  @doc group: :basic_collision_detection
  @spec collision_lines?(
          start_pos1 :: Zexray.Type.Vector2.t_all(),
          end_pos1 :: Zexray.Type.Vector2.t_all(),
          start_pos2 :: Zexray.Type.Vector2.t_all(),
          end_pos2 :: Zexray.Type.Vector2.t_all()
        ) :: boolean
  def collision_lines?(
        start_pos1,
        end_pos1,
        start_pos2,
        end_pos2
      )
      when is_like_vector2(start_pos1) and
             is_like_vector2(end_pos1) and
             is_like_vector2(start_pos2) and
             is_like_vector2(end_pos2) do
    {collision, _} =
      NIF.check_collision_lines(
        start_pos1 |> Zexray.Type.Vector2.to_nif(),
        end_pos1 |> Zexray.Type.Vector2.to_nif(),
        start_pos2 |> Zexray.Type.Vector2.to_nif(),
        end_pos2 |> Zexray.Type.Vector2.to_nif()
      )

    collision
  end

  @doc """
  Check the collision between two lines defined by two points each, returns collision point by reference
  """
  @doc group: :basic_collision_detection
  @spec collision_lines_ex?(
          start_pos1 :: Zexray.Type.Vector2.t_all(),
          end_pos1 :: Zexray.Type.Vector2.t_all(),
          start_pos2 :: Zexray.Type.Vector2.t_all(),
          end_pos2 :: Zexray.Type.Vector2.t_all(),
          return :: :value | :resource
        ) :: {collision :: boolean, collision_point :: Zexray.Type.Vector2.t_nif()}
  def collision_lines_ex?(
        start_pos1,
        end_pos1,
        start_pos2,
        end_pos2,
        return \\ :value
      )
      when is_like_vector2(start_pos1) and
             is_like_vector2(end_pos1) and
             is_like_vector2(start_pos2) and
             is_like_vector2(end_pos2) and
             is_nif_return(return) do
    {collision, collision_point} =
      NIF.check_collision_lines(
        start_pos1 |> Zexray.Type.Vector2.to_nif(),
        end_pos1 |> Zexray.Type.Vector2.to_nif(),
        start_pos2 |> Zexray.Type.Vector2.to_nif(),
        end_pos2 |> Zexray.Type.Vector2.to_nif(),
        return
      )

    {
      collision,
      collision_point |> Zexray.Type.Vector2.from_nif()
    }
  end

  @doc """
  Get collision rectangle for two rectangles collision
  """
  @doc group: :basic_collision_detection
  @spec collision_recs_ex?(
          rec1 :: Zexray.Type.Rectangle.t_all(),
          rec2 :: Zexray.Type.Rectangle.t_all(),
          return :: :value | :resource
        ) :: {collision :: boolean, collision_rec :: Zexray.Type.Rectangle.t_nif()}
  def collision_recs_ex?(
        rec1,
        rec2,
        return \\ :value
      )
      when is_like_rectangle(rec1) and
             is_like_rectangle(rec2) and
             is_nif_return(return) do
    collision_rec =
      NIF.get_collision_rec(
        rec1 |> Zexray.Type.Rectangle.to_nif(),
        rec2 |> Zexray.Type.Rectangle.to_nif(),
        return
      )
      |> Zexray.Type.Rectangle.from_nif()

    collision =
      case return do
        :value ->
          not (collision_rec.x == 0 and
                 collision_rec.y == 0 and
                 collision_rec.width == 0 and
                 collision_rec.height == 0)

        _ ->
          NIF.check_collision_recs(
            rec1 |> Zexray.Type.Rectangle.to_nif(),
            rec2 |> Zexray.Type.Rectangle.to_nif()
          )
      end

    {
      collision,
      collision_rec
    }
  end

  @doc """
  Get collision rectangle for two rectangles collision
  """
  @doc group: :basic_collision_detection
  @spec get_collision_rec(
          rec1 :: Zexray.Type.Rectangle.t_all(),
          rec2 :: Zexray.Type.Rectangle.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Rectangle.t_nif()
  def get_collision_rec(
        rec1,
        rec2,
        return \\ :value
      )
      when is_like_rectangle(rec1) and
             is_like_rectangle(rec2) and
             is_nif_return(return) do
    NIF.get_collision_rec(
      rec1 |> Zexray.Type.Rectangle.to_nif(),
      rec2 |> Zexray.Type.Rectangle.to_nif(),
      return
    )
    |> Zexray.Type.Rectangle.from_nif()
  end
end
