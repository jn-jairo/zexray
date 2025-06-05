defmodule Zexray.Shape do
  @moduledoc """
  Shape
  """

  use Zexray.Type

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
  defdelegate set_texture(
                texture,
                source
              ),
              to: NIF,
              as: :set_shapes_texture

  @doc """
  Get texture that is used for shapes drawing
  """
  @doc group: :configuration
  @spec get_texture(return :: :auto | :value | :resource) :: Zexray.Type.Texture2D.t_nif()
  defdelegate get_texture(return \\ :auto), to: NIF, as: :get_shapes_texture

  @doc """
  Get texture source rectangle that is used for shapes drawing
  """
  @doc group: :configuration
  @spec get_texture_rectangle(return :: :auto | :value | :resource) ::
          Zexray.Type.Rectangle.t_nif()
  defdelegate get_texture_rectangle(return \\ :auto), to: NIF, as: :get_shapes_texture_rectangle

  ###################
  #  Basic drawing  #
  ###################

  @doc """
  Draw a pixel using geometry [Can be slow, use with care]
  """
  @doc group: :basic_drawing
  @spec draw_pixel(
          pos_x :: integer,
          pos_y :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_pixel(
                pos_x,
                pos_y,
                color
              ),
              to: NIF,
              as: :draw_pixel

  @doc """
  Draw a pixel using geometry (Vector version) [Can be slow, use with care]
  """
  @doc group: :basic_drawing
  @spec draw_pixel_v(
          position :: Zexray.Type.Vector2.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_pixel_v(
                position,
                color
              ),
              to: NIF,
              as: :draw_pixel_v

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
  defdelegate draw_line(
                start_pos_x,
                start_pos_y,
                end_pos_x,
                end_pos_y,
                color
              ),
              to: NIF,
              as: :draw_line

  @doc """
  Draw a line (using gl lines)
  """
  @doc group: :basic_drawing
  @spec draw_line_v(
          start_pos :: Zexray.Type.Vector2.t_all(),
          end_pos :: Zexray.Type.Vector2.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_line_v(
                start_pos,
                end_pos,
                color
              ),
              to: NIF,
              as: :draw_line_v

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
  defdelegate draw_line_ex(
                start_pos,
                end_pos,
                thick,
                color
              ),
              to: NIF,
              as: :draw_line_ex

  @doc """
  Draw lines sequence (using gl lines)
  """
  @doc group: :basic_drawing
  @spec draw_line_strip(
          points :: [Zexray.Type.Vector2.t_all()],
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_line_strip(
                points,
                color
              ),
              to: NIF,
              as: :draw_line_strip

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
  defdelegate draw_line_bezier(
                start_pos,
                end_pos,
                thick,
                color
              ),
              to: NIF,
              as: :draw_line_bezier

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
  defdelegate draw_circle(
                center_x,
                center_y,
                radius,
                color
              ),
              to: NIF,
              as: :draw_circle

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
  defdelegate draw_circle_sector(
                center,
                radius,
                start_angle,
                end_angle,
                segments,
                color
              ),
              to: NIF,
              as: :draw_circle_sector

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
  defdelegate draw_circle_sector_lines(
                center,
                radius,
                start_angle,
                end_angle,
                segments,
                color
              ),
              to: NIF,
              as: :draw_circle_sector_lines

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
  defdelegate draw_circle_gradient(
                center_x,
                center_y,
                radius,
                inner,
                outer
              ),
              to: NIF,
              as: :draw_circle_gradient

  @doc """
  Draw a color-filled circle (Vector version)
  """
  @doc group: :basic_drawing
  @spec draw_circle_v(
          center :: Zexray.Type.Vector2.t_all(),
          radius :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_circle_v(
                center,
                radius,
                color
              ),
              to: NIF,
              as: :draw_circle_v

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
  defdelegate draw_circle_lines(
                center_x,
                center_y,
                radius,
                color
              ),
              to: NIF,
              as: :draw_circle_lines

  @doc """
  Draw circle outline (Vector version)
  """
  @doc group: :basic_drawing
  @spec draw_circle_lines_v(
          center :: Zexray.Type.Vector2.t_all(),
          radius :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_circle_lines_v(
                center,
                radius,
                color
              ),
              to: NIF,
              as: :draw_circle_lines_v

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
  defdelegate draw_ellipse(
                center_x,
                center_y,
                radius_h,
                radius_v,
                color
              ),
              to: NIF,
              as: :draw_ellipse

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
  defdelegate draw_ellipse_lines(
                center_x,
                center_y,
                radius_h,
                radius_v,
                color
              ),
              to: NIF,
              as: :draw_ellipse_lines

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
  defdelegate draw_ring(
                center,
                inner_radius,
                outer_radius,
                start_angle,
                end_angle,
                segments,
                color
              ),
              to: NIF,
              as: :draw_ring

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
  defdelegate draw_ring_lines(
                center,
                inner_radius,
                outer_radius,
                start_angle,
                end_angle,
                segments,
                color
              ),
              to: NIF,
              as: :draw_ring_lines

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
  defdelegate draw_rectangle(
                pos_x,
                pos_y,
                width,
                height,
                color
              ),
              to: NIF,
              as: :draw_rectangle

  @doc """
  Draw a color-filled rectangle (Vector version)
  """
  @doc group: :basic_drawing
  @spec draw_rectangle_v(
          position :: Zexray.Type.Vector2.t_all(),
          size :: Zexray.Type.Vector2.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_rectangle_v(
                position,
                size,
                color
              ),
              to: NIF,
              as: :draw_rectangle_v

  @doc """
  Draw a color-filled rectangle
  """
  @doc group: :basic_drawing
  @spec draw_rectangle_rec(
          rec :: Zexray.Type.Rectangle.t_all(),
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_rectangle_rec(
                rec,
                color
              ),
              to: NIF,
              as: :draw_rectangle_rec

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
  defdelegate draw_rectangle_pro(
                rec,
                origin,
                rotation,
                color
              ),
              to: NIF,
              as: :draw_rectangle_pro

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
  defdelegate draw_rectangle_gradient_v(
                pos_x,
                pos_y,
                width,
                height,
                top,
                bottom
              ),
              to: NIF,
              as: :draw_rectangle_gradient_v

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
  defdelegate draw_rectangle_gradient_h(
                pos_x,
                pos_y,
                width,
                height,
                left,
                right
              ),
              to: NIF,
              as: :draw_rectangle_gradient_h

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
  defdelegate draw_rectangle_gradient_ex(
                rec,
                top_left,
                bottom_left,
                top_right,
                bottom_right
              ),
              to: NIF,
              as: :draw_rectangle_gradient_ex

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
  defdelegate draw_rectangle_lines(
                pos_x,
                pos_y,
                width,
                height,
                color
              ),
              to: NIF,
              as: :draw_rectangle_lines

  @doc """
  Draw rectangle outline with extended parameters
  """
  @doc group: :basic_drawing
  @spec draw_rectangle_lines_ex(
          rec :: Zexray.Type.Rectangle.t_all(),
          line_thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_rectangle_lines_ex(
                rec,
                line_thick,
                color
              ),
              to: NIF,
              as: :draw_rectangle_lines_ex

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
  defdelegate draw_rectangle_rounded(
                rec,
                roundness,
                segments,
                color
              ),
              to: NIF,
              as: :draw_rectangle_rounded

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
  defdelegate draw_rectangle_rounded_lines(
                rec,
                roundness,
                segments,
                color
              ),
              to: NIF,
              as: :draw_rectangle_rounded_lines

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
  defdelegate draw_rectangle_rounded_lines_ex(
                rec,
                roundness,
                segments,
                line_thick,
                color
              ),
              to: NIF,
              as: :draw_rectangle_rounded_lines_ex

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
  defdelegate draw_triangle(
                v1,
                v2,
                v3,
                color
              ),
              to: NIF,
              as: :draw_triangle

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
  defdelegate draw_triangle_lines(
                v1,
                v2,
                v3,
                color
              ),
              to: NIF,
              as: :draw_triangle_lines

  @doc """
  Draw a triangle fan defined by points (first vertex is the center)
  """
  @doc group: :basic_drawing
  @spec draw_triangle_fan(
          points :: [Zexray.Type.Vector2.t_all()],
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_triangle_fan(
                points,
                color
              ),
              to: NIF,
              as: :draw_triangle_fan

  @doc """
  Draw a triangle strip defined by points
  """
  @doc group: :basic_drawing
  @spec draw_triangle_strip(
          points :: [Zexray.Type.Vector2.t_all()],
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_triangle_strip(
                points,
                color
              ),
              to: NIF,
              as: :draw_triangle_strip

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
  defdelegate draw_poly(
                center,
                sides,
                radius,
                rotation,
                color
              ),
              to: NIF,
              as: :draw_poly

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
  defdelegate draw_poly_lines(
                center,
                sides,
                radius,
                rotation,
                color
              ),
              to: NIF,
              as: :draw_poly_lines

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
  defdelegate draw_poly_lines_ex(
                center,
                sides,
                radius,
                rotation,
                line_thick,
                color
              ),
              to: NIF,
              as: :draw_poly_lines_ex

  ####################
  #  Spline drawing  #
  ####################

  @doc """
  Draw spline: Linear, minimum 2 points
  """
  @doc group: :spline_drawing
  @spec draw_spline_linear(
          points :: [Zexray.Type.Vector2.t_all()],
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_spline_linear(
                points,
                thick,
                color
              ),
              to: NIF,
              as: :draw_spline_linear

  @doc """
  Draw spline: B-Spline, minimum 4 points
  """
  @doc group: :spline_drawing
  @spec draw_spline_basis(
          points :: [Zexray.Type.Vector2.t_all()],
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_spline_basis(
                points,
                thick,
                color
              ),
              to: NIF,
              as: :draw_spline_basis

  @doc """
  Draw spline: Catmull-Rom, minimum 4 points
  """
  @doc group: :spline_drawing
  @spec draw_spline_catmull_rom(
          points :: [Zexray.Type.Vector2.t_all()],
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_spline_catmull_rom(
                points,
                thick,
                color
              ),
              to: NIF,
              as: :draw_spline_catmull_rom

  @doc """
  Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]
  """
  @doc group: :spline_drawing
  @spec draw_spline_bezier_quadratic(
          points :: [Zexray.Type.Vector2.t_all()],
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_spline_bezier_quadratic(
                points,
                thick,
                color
              ),
              to: NIF,
              as: :draw_spline_bezier_quadratic

  @doc """
  Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]
  """
  @doc group: :spline_drawing
  @spec draw_spline_bezier_cubic(
          points :: [Zexray.Type.Vector2.t_all()],
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_spline_bezier_cubic(
                points,
                thick,
                color
              ),
              to: NIF,
              as: :draw_spline_bezier_cubic

  @doc """
  Draw spline segment: Linear, 2 points
  """
  @doc group: :spline_drawing
  @spec draw_spline_segment_linear(
          p1 :: Zexray.Type.Vector2.t_all(),
          p2 :: Zexray.Type.Vector2.t_all(),
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_spline_segment_linear(
                p1,
                p2,
                thick,
                color
              ),
              to: NIF,
              as: :draw_spline_segment_linear

  @doc """
  Draw spline segment: B-Spline, 4 points
  """
  @doc group: :spline_drawing
  @spec draw_spline_segment_basis(
          p1 :: Zexray.Type.Vector2.t_all(),
          p2 :: Zexray.Type.Vector2.t_all(),
          p3 :: Zexray.Type.Vector2.t_all(),
          p4 :: Zexray.Type.Vector2.t_all(),
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_spline_segment_basis(
                p1,
                p2,
                p3,
                p4,
                thick,
                color
              ),
              to: NIF,
              as: :draw_spline_segment_basis

  @doc """
  Draw spline segment: Catmull-Rom, 4 points
  """
  @doc group: :spline_drawing
  @spec draw_spline_segment_catmull_rom(
          p1 :: Zexray.Type.Vector2.t_all(),
          p2 :: Zexray.Type.Vector2.t_all(),
          p3 :: Zexray.Type.Vector2.t_all(),
          p4 :: Zexray.Type.Vector2.t_all(),
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_spline_segment_catmull_rom(
                p1,
                p2,
                p3,
                p4,
                thick,
                color
              ),
              to: NIF,
              as: :draw_spline_segment_catmull_rom

  @doc """
  Draw spline segment: Quadratic Bezier, 2 points, 1 control point
  """
  @doc group: :spline_drawing
  @spec draw_spline_segment_bezier_quadratic(
          p1 :: Zexray.Type.Vector2.t_all(),
          c2 :: Zexray.Type.Vector2.t_all(),
          p3 :: Zexray.Type.Vector2.t_all(),
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_spline_segment_bezier_quadratic(
                p1,
                c2,
                p3,
                thick,
                color
              ),
              to: NIF,
              as: :draw_spline_segment_bezier_quadratic

  @doc """
  Draw spline segment: Cubic Bezier, 2 points, 2 control points
  """
  @doc group: :spline_drawing
  @spec draw_spline_segment_bezier_cubic(
          p1 :: Zexray.Type.Vector2.t_all(),
          c2 :: Zexray.Type.Vector2.t_all(),
          c3 :: Zexray.Type.Vector2.t_all(),
          p4 :: Zexray.Type.Vector2.t_all(),
          thick :: float,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_spline_segment_bezier_cubic(
                p1,
                c2,
                c3,
                p4,
                thick,
                color
              ),
              to: NIF,
              as: :draw_spline_segment_bezier_cubic

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
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  defdelegate get_spline_point_linear(
                start_pos,
                end_pos,
                t,
                return \\ :auto
              ),
              to: NIF,
              as: :get_spline_point_linear

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
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  defdelegate get_spline_point_basis(
                p1,
                p2,
                p3,
                p4,
                t,
                return \\ :auto
              ),
              to: NIF,
              as: :get_spline_point_basis

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
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  defdelegate get_spline_point_catmull_rom(
                p1,
                p2,
                p3,
                p4,
                t,
                return \\ :auto
              ),
              to: NIF,
              as: :get_spline_point_catmull_rom

  @doc """
  Get (evaluate) spline point: Quadratic Bezier
  """
  @doc group: :spline_segment_point_evaluation
  @spec get_spline_point_bezier_quad(
          p1 :: Zexray.Type.Vector2.t_all(),
          c2 :: Zexray.Type.Vector2.t_all(),
          p3 :: Zexray.Type.Vector2.t_all(),
          t :: float,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  defdelegate get_spline_point_bezier_quad(
                p1,
                c2,
                p3,
                t,
                return \\ :auto
              ),
              to: NIF,
              as: :get_spline_point_bezier_quad

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
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  defdelegate get_spline_point_bezier_cubic(
                p1,
                c2,
                c3,
                p4,
                t,
                return \\ :auto
              ),
              to: NIF,
              as: :get_spline_point_bezier_cubic

  #########################
  #  Collision detection  #
  #########################

  @doc """
  Check collision between two rectangles
  """
  @doc group: :collision_detection
  @spec collision_recs?(
          rec1 :: Zexray.Type.Rectangle.t_all(),
          rec2 :: Zexray.Type.Rectangle.t_all()
        ) :: boolean
  defdelegate collision_recs?(
                rec1,
                rec2
              ),
              to: NIF,
              as: :check_collision_recs

  @doc """
  Check collision between two circles
  """
  @doc group: :collision_detection
  @spec collision_circles?(
          center1 :: Zexray.Type.Vector2.t_all(),
          radius1 :: float,
          center2 :: Zexray.Type.Vector2.t_all(),
          radius2 :: float
        ) :: boolean
  defdelegate collision_circles?(
                center1,
                radius1,
                center2,
                radius2
              ),
              to: NIF,
              as: :check_collision_circles

  @doc """
  Check collision between circle and rectangle
  """
  @doc group: :collision_detection
  @spec collision_circle_rec?(
          center :: Zexray.Type.Vector2.t_all(),
          radius :: float,
          rec :: Zexray.Type.Rectangle.t_all()
        ) :: boolean
  defdelegate collision_circle_rec?(
                center,
                radius,
                rec
              ),
              to: NIF,
              as: :check_collision_circle_rec

  @doc """
  Check if circle collides with a line created betweeen two points [p1] and [p2]
  """
  @doc group: :collision_detection
  @spec collision_circle_line?(
          center :: Zexray.Type.Vector2.t_all(),
          radius :: float,
          p1 :: Zexray.Type.Vector2.t_all(),
          p2 :: Zexray.Type.Vector2.t_all()
        ) :: boolean
  defdelegate collision_circle_line?(
                center,
                radius,
                p1,
                p2
              ),
              to: NIF,
              as: :check_collision_circle_line

  @doc """
  Check if point is inside rectangle
  """
  @doc group: :collision_detection
  @spec collision_point_rec?(
          point :: Zexray.Type.Vector2.t_all(),
          rec :: Zexray.Type.Rectangle.t_all()
        ) :: boolean
  defdelegate collision_point_rec?(
                point,
                rec
              ),
              to: NIF,
              as: :check_collision_point_rec

  @doc """
  Check if point is inside circle
  """
  @doc group: :collision_detection
  @spec collision_point_circle?(
          point :: Zexray.Type.Vector2.t_all(),
          center :: Zexray.Type.Vector2.t_all(),
          radius :: float
        ) :: boolean
  defdelegate collision_point_circle?(
                point,
                center,
                radius
              ),
              to: NIF,
              as: :check_collision_point_circle

  @doc """
  Check if point is inside a triangle
  """
  @doc group: :collision_detection
  @spec collision_point_triangle?(
          point :: Zexray.Type.Vector2.t_all(),
          p1 :: Zexray.Type.Vector2.t_all(),
          p2 :: Zexray.Type.Vector2.t_all(),
          p3 :: Zexray.Type.Vector2.t_all()
        ) :: boolean
  defdelegate collision_point_triangle?(
                point,
                p1,
                p2,
                p3
              ),
              to: NIF,
              as: :check_collision_point_triangle

  @doc """
  Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
  """
  @doc group: :collision_detection
  @spec collision_point_line?(
          point :: Zexray.Type.Vector2.t_all(),
          p1 :: Zexray.Type.Vector2.t_all(),
          p2 :: Zexray.Type.Vector2.t_all(),
          threshold :: integer
        ) :: boolean
  defdelegate collision_point_line?(
                point,
                p1,
                p2,
                threshold
              ),
              to: NIF,
              as: :check_collision_point_line

  @doc """
  Check if point is within a polygon described by array of vertices
  """
  @doc group: :collision_detection
  @spec collision_point_poly?(
          point :: Zexray.Type.Vector2.t_all(),
          points :: [Zexray.Type.Vector2.t_all()]
        ) :: boolean
  defdelegate collision_point_poly?(
                point,
                points
              ),
              to: NIF,
              as: :check_collision_point_poly

  @doc """
  Check the collision between two lines defined by two points each, returns collision point by reference
  """
  @doc group: :collision_detection
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
      ) do
    {collision, _} =
      NIF.check_collision_lines(
        start_pos1,
        end_pos1,
        start_pos2,
        end_pos2
      )

    collision
  end

  @doc """
  Check the collision between two lines defined by two points each, returns collision point by reference
  """
  @doc group: :collision_detection
  @spec collision_lines_ex?(
          start_pos1 :: Zexray.Type.Vector2.t_all(),
          end_pos1 :: Zexray.Type.Vector2.t_all(),
          start_pos2 :: Zexray.Type.Vector2.t_all(),
          end_pos2 :: Zexray.Type.Vector2.t_all(),
          return :: :auto | :value | :resource
        ) :: {collision :: boolean, collision_point :: Zexray.Type.Vector2.t_nif()}
  defdelegate collision_lines_ex?(
                start_pos1,
                end_pos1,
                start_pos2,
                end_pos2,
                return \\ :auto
              ),
              to: NIF,
              as: :check_collision_lines

  @doc """
  Get collision rectangle for two rectangles collision
  """
  @doc group: :collision_detection
  @spec collision_recs_ex?(
          rec1 :: Zexray.Type.Rectangle.t_all(),
          rec2 :: Zexray.Type.Rectangle.t_all(),
          return :: :auto | :value | :resource
        ) :: {collision :: boolean, collision_rec :: Zexray.Type.Rectangle.t_nif()}
  def collision_recs_ex?(
        rec1,
        rec2,
        return \\ :auto
      ) do
    collision_rec =
      NIF.get_collision_rec(
        rec1,
        rec2,
        return
      )

    collision =
      case return do
        :value ->
          not (collision_rec == type_rectangle(x: 0.0, y: 0.0, width: 0.0, height: 0.0))

        _ ->
          NIF.check_collision_recs(
            rec1,
            rec2
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
  @doc group: :collision_detection
  @spec get_collision_rec(
          rec1 :: Zexray.Type.Rectangle.t_all(),
          rec2 :: Zexray.Type.Rectangle.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Rectangle.t_nif()
  defdelegate get_collision_rec(
                rec1,
                rec2,
                return \\ :auto
              ),
              to: NIF,
              as: :get_collision_rec
end
