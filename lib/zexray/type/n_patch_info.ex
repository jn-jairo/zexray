defmodule Zexray.Type.NPatchInfo do
  @moduledoc """
  N-patch layout info

  ## Fields

  |          |                                        |
  | -------- | -------------------------------------- |
  | `source` | Texture source rectangle               |
  | `left`   | Left border offset                     |
  | `top`    | Top border offset                      |
  | `right`  | Right border offset                    |
  | `bottom` | Bottom border offset                   |
  | `layout` | Layout of the n-patch: 3x3, 1x3 or 3x1 |
  """

  require Record

  require Zexray.Enum.NPatchLayout
  require Zexray.Type.Rectangle

  @type t ::
          record(:t,
            source: Zexray.Type.Rectangle.t_nif(),
            left: number,
            top: number,
            right: number,
            bottom: number,
            layout: Zexray.Enum.NPatchLayout.t()
          )

  Record.defrecord(:t, :n_patch_info,
    source: Zexray.Type.Rectangle.t(),
    left: 0,
    top: 0,
    right: 0,
    bottom: 0,
    layout: Zexray.Enum.NPatchLayout.enum(:nine_patch)
  )

  use Zexray.Type.TypeBase, prefix: "n_patch_info"

  @type t_all :: t | t_resource
end
