defmodule Zexray.Type.Font do
  @moduledoc """
  Font texture and GlyphInfo array data

  ## Fields

  |                 |                                      |
  | --------------- | ------------------------------------ |
  | `base_size`     | Base size (default chars height)     |
  | `glyph_count`   | Number of glyph characters           |
  | `glyph_padding` | Padding around the glyph characters  |
  | `texture`       | Texture atlas containing the glyphs  |
  | `recs`          | Rectangles in texture for the glyphs |
  | `glyphs`        | Glyphs info data                     |
  """

  require Record

  @type t ::
          record(:t,
            base_size: integer,
            glyph_count: integer,
            glyph_padding: integer,
            texture: Zexray.Type.Texture.t_nif(),
            recs: [Zexray.Type.Rectangle.t_nif()],
            glyphs: [Zexray.Type.GlyphInfo.t_nif()]
          )

  Record.defrecord(:t, :font,
    base_size: nil,
    glyph_count: 0,
    glyph_padding: 0,
    texture: nil,
    recs: [],
    glyphs: []
  )

  use Zexray.Type.TypeBase, prefix: "font"

  @type t_all :: t | t_resource
end
