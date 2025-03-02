defmodule Zexray.Type.Camera3DBase do
  @moduledoc false

  defmacro __using__(opts) do
    prefix = Keyword.fetch!(opts, :prefix)

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

      defstruct position: nil,
                target: nil,
                up: nil,
                fovy: nil,
                projection: nil

      use Zexray.Type.TypeBase, prefix: unquote(prefix)

      @type t ::
              %__MODULE__{
                position: Zexray.Type.Vector3.t_nif(),
                target: Zexray.Type.Vector3.t_nif(),
                up: Zexray.Type.Vector3.t_nif(),
                fovy: float,
                projection: Zexray.Enum.CameraProjection.t()
              }

      @type t_all ::
              Zexray.Type.Camera3D.t()
              | Zexray.Type.Camera.t()
              | {
                  Zexray.Type.Vector3.t_all(),
                  Zexray.Type.Vector3.t_all(),
                  Zexray.Type.Vector3.t_all(),
                  float,
                  Zexray.Enum.CameraProjection.t_all()
                }
              | map
              | keyword
              | Zexray.Type.Camera3D.Resource.t()
              | Zexray.Type.Camera.Resource.t()

      import Zexray.Guard

      @doc """
      Creates a new `t:t/0`.
      """
      def new(camera_3d)

      @spec new({
              position :: Zexray.Type.Vector3.t_all(),
              target :: Zexray.Type.Vector3.t_all(),
              up :: Zexray.Type.Vector3.t_all(),
              fovy :: float,
              projection :: Zexray.Enum.CameraProjection.t_all()
            }) :: t()
      def new({
            position,
            target,
            up,
            fovy,
            projection
          })
          when is_like_vector3(position) and
                 is_like_vector3(target) and
                 is_like_vector3(up) and
                 is_float(fovy) and
                 is_like_camera_projection(projection) do
        new(
          position: position,
          target: target,
          up: up,
          fovy: fovy,
          projection: projection
        )
      end

      @spec new(camera_3d :: struct) :: t()
      def new(camera_3d) when is_struct(camera_3d) do
        camera_3d =
          if String.ends_with?(Atom.to_string(camera_3d.__struct__), ".Resource") do
            apply(camera_3d.__struct__, :content, [camera_3d])
          else
            camera_3d
          end

        case camera_3d do
          %__MODULE__{} = camera_3d -> camera_3d
          _ -> new(Map.from_struct(camera_3d))
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

                  key in [:position, :target, :up] ->
                    cond do
                      is_struct(value, Zexray.Type.Vector3.Resource) -> value
                      is_reference(value) -> Zexray.Type.Vector3.Resource.new(value)
                      true -> Zexray.Type.Vector3.new(value)
                    end

                  key == :projection ->
                    Zexray.Enum.CameraProjection.value(value)

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

defmodule Zexray.Type.Camera3D do
  use Zexray.Type.Camera3DBase, prefix: "camera_3d"
end
