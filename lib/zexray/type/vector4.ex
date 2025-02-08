defmodule Zexray.Type.Vector4Base do
  @moduledoc false

  defmacro __using__(opts) do
    prefix = Keyword.fetch!(opts, :prefix)
    name = String.replace(prefix, "_", " ")

    quote do
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

      use Zexray.Type.TypeBase, prefix: unquote(prefix)

      @type t ::
              %__MODULE__{
                x: float,
                y: float,
                z: float,
                w: float
              }

      @type t_all ::
              Zexray.Type.Vector4.t()
              | Zexray.Type.Quaternion.t()
              | {float, float, float, float}
              | map
              | keyword
              | Zexray.Type.Vector4.Resource.t()
              | Zexray.Type.Quaternion.Resource.t()

      @doc """
      Creates a new `t:t/0`.
      """
      def new(vector)

      @spec new({
              x :: float,
              y :: float,
              z :: float,
              w :: float
            }) :: t()
      def new({x, y, z, w})
          when is_float(x) and
                 is_float(y) and
                 is_float(z) and
                 is_float(w) do
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
          raise ArgumentError, "Invalid #{unquote(name)}: #{inspect(fields)}"
        end
      end
    end
  end
end

defmodule Zexray.Type.Vector4 do
  use Zexray.Type.Vector4Base, prefix: "vector4"
end
