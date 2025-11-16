defmodule Kv.KeyValue do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:key, :string, autogenerate: false}
  
  schema "key_values" do
    field :value, :string
    timestamps()
  end

  def changeset(key_value, attrs) do
    key_value
    |> cast(attrs, [:key, :value])
    |> validate_required([:key, :value])
  end
end