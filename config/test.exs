use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :equiplent, Equiplent.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :equiplent, Equiplent.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "equiplent_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Start Hound for PhantomJs
config :hound, driver: "phantomjs"
