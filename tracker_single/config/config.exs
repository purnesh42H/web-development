# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tracker_single,
  ecto_repos: [TrackerSingle.Repo]

# Configures the endpoint
config :tracker_single, TrackerSingleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1dH33AhM6mFEc8zcyNa+XcENbKLXeVmr4hW0zSoyKQU3Nv5sWTqpjlwXBLn4a/Zt",
  render_errors: [view: TrackerSingleWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TrackerSingle.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
