defmodule Zexray.Enum.FontType do
  @moduledoc """
  Font type, defines generation method

  ## Values

  | id | name     | description                                   |
  | -- | -------- | --------------------------------------------- |
  |  0 | :default | Default font generation, anti-aliased         |
  |  1 | :bitmap  | Bitmap font generation, no anti-aliasing      |
  |  2 | :sdf     | SDF font generation, requires external shader |
  """

  use Zexray.Enum.EnumBase,
    prefix: "font_type",
    values: %{
      default: 0,
      bitmap: 1,
      sdf: 2
    }
end
