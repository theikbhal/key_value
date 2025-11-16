defmodule KvWeb.KeyValueControllerTest do
  use ExUnit.Case, async: true
  use Phoenix.ConnTest
  import Plug.Conn
  import Phoenix.ConnTest

  @endpoint KvWeb.Endpoint
  alias Kv.{KeyValue, Repo}

  setup do
    # Start a transaction for each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)

    # Set up the connection
    conn =
      build_conn()
      |> put_req_header("accept", "application/json")

    {:ok, conn: conn}
  end

  describe "create key_value" do
    @create_attrs %{key: "test1", value: "value1"}

    test "creates key_value when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/keys", @create_attrs)
      assert %{"key" => "test1", "value" => "value1"} = json_response(conn, 201)["data"]
    end
  end

  describe "get key_value" do
    setup do
      key_value = %KeyValue{key: "test_key", value: "test_value"} |> Repo.insert!()
      {:ok, key_value: key_value}
    end

    test "shows key_value", %{conn: conn, key_value: key_value} do
      conn = get(conn, ~p"/api/keys/#{key_value.key}")
      assert %{"key" => "test_key", "value" => "test_value"} = json_response(conn, 200)["data"]
    end
  end
end
