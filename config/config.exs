import Config

if config_env() == :prod do
  config :zexray, :optimize, "ReleaseSafe"
else
  config :zexray, :optimize, "Debug"
end

config :zexray, :target, "native"

config :zexray, :internal_docs, System.get_env("ZEXRAY_INTERNAL_DOCS") == "true"

config :zexray, :platform, "glfw"
config :zexray, :linux_display_backend, "Both"
config :zexray, :opengl_version, "auto"

case config_env() do
  :test ->
    config :zexray, :trace_log_level, :none
    config :zexray, :trace_log, false
    config :zexray, :trace_log_debug, false

  :dev ->
    config :zexray, :trace_log_level, :all
    config :zexray, :trace_log, true
    config :zexray, :trace_log_debug, true

  _ ->
    config :zexray, :trace_log_level, :info
    config :zexray, :trace_log, true
    config :zexray, :trace_log_debug, false
end
