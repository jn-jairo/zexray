defmodule Zexray.AutomationEvent do
  @moduledoc """
  Automation Event
  """

  alias Zexray.NIF

  @doc """
  Get automation event max params for AutomationEvent.params
  """
  @spec max_params() :: non_neg_integer
  defdelegate max_params(), to: NIF, as: :automation_event_get_max_params

  @doc """
  Get automation event list max automation events for AutomationEventList.events
  """
  @spec automation_event_list_max_automation_events() :: non_neg_integer
  defdelegate automation_event_list_max_automation_events(),
    to: NIF,
    as: :automation_event_list_get_max_automation_events
end
