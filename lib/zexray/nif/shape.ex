defmodule Zexray.NIF.Shape do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_shape [
        # Shapes configuration
        set_shapes_texture: 2,
        get_shapes_texture: 0,
        get_shapes_texture: 1,
        get_shapes_texture_rectangle: 0,
        get_shapes_texture_rectangle: 1,

        # Basic shapes drawing
        draw_pixel: 3,
        draw_pixel_v: 2,
        draw_line: 5,
        draw_line_v: 3,
        draw_line_ex: 4,
        draw_line_strip: 2,
        draw_line_bezier: 4,
        draw_circle: 4,
        draw_circle_sector: 6,
        draw_circle_sector_lines: 6,
        draw_circle_gradient: 5,
        draw_circle_v: 3,
        draw_circle_lines: 4,
        draw_circle_lines_v: 3,
        draw_ellipse: 5,
        draw_ellipse_v: 4,
        draw_ellipse_lines: 5,
        draw_ellipse_lines_v: 4,
        draw_ring: 7,
        draw_ring_lines: 7,
        draw_rectangle: 5,
        draw_rectangle_v: 3,
        draw_rectangle_rec: 2,
        draw_rectangle_pro: 4,
        draw_rectangle_gradient_v: 6,
        draw_rectangle_gradient_h: 6,
        draw_rectangle_gradient_ex: 5,
        draw_rectangle_lines: 5,
        draw_rectangle_lines_ex: 3,
        draw_rectangle_rounded: 4,
        draw_rectangle_rounded_lines: 4,
        draw_rectangle_rounded_lines_ex: 5,
        draw_triangle: 4,
        draw_triangle_lines: 4,
        draw_triangle_fan: 2,
        draw_triangle_strip: 2,
        draw_poly: 5,
        draw_poly_lines: 5,
        draw_poly_lines_ex: 6,

        # Splines drawing
        draw_spline_linear: 3,
        draw_spline_basis: 3,
        draw_spline_catmull_rom: 3,
        draw_spline_bezier_quadratic: 3,
        draw_spline_bezier_cubic: 3,
        draw_spline_segment_linear: 4,
        draw_spline_segment_basis: 6,
        draw_spline_segment_catmull_rom: 6,
        draw_spline_segment_bezier_quadratic: 5,
        draw_spline_segment_bezier_cubic: 6,

        # Spline segment point evaluation
        get_spline_point_linear: 3,
        get_spline_point_linear: 4,
        get_spline_point_basis: 5,
        get_spline_point_basis: 6,
        get_spline_point_catmull_rom: 5,
        get_spline_point_catmull_rom: 6,
        get_spline_point_bezier_quad: 4,
        get_spline_point_bezier_quad: 5,
        get_spline_point_bezier_cubic: 5,
        get_spline_point_bezier_cubic: 6,

        # Basic shapes collision detection
        check_collision_recs: 2,
        check_collision_circles: 4,
        check_collision_circle_rec: 3,
        check_collision_circle_line: 4,
        check_collision_point_rec: 2,
        check_collision_point_circle: 3,
        check_collision_point_triangle: 4,
        check_collision_point_line: 4,
        check_collision_point_poly: 2,
        check_collision_lines: 4,
        check_collision_lines: 5,
        get_collision_rec: 2,
        get_collision_rec: 3
      ]

      ##########################
      #  Shapes configuration  #
      ##########################

      @doc """
      Set texture and rectangle to be used on shapes drawing

      ```c
      // raylib.h
      RLAPI void SetShapesTexture(Texture2D texture, Rectangle source);
      ```
      """
      @doc group: :shapes_configuration
      @spec set_shapes_texture(
              texture :: tuple,
              source :: tuple
            ) :: :ok
      def set_shapes_texture(
            _texture,
            _source
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get texture that is used for shapes drawing

      ```c
      // raylib.h
      RLAPI Texture2D GetShapesTexture(void);
      ```
      """
      @doc group: :shapes_configuration
      @spec get_shapes_texture(return :: :auto | :value | :resource) :: tuple
      def get_shapes_texture(_return \\ :auto), do: :erlang.nif_error(:undef)

      @doc """
      Get texture source rectangle that is used for shapes drawing

      ```c
      // raylib.h
      RLAPI Rectangle GetShapesTextureRectangle(void);
      ```
      """
      @doc group: :shapes_configuration
      @spec get_shapes_texture_rectangle(return :: :auto | :value | :resource) :: tuple
      def get_shapes_texture_rectangle(_return \\ :auto), do: :erlang.nif_error(:undef)

      ##########################
      #  Basic shapes drawing  #
      ##########################

      @doc """
      Draw a pixel using geometry [Can be slow, use with care]

      ```c
      // raylib.h
      RLAPI void DrawPixel(int posX, int posY, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_pixel(
              pos_x :: integer,
              pos_y :: integer,
              color :: tuple
            ) :: :ok
      def draw_pixel(
            _pos_x,
            _pos_y,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a pixel using geometry (Vector version) [Can be slow, use with care]

      ```c
      // raylib.h
      RLAPI void DrawPixelV(Vector2 position, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_pixel_v(
              position :: tuple,
              color :: tuple
            ) :: :ok
      def draw_pixel_v(
            _position,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a line

      ```c
      // raylib.h
      RLAPI void DrawLine(int startPosX, int startPosY, int endPosX, int endPosY, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_line(
              start_pos_x :: integer,
              start_pos_y :: integer,
              end_pos_x :: integer,
              end_pos_y :: integer,
              color :: tuple
            ) :: :ok
      def draw_line(
            _start_pos_x,
            _start_pos_y,
            _end_pos_x,
            _end_pos_y,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a line (using gl lines)

      ```c
      // raylib.h
      RLAPI void DrawLineV(Vector2 startPos, Vector2 endPos, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_line_v(
              start_pos :: tuple,
              end_pos :: tuple,
              color :: tuple
            ) :: :ok
      def draw_line_v(
            _start_pos,
            _end_pos,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a line (using triangles/quads)

      ```c
      // raylib.h
      RLAPI void DrawLineEx(Vector2 startPos, Vector2 endPos, float thick, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_line_ex(
              start_pos :: tuple,
              end_pos :: tuple,
              thick :: number,
              color :: tuple
            ) :: :ok
      def draw_line_ex(
            _start_pos,
            _end_pos,
            _thick,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw lines sequence (using gl lines)

      ```c
      // raylib.h
      RLAPI void DrawLineStrip(const Vector2 *points, int pointCount, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_line_strip(
              points :: [tuple],
              color :: tuple
            ) :: :ok
      def draw_line_strip(
            _points,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw line segment cubic-bezier in-out interpolation

      ```c
      // raylib.h
      RLAPI void DrawLineBezier(Vector2 startPos, Vector2 endPos, float thick, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_line_bezier(
              start_pos :: tuple,
              end_pos :: tuple,
              thick :: number,
              color :: tuple
            ) :: :ok
      def draw_line_bezier(
            _start_pos,
            _end_pos,
            _thick,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a color-filled circle

      ```c
      // raylib.h
      RLAPI void DrawCircle(int centerX, int centerY, float radius, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_circle(
              center_x :: integer,
              center_y :: integer,
              radius :: number,
              color :: tuple
            ) :: :ok
      def draw_circle(
            _center_x,
            _center_y,
            _radius,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a piece of a circle

      ```c
      // raylib.h
      RLAPI void DrawCircleSector(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_circle_sector(
              center :: tuple,
              radius :: number,
              start_angle :: number,
              end_angle :: number,
              segments :: integer,
              color :: tuple
            ) :: :ok
      def draw_circle_sector(
            _center,
            _radius,
            _start_angle,
            _end_angle,
            _segments,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw circle sector outline

      ```c
      // raylib.h
      RLAPI void DrawCircleSectorLines(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_circle_sector_lines(
              center :: tuple,
              radius :: number,
              start_angle :: number,
              end_angle :: number,
              segments :: integer,
              color :: tuple
            ) :: :ok
      def draw_circle_sector_lines(
            _center,
            _radius,
            _start_angle,
            _end_angle,
            _segments,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a gradient-filled circle

      ```c
      // raylib.h
      RLAPI void DrawCircleGradient(int centerX, int centerY, float radius, Color inner, Color outer);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_circle_gradient(
              center_x :: integer,
              center_y :: integer,
              radius :: number,
              inner :: tuple,
              outer :: tuple
            ) :: :ok
      def draw_circle_gradient(
            _center_x,
            _center_y,
            _radius,
            _inner,
            _outer
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a color-filled circle (Vector version)

      ```c
      // raylib.h
      RLAPI void DrawCircleV(Vector2 center, float radius, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_circle_v(
              center :: tuple,
              radius :: number,
              color :: tuple
            ) :: :ok
      def draw_circle_v(
            _center,
            _radius,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw circle outline

      ```c
      // raylib.h
      RLAPI void DrawCircleLines(int centerX, int centerY, float radius, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_circle_lines(
              center_x :: integer,
              center_y :: integer,
              radius :: number,
              color :: tuple
            ) :: :ok
      def draw_circle_lines(
            _center_x,
            _center_y,
            _radius,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw circle outline (Vector version)

      ```c
      // raylib.h
      RLAPI void DrawCircleLinesV(Vector2 center, float radius, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_circle_lines_v(
              center :: tuple,
              radius :: number,
              color :: tuple
            ) :: :ok
      def draw_circle_lines_v(
            _center,
            _radius,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw ellipse

      ```c
      // raylib.h
      RLAPI void DrawEllipse(int centerX, int centerY, float radiusH, float radiusV, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_ellipse(
              center_x :: integer,
              center_y :: integer,
              radius_h :: number,
              radius_v :: number,
              color :: tuple
            ) :: :ok
      def draw_ellipse(
            _center_x,
            _center_y,
            _radius_h,
            _radius_v,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw ellipse (Vector version)

      ```c
      // raylib.h
      RLAPI void DrawEllipseV(Vector2 center, float radiusH, float radiusV, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_ellipse_v(
              center :: tuple,
              radius_h :: number,
              radius_v :: number,
              color :: tuple
            ) :: :ok
      def draw_ellipse_v(
            _center,
            _radius_h,
            _radius_v,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw ellipse outline

      ```c
      // raylib.h
      RLAPI void DrawEllipseLines(int centerX, int centerY, float radiusH, float radiusV, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_ellipse_lines(
              center_x :: integer,
              center_y :: integer,
              radius_h :: number,
              radius_v :: number,
              color :: tuple
            ) :: :ok
      def draw_ellipse_lines(
            _center_x,
            _center_y,
            _radius_h,
            _radius_v,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw ellipse outline (Vector version)

      ```c
      // raylib.h
      RLAPI void DrawEllipseLinesV(Vector2 center, float radiusH, float radiusV, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_ellipse_lines_v(
              center :: tuple,
              radius_h :: number,
              radius_v :: number,
              color :: tuple
            ) :: :ok
      def draw_ellipse_lines_v(
            _center,
            _radius_h,
            _radius_v,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw ring

      ```c
      // raylib.h
      RLAPI void DrawRing(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_ring(
              center :: tuple,
              inner_radius :: number,
              outer_radius :: number,
              start_angle :: number,
              end_angle :: number,
              segments :: integer,
              color :: tuple
            ) :: :ok
      def draw_ring(
            _center,
            _inner_radius,
            _outer_radius,
            _start_angle,
            _end_angle,
            _segments,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw ring outline

      ```c
      // raylib.h
      RLAPI void DrawRingLines(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_ring_lines(
              center :: tuple,
              inner_radius :: number,
              outer_radius :: number,
              start_angle :: number,
              end_angle :: number,
              segments :: integer,
              color :: tuple
            ) :: :ok
      def draw_ring_lines(
            _center,
            _inner_radius,
            _outer_radius,
            _start_angle,
            _end_angle,
            _segments,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a color-filled rectangle

      ```c
      // raylib.h
      RLAPI void DrawRectangle(int posX, int posY, int width, int height, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_rectangle(
              pos_x :: integer,
              pos_y :: integer,
              width :: integer,
              height :: integer,
              color :: tuple
            ) :: :ok
      def draw_rectangle(
            _pos_x,
            _pos_y,
            _width,
            _height,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a color-filled rectangle (Vector version)

      ```c
      // raylib.h
      RLAPI void DrawRectangleV(Vector2 position, Vector2 size, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_rectangle_v(
              position :: tuple,
              size :: tuple,
              color :: tuple
            ) :: :ok
      def draw_rectangle_v(
            _position,
            _size,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a color-filled rectangle

      ```c
      // raylib.h
      RLAPI void DrawRectangleRec(Rectangle rec, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_rectangle_rec(
              rec :: tuple,
              color :: tuple
            ) :: :ok
      def draw_rectangle_rec(
            _rec,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a color-filled rectangle with pro parameters

      ```c
      // raylib.h
      RLAPI void DrawRectanglePro(Rectangle rec, Vector2 origin, float rotation, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_rectangle_pro(
              rec :: tuple,
              origin :: tuple,
              rotation :: number,
              color :: tuple
            ) :: :ok
      def draw_rectangle_pro(
            _rec,
            _origin,
            _rotation,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a vertical-gradient-filled rectangle

      ```c
      // raylib.h
      RLAPI void DrawRectangleGradientV(int posX, int posY, int width, int height, Color top, Color bottom);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_rectangle_gradient_v(
              pos_x :: integer,
              pos_y :: integer,
              width :: integer,
              height :: integer,
              top :: tuple,
              bottom :: tuple
            ) :: :ok
      def draw_rectangle_gradient_v(
            _pos_x,
            _pos_y,
            _width,
            _height,
            _top,
            _bottom
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a horizontal-gradient-filled rectangle

      ```c
      // raylib.h
      RLAPI void DrawRectangleGradientH(int posX, int posY, int width, int height, Color left, Color right);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_rectangle_gradient_h(
              pos_x :: integer,
              pos_y :: integer,
              width :: integer,
              height :: integer,
              left :: tuple,
              right :: tuple
            ) :: :ok
      def draw_rectangle_gradient_h(
            _pos_x,
            _pos_y,
            _width,
            _height,
            _left,
            _right
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a gradient-filled rectangle with custom vertex colors

      ```c
      // raylib.h
      RLAPI void DrawRectangleGradientEx(Rectangle rec, Color topLeft, Color bottomLeft, Color bottomRight, Color topRight);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_rectangle_gradient_ex(
              rec :: tuple,
              top_left :: tuple,
              bottom_left :: tuple,
              top_right :: tuple,
              bottom_right :: tuple
            ) :: :ok
      def draw_rectangle_gradient_ex(
            _rec,
            _top_left,
            _bottom_left,
            _top_right,
            _bottom_right
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw rectangle outline

      ```c
      // raylib.h
      RLAPI void DrawRectangleLines(int posX, int posY, int width, int height, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_rectangle_lines(
              pos_x :: integer,
              pos_y :: integer,
              width :: integer,
              height :: integer,
              color :: tuple
            ) :: :ok
      def draw_rectangle_lines(
            _pos_x,
            _pos_y,
            _width,
            _height,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw rectangle outline with extended parameters

      ```c
      // raylib.h
      RLAPI void DrawRectangleLinesEx(Rectangle rec, float lineThick, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_rectangle_lines_ex(
              rec :: tuple,
              line_thick :: number,
              color :: tuple
            ) :: :ok
      def draw_rectangle_lines_ex(
            _rec,
            _line_thick,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw rectangle with rounded edges

      ```c
      // raylib.h
      RLAPI void DrawRectangleRounded(Rectangle rec, float roundness, int segments, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_rectangle_rounded(
              rec :: tuple,
              roundness :: number,
              segments :: integer,
              color :: tuple
            ) :: :ok
      def draw_rectangle_rounded(
            _rec,
            _roundness,
            _segments,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw rectangle lines with rounded edges

      ```c
      // raylib.h
      RLAPI void DrawRectangleRoundedLines(Rectangle rec, float roundness, int segments, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_rectangle_rounded_lines(
              rec :: tuple,
              roundness :: number,
              segments :: integer,
              color :: tuple
            ) :: :ok
      def draw_rectangle_rounded_lines(
            _rec,
            _roundness,
            _segments,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw rectangle with rounded edges outline

      ```c
      // raylib.h
      RLAPI void DrawRectangleRoundedLinesEx(Rectangle rec, float roundness, int segments, float lineThick, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_rectangle_rounded_lines_ex(
              rec :: tuple,
              roundness :: number,
              segments :: integer,
              line_thick :: number,
              color :: tuple
            ) :: :ok
      def draw_rectangle_rounded_lines_ex(
            _rec,
            _roundness,
            _segments,
            _line_thick,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a color-filled triangle (vertex in counter-clockwise order!)

      ```c
      // raylib.h
      RLAPI void DrawTriangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_triangle(
              v1 :: tuple,
              v2 :: tuple,
              v3 :: tuple,
              color :: tuple
            ) :: :ok
      def draw_triangle(
            _v1,
            _v2,
            _v3,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw triangle outline (vertex in counter-clockwise order!)

      ```c
      // raylib.h
      RLAPI void DrawTriangleLines(Vector2 v1, Vector2 v2, Vector2 v3, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_triangle_lines(
              v1 :: tuple,
              v2 :: tuple,
              v3 :: tuple,
              color :: tuple
            ) :: :ok
      def draw_triangle_lines(
            _v1,
            _v2,
            _v3,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a triangle fan defined by points (first vertex is the center)

      ```c
      // raylib.h
      RLAPI void DrawTriangleFan(const Vector2 *points, int pointCount, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_triangle_fan(
              points :: [tuple],
              color :: tuple
            ) :: :ok
      def draw_triangle_fan(
            _points,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a triangle strip defined by points

      ```c
      // raylib.h
      RLAPI void DrawTriangleStrip(const Vector2 *points, int pointCount, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_triangle_strip(
              points :: [tuple],
              color :: tuple
            ) :: :ok
      def draw_triangle_strip(
            _points,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a regular polygon (Vector version)

      ```c
      // raylib.h
      RLAPI void DrawPoly(Vector2 center, int sides, float radius, float rotation, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_poly(
              center :: tuple,
              sides :: integer,
              radius :: number,
              rotation :: number,
              color :: tuple
            ) :: :ok
      def draw_poly(
            _center,
            _sides,
            _radius,
            _rotation,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a polygon outline of n sides

      ```c
      // raylib.h
      RLAPI void DrawPolyLines(Vector2 center, int sides, float radius, float rotation, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_poly_lines(
              center :: tuple,
              sides :: integer,
              radius :: number,
              rotation :: number,
              color :: tuple
            ) :: :ok
      def draw_poly_lines(
            _center,
            _sides,
            _radius,
            _rotation,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a polygon outline of n sides with extended parameters

      ```c
      // raylib.h
      RLAPI void DrawPolyLinesEx(Vector2 center, int sides, float radius, float rotation, float lineThick, Color color);
      ```
      """
      @doc group: :basic_shapes_drawing
      @spec draw_poly_lines_ex(
              center :: tuple,
              sides :: integer,
              radius :: number,
              rotation :: number,
              line_thick :: number,
              color :: tuple
            ) :: :ok
      def draw_poly_lines_ex(
            _center,
            _sides,
            _radius,
            _rotation,
            _line_thick,
            _color
          ),
          do: :erlang.nif_error(:undef)

      #####################
      #  Splines drawing  #
      #####################

      @doc """
      Draw spline: Linear, minimum 2 points

      ```c
      // raylib.h
      RLAPI void DrawSplineLinear(const Vector2 *points, int pointCount, float thick, Color color);
      ```
      """
      @doc group: :splines_drawing
      @spec draw_spline_linear(
              points :: [tuple],
              thick :: number,
              color :: tuple
            ) :: :ok
      def draw_spline_linear(
            _points,
            _thick,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw spline: B-Spline, minimum 4 points

      ```c
      // raylib.h
      RLAPI void DrawSplineBasis(const Vector2 *points, int pointCount, float thick, Color color);
      ```
      """
      @doc group: :splines_drawing
      @spec draw_spline_basis(
              points :: [tuple],
              thick :: number,
              color :: tuple
            ) :: :ok
      def draw_spline_basis(
            _points,
            _thick,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw spline: Catmull-Rom, minimum 4 points

      ```c
      // raylib.h
      RLAPI void DrawSplineCatmullRom(const Vector2 *points, int pointCount, float thick, Color color);
      ```
      """
      @doc group: :splines_drawing
      @spec draw_spline_catmull_rom(
              points :: [tuple],
              thick :: number,
              color :: tuple
            ) :: :ok
      def draw_spline_catmull_rom(
            _points,
            _thick,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]

      ```c
      // raylib.h
      RLAPI void DrawSplineBezierQuadratic(const Vector2 *points, int pointCount, float thick, Color color);
      ```
      """
      @doc group: :splines_drawing
      @spec draw_spline_bezier_quadratic(
              points :: [tuple],
              thick :: number,
              color :: tuple
            ) :: :ok
      def draw_spline_bezier_quadratic(
            _points,
            _thick,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]

      ```c
      // raylib.h
      RLAPI void DrawSplineBezierCubic(const Vector2 *points, int pointCount, float thick, Color color);
      ```
      """
      @doc group: :splines_drawing
      @spec draw_spline_bezier_cubic(
              points :: [tuple],
              thick :: number,
              color :: tuple
            ) :: :ok
      def draw_spline_bezier_cubic(
            _points,
            _thick,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw spline segment: Linear, 2 points

      ```c
      // raylib.h
      RLAPI void DrawSplineSegmentLinear(Vector2 p1, Vector2 p2, float thick, Color color);
      ```
      """
      @doc group: :splines_drawing
      @spec draw_spline_segment_linear(
              p1 :: tuple,
              p2 :: tuple,
              thick :: number,
              color :: tuple
            ) :: :ok
      def draw_spline_segment_linear(
            _p1,
            _p2,
            _thick,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw spline segment: B-Spline, 4 points

      ```c
      // raylib.h
      RLAPI void DrawSplineSegmentBasis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color);
      ```
      """
      @doc group: :splines_drawing
      @spec draw_spline_segment_basis(
              p1 :: tuple,
              p2 :: tuple,
              p3 :: tuple,
              p4 :: tuple,
              thick :: number,
              color :: tuple
            ) :: :ok
      def draw_spline_segment_basis(
            _p1,
            _p2,
            _p3,
            _p4,
            _thick,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw spline segment: Catmull-Rom, 4 points

      ```c
      // raylib.h
      RLAPI void DrawSplineSegmentCatmullRom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color);
      ```
      """
      @doc group: :splines_drawing
      @spec draw_spline_segment_catmull_rom(
              p1 :: tuple,
              p2 :: tuple,
              p3 :: tuple,
              p4 :: tuple,
              thick :: number,
              color :: tuple
            ) :: :ok
      def draw_spline_segment_catmull_rom(
            _p1,
            _p2,
            _p3,
            _p4,
            _thick,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw spline segment: Quadratic Bezier, 2 points, 1 control point

      ```c
      // raylib.h
      RLAPI void DrawSplineSegmentBezierQuadratic(Vector2 p1, Vector2 c2, Vector2 p3, float thick, Color color);
      ```
      """
      @doc group: :splines_drawing
      @spec draw_spline_segment_bezier_quadratic(
              p1 :: tuple,
              c2 :: tuple,
              p3 :: tuple,
              thick :: number,
              color :: tuple
            ) :: :ok
      def draw_spline_segment_bezier_quadratic(
            _p1,
            _c2,
            _p3,
            _thick,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw spline segment: Cubic Bezier, 2 points, 2 control points

      ```c
      // raylib.h
      RLAPI void DrawSplineSegmentBezierCubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float thick, Color color);
      ```
      """
      @doc group: :splines_drawing
      @spec draw_spline_segment_bezier_cubic(
              p1 :: tuple,
              c2 :: tuple,
              c3 :: tuple,
              p4 :: tuple,
              thick :: number,
              color :: tuple
            ) :: :ok
      def draw_spline_segment_bezier_cubic(
            _p1,
            _c2,
            _c3,
            _p4,
            _thick,
            _color
          ),
          do: :erlang.nif_error(:undef)

      #####################################
      #  Spline segment point evaluation  #
      #####################################

      @doc """
      Get (evaluate) spline point: Linear

      ```c
      // raylib.h
      RLAPI Vector2 GetSplinePointLinear(Vector2 startPos, Vector2 endPos, float t);
      ```
      """
      @doc group: :spline_segment_point_evaluation
      @spec get_spline_point_linear(
              start_pos :: tuple,
              end_pos :: tuple,
              t :: number,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_spline_point_linear(
            _start_pos,
            _end_pos,
            _t,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get (evaluate) spline point: B-Spline

      ```c
      // raylib.h
      RLAPI Vector2 GetSplinePointBasis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t);
      ```
      """
      @doc group: :spline_segment_point_evaluation
      @spec get_spline_point_basis(
              p1 :: tuple,
              p2 :: tuple,
              p3 :: tuple,
              p4 :: tuple,
              t :: number,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_spline_point_basis(
            _p1,
            _p2,
            _p3,
            _p4,
            _t,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get (evaluate) spline point: Catmull-Rom

      ```c
      // raylib.h
      RLAPI Vector2 GetSplinePointCatmullRom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t);
      ```
      """
      @doc group: :spline_segment_point_evaluation
      @spec get_spline_point_catmull_rom(
              p1 :: tuple,
              p2 :: tuple,
              p3 :: tuple,
              p4 :: tuple,
              t :: number,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_spline_point_catmull_rom(
            _p1,
            _p2,
            _p3,
            _p4,
            _t,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get (evaluate) spline point: Quadratic Bezier

      ```c
      // raylib.h
      RLAPI Vector2 GetSplinePointBezierQuad(Vector2 p1, Vector2 c2, Vector2 p3, float t);
      ```
      """
      @doc group: :spline_segment_point_evaluation
      @spec get_spline_point_bezier_quad(
              p1 :: tuple,
              c2 :: tuple,
              p3 :: tuple,
              t :: number,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_spline_point_bezier_quad(
            _p1,
            _c2,
            _p3,
            _t,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get (evaluate) spline point: Cubic Bezier

      ```c
      // raylib.h
      RLAPI Vector2 GetSplinePointBezierCubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float t);
      ```
      """
      @doc group: :spline_segment_point_evaluation
      @spec get_spline_point_bezier_cubic(
              p1 :: tuple,
              c2 :: tuple,
              c3 :: tuple,
              p4 :: tuple,
              t :: number,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_spline_point_bezier_cubic(
            _p1,
            _c2,
            _c3,
            _p4,
            _t,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      ######################################
      #  Basic shapes collision detection  #
      ######################################

      @doc """
      Check collision between two rectangles

      ```c
      // raylib.h
      RLAPI bool CheckCollisionRecs(Rectangle rec1, Rectangle rec2);
      ```
      """
      @doc group: :basic_shapes_collision_detection
      @spec check_collision_recs(
              rec1 :: tuple,
              rec2 :: tuple
            ) :: boolean
      def check_collision_recs(
            _rec1,
            _rec2
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check collision between two circles

      ```c
      // raylib.h
      RLAPI bool CheckCollisionCircles(Vector2 center1, float radius1, Vector2 center2, float radius2);
      ```
      """
      @doc group: :basic_shapes_collision_detection
      @spec check_collision_circles(
              center1 :: tuple,
              radius1 :: number,
              center2 :: tuple,
              radius2 :: number
            ) :: boolean
      def check_collision_circles(
            _center1,
            _radius1,
            _center2,
            _radius2
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check collision between circle and rectangle

      ```c
      // raylib.h
      RLAPI bool CheckCollisionCircleRec(Vector2 center, float radius, Rectangle rec);
      ```
      """
      @doc group: :basic_shapes_collision_detection
      @spec check_collision_circle_rec(
              center :: tuple,
              radius :: number,
              rec :: tuple
            ) :: boolean
      def check_collision_circle_rec(
            _center,
            _radius,
            _rec
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check if circle collides with a line created betweeen two points [p1] and [p2]

      ```c
      // raylib.h
      RLAPI bool CheckCollisionCircleLine(Vector2 center, float radius, Vector2 p1, Vector2 p2);
      ```
      """
      @doc group: :basic_shapes_collision_detection
      @spec check_collision_circle_line(
              center :: tuple,
              radius :: number,
              p1 :: tuple,
              p2 :: tuple
            ) :: boolean
      def check_collision_circle_line(
            _center,
            _radius,
            _p1,
            _p2
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check if point is inside rectangle

      ```c
      // raylib.h
      RLAPI bool CheckCollisionPointRec(Vector2 point, Rectangle rec);
      ```
      """
      @doc group: :basic_shapes_collision_detection
      @spec check_collision_point_rec(
              point :: tuple,
              rec :: tuple
            ) :: boolean
      def check_collision_point_rec(
            _point,
            _rec
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check if point is inside circle

      ```c
      // raylib.h
      RLAPI bool CheckCollisionPointCircle(Vector2 point, Vector2 center, float radius);
      ```
      """
      @doc group: :basic_shapes_collision_detection
      @spec check_collision_point_circle(
              point :: tuple,
              center :: tuple,
              radius :: number
            ) :: boolean
      def check_collision_point_circle(
            _point,
            _center,
            _radius
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check if point is inside a triangle

      ```c
      // raylib.h
      RLAPI bool CheckCollisionPointTriangle(Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3);
      ```
      """
      @doc group: :basic_shapes_collision_detection
      @spec check_collision_point_triangle(
              point :: tuple,
              p1 :: tuple,
              p2 :: tuple,
              p3 :: tuple
            ) :: boolean
      def check_collision_point_triangle(
            _point,
            _p1,
            _p2,
            _p3
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]

      ```c
      // raylib.h
      RLAPI bool CheckCollisionPointLine(Vector2 point, Vector2 p1, Vector2 p2, int threshold);
      ```
      """
      @doc group: :basic_shapes_collision_detection
      @spec check_collision_point_line(
              point :: tuple,
              p1 :: tuple,
              p2 :: tuple,
              threshold :: integer
            ) :: boolean
      def check_collision_point_line(
            _point,
            _p1,
            _p2,
            _threshold
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check if point is within a polygon described by array of vertices

      ```c
      // raylib.h
      RLAPI bool CheckCollisionPointPoly(Vector2 point, const Vector2 *points, int pointCount);
      ```
      """
      @doc group: :basic_shapes_collision_detection
      @spec check_collision_point_poly(
              point :: tuple,
              points :: [tuple]
            ) :: boolean
      def check_collision_point_poly(
            _point,
            _points
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check the collision between two lines defined by two points each, returns collision point by reference

      ```c
      // raylib.h
      RLAPI bool CheckCollisionLines(Vector2 startPos1, Vector2 endPos1, Vector2 startPos2, Vector2 endPos2, Vector2 *collisionPoint);
      ```
      """
      @doc group: :basic_shapes_collision_detection
      @spec check_collision_lines(
              start_pos1 :: tuple,
              end_pos1 :: tuple,
              start_pos2 :: tuple,
              end_pos2 :: tuple,
              return :: :auto | :value | :resource
            ) :: {collision :: boolean, collision_point :: tuple}
      def check_collision_lines(
            _start_pos1,
            _end_pos1,
            _start_pos2,
            _end_pos2,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get collision rectangle for two rectangles collision

      ```c
      // raylib.h
      RLAPI Rectangle GetCollisionRec(Rectangle rec1, Rectangle rec2);
      ```
      """
      @doc group: :basic_shapes_collision_detection
      @spec get_collision_rec(
              rec1 :: tuple,
              rec2 :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_collision_rec(
            _rec1,
            _rec2,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)
    end
  end
end
