defmodule KvWeb.KeyValueController do
  use KvWeb, :controller

  alias Kv.KeyValueStore
  alias Kv.KeyValue

  action_fallback KvWeb.FallbackController

  def index(conn, _params) do
    key_values = KeyValueStore.list_key_values()
    render(conn, :index, key_values: key_values)
  end

  def create(conn, %{"key" => key, "value" => value}) do
    case KeyValueStore.create_key_value(%{key: key, value: value}) do
      {:ok, key_value} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/api/keys/#{key_value.key}")
        |> render(:show, key_value: key_value)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(json: KvWeb.ChangesetJSON)
        |> render(:error, changeset: changeset)
    end
  end

  def show(conn, %{"key" => key}) do
    key_value = KeyValueStore.get_key_value!(key)
    render(conn, :show, key_value: key_value)
  end

  def update(conn, %{"key" => key, "value" => value}) do
    key_value = KeyValueStore.get_key_value!(key)

    case KeyValueStore.update_key_value(key_value, %{value: value}) do
      {:ok, key_value} ->
        render(conn, :show, key_value: key_value)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(json: KvWeb.ChangesetJSON)
        |> render(:error, changeset: changeset)
    end
  end

  def delete(conn, %{"key" => key}) do
    key_value = KeyValueStore.get_key_value!(key)

    with {:ok, _} <- KeyValueStore.delete_key_value(key_value) do
      send_resp(conn, :no_content, "")
    end
  end
end