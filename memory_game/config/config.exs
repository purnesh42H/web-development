# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :memory_game, MemoryGameWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "V0QHFFiu6bshptT6bNsUZ5fSZf0uI2/Y2wEjidUDcfdVXj7WPXeySch2Iy6Ao7gU",
  render_errors: [view: MemoryGameWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MemoryGame.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
