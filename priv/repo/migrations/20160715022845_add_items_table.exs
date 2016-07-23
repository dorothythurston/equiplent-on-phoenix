defmodule Equiplent.Repo.Migrations.AddItemsTable do
  use Ecto.Migration
  def change do
    create table(:items) do
      add :name, :string, null: false
      add :user_id, references(:users), null: false

      timestamps
    end

    create index(:items, [:user_id])
  end
end
