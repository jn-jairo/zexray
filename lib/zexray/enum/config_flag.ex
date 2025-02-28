defmodule Zexray.Enum.ConfigFlag do
  @moduledoc """
  System/Window config flags

  NOTE: Every bit registers one state (use it with bit masks)

  By default all flags are set to 0

  ## Values

  | id         | name                      | description                                                                   |
  | ---------- | ------------------------- | ----------------------------------------------------------------------------- |
  | 0x00000040 | :vsync_hint               | Set to try enabling V-Sync on GPU                                             |
  | 0x00000002 | :fullscreen_mode          | Set to run program in fullscreen                                              |
  | 0x00000004 | :window_resizable         | Set to allow resizable window                                                 |
  | 0x00000008 | :window_undecorated       | Set to disable window decoration (frame and buttons)                          |
  | 0x00000080 | :window_hidden            | Set to hide window                                                            |
  | 0x00000200 | :window_minimized         | Set to minimize window (iconify)                                              |
  | 0x00000400 | :window_maximized         | Set to maximize window (expanded to monitor)                                  |
  | 0x00000800 | :window_unfocused         | Set to window non focused                                                     |
  | 0x00001000 | :window_topmost           | Set to window always on top                                                   |
  | 0x00000100 | :window_always_run        | Set to allow windows running while minimized                                  |
  | 0x00000010 | :window_transparent       | Set to allow transparent framebuffer                                          |
  | 0x00002000 | :window_highdpi           | Set to support HighDPI                                                        |
  | 0x00004000 | :window_mouse_passthrough | Set to support mouse passthrough, only supported when FLAG_WINDOW_UNDECORATED |
  | 0x00008000 | :borderless_windowed_mode | Set to run program in borderless windowed mode                                |
  | 0x00000020 | :msaa_4x_hint             | Set to try enabling MSAA 4X                                                   |
  | 0x00010000 | :interlaced_hint          | Set to try enabling interlaced video format (for V3D)                         |
  """

  use Zexray.Enum.EnumBase,
    prefix: "config_flag",
    values: %{
      vsync_hint: 0x00000040,
      fullscreen_mode: 0x00000002,
      window_resizable: 0x00000004,
      window_undecorated: 0x00000008,
      window_hidden: 0x00000080,
      window_minimized: 0x00000200,
      window_maximized: 0x00000400,
      window_unfocused: 0x00000800,
      window_topmost: 0x00001000,
      window_always_run: 0x00000100,
      window_transparent: 0x00000010,
      window_highdpi: 0x00002000,
      window_mouse_passthrough: 0x00004000,
      borderless_windowed_mode: 0x00008000,
      msaa_4x_hint: 0x00000020,
      interlaced_hint: 0x00010000
    }
end
