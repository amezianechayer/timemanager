# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :api_time_manager,
  ecto_repos: [ApiTimeManager.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :api_time_manager, ApiTimeManagerWeb.Endpoint,
  url: [host: "localhost"],
  http: [port: 4000, ip: {0, 0, 0, 0}],  # Ajout de l'adresse IP 0.0.0.0
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: ApiTimeManagerWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ApiTimeManager.PubSub,
  live_view: [signing_salt: "/D72y2oA"]
  # Add this line




# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :api_time_manager, ApiTimeManager.Mailer, adapter: Swoosh.Adapters.Local

config :api_time_manager, ApiTimeManager.Guardian,
  issuer: "api_time_manager",
  secret_key: "+1nY+ozAPV2NHonBit2nwciVsHJvfCG0cZyGt6t8ubYYXSkbMW3c1wg5qWAB/EGN"


# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
