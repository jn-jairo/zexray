# Zexray

A simple and easy-to-use graphic library.

[**Z**ig](https://ziglang.org) +
[**E**li**X**ir](https://elixir-lang.org) +
[**RAY**lib](https://raylib.com)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `zexray` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:zexray, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/zexray>.

## Configuration

```elixir
# config/config.exs

import Config

#########
#  Zig  #
#########

# Prioritize performance, safety, or binary size
# Debug | ReleaseSafe | ReleaseFast | ReleaseSmall
# (default: ReleaseSafe)
config :zexray, :optimize, "ReleaseSafe"

# The CPU architecture, OS, and ABI to build for (default: native)
config :zexray, :target, "native"

############
#  Raylib  #
############

# Platform backend for desktop target
# glfw | rgfw | sdl | drm
# (default: glfw)
config :zexray, :platform, "glfw"

# Linux display backend
# X11 | Wayland | Both
# (default: Both)
config :zexray, :linux_display_backend, "Both"

# OpenGL version
# auto | gl_1_1 | gl_2_1 | gl_3_3 | gl_4_3 | gles_2 | gles_3
# (default: auto)
config :zexray, :opengl_version, "auto"

# Allow automatic screen capture of current screen pressing F12 (default: false)
config :zexray, :screen_capture, false

# Allow automatic gif recording of current screen pressing CTRL+F12 (default: false)
config :zexray, :gif_recording, false

# Trace log level
# :all | :trace | :debug | :info | :warning | :error | :fatal | :none
# (default: :info)
config :zexray, :trace_log_level, :info

# Enable trace log (default: true)
config :zexray, :trace_log, true

# Enable trace log debug (default: false)
config :zexray, :trace_log_debug, false
```

## Livebook

The examples can be run in livebook, but be aware that livebook reduces performance.

For best performance, export the livebook to a script in the `IEx session` tab of the livebook export,
and run as `elixir path/to/notebook.exs` or `iex --dot-iex path/to/notebook.exs`.
