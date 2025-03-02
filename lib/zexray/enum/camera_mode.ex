defmodule Zexray.Enum.CameraMode do
  @moduledoc """
  Camera system modes

  ## Values

  | id | name          | description                                                     |
  | -- | ------------- | --------------------------------------------------------------- |
  |  0 | :custom       | Camera custom, controlled by user (UpdateCamera() does nothing) |
  |  1 | :free         | Camera free mode                                                |
  |  2 | :orbital      | Camera orbital, around target, zoom supported                   |
  |  3 | :first_person | Camera first person                                             |
  |  4 | :third_person | Camera third person                                             |
  """

  use Zexray.Enum.EnumBase,
    prefix: "camera_mode",
    values: %{
      custom: 0,
      free: 1,
      orbital: 2,
      first_person: 3,
      third_person: 4
    }
end
