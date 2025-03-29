defmodule Zexray.Enum.ShaderUniformDataType do
  @moduledoc """
  Shader uniform data type

  ## Values

  | id | name       | description                                  |
  | -- | ---------- | -------------------------------------------- |
  |  0 | :float     | Shader uniform type: float                   |
  |  1 | :vec2      | Shader uniform type: vec2 (2 float)          |
  |  2 | :vec3      | Shader uniform type: vec3 (3 float)          |
  |  3 | :vec4      | Shader uniform type: vec4 (4 float)          |
  |  4 | :int       | Shader uniform type: int                     |
  |  5 | :ivec2     | Shader uniform type: ivec2 (2 int)           |
  |  6 | :ivec3     | Shader uniform type: ivec3 (3 int)           |
  |  7 | :ivec4     | Shader uniform type: ivec4 (4 int)           |
  |  8 | :uint      | Shader uniform type: unsigned int            |
  |  9 | :uivec2    | Shader uniform type: uivec2 (2 unsigned int) |
  | 10 | :uivec3    | Shader uniform type: uivec3 (3 unsigned int) |
  | 11 | :uivec4    | Shader uniform type: uivec4 (4 unsigned int) |
  | 12 | :sampler2d | Shader uniform type: sampler2d               |
  """

  use Zexray.Enum.EnumBase,
    prefix: "shader_uniform_data_type",
    values: %{
      float: 0,
      vec2: 1,
      vec3: 2,
      vec4: 3,
      int: 4,
      ivec2: 5,
      ivec3: 6,
      ivec4: 7,
      uint: 8,
      uivec2: 9,
      uivec3: 10,
      uivec4: 11,
      sampler2d: 12
    }
end
