defmodule Zexray.Type.ModelAnimation do
  @moduledoc """
  Model Animation

  ## Fields

  |               |                              |
  | ------------- | ---------------------------- |
  | `bone_count`  | Number of bones              |
  | `frame_count` | Number of animation frames   |
  | `bones`       | Bones information (skeleton) |
  | `frame_poses` | Poses array by frame         |
  | `name`        | Animation name               |
  """

  defstruct bone_count: 0,
            frame_count: 0,
            bones: [],
            frame_poses: [],
            name: nil

  use Zexray.Type.TypeBase, prefix: "model_animation"

  @type t ::
          %__MODULE__{
            bone_count: integer,
            frame_count: integer,
            bones: [Zexray.Type.BoneInfo.t_nif()],
            frame_poses: [[Zexray.Type.Transform.t_nif()]],
            name: binary
          }

  @type t_all ::
          t
          | {
              integer,
              integer,
              [Zexray.Type.BoneInfo.t_all()],
              [[Zexray.Type.Transform.t_all()]],
              binary
            }
          | map
          | keyword
          | Resource.t()

  import Zexray.Guard

  @doc """
  Creates a new `t:t/0`.
  """
  def new(model_animation)

  @spec new({
          bone_count :: integer,
          frame_count :: integer,
          bones :: [Zexray.Type.BoneInfo.t_all()],
          frame_poses :: [[Zexray.Type.Transform.t_all()]],
          name :: binary
        }) :: t()
  def new({
        bone_count,
        frame_count,
        bones,
        frame_poses,
        name
      })
      when is_integer(bone_count) and
             is_integer(frame_count) and
             is_list(bones) and (bones == [] or is_bone_info_like(hd(bones))) and
             (is_list(frame_poses) and
                (frame_poses == [] or
                   (is_list(hd(frame_poses)) and
                      (hd(frame_poses) == [] or is_transform_like(hd(hd(frame_poses))))))) and
             is_binary(name) do
    new(
      bone_count: bone_count,
      frame_count: frame_count,
      bones: bones,
      frame_poses: frame_poses,
      name: name
    )
  end

  @spec new(model_animation :: struct) :: t()
  def new(model_animation) when is_struct(model_animation) do
    model_animation =
      if String.ends_with?(Atom.to_string(model_animation.__struct__), ".Resource") do
        apply(model_animation.__struct__, :content, [model_animation])
      else
        model_animation
      end

    case model_animation do
      %__MODULE__{} = model_animation -> model_animation
      _ -> new(Map.from_struct(model_animation))
    end
  end

  @spec new(fields :: Enumerable.t()) :: t()
  def new(fields) do
    if Enumerable.impl_for(fields) != nil do
      struct!(
        __MODULE__,
        fields
        |> Enum.map(fn {key, value} ->
          cond do
            key == :bones and is_list(value) ->
              {key,
               Enum.map(value, fn v ->
                 cond do
                   is_struct(v, Zexray.Type.BoneInfo.Resource) -> v
                   is_reference(v) -> Zexray.Type.BoneInfo.Resource.new(v)
                   true -> Zexray.Type.BoneInfo.new(v)
                 end
               end)}

            key == :frame_poses and is_list(value) ->
              {key,
               Enum.map(
                 value,
                 &Enum.map(&1, fn v ->
                   cond do
                     is_struct(v, Zexray.Type.Transform.Resource) -> v
                     is_reference(v) -> Zexray.Type.Transform.Resource.new(v)
                     true -> Zexray.Type.Transform.new(v)
                   end
                 end)
               )}

            true ->
              {key, value}
          end
        end)
      )
    else
      raise ArgumentError, "Invalid model animation: #{inspect(fields)}"
    end
  end
end
