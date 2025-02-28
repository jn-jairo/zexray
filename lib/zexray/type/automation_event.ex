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

  defstruct frame: 0,
            type: 0,
            params: []

  use Zexray.Type.TypeBase, prefix: "automation_event"

  @type t ::
          %__MODULE__{
            frame: non_neg_integer,
            type: non_neg_integer,
            params: [integer]
          }

  @type t_all ::
          t
          | {
              non_neg_integer,
              non_neg_integer,
              [integer]
            }
          | map
          | keyword
          | Resource.t()

  @doc """
  Creates a new `t:t/0`.
  """
  def new(automation_event)

  @spec new({
          frame :: non_neg_integer,
          type :: non_neg_integer,
          params :: [integer]
        }) :: t()
  def new({
        frame,
        type,
        params
      })
      when is_integer(frame) and
             is_integer(type) and
             is_list(params) and (params == [] or is_integer(hd(params))) do
    new(
      frame: frame,
      type: type,
      params: params
    )
  end

  @spec new(automation_event :: struct) :: t()
  def new(automation_event) when is_struct(automation_event) do
    automation_event =
      if String.ends_with?(Atom.to_string(automation_event.__struct__), ".Resource") do
        apply(automation_event.__struct__, :content, [automation_event])
      else
        automation_event
      end

    case automation_event do
      %__MODULE__{} = automation_event -> automation_event
      _ -> new(Map.from_struct(automation_event))
    end
  end

  @spec new(fields :: Enumerable.t()) :: t()
  def new(fields) do
    if Enumerable.impl_for(fields) != nil do
      struct!(
        __MODULE__,
        fields
      )
    else
      raise_argument_error(fields)
    end
  end
end
