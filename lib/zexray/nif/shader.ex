defmodule Zexray.NIF.Shader do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_shader [
        # Shader
        shader_get_max_locations: 0,
        load_shader: 2,
        load_shader: 3,
        load_shader_from_memory: 2,
        load_shader_from_memory: 3,
        is_shader_valid: 1,
        get_shader_location: 2,
        get_shader_location_attrib: 2,
        set_shader_value: 4,
        set_shader_value_v: 4,
        set_shader_value_matrix: 3,
        set_shader_value_texture: 3
      ]

      ############
      #  Shader  #
      ############

      @doc """
      Get shader max locations for Shader.locs

      ```c
      // config.h
      RL_MAX_SHADER_LOCATIONS
      ```
      """
      @doc group: :shader
      @spec shader_get_max_locations() :: non_neg_integer
      def shader_get_max_locations(), do: :erlang.nif_error(:undef)

      @doc """
      Load shader from files and bind default locations

      ```c
      // raylib.h
      RLAPI Shader LoadShader(const char *vsFileName, const char *fsFileName);
      ```
      """
      @doc group: :shader
      @spec load_shader(
              vs_file_name :: binary,
              fs_file_name :: binary,
              return :: :value | :resource
            ) :: tuple
      def load_shader(
            _vs_file_name,
            _fs_file_name,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load shader from code strings and bind default locations

      ```c
      // raylib.h
      RLAPI Shader LoadShaderFromMemory(const char *vsCode, const char *fsCode);
      ```
      """
      @doc group: :shader
      @spec load_shader_from_memory(
              vs_code :: binary,
              fs_code :: binary,
              return :: :value | :resource
            ) :: tuple
      def load_shader_from_memory(
            _vs_code,
            _fs_code,
            _return \\ :value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check if a shader is valid (loaded on GPU)

      ```c
      // raylib.h
      RLAPI bool IsShaderValid(Shader shader);
      ```
      """
      @doc group: :shader
      @spec is_shader_valid(shader :: tuple) :: boolean
      def is_shader_valid(_shader), do: :erlang.nif_error(:undef)

      @doc """
      Get shader uniform location

      ```c
      // raylib.h
      RLAPI int GetShaderLocation(Shader shader, const char *uniformName);
      ```
      """
      @doc group: :shader
      @spec get_shader_location(
              shader :: tuple,
              uniform_name :: binary
            ) :: integer
      def get_shader_location(
            _shader,
            _uniform_name
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get shader attribute location

      ```c
      // raylib.h
      RLAPI int GetShaderLocationAttrib(Shader shader, const char *attribName);
      ```
      """
      @doc group: :shader
      @spec get_shader_location_attrib(
              shader :: tuple,
              attrib_name :: binary
            ) :: integer
      def get_shader_location_attrib(
            _shader,
            _attrib_name
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set shader uniform value

      ```c
      // raylib.h
      RLAPI void SetShaderValue(Shader shader, int locIndex, const void *value, int uniformType);
      ```
      """
      @doc group: :shader
      @spec set_shader_value(
              shader :: tuple,
              loc_index :: integer,
              value :: float | integer | tuple,
              uniform_type :: integer
            ) :: :ok
      def set_shader_value(
            _shader,
            _loc_index,
            _value,
            _uniform_type
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set shader uniform value vector

      ```c
      // raylib.h
      RLAPI void SetShaderValueV(Shader shader, int locIndex, const void *value, int uniformType, int count);
      ```
      """
      @doc group: :shader
      @spec set_shader_value_v(
              shader :: tuple,
              loc_index :: integer,
              value :: [float] | [integer] | [tuple],
              uniform_type :: integer
            ) :: :ok
      def set_shader_value_v(
            _shader,
            _loc_index,
            _value,
            _uniform_type
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set shader uniform value (matrix 4x4)

      ```c
      // raylib.h
      RLAPI void SetShaderValueMatrix(Shader shader, int locIndex, Matrix mat);
      ```
      """
      @doc group: :shader
      @spec set_shader_value_matrix(
              shader :: tuple,
              loc_index :: integer,
              mat :: tuple
            ) :: :ok
      def set_shader_value_matrix(
            _shader,
            _loc_index,
            _mat
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set shader uniform value for texture (sampler2d)

      ```c
      // raylib.h
      RLAPI void SetShaderValueTexture(Shader shader, int locIndex, Texture2D texture);
      ```
      """
      @doc group: :shader
      @spec set_shader_value_texture(
              shader :: tuple,
              loc_index :: integer,
              texture :: tuple
            ) :: :ok
      def set_shader_value_texture(
            _shader,
            _loc_index,
            _texture
          ),
          do: :erlang.nif_error(:undef)
    end
  end
end
