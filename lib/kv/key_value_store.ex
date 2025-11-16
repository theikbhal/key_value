defmodule Kv.KeyValueStore do
  @moduledoc """
  Context module for managing key-value pairs.
  The key is provided by the user and used as the primary key.
  """

  import Ecto.Query, warn: false
  alias Kv.Repo
  alias Kv.KeyValue

  @doc """
  Returns the list of all key-value pairs.
  """
  def list_key_values do
    Repo.all(KeyValue)
  end

  @doc """
  Gets a single key-value pair by key.

  Raises `Ecto.NoResultsError` if the key doesn't exist.
  """
  def get_key_value!(key), do: Repo.get!(KeyValue, key)

  @doc """
  Creates a key-value pair.

  ## Examples

      iex> create_key_value(%{key: "name", value: "John"})
      {:ok, %KeyValue{}}

      iex> create_key_value(%{key: "name", value: ""})
      {:error, %Ecto.Changeset{}}

  """
  def create_key_value(attrs \\ %{}) do
    %KeyValue{}
    |> KeyValue.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a key-value pair.

  ## Examples

      iex> update_key_value(key_value, %{value: "new value"})
      {:ok, %KeyValue{}}

      iex> update_key_value(key_value, %{value: ""})
      {:error, %Ecto.Changeset{}}

  """
  def update_key_value(%KeyValue{} = key_value, attrs) do
    key_value
    |> KeyValue.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a key-value pair.

  ## Examples

      iex> delete_key_value(key_value)
      {:ok, %KeyValue{}}

      iex> delete_key_value(key_value)
      {:error, %Ecto.Changeset{}}

  """
  def delete_key_value(%KeyValue{} = key_value) do
    Repo.delete(key_value)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking key-value changes.

  ## Examples

      iex> change_key_value(key_value)
      %Ecto.Changeset{data: %KeyValue{}}

  """
  def change_key_value(%KeyValue{} = key_value, attrs \\ %{}) do
    KeyValue.changeset(key_value, attrs)
  end
end