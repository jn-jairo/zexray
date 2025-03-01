defmodule Zexray.Enum.ShaderLocationIndex do
  @moduledoc """
  Shader location index

  ## Values

  | id | name                | description                                                                      |
  | -- | ------------------- | -------------------------------------------------------------------------------- |
  |  0 | :vertex_position    | Shader location: vertex attribute: position                                      |
  |  1 | :vertex_texcoord01  | Shader location: vertex attribute: texcoord01                                    |
  |  2 | :vertex_texcoord02  | Shader location: vertex attribute: texcoord02                                    |
  |  3 | :vertex_normal      | Shader location: vertex attribute: normal                                        |
  |  4 | :vertex_tangent     | Shader location: vertex attribute: tangent                                       |
  |  5 | :vertex_color       | Shader location: vertex attribute: color                                         |
  |  6 | :matrix_mvp         | Shader location: matrix uniform: model-view-projection                           |
  |  7 | :matrix_view        | Shader location: matrix uniform: view (camera transform)                         |
  |  8 | :matrix_projection  | Shader location: matrix uniform: projection                                      |
  |  9 | :matrix_model       | Shader location: matrix uniform: model (transform)                               |
  | 10 | :matrix_normal      | Shader location: matrix uniform: normal                                          |
  | 11 | :vector_view        | Shader location: vector uniform: view                                            |
  | 12 | :color_diffuse      | Shader location: vector uniform: diffuse color                                   |
  | 13 | :color_specular     | Shader location: vector uniform: specular color                                  |
  | 14 | :color_ambient      | Shader location: vector uniform: ambient color                                   |
  | 15 | :map_albedo         | Shader location: sampler2d texture: albedo (same as: :map_diffuse)               |
  | 15 | :map_diffuse        | Shader location: sampler2d texture: diffuse (same as: :map_albedo)               |
  | 16 | :map_metalness      | Shader location: sampler2d texture: metalness (same as: :map_specular)           |
  | 16 | :map_specular       | Shader location: sampler2d texture: specular (same as: :map_metalness)           |
  | 17 | :map_normal         | Shader location: sampler2d texture: normal                                       |
  | 18 | :map_roughness      | Shader location: sampler2d texture: roughness                                    |
  | 19 | :map_occlusion      | Shader location: sampler2d texture: occlusion                                    |
  | 20 | :map_emission       | Shader location: sampler2d texture: emission                                     |
  | 21 | :map_height         | Shader location: sampler2d texture: height                                       |
  | 22 | :map_cubemap        | Shader location: samplerCube texture: cubemap                                    |
  | 23 | :map_irradiance     | Shader location: samplerCube texture: irradiance                                 |
  | 24 | :map_prefilter      | Shader location: samplerCube texture: prefilter                                  |
  | 25 | :map_brdf           | Shader location: sampler2d texture: brdf                                         |
  | 26 | :vertex_boneids     | Shader location: vertex attribute: boneIds                                       |
  | 27 | :vertex_boneweights | Shader location: vertex attribute: boneWeights                                   |
  | 28 | :bone_matrices      | Shader location: array of matrices uniform: boneMatrices                         |
  """

  use Zexray.Enum.EnumBase,
    prefix: "shader_location_index",
    values: %{
      vertex_position: 0,
      vertex_texcoord01: 1,
      vertex_texcoord02: 2,
      vertex_normal: 3,
      vertex_tangent: 4,
      vertex_color: 5,
      matrix_mvp: 6,
      matrix_view: 7,
      matrix_projection: 8,
      matrix_model: 9,
      matrix_normal: 10,
      vector_view: 11,
      color_diffuse: 12,
      color_specular: 13,
      color_ambient: 14,
      map_diffuse: 15,
      map_albedo: 15,
      map_specular: 16,
      map_metalness: 16,
      map_normal: 17,
      map_roughness: 18,
      map_occlusion: 19,
      map_emission: 20,
      map_height: 21,
      map_cubemap: 22,
      map_irradiance: 23,
      map_prefilter: 24,
      map_brdf: 25,
      vertex_boneids: 26,
      vertex_boneweights: 27,
      bone_matrices: 28
    }
end
