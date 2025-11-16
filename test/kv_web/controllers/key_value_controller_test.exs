defmodule KvWeb.KeyValueControllerTest do
  use KvWeb.ConnCase

  alias Kv.KeyValue
  alias Kv.Repo

  @create_attrs %{key: "test1", value: "value1"}
  @update_attrs %{value: "updated_value"}
  @invalid_attrs %{key: nil, value: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create key_value" do
    test "creates key_value when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/keys", @create_attrs)
      assert %{"key" => key} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/keys/#{key}")
      assert %{
               "key" => "test1",
               "value" => "value1"
             } = json_response(conn, 200)["data"]
    end

    test "returns error when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/keys", @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "get key_value" do
    setup [:create_key_value]

    test "shows key_value", %{conn: conn, key_value: key_value} do
      conn = get(conn, ~p"/api/keys/#{key_value.key}")
      assert %{
               "key" => key_value.key,
               "value" => key_value.value
             } = json_response(conn, 200)["data"]
    end

    test "returns 404 when key doesn't exist", %{conn: conn} do
      assert_error_sent 404, fn ->
        get(conn, ~p"/api/keys/non_existent_key")
      end
    end
  end

  describe "update key_value" do
    setup [:create_key_value]

    test "updates key_value when data is valid", %{conn: conn, key_value: key_value} do
      conn = put(conn, ~p"/api/keys/#{key_value.key}", @update_attrs)
      assert %{"value" => "updated_value"} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/keys/#{key_value.key}")
      assert %{"value" => "updated_value"} = json_response(conn, 200)["data"]
    end
  end

  describe "delete key_value" do
    setup [:create_key_value]

    test "deletes key_value", %{conn: conn, key_value: key_value} do
      conn = delete(conn, ~p"/api/keys/#{key_value.key}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/keys/#{key_value.key}")
      end
    end
  end

  defp create_key_value(_) do
    {:ok, key_value} =
      %KeyValue{key: "test_key", value: "test_value"}
      |> Repo.insert()
    %{key_value: key_value}
  end
end
