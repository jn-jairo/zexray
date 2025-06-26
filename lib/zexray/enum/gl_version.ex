defmodule Zexray.Enum.GlVersion do
  @moduledoc """
  OpenGL version

  ## Values

  | id | name          | description                 |
  | -- | ------------- | --------------------------- |
  |  1 | :opengl_11    | OpenGL 1.1                  |
  |  2 | :opengl_21    | OpenGL 2.1 (GLSL 120)       |
  |  3 | :opengl_33    | OpenGL 3.3 (GLSL 330)       |
  |  4 | :opengl_43    | OpenGL 4.3 (using GLSL 330) |
  |  5 | :opengl_es_20 | OpenGL ES 2.0 (GLSL 100)    |
  |  6 | :opengl_es_30 | OpenGL ES 3.0 (GLSL 300 es) |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gl_version",
    values: %{
      opengl_11: 1,
      opengl_21: 2,
      opengl_33: 3,
      opengl_43: 4,
      opengl_es_20: 5,
      opengl_es_30: 6
    }
end
