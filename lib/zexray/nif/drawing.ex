defmodule Zexray.NIF.Drawing do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_drawing [
        # Drawing
        clear_background: 1,
        begin_drawing: 0,
        end_drawing: 0,
        begin_mode_2d: 1,
        end_mode_2d: 0,
        begin_mode_3d: 1,
        end_mode_3d: 0,
        begin_texture_mode: 1,
        end_texture_mode: 0,
        begin_shader_mode: 1,
        end_shader_mode: 0,
        begin_blend_mode: 1,
        end_blend_mode: 0,
        begin_scissor_mode: 4,
        end_scissor_mode: 0,
        begin_vr_stereo_mode: 1,
        end_vr_stereo_mode: 0
      ]

      #############
      #  Drawing  #
      #############

      @doc """
      Set background color (framebuffer clear color)

      ```c
      // raylib.h
      RLAPI void ClearBackground(Color color);
      ```
      """
      @doc group: :drawing
      @spec clear_background(color :: map | reference) :: :ok
      def clear_background(_color), do: :erlang.nif_error(:undef)

      @doc """
      Setup canvas (framebuffer) to start drawing

      ```c
      // raylib.h
      RLAPI void BeginDrawing(void);
      ```
      """
      @doc group: :drawing
      @spec begin_drawing() :: :ok
      def begin_drawing(), do: :erlang.nif_error(:undef)

      @doc """
      End canvas drawing and swap buffers (double buffering)

      ```c
      // raylib.h
      RLAPI void EndDrawing(void);
      ```
      """
      @doc group: :drawing
      @spec end_drawing() :: :ok
      def end_drawing(), do: :erlang.nif_error(:undef)

      @doc """
      Begin 2D mode with custom camera (2D)

      ```c
      // raylib.h
      RLAPI void BeginMode2D(Camera2D camera);
      ```
      """
      @doc group: :drawing
      @spec begin_mode_2d(camera :: map | reference) :: :ok
      def begin_mode_2d(_camera), do: :erlang.nif_error(:undef)

      @doc """
      Ends 2D mode with custom camera

      ```c
      // raylib.h
      RLAPI void EndMode2D(void);
      ```
      """
      @doc group: :drawing
      @spec end_mode_2d() :: :ok
      def end_mode_2d(), do: :erlang.nif_error(:undef)

      @doc """
      Begin 3D mode with custom camera (3D)

      ```c
      // raylib.h
      RLAPI void BeginMode3D(Camera3D camera);
      ```
      """
      @doc group: :drawing
      @spec begin_mode_3d(camera :: map | reference) :: :ok
      def begin_mode_3d(_camera), do: :erlang.nif_error(:undef)

      @doc """
      Ends 3D mode and returns to default 2D orthographic mode

      ```c
      // raylib.h
      RLAPI void EndMode3D(void);
      ```
      """
      @doc group: :drawing
      @spec end_mode_3d() :: :ok
      def end_mode_3d(), do: :erlang.nif_error(:undef)

      @doc """
      Begin drawing to render texture

      ```c
      // raylib.h
      RLAPI void BeginTextureMode(RenderTexture2D target);
      ```
      """
      @doc group: :drawing
      @spec begin_texture_mode(target :: map | reference) :: :ok
      def begin_texture_mode(_target), do: :erlang.nif_error(:undef)

      @doc """
      Ends drawing to render texture

      ```c
      // raylib.h
      RLAPI void EndTextureMode(void);
      ```
      """
      @doc group: :drawing
      @spec end_texture_mode() :: :ok
      def end_texture_mode(), do: :erlang.nif_error(:undef)

      @doc """
      Begin custom shader drawing

      ```c
      // raylib.h
      RLAPI void BeginShaderMode(Shader shader);
      ```
      """
      @doc group: :drawing
      @spec begin_shader_mode(shader :: map | reference) :: :ok
      def begin_shader_mode(_shader), do: :erlang.nif_error(:undef)

      @doc """
      End custom shader drawing (use default shader)

      ```c
      // raylib.h
      RLAPI void EndShaderMode(void);
      ```
      """
      @doc group: :drawing
      @spec end_shader_mode() :: :ok
      def end_shader_mode(), do: :erlang.nif_error(:undef)

      @doc """
      Begin blending mode (alpha, additive, multiplied, subtract, custom)

      ```c
      // raylib.h
      RLAPI void BeginBlendMode(int mode);
      ```
      """
      @doc group: :drawing
      @spec begin_blend_mode(mode :: integer) :: :ok
      def begin_blend_mode(_mode), do: :erlang.nif_error(:undef)

      @doc """
      End blending mode (reset to default: alpha blending)

      ```c
      // raylib.h
      RLAPI void EndBlendMode(void);
      ```
      """
      @doc group: :drawing
      @spec end_blend_mode() :: :ok
      def end_blend_mode(), do: :erlang.nif_error(:undef)

      @doc """
      Begin scissor mode (define screen area for following drawing)

      ```c
      // raylib.h
      RLAPI void BeginScissorMode(int x, int y, int width, int height);
      ```
      """
      @doc group: :drawing
      @spec begin_scissor_mode(
              x :: integer,
              y :: integer,
              width :: integer,
              height :: integer
            ) :: :ok
      def begin_scissor_mode(
            _x,
            _y,
            _width,
            _height
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      End scissor mode

      ```c
      // raylib.h
      RLAPI void EndScissorMode(void);
      ```
      """
      @doc group: :drawing
      @spec end_scissor_mode() :: :ok
      def end_scissor_mode(), do: :erlang.nif_error(:undef)

      @doc """
      Begin stereo rendering (requires VR simulator)

      ```c
      // raylib.h
      RLAPI void BeginVrStereoMode(VrStereoConfig config);
      ```
      """
      @doc group: :drawing
      @spec begin_vr_stereo_mode(config :: map | reference) :: :ok
      def begin_vr_stereo_mode(_config), do: :erlang.nif_error(:undef)

      @doc """
      End stereo rendering (requires VR simulator)

      ```c
      // raylib.h
      RLAPI void EndVrStereoMode(void);
      ```
      """
      @doc group: :drawing
      @spec end_vr_stereo_mode() :: :ok
      def end_vr_stereo_mode(), do: :erlang.nif_error(:undef)
    end
  end
end
