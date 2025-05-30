defmodule Zexray.Type.Image do
  @moduledoc """
  Pixel data stored in CPU memory (RAM)

  ## Fields

  |           |                             |
  | --------- | --------------------------- |
  | `data`    | Image raw data              |
  | `width`   | Image base width            |
  | `height`  | Image base height           |
  | `mipmaps` | Mipmap levels, 1 by default |
  | `format`  | Data format                 |
  """

  require Record

  @type t ::
          record(:t,
            data: binary,
            width: integer,
            height: integer,
            mipmaps: integer,
            format: Zexray.Enum.PixelFormat.t()
          )

  Record.defrecord(:t, :image,
    data: nil,
    width: 0,
    height: 0,
    mipmaps: 1,
    format: nil
  )

  use Zexray.Type.TypeBase, prefix: "image"

  @type t_all :: t | t_resource
end
