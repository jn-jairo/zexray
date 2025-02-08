defmodule Zexray.NIF do
  if Application.compile_env(:zexray, :internal_docs) do
    @moduledoc """
    Internal module, don't use it directly.
    """
  else
    @moduledoc false
    alias IEx.App
  end

  @on_load :__on_load__

  def __on_load__ do
    lib = ~c"#{:code.priv_dir(:zexray)}/lib/libzexray"
    :erlang.load_nif(lib, 0)

    Application.fetch_env!(:zexray, :trace_log_level)
    |> Zexray.Enum.TraceLogLevel.value()
    |> set_trace_log_level()
  end

  use Zexray.NIF.Resource
  use Zexray.NIF.Font
  use Zexray.NIF.Image
  use Zexray.NIF.Material
  use Zexray.NIF.Mesh
  use Zexray.NIF.Model
  use Zexray.NIF.Shader
  use Zexray.NIF.Util

  @nifs @nifs_resource ++
          @nifs_font ++
          @nifs_image ++
          @nifs_material ++
          @nifs_mesh ++
          @nifs_model ++
          @nifs_shader ++
          @nifs_util
end
