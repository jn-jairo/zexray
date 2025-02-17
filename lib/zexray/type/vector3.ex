defmodule Zexray.Type.Vector3 do
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

  use Zexray.Type.TypeBase, prefix: "vector3"

  @type t ::
          %__MODULE__{
            x: float,
            y: float,
            z: float
          }

  @type t_all ::
          t
          | {float, float, float}
          | map
          | keyword
          | Resource.t()

  @doc """
  Creates a new `t:t/0`.
  """
  def new(vector)

  @spec new({
          x :: float,
          y :: float,
          z :: float
        }) :: t()
  def new({x, y, z})
      when is_float(x) and
             is_float(y) and
             is_float(z) do
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
