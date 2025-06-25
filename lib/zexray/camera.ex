defmodule Zexray.Camera do
  @moduledoc """
  Camera
  """

  alias Zexray.NIF

  ############
  #  Camera  #
  ############

  @doc """
  Update camera position for selected mode
  """
  @spec update(
          camera :: Zexray.Type.Camera.t_all(),
          mode :: Zexray.Enum.CameraMode.t(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  defdelegate update(
                camera,
                mode,
                return \\ :auto
              ),
              to: NIF,
              as: :update_camera

  @doc """
  Update camera movement/rotation
  """
  @spec update_pro(
          camera :: Zexray.Type.Camera.t_all(),
          movement :: Zexray.Type.Vector3.t_all(),
          rotation :: Zexray.Type.Vector3.t_all(),
          zoom :: number,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  defdelegate update_pro(
                camera,
                movement,
                rotation,
                zoom,
                return \\ :auto
              ),
              to: NIF,
              as: :update_camera_pro

  @doc """
  Returns the cameras forward vector (normalized)
  """
  @spec get_forward(
          camera :: Zexray.Type.Camera.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Vector3.t_nif()
  defdelegate get_forward(
                camera,
                return \\ :auto
              ),
              to: NIF,
              as: :get_camera_forward

  @doc """
  Returns the cameras up vector (normalized)
  NOTE: The up vector might not be perpendicular to the forward vector
  """
  @spec get_up(
          camera :: Zexray.Type.Camera.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Vector3.t_nif()
  defdelegate get_up(
                camera,
                return \\ :auto
              ),
              to: NIF,
              as: :get_camera_up

  @doc """
  Returns the cameras right vector (normalized)
  """
  @spec get_right(
          camera :: Zexray.Type.Camera.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Vector3.t_nif()
  defdelegate get_right(
                camera,
                return \\ :auto
              ),
              to: NIF,
              as: :get_camera_right

  @doc """
  Moves the camera in its forward direction
  """
  @spec move_forward(
          camera :: Zexray.Type.Camera.t_all(),
          distance :: number,
          move_in_world_plane :: boolean,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  defdelegate move_forward(
                camera,
                distance,
                move_in_world_plane,
                return \\ :auto
              ),
              to: NIF,
              as: :camera_move_forward

  @doc """
  Moves the camera in its up direction
  """
  @spec move_up(
          camera :: Zexray.Type.Camera.t_all(),
          distance :: number,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  defdelegate move_up(
                camera,
                distance,
                return \\ :auto
              ),
              to: NIF,
              as: :camera_move_up

  @doc """
  Moves the camera target in its current right direction
  """
  @spec move_right(
          camera :: Zexray.Type.Camera.t_all(),
          distance :: number,
          move_in_world_plane :: boolean,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  defdelegate move_right(
                camera,
                distance,
                move_in_world_plane,
                return \\ :auto
              ),
              to: NIF,
              as: :camera_move_right

  @doc """
  Moves the camera position closer/farther to/from the camera target
  """
  @spec move_to_target(
          camera :: Zexray.Type.Camera.t_all(),
          delta :: number,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  defdelegate move_to_target(
                camera,
                delta,
                return \\ :auto
              ),
              to: NIF,
              as: :camera_move_to_target

  @doc """
  Rotates the camera around its up vector
  Yaw is "looking left and right"
  If rotateAroundTarget is false, the camera rotates around its position
  NOTE: angle must be provided in radians
  """
  @spec yaw(
          camera :: Zexray.Type.Camera.t_all(),
          angle :: number,
          rotate_around_target :: boolean,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  defdelegate yaw(
                camera,
                angle,
                rotate_around_target,
                return \\ :auto
              ),
              to: NIF,
              as: :camera_yaw

  @doc """
  Rotates the camera around its right vector, pitch is "looking up and down"
  - lockView prevents camera overrotation (aka "somersaults")
  - rotateAroundTarget defines if rotation is around target or around its position
  - rotateUp rotates the up direction as well (typically only usefull in CAMERA_FREE)
  NOTE: angle must be provided in radians
  """
  @spec pitch(
          camera :: Zexray.Type.Camera.t_all(),
          angle :: number,
          lock_view :: boolean,
          rotate_around_target :: boolean,
          rotate_up :: boolean,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  defdelegate pitch(
                camera,
                angle,
                lock_view,
                rotate_around_target,
                rotate_up,
                return \\ :auto
              ),
              to: NIF,
              as: :camera_pitch

  @doc """
  Rotates the camera around its forward vector
  Roll is "turning your head sideways to the left or right"
  NOTE: angle must be provided in radians
  """
  @spec roll(
          camera :: Zexray.Type.Camera.t_all(),
          angle :: number,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  defdelegate roll(
                camera,
                angle,
                return \\ :auto
              ),
              to: NIF,
              as: :camera_roll

  @doc """
  Returns the camera view matrix
  """
  @spec get_view_matrix(
          camera :: Zexray.Type.Camera.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Matrix.t_nif()
  defdelegate get_view_matrix(
                camera,
                return \\ :auto
              ),
              to: NIF,
              as: :get_camera_view_matrix

  @doc """
  Returns the camera projection matrix
  """
  @spec get_projection_matrix(
          camera :: Zexray.Type.Camera.t_all(),
          aspect :: number,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Matrix.t_nif()
  defdelegate get_projection_matrix(
                camera,
                aspect,
                return \\ :auto
              ),
              to: NIF,
              as: :get_camera_projection_matrix
end
