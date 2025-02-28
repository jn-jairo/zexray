defmodule Zexray.NIF.AutomationEvent do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_automation_event [
        # AutomationEvent
        automation_event_get_max_params: 0,

        # AutomationEventList
        automation_event_list_get_max_automation_events: 0
      ]

      #####################
      #  AutomationEvent  #
      #####################

      @doc """
      Get automation event max params for AutomationEvent.params
      """
      @doc group: :automation_event
      @spec automation_event_get_max_params() :: non_neg_integer
      def automation_event_get_max_params(), do: :erlang.nif_error(:undef)

      #########################
      #  AutomationEventList  #
      #########################

      @doc """
      Get automation event list max automation events for AutomationEventList.events
      """
      @doc group: :automation_event
      @spec automation_event_list_get_max_automation_events() :: non_neg_integer
      def automation_event_list_get_max_automation_events(), do: :erlang.nif_error(:undef)
    end
  end
end
