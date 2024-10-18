defmodule ApiTimeManagerWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :api_time_manager

  @session_options [
    store: :cookie,
    key: "_api_time_manager_key",
    signing_salt: "sqpCt5Uk",
    same_site: "Lax"
  ]

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  plug Plug.Static,
    at: "/",
    from: :api_time_manager,
    gzip: false,
    only: ApiTimeManagerWeb.static_paths()

  if code_reloading? do
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :api_time_manager
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug CORSPlug, origin: ["http://localhost:8080"]
  plug Plug.Session, @session_options

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug ApiTimeManagerWeb.Router
end
