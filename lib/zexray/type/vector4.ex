defmodule Zexray.Type.Vector4Base do
  @moduledoc false

  defmacro __using__(opts) do
    prefix = Keyword.fetch!(opts, :prefix)
    prefix_atom = String.to_atom(prefix)

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

      require Record

      @type t ::
              record(:t,
                x: number,
                y: number,
                z: number,
                w: number
              )

      Record.defrecord(:t, unquote(prefix_atom),
        x: 0.0,
        y: 0.0,
        z: 0.0,
        w: 0.0
      )

      use Zexray.Type.TypeBase, prefix: unquote(prefix)

      @type t_all ::
              Zexray.Type.Vector4.t()
              | Zexray.Type.Vector4.t_resource()
              | Zexray.Type.Quaternion.t()
              | Zexray.Type.Quaternion.t_resource()
    end
  end
end

defmodule Zexray.Type.Vector4 do
  use Zexray.Type.Vector4Base, prefix: "vector4"
end
