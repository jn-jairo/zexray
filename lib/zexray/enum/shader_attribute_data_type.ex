defmodule Zexray.Enum.ShaderAttributeDataType do
  @moduledoc """
  Shader attribute data types

  ## Values

  | id | name   | description                           |
  | -- | ------ | ------------------------------------- |
  |  0 | :float | Shader attribute type: float          |
  |  1 | :vec2  | Shader attribute type: vec2 (2 float) |
  |  2 | :vec3  | Shader attribute type: vec3 (3 float) |
  |  3 | :vec4  | Shader attribute type: vec4 (4 float) |
  """

  use Zexray.Enum.EnumBase,
    prefix: "shader_attribute_data_type",
    values: %{
      float: 0,
      vec2: 1,
      vec3: 2,
      vec4: 3
    }
end
