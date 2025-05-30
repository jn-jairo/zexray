defmodule Zexray.WindowTest do
  use Zexray.WindowCase
  doctest Zexray.Window

  use Zexray.Enum
  use Zexray.Type

  @moduletag :nif
  @moduletag :window

  alias Zexray.FrameControl
  alias Zexray.Image
  alias Zexray.Resource
  alias Zexray.Window

  import Zexray.Guard
  import Zexray.Util, only: [similar?: 2, wait_fn: 1]

  test "initialization" do
    if Window.ready?() do
      Window.close()
    end

    try do
      assert not Window.ready?()
      Window.init(800, 600, "test window initialization")
      assert Window.ready?()
    after
      Window.close()
    end

    assert not Window.ready?()
  end

  test "should close" do
    assert not Window.should_close?()
  end

  test "fullscreen" do
    assert not Window.fullscreen?()
  end

  test "hidden" do
    assert not Window.hidden?()
  end

  test "minimized" do
    assert not Window.minimized?()
  end

  test "maximized" do
    assert not Window.maximized?()
  end

  test "focused" do
    assert :ok = Window.focus()
    assert Window.focused?()
  end

  test "resized" do
    assert not Window.resized?()
  end

  test "state" do
    assert not Window.state?(enum_config_flag(:window_resizable))

    Window.set_state(enum_config_flag(:window_resizable))
    assert Window.state?(enum_config_flag(:window_resizable))

    Window.clear_state(enum_config_flag(:window_resizable))
    assert not Window.state?(enum_config_flag(:window_resizable))
  end

  test "toggle fullscreen" do
    assert not Window.fullscreen?()

    Window.toggle_fullscreen()
    assert Window.fullscreen?()

    Window.toggle_fullscreen()
    assert not Window.fullscreen?()
  end

  test "toggle borderless" do
    assert not Window.state?(enum_config_flag(:borderless_windowed_mode))

    Window.toggle_borderless()
    assert Window.state?(enum_config_flag(:borderless_windowed_mode))

    Window.toggle_borderless()
    assert not Window.state?(enum_config_flag(:borderless_windowed_mode))
  end

  test "maximize" do
    Window.set_state(enum_config_flag(:window_resizable))
    assert not Window.maximized?()

    Window.maximize()
    assert Window.maximized?()
  end

  test "minimize" do
    Window.set_state(enum_config_flag(:window_always_run))
    assert not Window.minimized?()

    Window.minimize()

    wait_fn(fn ->
      FrameControl.poll_input_events()
      Window.minimized?()
    end)

    assert Window.minimized?()
  end

  test "restore" do
    Window.set_state(enum_config_flag(:window_resizable))
    Window.set_state(enum_config_flag(:window_always_run))
    assert not Window.maximized?()

    Window.maximize()
    assert Window.maximized?()

    Window.restore()
    assert not Window.maximized?()
  end

  test "set icon" do
    assert :ok =
             Image.gen_color(64, 64, enum_color(:yellow))
             |> Window.set_icon()
  end

  test "set icons" do
    assert :ok =
             [enum_color(:yellow), enum_color(:blue)]
             |> Enum.map(fn color ->
               Image.gen_color(64, 64, color)
             end)
             |> Window.set_icons()
  end

  test "set title" do
    assert :ok = Window.set_title("Zexray New Title")
  end

  test "position" do
    position = type_vector2(x: 3.0, y: 4.0)

    Window.set_position(
      type_vector2(position, :x) |> trunc(),
      type_vector2(position, :y) |> trunc()
    )

    wait_fn(fn -> similar?(position, Window.get_position()) end)

    assert similar?(position, Window.get_position())

    position_resource = Window.get_position(:resource)
    assert similar?(position, Resource.content!(position_resource))
    Resource.free_async!(position_resource)
  end

  test "size" do
    Window.set_state(enum_config_flag(:window_resizable))

    width = 500
    height = 300

    assert :ok = Window.set_min_size(200, 100)
    assert :ok = Window.set_max_size(600, 400)
    assert :ok = Window.set_size(width, height)

    wait_fn(fn ->
      Window.get_screen_width() == width and Window.get_screen_height() == height
    end)

    assert ^width = Window.get_screen_width()
    assert ^height = Window.get_screen_height()

    scale_dpi = Window.get_scale_dpi()

    render_width = trunc(type_vector2(scale_dpi, :x) * 800)
    render_height = trunc(type_vector2(scale_dpi, :y) * 600)

    assert ^render_width = Window.get_render_width()
    assert ^render_height = Window.get_render_height()
  end

  test "opacity" do
    assert :ok = Window.set_opacity(0.5)
  end

  test "clipboard" do
    text = "foo bar"
    assert :ok = Window.set_clipboard_text(text)
    assert ^text = Window.get_clipboard_text()

    image = Window.get_clipboard_image()
    assert is_image(image)

    image_resource = Window.get_clipboard_image(:resource)
    assert is_image(Resource.content!(image_resource))
    Resource.free_async!(image_resource)
  end

  test "event waiting" do
    assert :ok = Window.enable_event_waiting()
    assert :ok = Window.disable_event_waiting()
  end
end
