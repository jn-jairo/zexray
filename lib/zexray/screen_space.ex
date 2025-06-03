defmodule Zexray.ScreenSpace do
  @moduledoc """
  Screen Space
  """

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
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Ray.t_nif()
  defdelegate get_screen_to_world_ray(
                position,
                camera,
                return \\ :auto
              ),
              to: NIF,
              as: :get_screen_to_world_ray

  @doc """
  Get a ray trace from screen position (i.e mouse) in a viewport
  """
  @spec get_screen_to_world_ray_ex(
          position :: Zexray.Type.Vector2.t_all(),
          camera :: Zexray.Type.Camera.t_all(),
          width :: integer,
          height :: integer,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Ray.t_nif()
  defdelegate get_screen_to_world_ray_ex(
                position,
                camera,
                width,
                height,
                return \\ :auto
              ),
              to: NIF,
              as: :get_screen_to_world_ray_ex

  @doc """
  Get the screen space position for a 3d world space position
  """
  @spec get_world_to_screen(
          position :: Zexray.Type.Vector3.t_all(),
          camera :: Zexray.Type.Camera.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  defdelegate get_world_to_screen(
                position,
                camera,
                return \\ :auto
              ),
              to: NIF,
              as: :get_world_to_screen

  @doc """
  Get size position for a 3d world space position
  """
  @spec get_world_to_screen_ex(
          position :: Zexray.Type.Vector3.t_all(),
          camera :: Zexray.Type.Camera.t_all(),
          width :: integer,
          height :: integer,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  defdelegate get_world_to_screen_ex(
                position,
                camera,
                width,
                height,
                return \\ :auto
              ),
              to: NIF,
              as: :get_world_to_screen_ex

  @doc """
  Get the screen space position for a 2d camera world space position
  """
  @spec get_world_to_screen_2d(
          position :: Zexray.Type.Vector2.t_all(),
          camera :: Zexray.Type.Camera2D.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  defdelegate get_world_to_screen_2d(
                position,
                camera,
                return \\ :auto
              ),
              to: NIF,
              as: :get_world_to_screen_2d

  @doc """
  Get the world space position for a 2d camera screen space position
  """
  @spec get_screen_to_world_2d(
          position :: Zexray.Type.Vector2.t_all(),
          camera :: Zexray.Type.Camera2D.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  defdelegate get_screen_to_world_2d(
                position,
                camera,
                return \\ :auto
              ),
              to: NIF,
              as: :get_screen_to_world_2d

  @doc """
  Get camera transform matrix (view matrix)
  """
  @spec get_camera_matrix(
          camera :: Zexray.Type.Camera.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Matrix.t_nif()
  defdelegate get_camera_matrix(
                camera,
                return \\ :auto
              ),
              to: NIF,
              as: :get_camera_matrix

  @doc """
  Get camera 2d transform matrix
  """
  @spec get_camera_matrix_2d(
          camera :: Zexray.Type.Camera2D.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Matrix.t_nif()
  defdelegate get_camera_matrix_2d(
                camera,
                return \\ :auto
              ),
              to: NIF,
              as: :get_camera_matrix_2d
end
