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

  defstruct source: nil,
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            layout: nil

  use Zexray.Type.TypeBase, prefix: "n_patch_info"

  @type t ::
          %__MODULE__{
            source: Zexray.Type.Rectangle.t_nif(),
            left: integer,
            top: integer,
            right: integer,
            bottom: integer,
            layout: Zexray.Enum.NPatchLayout.t()
          }

  @type t_all ::
          t
          | {
              Zexray.Type.Rectangle.t_all(),
              integer,
              integer,
              integer,
              integer,
              Zexray.Enum.NPatchLayout.t_all()
            }
          | map
          | keyword
          | Resource.t()

  import Zexray.Guard

  @doc """
  Creates a new `t:t/0`.
  """
  def new(n_patch_info)

  @spec new({
          source :: Zexray.Type.Rectangle.t_all(),
          left :: integer,
          top :: integer,
          right :: integer,
          bottom :: integer,
          layout :: Zexray.Enum.NPatchLayout.t_all()
        }) :: t()
  def new({
        source,
        left,
        top,
        right,
        bottom,
        layout
      })
      when is_like_rectangle(source) and
             is_integer(left) and
             is_integer(top) and
             is_integer(right) and
             is_integer(bottom) and
             is_like_n_patch_layout(layout) do
    new(
      source: source,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      layout: layout
    )
  end

  @spec new(n_patch_info :: struct) :: t()
  def new(n_patch_info) when is_struct(n_patch_info) do
    n_patch_info =
      if String.ends_with?(Atom.to_string(n_patch_info.__struct__), ".Resource") do
        apply(n_patch_info.__struct__, :content, [n_patch_info])
      else
        n_patch_info
      end

    case n_patch_info do
      %__MODULE__{} = n_patch_info -> n_patch_info
      _ -> new(Map.from_struct(n_patch_info))
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

              key == :source ->
                cond do
                  is_struct(value, Zexray.Type.Rectangle.Resource) -> value
                  is_reference(value) -> Zexray.Type.Rectangle.Resource.new(value)
                  true -> Zexray.Type.Rectangle.new(value)
                end

              key == :layout ->
                Zexray.Enum.NPatchLayout.value(value)

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
