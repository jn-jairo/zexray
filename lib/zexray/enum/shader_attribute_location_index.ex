defmodule Zexray.Enum.ShaderAttributeLocationIndex do
  @moduledoc """
  Shader attribute location index

  ## Values

  | id | name         | description               |
  | -- | ------------ | ------------------------- |
  |  0 | :position    | Vertex position           |
  |  1 | :texcoord    | Texture coordinates       |
  |  2 | :normal      | Normal                    |
  |  3 | :color       | Vertex color              |
  |  4 | :tangent     | Tangent vector            |
  |  5 | :texcoord2   | Texture coordinates 2     |
  |  6 | :indices     | Indices                   |
  |  7 | :boneids     | Bone ids                  |
  |  8 | :boneweights | Bone weights              |
  |  9 | :instance_tx | Instance transform matrix |
  """

  use Zexray.Enum.EnumBase,
    prefix: "shader_attribute_location_index",
    values: %{
      position: 0,
      texcoord: 1,
      normal: 2,
      color: 3,
      tangent: 4,
      texcoord2: 5,
      indices: 6,
      boneids: 7,
      boneweights: 8,
      instance_tx: 9
    }
end
