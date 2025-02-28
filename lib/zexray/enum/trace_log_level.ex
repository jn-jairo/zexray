defmodule Zexray.Enum.TraceLogLevel do
  @moduledoc """
  Trace log level

  NOTE: Organized by priority level

  ## Values

  | id | name     | description                                                                         |
  | -- | -------- | ----------------------------------------------------------------------------------- |
  |  0 | :all     | Display all logs                                                                    |
  |  1 | :trace   | Trace logging, intended for internal use only                                       |
  |  2 | :debug   | Debug logging, used for internal debugging, it should be disabled on release builds |
  |  3 | :info    | Info logging, used for program execution info                                       |
  |  4 | :warning | Warning logging, used on recoverable failures                                       |
  |  5 | :error   | Error logging, used on unrecoverable failures                                       |
  |  6 | :fatal   | Fatal logging, used to abort program: exit(EXIT_FAILURE)                            |
  |  7 | :none    | Disable logging                                                                     |
  """

  use Zexray.Enum.EnumBase,
    prefix: "trace_log_level",
    values: %{
      all: 0,
      trace: 1,
      debug: 2,
      info: 3,
      warning: 4,
      error: 5,
      fatal: 6,
      none: 7
    }
end
