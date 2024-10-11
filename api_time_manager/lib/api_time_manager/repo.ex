defmodule ApiTimeManager.Repo do
  use Ecto.Repo,
    otp_app: :api_time_manager,
    adapter: Ecto.Adapters.Postgres
end
