defmodule Zexray.Type.Shader do
  @moduledoc """
  Shader

  ## Fields

  |        |                        |
  | ------ | ---------------------- |
  | `id`   | Shader program id      |
  | `locs` | Shader locations array |
  """

  defstruct id: 0,
            locs: []

  use Zexray.Type.TypeBase, prefix: "shader"

  @type t ::
          %__MODULE__{
            id: non_neg_integer,
            locs: [integer]
          }

  @type t_all ::
          t
          | {
              non_neg_integer,
              [integer]
            }
          | map
          | keyword
          | Resource.t()

  @doc """
  Creates a new `t:t/0`.
  """
  def new(shader)

  @spec new({
          id :: non_neg_integer,
          locs :: [integer]
        }) :: t()
  def new({id, locs})
      when is_integer(id) and
             is_list(locs) and (locs == [] or is_integer(hd(locs))) do
    new(
      id: id,
      locs: locs
    )
  end

  @spec new(shader :: struct) :: t()
  def new(shader) when is_struct(shader) do
    shader =
      if String.ends_with?(Atom.to_string(shader.__struct__), ".Resource") do
        apply(shader.__struct__, :content, [shader])
      else
        shader
      end

    case shader do
      %__MODULE__{} = shader -> shader
      _ -> new(Map.from_struct(shader))
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
