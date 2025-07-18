defmodule Zexray.NIF.ScreenSpace do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_screen_space [
        # Screen space
        get_screen_to_world_ray: 2,
        get_screen_to_world_ray: 3,
        get_screen_to_world_ray_ex: 4,
        get_screen_to_world_ray_ex: 5,
        get_world_to_screen: 2,
        get_world_to_screen: 3,
        get_world_to_screen_ex: 4,
        get_world_to_screen_ex: 5,
        get_world_to_screen_2d: 2,
        get_world_to_screen_2d: 3,
        get_screen_to_world_2d: 2,
        get_screen_to_world_2d: 3,
        get_camera_matrix: 1,
        get_camera_matrix: 2,
        get_camera_matrix_2d: 1,
        get_camera_matrix_2d: 2
      ]

      ##################
      #  Screen space  #
      ##################

      @doc """
      Get a ray trace from screen position (i.e mouse)

      ```c
      // raylib.h
      RLAPI Ray GetScreenToWorldRay(Vector2 position, Camera camera);
      ```
      """
      @doc group: :screen_space
      @spec get_screen_to_world_ray(
              position :: tuple,
              camera :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_screen_to_world_ray(
            _position,
            _camera,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get a ray trace from screen position (i.e mouse) in a viewport

      ```c
      // raylib.h
      RLAPI Ray GetScreenToWorldRayEx(Vector2 position, Camera camera, int width, int height);
      ```
      """
      @doc group: :screen_space
      @spec get_screen_to_world_ray_ex(
              position :: tuple,
              camera :: tuple,
              width :: number,
              height :: number,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_screen_to_world_ray_ex(
            _position,
            _camera,
            _width,
            _height,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get the screen space position for a 3d world space position

      ```c
      // raylib.h
      RLAPI Vector2 GetWorldToScreen(Vector3 position, Camera camera);
      ```
      """
      @doc group: :screen_space
      @spec get_world_to_screen(
              position :: tuple,
              camera :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_world_to_screen(
            _position,
            _camera,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get size position for a 3d world space position

      ```c
      // raylib.h
      RLAPI Vector2 GetWorldToScreenEx(Vector3 position, Camera camera, int width, int height);
      ```
      """
      @doc group: :screen_space
      @spec get_world_to_screen_ex(
              position :: tuple,
              camera :: tuple,
              width :: number,
              height :: number,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_world_to_screen_ex(
            _position,
            _camera,
            _width,
            _height,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get the screen space position for a 2d camera world space position

      ```c
      // raylib.h
      RLAPI Vector2 GetWorldToScreen2D(Vector2 position, Camera2D camera);
      ```
      """
      @doc group: :screen_space
      @spec get_world_to_screen_2d(
              position :: tuple,
              camera :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_world_to_screen_2d(
            _position,
            _camera,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get the world space position for a 2d camera screen space position

      ```c
      // raylib.h
      RLAPI Vector2 GetScreenToWorld2D(Vector2 position, Camera2D camera);
      ```
      """
      @doc group: :screen_space
      @spec get_screen_to_world_2d(
              position :: tuple,
              camera :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_screen_to_world_2d(
            _position,
            _camera,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get camera transform matrix (view matrix)

      ```c
      // raylib.h
      RLAPI Matrix GetCameraMatrix(Camera camera);
      ```
      """
      @doc group: :screen_space
      @spec get_camera_matrix(
              camera :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_camera_matrix(
            _camera,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get camera 2d transform matrix

      ```c
      // raylib.h
      RLAPI Matrix GetCameraMatrix2D(Camera2D camera);
      ```
      """
      @doc group: :screen_space
      @spec get_camera_matrix_2d(
              camera :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_camera_matrix_2d(
            _camera,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)
    end
  end
end
