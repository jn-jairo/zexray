defmodule Zexray.Camera do
  import Zexray.Guard
  alias Zexray.NIF

  ############
  #  Camera  #
  ############

  @doc """
  Update camera position for selected mode
  """
  @spec update(
          camera :: Zexray.Type.Camera.t_all(),
          mode :: Zexray.Enum.CameraMode.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  def update(
        camera,
        mode,
        return \\ :value
      )
      when is_like_camera(camera) and
             is_like_camera_mode(mode) and
             is_nif_return(return) do
    NIF.update_camera(
      camera |> Zexray.Type.Camera.to_nif(),
      Zexray.Enum.CameraMode.value(mode),
      return
    )
    |> Zexray.Type.Camera.from_nif()
  end

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
  def update_pro(
        camera,
        movement,
        rotation,
        zoom,
        return \\ :value
      )
      when is_like_camera(camera) and
             is_like_vector3(movement) and
             is_like_vector3(rotation) and
             is_float(zoom) and
             is_nif_return(return) do
    NIF.update_camera_pro(
      camera |> Zexray.Type.Camera.to_nif(),
      movement |> Zexray.Type.Vector3.to_nif(),
      rotation |> Zexray.Type.Vector3.to_nif(),
      zoom,
      return
    )
    |> Zexray.Type.Camera.from_nif()
  end

  @doc """
  Returns the cameras forward vector (normalized)
  """
  @spec get_forward(
          camera :: Zexray.Type.Camera.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Vector3.t_nif()
  def get_forward(
        camera,
        return \\ :value
      )
      when is_like_camera(camera) and
             is_nif_return(return) do
    NIF.get_camera_forward(
      camera |> Zexray.Type.Camera.to_nif(),
      return
    )
    |> Zexray.Type.Vector3.from_nif()
  end

  @doc """
  Returns the cameras up vector (normalized)
  NOTE: The up vector might not be perpendicular to the forward vector
  """
  @spec get_up(
          camera :: Zexray.Type.Camera.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Vector3.t_nif()
  def get_up(
        camera,
        return \\ :value
      )
      when is_like_camera(camera) and
             is_nif_return(return) do
    NIF.get_camera_up(
      camera |> Zexray.Type.Camera.to_nif(),
      return
    )
    |> Zexray.Type.Vector3.from_nif()
  end

  @doc """
  Returns the cameras right vector (normalized)
  """
  @spec get_right(
          camera :: Zexray.Type.Camera.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Vector3.t_nif()
  def get_right(
        camera,
        return \\ :value
      )
      when is_like_camera(camera) and
             is_nif_return(return) do
    NIF.get_camera_right(
      camera |> Zexray.Type.Camera.to_nif(),
      return
    )
    |> Zexray.Type.Vector3.from_nif()
  end

  @doc """
  Moves the camera in its forward direction
  """
  @spec move_forward(
          camera :: Zexray.Type.Camera.t_all(),
          distance :: float,
          move_in_world_plane :: boolean,
          return :: :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  def move_forward(
        camera,
        distance,
        move_in_world_plane,
        return \\ :value
      )
      when is_like_camera(camera) and
             is_float(distance) and
             is_boolean(move_in_world_plane) and
             is_nif_return(return) do
    NIF.camera_move_forward(
      camera |> Zexray.Type.Camera.to_nif(),
      distance,
      move_in_world_plane,
      return
    )
    |> Zexray.Type.Camera.from_nif()
  end

  @doc """
  Moves the camera in its up direction
  """
  @spec move_up(
          camera :: Zexray.Type.Camera.t_all(),
          distance :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  def move_up(
        camera,
        distance,
        return \\ :value
      )
      when is_like_camera(camera) and
             is_float(distance) and
             is_nif_return(return) do
    NIF.camera_move_up(
      camera |> Zexray.Type.Camera.to_nif(),
      distance,
      return
    )
    |> Zexray.Type.Camera.from_nif()
  end

  @doc """
  Moves the camera target in its current right direction
  """
  @spec move_right(
          camera :: Zexray.Type.Camera.t_all(),
          distance :: float,
          move_in_world_plane :: boolean,
          return :: :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  def move_right(
        camera,
        distance,
        move_in_world_plane,
        return \\ :value
      )
      when is_like_camera(camera) and
             is_float(distance) and
             is_boolean(move_in_world_plane) and
             is_nif_return(return) do
    NIF.camera_move_right(
      camera |> Zexray.Type.Camera.to_nif(),
      distance,
      move_in_world_plane,
      return
    )
    |> Zexray.Type.Camera.from_nif()
  end

  @doc """
  Moves the camera position closer/farther to/from the camera target
  """
  @spec move_to_target(
          camera :: Zexray.Type.Camera.t_all(),
          delta :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Camera.t_nif()
  def move_to_target(
        camera,
        delta,
        return \\ :value
      )
      when is_like_camera(camera) and
             is_float(delta) and
             is_nif_return(return) do
    NIF.camera_move_to_target(
      camera |> Zexray.Type.Camera.to_nif(),
      delta,
      return
    )
    |> Zexray.Type.Camera.from_nif()
  end

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
  def yaw(
        camera,
        angle,
        rotate_around_target,
        return \\ :value
      )
      when is_like_camera(camera) and
             is_float(angle) and
             is_boolean(rotate_around_target) and
             is_nif_return(return) do
    NIF.camera_yaw(
      camera |> Zexray.Type.Camera.to_nif(),
      angle,
      rotate_around_target,
      return
    )
    |> Zexray.Type.Camera.from_nif()
  end

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
  def pitch(
        camera,
        angle,
        lock_view,
        rotate_around_target,
        rotate_up,
        return \\ :value
      )
      when is_like_camera(camera) and
             is_float(angle) and
             is_boolean(lock_view) and
             is_boolean(rotate_around_target) and
             is_boolean(rotate_up) and
             is_nif_return(return) do
    NIF.camera_pitch(
      camera |> Zexray.Type.Camera.to_nif(),
      angle,
      lock_view,
      rotate_around_target,
      rotate_up,
      return
    )
    |> Zexray.Type.Camera.from_nif()
  end

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
  def roll(
        camera,
        angle,
        return \\ :value
      )
      when is_like_camera(camera) and
             is_float(angle) and
             is_nif_return(return) do
    NIF.camera_roll(
      camera |> Zexray.Type.Camera.to_nif(),
      angle,
      return
    )
    |> Zexray.Type.Camera.from_nif()
  end

  @doc """
  Returns the camera view matrix
  """
  @spec get_view_matrix(
          camera :: Zexray.Type.Camera.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Matrix.t_nif()
  def get_view_matrix(
        camera,
        return \\ :value
      )
      when is_like_camera(camera) and
             is_nif_return(return) do
    NIF.get_camera_view_matrix(
      camera |> Zexray.Type.Camera.to_nif(),
      return
    )
    |> Zexray.Type.Matrix.from_nif()
  end

  @doc """
  Returns the camera projection matrix
  """
  @spec get_projection_matrix(
          camera :: Zexray.Type.Camera.t_all(),
          aspect :: float,
          return :: :value | :resource
        ) :: Zexray.Type.Matrix.t_nif()
  def get_projection_matrix(
        camera,
        aspect,
        return \\ :value
      )
      when is_like_camera(camera) and
             is_float(aspect) and
             is_nif_return(return) do
    NIF.get_camera_projection_matrix(
      camera |> Zexray.Type.Camera.to_nif(),
      aspect,
      return
    )
    |> Zexray.Type.Matrix.from_nif()
  end
end
