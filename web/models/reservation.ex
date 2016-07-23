defmodule Equiplent.Reservation do
  use Equiplent.Web, :model
  import Equiplent.Gettext

  schema "reservations" do
    field :begins_at, Ecto.DateTime
    field :ends_at, Ecto.DateTime
    field :status, :string
    belongs_to :user, Equiplent.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:begins_at, :ends_at, :status])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:item_id)
    |> validate_required([:begins_at, :ends_at], message: gettext("Required Value"))
    |> validate_inclusion(:status, ["requested", "approved", "denied"])
  end
end
