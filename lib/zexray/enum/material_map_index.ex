defmodule Zexray.Enum.MaterialMapIndex do
  @moduledoc """
  Material map index

  ## Values

  | id | name        | description                                          |
  | -- | ----------- | ---------------------------------------------------- |
  |  0 | :albedo     | Albedo material (same as: :diffuse)                  |
  |  0 | :diffuse    | Diffuse material (same as: :albedo)                  |
  |  1 | :metalness  | Metalness material (same as: :specular)              |
  |  1 | :specular   | Specular material (same as: :metalness)              |
  |  2 | :normal     | Normal material                                      |
  |  3 | :roughness  | Roughness material                                   |
  |  4 | :occlusion  | Ambient occlusion material                           |
  |  5 | :emission   | Emission material                                    |
  |  6 | :height     | Heightmap material                                   |
  |  7 | :cubemap    | Cubemap material (NOTE: Uses GL_TEXTURE_CUBE_MAP)    |
  |  8 | :irradiance | Irradiance material (NOTE: Uses GL_TEXTURE_CUBE_MAP) |
  |  9 | :prefilter  | Prefilter material (NOTE: Uses GL_TEXTURE_CUBE_MAP)  |
  | 10 | :brdf       | Brdf material                                        |
  """

  use Zexray.Enum.EnumBase,
    prefix: "material_map_index",
    values: %{
      diffuse: 0,
      albedo: 0,
      specular: 1,
      metalness: 1,
      normal: 2,
      roughness: 3,
      occlusion: 4,
      emission: 5,
      height: 6,
      cubemap: 7,
      irradiance: 8,
      prefilter: 9,
      brdf: 10
    }
end
