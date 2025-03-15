defmodule Zexray.WindowCase do
  @moduledoc false

  use ExUnit.CaseTemplate

  alias Zexray.Window

  setup :setup_callback

  def setup_callback(%{test: test_name}) do
    window_init(Atom.to_string(test_name))

    on_exit(fn ->
      window_close()
    end)

    :ok
  end

  defp window_init(title) do
    Window.init(800, 600, title)
    Window.clear_state(:all)

    :ok
  end

  defp window_close do
    if Window.ready?() do
      Window.close()
    end

    :ok
  end
end

defmodule Zexray.WindowAllCase do
  @moduledoc false

  use ExUnit.CaseTemplate

  alias Zexray.Window

  setup_all :setup_all_callback

  def setup_all_callback(_) do
    window_init()

    on_exit(fn ->
      window_close()
    end)

    :ok
  end

  setup :setup_callback

  def setup_callback(_) do
    if not Window.ready?() do
      window_init()
    end

    :ok
  end

  defp window_init() do
    Window.init(800, 600, "Zexray Test")
    Window.clear_state(:all)

    :ok
  end

  def window_close do
    if Window.ready?() do
      Window.close()
    end

    :ok
  end
end
