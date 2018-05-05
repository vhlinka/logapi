use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :logapi, LogApiWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :logapi, LogApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("ELIXIR_DB_USERNAME"),
  password: System.get_env("ELIXIR_DB_PASSWORD"),
  database: "pkglog_dev2",
  hostname: System.get_env("ELIXIR_DB_HOSTNAME"),
  pool: Ecto.Adapters.SQL.Sandbox
