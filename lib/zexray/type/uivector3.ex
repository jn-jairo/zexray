defmodule Zexray.Type.UIVector3 do
  @moduledoc """
  3 components

  ## Fields

  |     |                    |
  | --- | ------------------ |
  | `x` | Vector x component |
  | `y` | Vector y component |
  | `z` | Vector z component |
  """

  defstruct x: 0.0,
            y: 0.0,
            z: 0.0

  use Zexray.Type.TypeBase, prefix: "uivector3"

  import Zexray.Guard

  @type t ::
          %__MODULE__{
            x: non_neg_integer,
            y: non_neg_integer,
            z: non_neg_integer
          }

  @type t_all ::
          t
          | {non_neg_integer, non_neg_integer, non_neg_integer}
          | map
          | keyword
          | Resource.t()

  @doc """
  Creates a new `t:t/0`.
  """
  def new(vector)

  @spec new({
          x :: non_neg_integer,
          y :: non_neg_integer,
          z :: non_neg_integer
        }) :: t()
  def new({
        x,
        y,
        z
      })
      when is_non_neg_integer(x) and
             is_non_neg_integer(y) and
             is_non_neg_integer(z) do
    new(
      x: x,
      y: y,
      z: z
    )
  end

  @spec new(vector :: struct) :: t()
  def new(vector) when is_struct(vector) do
    vector =
      if String.ends_with?(Atom.to_string(vector.__struct__), ".Resource") do
        apply(vector.__struct__, :content, [vector])
      else
        vector
      end

    case vector do
      %__MODULE__{} = vector -> vector
      _ -> new(Map.from_struct(vector))
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
