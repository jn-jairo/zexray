defmodule Zexray.Font do
  import Zexray.Guard
  alias Zexray.NIF

  ##################
  #  Font loading  #
  ##################

  @doc """
  Load font from file into GPU memory (VRAM)
  """
  @doc group: :loading
  @spec load(
          file_name :: String.t(),
          return :: :value | :resource
        ) :: Zexray.Type.Font.t_nif()
  def load(file_name, return \\ :value)
      when is_binary(file_name) and
             is_nif_return(return) do
    NIF.load_font(
      file_name,
      return
    )
    |> Zexray.Type.Font.from_nif()
  end
end
