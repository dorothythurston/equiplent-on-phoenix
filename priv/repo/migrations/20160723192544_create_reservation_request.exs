defmodule Equiplent.Repo.Migrations.CreateReservationRequest do
  use Ecto.Migration

  def change do
    create table(:reservation_requests) do
      add :requested_start_date, :datetime, null: :false
      add :requested_end_date, :datetime, null: :false
      add :status, :string, null: false, default: "pending approval"
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :item_id, references(:items, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:reservation_requests, [:user_id])
    create index(:reservation_requests, [:item_id])
  end
end
