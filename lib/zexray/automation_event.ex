defmodule Zexray.AutomationEvent do
  @moduledoc """
  Automation Event
  """

  alias Zexray.NIF

  @doc """
  Get automation event max params for AutomationEvent.params
  """
  @spec max_params() :: non_neg_integer
  def max_params() do
    NIF.automation_event_get_max_params()
  end

  @doc """
  Get automation event list max automation events for AutomationEventList.events
  """
  @spec automation_event_list_max_automation_events() :: non_neg_integer
  def automation_event_list_max_automation_events() do
    NIF.automation_event_list_get_max_automation_events()
  end
end
