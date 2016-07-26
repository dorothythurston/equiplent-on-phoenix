defmodule Equiplent.Reservation do
  use Equiplent.Web, :model

  import Equiplent.Gettext

  schema "reservations" do
    field :begins_at, Ecto.DateTime
    field :ends_at, Ecto.DateTime
    field :status, :string
    belongs_to :user, Equiplent.User
    belongs_to :item, Equiplent.Item

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:begins_at, :ends_at, :status, :item_id, :user_id])
    |> foreign_key_constraint(:item_id)
    |> foreign_key_constraint(:user_id)
    |> validate_required([:begins_at, :ends_at, :item_id, :user_id])
    |> validate_dates
    |> validate_inclusion(:status, ["Pending", "Approved", "Denied"], message: gettext("Invalid status"))
  end

  defp validate_dates(changeset) do
    begins_at = get_change(changeset, :begins_at)
    ends_at = get_change(changeset, :ends_at)
    if begins_at && ends_at do
      if dates_invalid?(begins_at, ends_at) do
        changeset = add_error(changeset, :begins_at, gettext("Must be before reservation end date"))
      end
    end
    changeset
  end

  defp dates_invalid?(begins_at, ends_at) do
    Ecto.DateTime.compare(begins_at, ends_at) != :lt
  end
end
