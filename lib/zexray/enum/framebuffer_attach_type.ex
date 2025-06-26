defmodule Zexray.Enum.FramebufferAttachType do
  @moduledoc """
  Framebuffer attachment type

  NOTE: By default up to 8 color channels defined, but it can be more

  ## Values

  |  id | name            | description                          |
  | --- | --------------- | ------------------------------------ |
  |   0 | :color_channel0 | Framebuffer attachment type: color 0 |
  |   1 | :color_channel1 | Framebuffer attachment type: color 1 |
  |   2 | :color_channel2 | Framebuffer attachment type: color 2 |
  |   3 | :color_channel3 | Framebuffer attachment type: color 3 |
  |   4 | :color_channel4 | Framebuffer attachment type: color 4 |
  |   5 | :color_channel5 | Framebuffer attachment type: color 5 |
  |   6 | :color_channel6 | Framebuffer attachment type: color 6 |
  |   7 | :color_channel7 | Framebuffer attachment type: color 7 |
  | 100 | :depth          | Framebuffer attachment type: depth   |
  | 200 | :stencil        | Framebuffer attachment type: stencil |
  """

  use Zexray.Enum.EnumBase,
    prefix: "framebuffer_attach_type",
    values: %{
      color_channel0: 0,
      color_channel1: 1,
      color_channel2: 2,
      color_channel3: 3,
      color_channel4: 4,
      color_channel5: 5,
      color_channel6: 6,
      color_channel7: 7,
      depth: 100,
      stencil: 200
    }
end
