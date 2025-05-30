Application.fetch_env!(:zexray, :trace_log_level)
|> Zexray.Enum.TraceLogLevel.value()
|> Zexray.TraceLog.set_level()

ExUnit.start(
  exclude: [
    :nif,
    :resource,
    :window
  ]
)
