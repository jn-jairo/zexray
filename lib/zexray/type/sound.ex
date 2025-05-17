defmodule Zexray.Type.SoundBase do
  @moduledoc false

  defmacro __using__(opts) do
    prefix = Keyword.fetch!(opts, :prefix)

    quote do
      @moduledoc """
      Sound

      ## Fields

      |               |                                               |
      | ------------- | --------------------------------------------- |
      | `stream`      | Audio stream                                  |
      | `frame_count` | Total number of frames (considering channels) |
      """

      defstruct stream: nil,
                frame_count: 0

      use Zexray.Type.TypeBase, prefix: unquote(prefix)

      @type t ::
              %__MODULE__{
                stream: Zexray.Type.AudioStream.t_nif(),
                frame_count: non_neg_integer
              }

      @type t_all ::
              Zexray.Type.Sound.t()
              | Zexray.Type.SoundAlias.t()
              | {
                  Zexray.Type.AudioStream.t_all(),
                  non_neg_integer
                }
              | map
              | keyword
              | Zexray.Type.Sound.Resource.t()
              | Zexray.Type.SoundAlias.Resource.t()

      import Zexray.Guard

      @doc """
      Creates a new `t:t/0`.
      """
      def new(sound)

      @spec new({
              stream :: Zexray.Type.AudioStream.t_all(),
              frame_count :: non_neg_integer
            }) :: t()
      def new({
            stream,
            frame_count
          })
          when is_like_audio_stream(stream) and
                 is_integer(frame_count) do
        new(
          stream: stream,
          frame_count: frame_count
        )
      end

      @spec new(sound :: struct) :: t()
      def new(sound) when is_struct(sound) do
        sound =
          if String.ends_with?(Atom.to_string(sound.__struct__), ".Resource") do
            apply(sound.__struct__, :content, [sound])
          else
            sound
          end

        case sound do
          %__MODULE__{} = sound -> sound
          _ -> new(Map.from_struct(sound))
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
  end
end

defmodule Zexray.Type.Sound do
  use Zexray.Type.SoundBase, prefix: "sound"
end
