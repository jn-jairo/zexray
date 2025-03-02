defmodule Zexray.Enum.TextureFilter do
  @moduledoc """
  Texture parameters: filter mode

  NOTE 1: Filtering considers mipmaps if available in the texture

  NOTE 2: Filter is accordingly set for minification and magnification

  ## Values

  | id | name             | description                               |
  | -- | ---------------- | ----------------------------------------- |
  |  0 | :point           | No filter, just pixel approximation       |
  |  1 | :bilinear        | Linear filtering                          |
  |  2 | :trilinear       | Trilinear filtering (linear with mipmaps) |
  |  3 | :anisotropic_4x  | Anisotropic filtering 4x                  |
  |  4 | :anisotropic_8x  | Anisotropic filtering 8x                  |
  |  5 | :anisotropic_16x | Anisotropic filtering 16x                 |
  """

  use Zexray.Enum.EnumBase,
    prefix: "texture_filter",
    values: %{
      point: 0,
      bilinear: 1,
      trilinear: 2,
      anisotropic_4x: 3,
      anisotropic_8x: 4,
      anisotropic_16x: 5
    }
end
