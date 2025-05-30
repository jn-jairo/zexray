defmodule Zexray.Type.AutomationEventList do
  @moduledoc """
  Automation event list

  ## Fields

  |            |                                            |
  | ---------- | ------------------------------------------ |
  | `capacity` | Events max entries (MAX_AUTOMATION_EVENTS) |
  | `count`    | Events entries count                       |
  | `events`   | Events entries                             |
  """

  require Record

  @type t ::
          record(:t,
            capacity: non_neg_integer,
            count: non_neg_integer,
            events: [Zexray.Type.AutomationEvent.t_nif()]
          )

  Record.defrecord(:t, :automation_event_list,
    capacity: 0,
    count: 0,
    events: []
  )

  use Zexray.Type.TypeBase, prefix: "automation_event_list"

  @type t_all :: t | t_resource
end
