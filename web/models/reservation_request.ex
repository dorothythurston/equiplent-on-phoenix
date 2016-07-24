defmodule Equiplent.ReservationRequest do
  use Equiplent.Web, :model

  schema "reservation_requests" do
    field :requested_start_date, Ecto.DateTime
    field :requested_end_date, Ecto.DateTime
    field :status, :string
    belongs_to :user, Equiplent.User
    belongs_to :item, Equiplent.Item
    has_one :reservation, Equiplent.Reservation

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:requested_start_date, :requested_end_date, :status, :item_id, :user_id])
    |> foreign_key_constraint(:item_id)
    |> foreign_key_constraint(:user_id)
    |> validate_required([:requested_start_date, :requested_end_date])
    |> validate_inclusion(:status, ["pending approval", "approved", "denied"])
  end
end
