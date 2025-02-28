defmodule Zexray.AutomationEvent do
  alias Zexray.NIF

  @doc """
  Get automation event max params for AutomationEvent.params
  """
  @spec max_params() :: non_neg_integer
  def max_params() do
    NIF.automation_event_get_max_params()
  end
end
