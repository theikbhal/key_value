ExUnit.start()

# Configure Ecto for testing
Application.put_env(:kv, :sql_sandbox, true)

# Start the Ecto repository
Ecto.Adapters.SQL.Sandbox.mode(Kv.Repo, :manual)
