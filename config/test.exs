import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
# config :kv, Kv.Repo,
#   database: Path.expand("../kv_test.db", __DIR__),
#   pool_size: 5,
#   pool: Ecto.Adapters.SQL.Sandbox

config :kv, Kv.Repo,
  database: "test_db.sqlite3",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :kv, KvWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "LYsZTGSNUXQLcKnjs/khp+Bm0tJSKWlk2lrWcmp+/1Tyz9HULenfp6/21Alqh65Z",
  server: false

# In test we don't send emails
config :kv, Kv.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
