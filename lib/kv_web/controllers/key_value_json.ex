defmodule KvWeb.KeyValueJSON do
  @moduledoc false
  
  def index(%{key_values: key_values}) do
    %{data: Enum.map(key_values, &data/1)}
  end

  def show(%{key_value: key_value}) do
    %{data: data(key_value)}
  end

  defp data(%{key: key, value: value, inserted_at: inserted_at, updated_at: updated_at}) do
    %{
      key: key,
      value: value,
      inserted_at: inserted_at,
      updated_at: updated_at
    }
  end
end