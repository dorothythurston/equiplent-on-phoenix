defmodule Equiplent.Repo.Migrations.CreateReservation do
  use Ecto.Migration

  def up do
    execute "CREATE TYPE status AS ENUM('Pending','Approved','Denied');"

    create table(:reservations) do
      add :begins_at, :datetime, null: :false
      add :ends_at, :datetime, null: :false
      add :status, :status, null: :false, default: "Pending"
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :item_id, references(:items, on_delete: :nothing), null: false

      timestamps null: false
    end

    create index(:reservations, [:user_id])
    create index(:reservations, [:item_id])
  end

  def down do
    drop table(:reservations)
    execute "DROP TYPE status;"
  end
end
