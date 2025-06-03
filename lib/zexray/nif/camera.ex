defmodule Zexray.NIF.Camera do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_camera [
        # Camera
        update_camera: 2,
        update_camera: 3,
        update_camera_pro: 4,
        update_camera_pro: 5,
        get_camera_forward: 1,
        get_camera_forward: 2,
        get_camera_up: 1,
        get_camera_up: 2,
        get_camera_right: 1,
        get_camera_right: 2,
        camera_move_forward: 3,
        camera_move_forward: 4,
        camera_move_up: 2,
        camera_move_up: 3,
        camera_move_right: 3,
        camera_move_right: 4,
        camera_move_to_target: 2,
        camera_move_to_target: 3,
        camera_yaw: 3,
        camera_yaw: 4,
        camera_pitch: 5,
        camera_pitch: 6,
        camera_roll: 2,
        camera_roll: 3,
        get_camera_view_matrix: 1,
        get_camera_view_matrix: 2,
        get_camera_projection_matrix: 2,
        get_camera_projection_matrix: 3
      ]

      ############
      #  Camera  #
      ############

      @doc """
      Update camera position for selected mode

      ```c
      // raylib.h
      RLAPI void UpdateCamera(Camera *camera, int mode);
      ```
      """
      @doc group: :camera
      @spec update_camera(
              camera :: tuple,
              mode :: integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def update_camera(
            _camera,
            _mode,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Update camera movement/rotation

      ```c
      // raylib.h
      RLAPI void UpdateCameraPro(Camera *camera, Vector3 movement, Vector3 rotation, float zoom);
      ```
      """
      @doc group: :camera
      @spec update_camera_pro(
              camera :: tuple,
              movement :: tuple,
              rotation :: tuple,
              zoom :: float,
              return :: :auto | :value | :resource
            ) :: tuple
      def update_camera_pro(
            _camera,
            _movement,
            _rotation,
            _zoom,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Returns the cameras forward vector (normalized)

      ```c
      // rcamera.h
      RLAPI Vector3 GetCameraForward(Camera *camera);
      ```
      """
      @doc group: :camera
      @spec get_camera_forward(
              camera :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_camera_forward(
            _camera,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Returns the cameras up vector (normalized)
      NOTE: The up vector might not be perpendicular to the forward vector

      ```c
      // rcamera.h
      RLAPI Vector3 GetCameraUp(Camera *camera);
      ```
      """
      @doc group: :camera
      @spec get_camera_up(
              camera :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_camera_up(
            _camera,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Returns the cameras right vector (normalized)

      ```c
      // rcamera.h
      RLAPI Vector3 GetCameraRight(Camera *camera);
      ```
      """
      @doc group: :camera
      @spec get_camera_right(
              camera :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_camera_right(
            _camera,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Moves the camera in its forward direction

      ```c
      // rcamera.h
      RLAPI void CameraMoveForward(Camera *camera, float distance, bool moveInWorldPlane);
      ```
      """
      @doc group: :camera
      @spec camera_move_forward(
              camera :: tuple,
              distance :: float,
              move_in_world_plane :: boolean,
              return :: :auto | :value | :resource
            ) :: tuple
      def camera_move_forward(
            _camera,
            _distance,
            _move_in_world_plane,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Moves the camera in its up direction

      ```c
      // rcamera.h
      RLAPI void CameraMoveUp(Camera *camera, float distance);
      ```
      """
      @doc group: :camera
      @spec camera_move_up(
              camera :: tuple,
              distance :: float,
              return :: :auto | :value | :resource
            ) :: tuple
      def camera_move_up(
            _camera,
            _distance,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Moves the camera target in its current right direction

      ```c
      // rcamera.h
      RLAPI void CameraMoveRight(Camera *camera, float distance, bool moveInWorldPlane);
      ```
      """
      @doc group: :camera
      @spec camera_move_right(
              camera :: tuple,
              distance :: float,
              move_in_world_plane :: boolean,
              return :: :auto | :value | :resource
            ) :: tuple
      def camera_move_right(
            _camera,
            _distance,
            _move_in_world_plane,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Moves the camera position closer/farther to/from the camera target

      ```c
      // rcamera.h
      RLAPI void CameraMoveToTarget(Camera *camera, float delta);
      ```
      """
      @doc group: :camera
      @spec camera_move_to_target(
              camera :: tuple,
              delta :: float,
              return :: :auto | :value | :resource
            ) :: tuple
      def camera_move_to_target(
            _camera,
            _delta,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Rotates the camera around its up vector
      Yaw is "looking left and right"
      If rotateAroundTarget is false, the camera rotates around its position
      NOTE: angle must be provided in radians

      ```c
      // rcamera.h
      RLAPI void CameraYaw(Camera *camera, float angle, bool rotateAroundTarget);
      ```
      """
      @doc group: :camera
      @spec camera_yaw(
              camera :: tuple,
              angle :: float,
              rotate_around_target :: boolean,
              return :: :auto | :value | :resource
            ) :: tuple
      def camera_yaw(
            _camera,
            _angle,
            _rotate_around_target,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Rotates the camera around its right vector, pitch is "looking up and down"
      - lockView prevents camera overrotation (aka "somersaults")
      - rotateAroundTarget defines if rotation is around target or around its position
      - rotateUp rotates the up direction as well (typically only usefull in CAMERA_FREE)
      NOTE: angle must be provided in radians

      ```c
      // rcamera.h
      RLAPI void CameraPitch(Camera *camera, float angle, bool lockView, bool rotateAroundTarget, bool rotateUp);
      ```
      """
      @doc group: :camera
      @spec camera_pitch(
              camera :: tuple,
              angle :: float,
              lock_view :: boolean,
              rotate_around_target :: boolean,
              rotate_up :: boolean,
              return :: :auto | :value | :resource
            ) :: tuple
      def camera_pitch(
            _camera,
            _angle,
            _lock_view,
            _rotate_around_target,
            _rotate_up,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Rotates the camera around its forward vector
      Roll is "turning your head sideways to the left or right"
      NOTE: angle must be provided in radians

      ```c
      // rcamera.h
      RLAPI void CameraRoll(Camera *camera, float angle);
      ```
      """
      @doc group: :camera
      @spec camera_roll(
              camera :: tuple,
              angle :: float,
              return :: :auto | :value | :resource
            ) :: tuple
      def camera_roll(
            _camera,
            _angle,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Returns the camera view matrix

      ```c
      // rcamera.h
      RLAPI Matrix GetCameraViewMatrix(Camera *camera);
      ```
      """
      @doc group: :camera
      @spec get_camera_view_matrix(
              camera :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_camera_view_matrix(
            _camera,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Returns the camera projection matrix

      ```c
      // rcamera.h
      RLAPI Matrix GetCameraProjectionMatrix(Camera *camera, float aspect);
      ```
      """
      @doc group: :camera
      @spec get_camera_projection_matrix(
              camera :: tuple,
              aspect :: float,
              return :: :auto | :value | :resource
            ) :: tuple
      def get_camera_projection_matrix(
            _camera,
            _aspect,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)
    end
  end
end
