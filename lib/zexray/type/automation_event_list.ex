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

  defstruct capacity: 0,
            count: 0,
            events: []

  use Zexray.Type.TypeBase, prefix: "automation_event_list"

  @type t ::
          %__MODULE__{
            capacity: non_neg_integer,
            count: non_neg_integer,
            events: [Zexray.Type.AutomationEvent.t_nif()]
          }

  @type t_all ::
          t
          | {
              non_neg_integer,
              non_neg_integer,
              [Zexray.Type.AutomationEvent.t_all()]
            }
          | map
          | keyword
          | Resource.t()

  import Zexray.Guard

  @doc """
  Creates a new `t:t/0`.
  """
  def new(automation_event_list)

  @spec new({
          capacity :: non_neg_integer,
          count :: non_neg_integer,
          events :: [Zexray.Type.AutomationEvent.t_all()]
        }) :: t()
  def new({
        capacity,
        count,
        events
      })
      when is_integer(capacity) and
             is_integer(count) and
             is_list(events) and (events == [] or is_automation_event_like(hd(events))) do
    new(
      capacity: capacity,
      count: count,
      events: events
    )
  end

  @spec new(automation_event_list :: struct) :: t()
  def new(automation_event_list) when is_struct(automation_event_list) do
    automation_event_list =
      if String.ends_with?(Atom.to_string(automation_event_list.__struct__), ".Resource") do
        apply(automation_event_list.__struct__, :content, [automation_event_list])
      else
        automation_event_list
      end

    case automation_event_list do
      %__MODULE__{} = automation_event_list -> automation_event_list
      _ -> new(Map.from_struct(automation_event_list))
    end
  end

  @spec new(fields :: Enumerable.t()) :: t()
  def new(fields) do
    if Enumerable.impl_for(fields) != nil do
      struct!(
        __MODULE__,
        fields
        |> Enum.map(fn {key, value} ->
          value =
            cond do
              is_nil(value) ->
                value

              key == :events and is_list(value) ->
                Enum.map(value, fn v ->
                  cond do
                    is_struct(v, Zexray.Type.AutomationEvent.Resource) -> v
                    is_reference(v) -> Zexray.Type.AutomationEvent.Resource.new(v)
                    true -> Zexray.Type.AutomationEvent.new(v)
                  end
                end)

              true ->
                value
            end

          {key, value}
        end)
      )
    else
      raise_argument_error(fields)
    end
  end
end
