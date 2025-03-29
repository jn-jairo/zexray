defmodule Zexray.Shader do
  import Zexray.Guard
  alias Zexray.NIF

  ############
  #  Shader  #
  ############

  @doc """
  Get shader max locations for Shader.locs
  """
  @spec max_locations() :: non_neg_integer
  def max_locations() do
    NIF.shader_get_max_locations()
  end

  @doc """
  Load shader from files and bind default locations
  """
  @spec load(
          vs_file_name :: binary,
          fs_file_name :: binary,
          return :: :value | :resource
        ) :: Zexray.Type.Shader.t_nif()
  def load(
        vs_file_name,
        fs_file_name,
        return \\ :value
      )
      when is_binary(vs_file_name) and
             is_binary(fs_file_name) and
             is_nif_return(return) do
    NIF.load_shader(
      vs_file_name,
      fs_file_name,
      return
    )
    |> Zexray.Type.Shader.from_nif()
  end

  @doc """
  Load shader from code strings and bind default locations
  """
  @spec load_from_memory(
          vs_code :: binary,
          fs_code :: binary,
          return :: :value | :resource
        ) :: Zexray.Type.Shader.t_nif()
  def load_from_memory(
        vs_code,
        fs_code,
        return \\ :value
      )
      when is_binary(vs_code) and
             is_binary(fs_code) and
             is_nif_return(return) do
    NIF.load_shader_from_memory(
      vs_code,
      fs_code,
      return
    )
    |> Zexray.Type.Shader.from_nif()
  end

  @doc """
  Check if a shader is valid (loaded on GPU)
  """
  @spec is_valid(shader :: Zexray.Type.Shader.t_all()) :: boolean
  def is_valid(shader)
      when is_like_shader(shader) do
    NIF.is_shader_valid(shader |> Zexray.Type.Shader.to_nif())
  end

  @doc """
  Get shader uniform location
  """
  @spec get_location(
          shader :: Zexray.Type.Shader.t_all(),
          uniform_name :: binary
        ) :: integer
  def get_location(
        shader,
        uniform_name
      )
      when is_like_shader(shader) and
             is_binary(uniform_name) do
    NIF.get_shader_location(
      shader |> Zexray.Type.Shader.to_nif(),
      uniform_name
    )
  end

  @doc """
  Get shader attribute location
  """
  @spec get_location_attrib(
          shader :: Zexray.Type.Shader.t_all(),
          attrib_name :: binary
        ) :: integer
  def get_location_attrib(
        shader,
        attrib_name
      )
      when is_like_shader(shader) and
             is_binary(attrib_name) do
    NIF.get_shader_location_attrib(
      shader |> Zexray.Type.Shader.to_nif(),
      attrib_name
    )
  end

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
  def set_value(
        shader,
        loc_index,
        value,
        uniform_type
      )
      when is_like_shader(shader) and
             is_integer(loc_index) and
             (is_float(value) or
                is_integer(value) or
                is_like_vector2(value) or
                is_like_vector3(value) or
                is_like_vector4(value) or
                is_like_ivector2(value) or
                is_like_ivector3(value) or
                is_like_ivector4(value) or
                is_like_uivector2(value) or
                is_like_uivector3(value) or
                is_like_uivector4(value)) and
             is_integer(uniform_type) do
    NIF.set_shader_value(
      shader |> Zexray.Type.Shader.to_nif(),
      loc_index,
      value,
      uniform_type
    )
  end

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
  def set_value_v(
        shader,
        loc_index,
        value,
        uniform_type
      )
      when is_like_shader(shader) and
             is_integer(loc_index) and
             is_list(value) and
             (value == [] or
                is_float(hd(value)) or
                is_integer(hd(value)) or
                is_like_vector2(hd(value)) or
                is_like_vector3(hd(value)) or
                is_like_vector4(hd(value)) or
                is_like_ivector2(hd(value)) or
                is_like_ivector3(hd(value)) or
                is_like_ivector4(hd(value)) or
                is_like_uivector2(hd(value)) or
                is_like_uivector3(hd(value)) or
                is_like_uivector4(hd(value))) and
             is_integer(uniform_type) do
    NIF.set_shader_value_v(
      shader |> Zexray.Type.Shader.to_nif(),
      loc_index,
      value,
      uniform_type
    )
  end

  @doc """
  Set shader uniform value (matrix 4x4)
  """
  @spec set_value_matrix(
          shader :: Zexray.Type.Shader.t_all(),
          loc_index :: integer,
          mat :: Zexray.Type.Matrix.t_all()
        ) :: :ok
  def set_value_matrix(
        shader,
        loc_index,
        mat
      )
      when is_like_shader(shader) and
             is_integer(loc_index) and
             is_like_matrix(mat) do
    NIF.set_shader_value_matrix(
      shader |> Zexray.Type.Shader.to_nif(),
      loc_index,
      mat |> Zexray.Type.Matrix.to_nif()
    )
  end

  @doc """
  Set shader uniform value for texture (sampler2d)
  """
  @spec set_value_texture(
          shader :: Zexray.Type.Shader.t_all(),
          loc_index :: integer,
          texture :: Zexray.Type.Texture2D.t_all()
        ) :: :ok
  def set_value_texture(
        shader,
        loc_index,
        texture
      )
      when is_like_shader(shader) and
             is_integer(loc_index) and
             is_like_texture_2d(texture) do
    NIF.set_shader_value_texture(
      shader |> Zexray.Type.Shader.to_nif(),
      loc_index,
      texture |> Zexray.Type.Texture2D.to_nif()
    )
  end
end
