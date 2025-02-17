defmodule Zexray.Type.BoneInfo do
  @moduledoc """
  Skeletal animation bone

  ## Fields

  |          |             |
  | -------- | ----------- |
  | `name`   | Bone name   |
  | `parent` | Bone parent |
  """

  defstruct name: nil,
            parent: nil

  use Zexray.Type.TypeBase, prefix: "bone_info"

  @type t ::
          %__MODULE__{
            name: binary,
            parent: integer
          }

  @type t_all ::
          t
          | {
              binary,
              integer
            }
          | map
          | keyword
          | Resource.t()

  @doc """
  Creates a new `t:t/0`.
  """
  def new(bone_info)

  @spec new({
          name :: binary,
          parent :: integer
        }) :: t()
  def new({name, parent})
      when is_binary(name) and
             is_integer(parent) do
    new(
      name: name,
      parent: parent
    )
  end

  @spec new(bone_info :: struct) :: t()
  def new(bone_info) when is_struct(bone_info) do
    bone_info =
      if String.ends_with?(Atom.to_string(bone_info.__struct__), ".Resource") do
        apply(bone_info.__struct__, :content, [bone_info])
      else
        bone_info
      end

    case bone_info do
      %__MODULE__{} = bone_info -> bone_info
      _ -> new(Map.from_struct(bone_info))
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
