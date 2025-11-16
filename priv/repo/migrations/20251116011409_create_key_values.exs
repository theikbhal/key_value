defmodule Kv.Repo.Migrations.CreateKeyValues do
  use Ecto.Migration

  def change do
    create table(:key_values, primary_key: false) do
        add :key, :string, primary_key: true
        add :value, :text

        timestamps()
    end

    create unique_index(:key_values, [:key])
  end
end
