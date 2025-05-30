defmodule Zexray.Type.AutomationEvent do
  @moduledoc """
  Automation event

  ## Fields

  |          |                                  |
  | -------- | -------------------------------- |
  | `frame`  | Event frame                      |
  | `type`   | Event type (AutomationEventType) |
  | `params` | Event parameters (if required)   |
  """

  require Record

  @type t ::
          record(:t,
            frame: non_neg_integer,
            type: non_neg_integer,
            params: [integer]
          )

  Record.defrecord(:t, :automation_event,
    frame: 0,
    type: 0,
    params: []
  )

  use Zexray.Type.TypeBase, prefix: "automation_event"

  @type t_all :: t | t_resource
end
