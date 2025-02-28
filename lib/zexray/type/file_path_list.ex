defmodule Zexray.Type.FilePathList do
  @moduledoc """
  File path list

  ## Fields

  |            |                         |
  | ---------- | ----------------------- |
  | `capacity` | Filepaths max entries   |
  | `count`    | Filepaths entries count |
  | `paths`    | Filepaths entries       |
  """

  defstruct capacity: 0,
            count: 0,
            paths: []

  use Zexray.Type.TypeBase, prefix: "file_path_list"

  @type t ::
          %__MODULE__{
            capacity: non_neg_integer,
            count: non_neg_integer,
            paths: [binary]
          }

  @type t_all ::
          t
          | {
              non_neg_integer,
              non_neg_integer,
              [binary]
            }
          | map
          | keyword
          | Resource.t()

  @doc """
  Creates a new `t:t/0`.
  """
  def new(file_path_list)

  @spec new({
          capacity :: non_neg_integer,
          count :: non_neg_integer,
          paths :: [binary]
        }) :: t()
  def new({
        capacity,
        count,
        paths
      })
      when is_integer(capacity) and
             is_integer(count) and
             is_list(paths) and (paths == [] or is_binary(hd(paths))) do
    new(
      capacity: capacity,
      count: count,
      paths: paths
    )
  end

  @spec new(file_path_list :: struct) :: t()
  def new(file_path_list) when is_struct(file_path_list) do
    file_path_list =
      if String.ends_with?(Atom.to_string(file_path_list.__struct__), ".Resource") do
        apply(file_path_list.__struct__, :content, [file_path_list])
      else
        file_path_list
      end

    case file_path_list do
      %__MODULE__{} = file_path_list -> file_path_list
      _ -> new(Map.from_struct(file_path_list))
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
