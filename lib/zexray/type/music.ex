defmodule Zexray.Type.Music do
  @moduledoc """
  Audio stream, anything longer than ~10 seconds should be streamed

  ## Fields

  |               |                                               |
  | ------------- | --------------------------------------------- |
  | `stream`      | Audio stream                                  |
  | `frame_count` | Total number of frames (considering channels) |
  | `looping`     | Music looping enable                          |
  | `ctx_type`    | Type of music context (audio filetype)        |
  | `ctx_data`    | Audio context data, depends on type           |
  """

  defstruct stream: nil,
            frame_count: 0,
            looping: false,
            ctx_type: 0,
            ctx_data: nil

  use Zexray.Type.TypeBase, prefix: "music"

  @type t ::
          %__MODULE__{
            stream: Zexray.Type.AudioStream.t_nif(),
            frame_count: non_neg_integer,
            looping: boolean,
            ctx_type: integer,
            ctx_data: reference | nil
          }

  @type t_all ::
          t
          | {
              Zexray.Type.AudioStream.t_all(),
              non_neg_integer,
              boolean,
              integer,
              reference | nil
            }
          | map
          | keyword
          | Resource.t()

  import Zexray.Guard

  @doc """
  Creates a new `t:t/0`.
  """
  def new(music)

  @spec new({
          stream :: Zexray.Type.AudioStream.t_all(),
          frame_count :: non_neg_integer,
          looping :: boolean,
          ctx_type :: integer,
          ctx_data :: reference | nil
        }) :: t()
  def new({
        stream,
        frame_count,
        looping,
        ctx_type,
        ctx_data
      })
      when is_like_audio_stream(stream) and
             is_integer(frame_count) and
             is_boolean(looping) and
             is_integer(ctx_type) and
             (is_reference(ctx_data) or is_nil(ctx_data)) do
    new(
      stream: stream,
      frame_count: frame_count,
      looping: looping,
      ctx_type: ctx_type,
      ctx_data: ctx_data
    )
  end

  @spec new(music :: struct) :: t()
  def new(music) when is_struct(music) do
    music =
      if String.ends_with?(Atom.to_string(music.__struct__), ".Resource") do
        apply(music.__struct__, :content, [music])
      else
        music
      end

    case music do
      %__MODULE__{} = music -> music
      _ -> new(Map.from_struct(music))
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

              key == :stream ->
                cond do
                  is_struct(value, Zexray.Type.AudioStream.Resource) -> value
                  is_reference(value) -> Zexray.Type.AudioStream.Resource.new(value)
                  true -> Zexray.Type.AudioStream.new(value)
                end

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
