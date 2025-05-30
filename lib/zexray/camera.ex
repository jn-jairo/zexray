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
          return :: :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  defdelegate update(
                camera,
                mode,
                return \\ :value
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
          zoom :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  defdelegate update_pro(
                camera,
                movement,
                rotation,
                zoom,
                return \\ :value
              ),
              to: NIF,
              as: :update_camera_pro

  @doc """
  Returns the cameras forward vector (normalized)
  """
  @spec get_forward(
          camera :: Zexray.Type.Camera.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Vector3.t_nif()
  defdelegate get_forward(
                camera,
                return \\ :value
              ),
              to: NIF,
              as: :get_camera_forward

  @doc """
  Returns the cameras up vector (normalized)
  NOTE: The up vector might not be perpendicular to the forward vector
  """
  @spec get_up(
          camera :: Zexray.Type.Camera.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Vector3.t_nif()
  defdelegate get_up(
                camera,
                return \\ :value
              ),
              to: NIF,
              as: :get_camera_up

  @doc """
  Returns the cameras right vector (normalized)
  """
  @spec get_right(
          camera :: Zexray.Type.Camera.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Vector3.t_nif()
  defdelegate get_right(
                camera,
                return \\ :value
              ),
              to: NIF,
              as: :get_camera_right

  @doc """
  Moves the camera in its forward direction
  """
  @spec move_forward(
          camera :: Zexray.Type.Camera.t_all(),
          distance :: float,
          move_in_world_plane :: boolean,
          return :: :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  defdelegate move_forward(
                camera,
                distance,
                move_in_world_plane,
                return \\ :value
              ),
              to: NIF,
              as: :camera_move_forward

  @doc """
  Moves the camera in its up direction
  """
  @spec move_up(
          camera :: Zexray.Type.Camera.t_all(),
          distance :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  defdelegate move_up(
                camera,
                distance,
                return \\ :value
              ),
              to: NIF,
              as: :camera_move_up

  @doc """
  Moves the camera target in its current right direction
  """
  @spec move_right(
          camera :: Zexray.Type.Camera.t_all(),
          distance :: float,
          move_in_world_plane :: boolean,
          return :: :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  defdelegate move_right(
                camera,
                distance,
                move_in_world_plane,
                return \\ :value
              ),
              to: NIF,
              as: :camera_move_right

  @doc """
  Moves the camera position closer/farther to/from the camera target
  """
  @spec move_to_target(
          camera :: Zexray.Type.Camera.t_all(),
          delta :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  defdelegate move_to_target(
                camera,
                delta,
                return \\ :value
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
          angle :: float,
          rotate_around_target :: boolean,
          return :: :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  defdelegate yaw(
                camera,
                angle,
                rotate_around_target,
                return \\ :value
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
          angle :: float,
          lock_view :: boolean,
          rotate_around_target :: boolean,
          rotate_up :: boolean,
          return :: :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  defdelegate pitch(
                camera,
                angle,
                lock_view,
                rotate_around_target,
                rotate_up,
                return \\ :value
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
          angle :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  defdelegate roll(
                camera,
                angle,
                return \\ :value
              ),
              to: NIF,
              as: :camera_roll

  @doc """
  Returns the camera view matrix
  """
  @spec get_view_matrix(
          camera :: Zexray.Type.Camera.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Matrix.t_nif()
  defdelegate get_view_matrix(
                camera,
                return \\ :value
              ),
              to: NIF,
              as: :get_camera_view_matrix

  @doc """
  Returns the camera projection matrix
  """
  @spec get_projection_matrix(
          camera :: Zexray.Type.Camera.t_all(),
          aspect :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Matrix.t_nif()
  defdelegate get_projection_matrix(
                camera,
                aspect,
                return \\ :value
              ),
              to: NIF,
              as: :get_camera_projection_matrix
end
