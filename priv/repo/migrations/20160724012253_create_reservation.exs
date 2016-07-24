defmodule Equiplent.Repo.Migrations.CreateReservation do
  use Ecto.Migration

  def change do
    create table(:reservations) do
      add :begins_at, :datetime, null: :false
      add :ends_at, :datetime, null: :false
      add :item_id, references(:items, on_delete: :nothing), null: :false
      add :user_id, references(:users, on_delete: :nothing), null: :false
      add :reservation_request_id, references(:reservation_requests, on_delete: :nothing), null: :false

      timestamps()
    end

    create unique_index(:reservations, [:reservation_request_id])
    create index(:reservations, [:user_id])
    create index(:reservations, [:item_id])
  end
end
