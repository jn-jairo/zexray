Application.fetch_env!(:zexray, :trace_log_level)
|> Zexray.Util.set_trace_log_level()

ExUnit.start(
  exclude: [
    :window
  ]
)
