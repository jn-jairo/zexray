import Config

if config_env() == :prod do
  config :zexray, :zig_build_optimize, "ReleaseSafe"
else
  config :zexray, :zig_build_optimize, "Debug"
end

config :zexray, :zig_build_target, "native"

config :zexray, :internal_docs, System.get_env("ZEXRAY_INTERNAL_DOCS") == "true"

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
