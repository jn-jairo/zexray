defmodule Zexray.MixProject do
  use Mix.Project

  @source_url "https://github.com/jn-jairo/zexray"
  @version "0.1.0"

  def project do
    [
      app: :zexray,
      version: @version,
      elixir: "~> 1.18",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      compilers: [:zig_build] ++ Mix.compilers(),
      aliases: [
        "compile.zig_build": &zig_build/1
      ],

      # Dialyzer
      dialyzer: dialyzer(),

      # Docs
      name: "Zexray",
      source_url: @source_url,
      docs: &docs/0,

      # Coverage
      test_coverage: test_coverage()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(:dev), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.36.1", only: :dev, runtime: false},
      {:ex_unit_parameterize, "~> 0.1.0-alpha.4", only: :test, runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:eflambe, "~> 0.3.1", only: :dev, runtime: false},
      {:benchee, "~> 1.3", only: :dev, runtime: false}
    ]
  end

  defp dialyzer do
    [
      plt_add_apps: [:mix, :ex_unit]
    ]
  end

  defp zig_build(_args) do
    zig = System.find_executable("zig") || Mix.raise("zig not found in the path")

    prefix = Path.join([Mix.Project.app_path(), "priv"])

    erts_include_path =
      Path.join([
        "#{:code.root_dir()}",
        "erts-#{:erlang.system_info(:version)}",
        "include"
      ])

    optimize = Application.get_env(:zexray, :optimize, "ReleaseSafe")
    target = Application.get_env(:zexray, :target, "native")

    platform = Application.get_env(:zexray, :platform, "glfw")
    linux_display_backend = Application.get_env(:zexray, :linux_display_backend, "Both")
    opengl_version = Application.get_env(:zexray, :opengl_version, "auto")

    raylib_trace_log = Application.get_env(:zexray, :trace_log, true) |> Atom.to_string()

    raylib_trace_log_debug =
      Application.get_env(:zexray, :trace_log_debug, false) |> Atom.to_string()

    raylib_screen_capture =
      Application.get_env(:zexray, :screen_capture, false) |> Atom.to_string()

    raylib_gif_recording =
      Application.get_env(:zexray, :gif_recording, false) |> Atom.to_string()

    args = [
      "build",
      "-Doptimize=#{optimize}",
      "-Dtarget=#{target}",
      "-Dplatform=#{platform}",
      "-Dlinux_display_backend=#{linux_display_backend}",
      "-Dopengl_version=#{opengl_version}",
      "-Derts_include_path=#{erts_include_path}",
      "-Draylib_trace_log=#{raylib_trace_log}",
      "-Draylib_trace_log_debug=#{raylib_trace_log_debug}",
      "-Draylib_screen_capture=#{raylib_screen_capture}",
      "-Draylib_gif_recording=#{raylib_gif_recording}",
      "--prefix",
      "#{prefix}"
    ]

    env = %{}

    cmd!(zig, args, env)

    {:ok, []}
  end

  defp cmd!(exec, args, env) do
    opts = [
      into: IO.stream(:stdio, :line),
      stderr_to_stdout: true,
      env: env
    ]

    case System.cmd(exec, args, opts) do
      {_, 0} -> :ok
      {_, status} -> Mix.raise("zig failed with status #{status}")
    end
  end

  defp test_coverage do
    [
      ignore_modules: [
        Zexray.Enum.EnumBase,
        Zexray.Guard,
        Zexray.NIF,
        Zexray.OutOfMemoryError,
        Zexray.Type.Camera3DBase,
        Zexray.Type.RenderTextureBase,
        Zexray.Type.TextureBase,
        Zexray.Type.TypeBase,
        Zexray.Type.Vector4Base
      ]
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: [
        "README.md",
        # Examples Core
        "examples/core/2d_camera.livemd": [filename: "example_core_2d_camera"],
        "examples/core/2d_camera_mouse_zoom.livemd": [
          filename: "example_core_2d_camera_mouse_zoom"
        ],
        # Examples Audio
        "examples/audio/sound_loading.livemd": [filename: "example_audio_sound_loading"],
        "examples/audio/music_stream.livemd": [filename: "example_audio_music_stream"],
        "examples/audio/module_playing.livemd": [filename: "example_audio_module_playing"],
        "examples/audio/sound_multi.livemd": [filename: "example_audio_sound_multi"],
        "examples/audio/sound_positioning.livemd": [filename: "example_audio_sound_positioning"],
        "examples/audio/raw_stream.livemd": [filename: "example_audio_raw_stream"],
        "examples/audio/stream_effects.livemd": [filename: "example_audio_stream_effects"],
        # Examples Gui
        "examples/gui/controls_test_suite.livemd": [filename: "example_gui_controls_test_suite"],
        # Examples Shapes
        "examples/shapes/rectangle_advanced.livemd": [
          filename: "example_shapes_rectangle_advanced"
        ],
        # Examples Textures
        "examples/textures/sprite_anim.livemd": [filename: "example_textures_sprite_anim"],
        "examples/textures/sprite_button.livemd": [filename: "example_textures_sprite_button"],
        "examples/textures/sprite_explosion.livemd": [filename: "example_textures_sprite_explosion"],
        "examples/textures/bunnymark.livemd": [filename: "example_textures_bunnymark"]
      ],
      source_ref: "v#{@version}",
      source_url: @source_url,
      default_group_for_doc: fn metadata ->
        if group = metadata[:group] do
          kind =
            metadata[:kind]
            |> Atom.to_string()
            |> String.capitalize()

          group =
            if is_atom(group) do
              group
              |> Atom.to_string()
              |> String.split("_")
              |> Enum.map(&String.capitalize/1)
              |> Enum.join(" ")
            else
              group
            end

          "#{kind}: #{group}"
        end
      end,
      groups_for_extras: [
        "Examples: Core": ~r"examples/core",
        "Examples: Audio": ~r"examples/audio",
        "Examples: Gui": ~r"examples/gui",
        "Examples: Shapes": ~r"examples/shapes",
        "Examples: Textures": ~r"examples/textures"
      ],
      groups_for_modules: [
        Bindings: [
          Zexray.NIF
        ],
        Enums: ~r"Zexray\.Enum\.",
        Types: ~r"Zexray\.Type\.(?!.*Resource)",
        "Types Resource": ~r"Zexray\.Type\..*Resource"
      ],
      nest_modules_by_prefix: [
        Zexray.Enum,
        Zexray.Type
      ]
    ]
  end
end
