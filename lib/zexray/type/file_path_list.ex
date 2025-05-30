defmodule Zexray.Type.FilePathList do
  @moduledoc """
  File path list

  ## Fields

  |            |                         |
  | ---------- | ----------------------- |
  | `capacity` | Filepaths max entries   |
  | `count`    | Filepaths entries count |
  | `paths`    | Filepaths entries       |
  """

  require Record

  @type t ::
          record(:t,
            capacity: non_neg_integer,
            count: non_neg_integer,
            paths: [binary]
          )

  Record.defrecord(:t, :file_path_list,
    capacity: 0,
    count: 0,
    paths: []
  )

  use Zexray.Type.TypeBase, prefix: "file_path_list"

  @type t_all :: t | t_resource
end
