defmodule KvWeb.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ConnTest
      import KvWeb.ConnCase
      import KvWeb.Router.Helpers
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Kv.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Kv.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
