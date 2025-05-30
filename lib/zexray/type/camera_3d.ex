defmodule Zexray.Type.Camera3DBase do
  @moduledoc false

  defmacro __using__(opts) do
    prefix = Keyword.fetch!(opts, :prefix)
    prefix_atom = String.to_atom(prefix)

    quote do
      @moduledoc """
      Defines position/orientation in 3d space

      ## Fields

      |              |                                                                                                       |
      | ------------ | ----------------------------------------------------------------------------------------------------- |
      | `position`   | Camera position                                                                                       |
      | `target`     | Camera target it looks-at                                                                             |
      | `up`         | Camera up vector (rotation over its axis)                                                             |
      | `fovy`       | Camera field-of-view aperture in Y (degrees) in perspective, used as near plane width in orthographic |
      | `projection` | Camera projection                                                                                     |
      """

      require Record

      @type t ::
              record(:t,
                position: Zexray.Type.Vector3.t_nif(),
                target: Zexray.Type.Vector3.t_nif(),
                up: Zexray.Type.Vector3.t_nif(),
                fovy: float,
                projection: Zexray.Enum.CameraProjection.t()
              )

      Record.defrecord(:t, unquote(prefix_atom),
        position: nil,
        target: nil,
        up: nil,
        fovy: nil,
        projection: nil
      )

      use Zexray.Type.TypeBase, prefix: unquote(prefix)

      @type t_all ::
              Zexray.Type.Camera3D.t()
              | Zexray.Type.Camera3D.t_resource()
              | Zexray.Type.Camera.t()
              | Zexray.Type.Camera.t_resource()
    end
  end
end

defmodule Zexray.Type.Camera3D do
  use Zexray.Type.Camera3DBase, prefix: "camera_3d"
end
