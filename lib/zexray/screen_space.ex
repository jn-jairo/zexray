defmodule Zexray.ScreenSpace do
  import Zexray.Guard
  alias Zexray.NIF

  ##################
  #  Screen space  #
  ##################

  @doc """
  Get a ray trace from screen position (i.e mouse)
  """
  @spec get_screen_to_world_ray(
          position :: Zexray.Type.Vector2.t_all(),
          camera :: Zexray.Type.Camera.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Ray.t_nif()
  def get_screen_to_world_ray(
        position,
        camera,
        return \\ :value
      )
      when is_like_vector2(position) and
             is_like_camera(camera) and
             is_nif_return(return) do
    NIF.get_screen_to_world_ray(
      position |> Zexray.Type.Vector2.to_nif(),
      camera |> Zexray.Type.Camera.to_nif(),
      return
    )
    |> Zexray.Type.Ray.from_nif()
  end

  @doc """
  Get a ray trace from screen position (i.e mouse) in a viewport
  """
  @spec get_screen_to_world_ray_ex(
          position :: Zexray.Type.Vector2.t_all(),
          camera :: Zexray.Type.Camera.t_all(),
          width :: integer,
          height :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Ray.t_nif()
  def get_screen_to_world_ray_ex(
        position,
        camera,
        width,
        height,
        return \\ :value
      )
      when is_like_vector2(position) and
             is_like_camera(camera) and
             is_integer(width) and
             is_integer(height) and
             is_nif_return(return) do
    NIF.get_screen_to_world_ray_ex(
      position |> Zexray.Type.Vector2.to_nif(),
      camera |> Zexray.Type.Camera.to_nif(),
      width,
      height,
      return
    )
    |> Zexray.Type.Ray.from_nif()
  end

  @doc """
  Get the screen space position for a 3d world space position
  """
  @spec get_world_to_screen(
          position :: Zexray.Type.Vector3.t_all(),
          camera :: Zexray.Type.Camera.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  def get_world_to_screen(
        position,
        camera,
        return \\ :value
      )
      when is_like_vector3(position) and
             is_like_camera(camera) and
             is_nif_return(return) do
    NIF.get_world_to_screen(
      position |> Zexray.Type.Vector3.to_nif(),
      camera |> Zexray.Type.Camera.to_nif(),
      return
    )
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Get size position for a 3d world space position
  """
  @spec get_world_to_screen_ex(
          position :: Zexray.Type.Vector3.t_all(),
          camera :: Zexray.Type.Camera.t_all(),
          width :: integer,
          height :: integer,
          return :: :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  def get_world_to_screen_ex(
        position,
        camera,
        width,
        height,
        return \\ :value
      )
      when is_like_vector3(position) and
             is_like_camera(camera) and
             is_integer(width) and
             is_integer(height) and
             is_nif_return(return) do
    NIF.get_world_to_screen_ex(
      position |> Zexray.Type.Vector3.to_nif(),
      camera |> Zexray.Type.Camera.to_nif(),
      width,
      height,
      return
    )
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Get the screen space position for a 2d camera world space position
  """
  @spec get_world_to_screen_2d(
          position :: Zexray.Type.Vector2.t_all(),
          camera :: Zexray.Type.Camera2D.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  def get_world_to_screen_2d(
        position,
        camera,
        return \\ :value
      )
      when is_like_vector2(position) and
             is_like_camera_2d(camera) and
             is_nif_return(return) do
    NIF.get_world_to_screen_2d(
      position |> Zexray.Type.Vector2.to_nif(),
      camera |> Zexray.Type.Camera2D.to_nif(),
      return
    )
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Get the world space position for a 2d camera screen space position
  """
  @spec get_screen_to_world_2d(
          position :: Zexray.Type.Vector2.t_all(),
          camera :: Zexray.Type.Camera2D.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  def get_screen_to_world_2d(
        position,
        camera,
        return \\ :value
      )
      when is_like_vector2(position) and
             is_like_camera_2d(camera) and
             is_nif_return(return) do
    NIF.get_screen_to_world_2d(
      position |> Zexray.Type.Vector2.to_nif(),
      camera |> Zexray.Type.Camera2D.to_nif(),
      return
    )
    |> Zexray.Type.Vector2.from_nif()
  end

  @doc """
  Get camera transform matrix (view matrix)
  """
  @spec get_camera_matrix(
          camera :: Zexray.Type.Camera.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Matrix.t_nif()
  def get_camera_matrix(
        camera,
        return \\ :value
      )
      when is_like_camera(camera) and
             is_nif_return(return) do
    NIF.get_camera_matrix(
      camera |> Zexray.Type.Camera.to_nif(),
      return
    )
    |> Zexray.Type.Matrix.from_nif()
  end

  @doc """
  Get camera 2d transform matrix
  """
  @spec get_camera_matrix_2d(
          camera :: Zexray.Type.Camera2D.t_all(),
          return :: :value | :resource
        ) :: Zexray.Type.Matrix.t_nif()
  def get_camera_matrix_2d(
        camera,
        return \\ :value
      )
      when is_like_camera_2d(camera) and
             is_nif_return(return) do
    NIF.get_camera_matrix_2d(
      camera |> Zexray.Type.Camera2D.to_nif(),
      return
    )
    |> Zexray.Type.Matrix.from_nif()
  end
end
