defmodule Equiplent.Repo.Migrations.CreateReservation do
  use Ecto.Migration

  def change do
    create table(:reservations) do
      add :begins_at, :datetime, null: :false
      add :ends_at, :datetime, null: :false
      add :status, :string, null: :false, default: "requested"
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:reservations, [:user_id])
  end
end
