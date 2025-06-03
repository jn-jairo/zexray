defmodule Zexray.Shader do
  @moduledoc """
  Shader
  """

  alias Zexray.NIF

  ############
  #  Shader  #
  ############

  @doc """
  Get shader max locations for Shader.locs
  """
  @spec max_locations() :: non_neg_integer
  defdelegate max_locations(), to: NIF, as: :shader_get_max_locations

  @doc """
  Load shader from files and bind default locations
  """
  @spec load(
          vs_file_name :: binary,
          fs_file_name :: binary,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Shader.t_nif()
  defdelegate load(
                vs_file_name,
                fs_file_name,
                return \\ :auto
              ),
              to: NIF,
              as: :load_shader

  @doc """
  Load shader from code strings and bind default locations
  """
  @spec load_from_memory(
          vs_code :: binary,
          fs_code :: binary,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Shader.t_nif()
  defdelegate load_from_memory(
                vs_code,
                fs_code,
                return \\ :auto
              ),
              to: NIF,
              as: :load_shader_from_memory

  @doc """
  Check if a shader is valid (loaded on GPU)
  """
  @spec is_valid(shader :: Zexray.Type.Shader.t_all()) :: boolean
  defdelegate is_valid(shader), to: NIF, as: :is_shader_valid

  @doc """
  Get shader uniform location
  """
  @spec get_location(
          shader :: Zexray.Type.Shader.t_all(),
          uniform_name :: binary
        ) :: integer
  defdelegate get_location(
                shader,
                uniform_name
              ),
              to: NIF,
              as: :get_shader_location

  @doc """
  Get shader attribute location
  """
  @spec get_location_attrib(
          shader :: Zexray.Type.Shader.t_all(),
          attrib_name :: binary
        ) :: integer
  defdelegate get_location_attrib(
                shader,
                attrib_name
              ),
              to: NIF,
              as: :get_shader_location_attrib

  @doc """
  Set shader uniform value
  """
  @spec set_value(
          shader :: Zexray.Type.Shader.t_all(),
          loc_index :: integer,
          value ::
            float
            | integer
            | Zexray.Type.Vector2.t_all()
            | Zexray.Type.Vector3.t_all()
            | Zexray.Type.Vector4.t_all()
            | Zexray.Type.IVector2.t_all()
            | Zexray.Type.IVector3.t_all()
            | Zexray.Type.IVector4.t_all()
            | Zexray.Type.UIVector2.t_all()
            | Zexray.Type.UIVector3.t_all()
            | Zexray.Type.UIVector4.t_all(),
          uniform_type :: integer
        ) :: :ok
  defdelegate set_value(
                shader,
                loc_index,
                value,
                uniform_type
              ),
              to: NIF,
              as: :set_shader_value

  @doc """
  Set shader uniform value vector
  """
  @spec set_value_v(
          shader :: Zexray.Type.Shader.t_all(),
          loc_index :: integer,
          value ::
            [float]
            | [integer]
            | [Zexray.Type.Vector2.t_all()]
            | [Zexray.Type.Vector3.t_all()]
            | [Zexray.Type.Vector4.t_all()]
            | [Zexray.Type.IVector2.t_all()]
            | [Zexray.Type.IVector3.t_all()]
            | [Zexray.Type.IVector4.t_all()]
            | [Zexray.Type.UIVector2.t_all()]
            | [Zexray.Type.UIVector3.t_all()]
            | [Zexray.Type.UIVector4.t_all()],
          uniform_type :: integer
        ) :: :ok
  defdelegate set_value_v(
                shader,
                loc_index,
                value,
                uniform_type
              ),
              to: NIF,
              as: :set_shader_value_v

  @doc """
  Set shader uniform value (matrix 4x4)
  """
  @spec set_value_matrix(
          shader :: Zexray.Type.Shader.t_all(),
          loc_index :: integer,
          mat :: Zexray.Type.Matrix.t_all()
        ) :: :ok
  defdelegate set_value_matrix(
                shader,
                loc_index,
                mat
              ),
              to: NIF,
              as: :set_shader_value_matrix

  @doc """
  Set shader uniform value for texture (sampler2d)
  """
  @spec set_value_texture(
          shader :: Zexray.Type.Shader.t_all(),
          loc_index :: integer,
          texture :: Zexray.Type.Texture2D.t_all()
        ) :: :ok
  defdelegate set_value_texture(
                shader,
                loc_index,
                texture
              ),
              to: NIF,
              as: :set_shader_value_texture
end
