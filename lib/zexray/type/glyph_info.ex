defmodule Zexray.Type.GlyphInfo do
  @moduledoc """
  Font characters glyphs info

  ## Fields

  |             |                                 |
  | ----------- | ------------------------------- |
  | `value`     | Character value (Unicode)       |
  | `offset_x`  | Character offset X when drawing |
  | `offset_y`  | Character offset Y when drawing |
  | `advance_x` | Character advance position X    |
  | `image`     | Character image data            |
  """

  require Record

  @type t ::
          record(:t,
            value: integer,
            offset_x: integer,
            offset_y: integer,
            advance_x: integer,
            image: Zexray.Type.Image.t_nif()
          )

  Record.defrecord(:t, :glyph_info,
    value: nil,
    offset_x: 0,
    offset_y: 0,
    advance_x: 0,
    image: nil
  )

  use Zexray.Type.TypeBase, prefix: "glyph_info"

  @type t_all :: t | t_resource
end
