defmodule Zexray.Enum.FramebufferAttachTextureType do
  @moduledoc """
  Framebuffer texture attachment type

  ## Values

  |  id | name                | description                                           |
  | --- | ------------------- | ----------------------------------------------------- |
  |   0 | :cubemap_positive_x | Framebuffer texture attachment type: cubemap, +X side |
  |   1 | :cubemap_negative_x | Framebuffer texture attachment type: cubemap, -X side |
  |   2 | :cubemap_positive_y | Framebuffer texture attachment type: cubemap, +Y side |
  |   3 | :cubemap_negative_y | Framebuffer texture attachment type: cubemap, -Y side |
  |   4 | :cubemap_positive_z | Framebuffer texture attachment type: cubemap, +Z side |
  |   5 | :cubemap_negative_z | Framebuffer texture attachment type: cubemap, -Z side |
  | 100 | :texture2d          | Framebuffer texture attachment type: texture2d        |
  | 200 | :renderbuffer       | Framebuffer texture attachment type: renderbuffer     |
  """

  use Zexray.Enum.EnumBase,
    prefix: "framebuffer_attach_texture_type",
    values: %{
      cubemap_positive_x: 0,
      cubemap_negative_x: 1,
      cubemap_positive_y: 2,
      cubemap_negative_y: 3,
      cubemap_positive_z: 4,
      cubemap_negative_z: 5,
      texture2d: 100,
      renderbuffer: 200
    }
end
