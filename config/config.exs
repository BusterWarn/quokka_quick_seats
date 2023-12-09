# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :phoenix,
       :template_engines,
       heex: Phoenix.LiveView.Engine

config :quokka_quick_seats,
  ecto_repos: [QuokkaQuickSeats.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :quokka_quick_seats, QuokkaQuickSeatsWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: QuokkaQuickSeatsWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: QuokkaQuickSeats.PubSub,
  live_view: [signing_salt: "2js8eKSE"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
