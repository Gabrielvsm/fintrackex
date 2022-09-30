import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :fintrackex, Fintrackex.Repo,
  database: Path.expand("../fintrackex_test.db", Path.dirname(__ENV__.file)),
  pool_size: 5,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fintrackex, FintrackexWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "ncPrw94u/Jdm4R7S9GS0ruAAPNq5gG+wFfPSWnwPlpzMsK+13QJ0N2tQ00hC07ce",
  server: false

# In test we don't send emails.
config :fintrackex, Fintrackex.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
