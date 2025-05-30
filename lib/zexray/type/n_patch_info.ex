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

  @type t ::
          record(:t,
            source: Zexray.Type.Rectangle.t_nif(),
            left: integer,
            top: integer,
            right: integer,
            bottom: integer,
            layout: Zexray.Enum.NPatchLayout.t()
          )

  Record.defrecord(:t, :n_patch_info,
    source: nil,
    left: 0,
    top: 0,
    right: 0,
    bottom: 0,
    layout: nil
  )

  use Zexray.Type.TypeBase, prefix: "n_patch_info"

  @type t_all :: t | t_resource
end
