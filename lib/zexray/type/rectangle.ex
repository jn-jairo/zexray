defmodule Zexray.Type.Rectangle do
  @moduledoc """
  4 components

  ## Fields

  |          |                                      |
  | -------- | ------------------------------------ |
  | `x`      | Rectangle top-left corner position x |
  | `y`      | Rectangle top-left corner position y |
  | `width`  | Rectangle width                      |
  | `height` | Rectangle height                     |
  """

  defstruct x: 0.0,
            y: 0.0,
            width: 0.0,
            height: 0.0

  use Zexray.Type.TypeBase, prefix: "rectangle"

  @type t ::
          %__MODULE__{
            x: float,
            y: float,
            width: float,
            height: float
          }

  @type t_all ::
          t
          | {float, float, float, float}
          | map
          | keyword
          | Resource.t()

  @doc """
  Creates a new `t:t/0`.
  """
  def new(rectangle)

  @spec new({
          x :: float,
          y :: float,
          width :: float,
          height :: float
        }) :: t()
  def new({x, y, width, height})
      when is_float(x) and
             is_float(y) and
             is_float(width) and
             is_float(height) do
    new(
      x: x,
      y: y,
      width: width,
      height: height
    )
  end

  @spec new(rectangle :: struct) :: t()
  def new(rectangle) when is_struct(rectangle) do
    rectangle =
      if String.ends_with?(Atom.to_string(rectangle.__struct__), ".Resource") do
        apply(rectangle.__struct__, :content, [rectangle])
      else
        rectangle
      end

    case rectangle do
      %__MODULE__{} = rectangle -> rectangle
      _ -> new(Map.from_struct(rectangle))
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
