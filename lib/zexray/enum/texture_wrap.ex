defmodule Zexray.Enum.TextureWrap do
  @moduledoc """
  Texture parameters: wrap mode

  ## Values

  | id | name           | description                                            |
  | -- | -------------- | ------------------------------------------------------ |
  |  0 | :repeat        | Repeats texture in tiled mode                          |
  |  1 | :clamp         | Clamps texture to edge pixel in tiled mode             |
  |  2 | :mirror_repeat | Mirrors and repeats the texture in tiled mode          |
  |  3 | :mirror_clamp  | Mirrors and clamps to border the texture in tiled mode |
  """

  use Zexray.Enum.EnumBase,
    prefix: "texture_wrap",
    values: %{
      repeat: 0,
      clamp: 1,
      mirror_repeat: 2,
      mirror_clamp: 3
    }
end
