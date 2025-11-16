defmodule KvWeb.PageController do
  use KvWeb, :controller
  alias Kv.KeyValueStore

  def index(conn, _params) do
    key_values = KeyValueStore.list_key_values()
    render(conn, "index.html", key_values: key_values)
  end
end
