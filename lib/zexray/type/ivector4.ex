defmodule Zexray.Type.IVector4 do
  @moduledoc """
  4 components

  ## Fields

  |     |                    |
  | --- | ------------------ |
  | `x` | Vector x component |
  | `y` | Vector y component |
  | `z` | Vector z component |
  | `w` | Vector w component |
  """

  defstruct x: 0.0,
            y: 0.0,
            z: 0.0,
            w: 0.0

  use Zexray.Type.TypeBase, prefix: "ivector4"

  @type t ::
          %__MODULE__{
            x: integer,
            y: integer,
            z: integer,
            w: integer
          }

  @type t_all ::
          t
          | {integer, integer, integer, integer}
          | map
          | keyword
          | Resource.t()

  @doc """
  Creates a new `t:t/0`.
  """
  def new(vector)

  @spec new({
          x :: integer,
          y :: integer,
          z :: integer,
          w :: integer
        }) :: t()
  def new({
        x,
        y,
        z,
        w
      })
      when is_integer(x) and
             is_integer(y) and
             is_integer(z) and
             is_integer(w) do
    new(
      x: x,
      y: y,
      z: z,
      w: w
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
