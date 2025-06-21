defmodule Zexray.Math do
  @moduledoc """
  Math functions to work with Vector2, Vector3, Vector4, Matrix and Quaternions
  """

  # @epsilon 0.000001
  @epsilon 0.00001

  @deg2rad :math.pi() / 180.0
  @rad2deg 180.0 / :math.pi()

  use Zexray.Type

  use Zexray.Math.Util

  use Zexray.Math.Matrix
  use Zexray.Math.Quaternion
  use Zexray.Math.Vector2
  use Zexray.Math.Vector3
  use Zexray.Math.Vector4
end
