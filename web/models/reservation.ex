defmodule Equiplent.Reservation do
  use Equiplent.Web, :model
  import Equiplent.Gettext

  schema "reservations" do
    field :begins_at, Ecto.DateTime
    field :ends_at, Ecto.DateTime
    belongs_to :item, Equiplent.Item
    belongs_to :user, Equiplent.User
    belongs_to :reservation_request, Equiplent.ReservationRequest

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:begins_at, :ends_at, :user_id, :item_id, :reservation_request_id])
    |> unique_constraint(:reservation_request_id, name: :reservations_reservation_request_id_index, message: gettext("Reservation already exists"))
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:item_id)
    |> foreign_key_constraint(:reservation_request_id)
    |> validate_required([:begins_at, :ends_at, :user_id, :item_id, :reservation_request_id], message: gettext("Required Value"))
  end
end
