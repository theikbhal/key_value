defmodule Kv.Repo do
  use Ecto.Repo,
    otp_app: :kv,
    adapter: Ecto.Adapters.SQLite3
end
