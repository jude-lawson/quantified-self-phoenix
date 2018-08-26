# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :quantified_self_phoenix,
  ecto_repos: [QuantifiedSelfPhoenix.Repo]

# Configures the endpoint
config :quantified_self_phoenix, QuantifiedSelfPhoenixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4tGHSxSoP9iGmCGtyXoMTFfKJNzBfjp6DAINQ9hbYDT8clbcQNnxTZBs8j2QuhWt",
  render_errors: [view: QuantifiedSelfPhoenixWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: QuantifiedSelfPhoenix.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
