defmodule Equiplent.ReservationTest do
  use Equiplent.ModelCase
  import Equiplent.Factory

  alias Equiplent.Reservation

  test "changeset with valid attributes" do
    user = insert(:user)
    item = insert(:item)
    valid_attrs = %{begins_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010},
                    ends_at: %{day: 18, hour: 14, min: 0, month: 4, sec: 0, year: 2010},
                    status: "Pending",
                    user_id: user.id,
                    item_id: item.id
                  }
    changeset = Reservation.changeset(%Reservation{}, valid_attrs)
    assert changeset.valid?
  end

  test "changeset with non existent user is invalid" do
    non_existant_user = %{user_id: 1}
    item = insert(:item)
    attrs = %{begins_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010},
              ends_at: %{day: 18, hour: 14, min: 0, month: 4, sec: 0, year: 2010},
              status: "Pending",
              item_id: item.id,
            }
    attrs = Map.merge(attrs, non_existant_user)
    changeset = Reservation.changeset(%Reservation{}, attrs)
    assert {:error, changeset} = Equiplent.Repo.insert(changeset)
    assert changeset.errors[:user_id] == {gettext("does not exist"), []}
  end

  test "changeset with non existent item is invalid" do
    non_existant_item = %{item_id: 1}
    user = insert(:user)
    attrs = %{begins_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010},
              ends_at: %{day: 18, hour: 14, min: 0, month: 4, sec: 0, year: 2010},
              status: "Pending",
              user_id: user.id
            }
    attrs = Map.merge(attrs, non_existant_item)
    changeset = Reservation.changeset(%Reservation{}, attrs)
    assert {:error, changeset} = Equiplent.Repo.insert(changeset)
    assert changeset.errors[:item_id] == {gettext("does not exist"), []}
  end

  test "changeset with non existent status is invalid" do
    attrs = %{begins_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010},
              ends_at: %{day: 18, hour: 14, min: 0, month: 4, sec: 0, year: 2010},
              item_id: insert(:item).id,
              user_id: insert(:user).id
            }
    attrs = Map.merge(attrs, %{status: "bats"})
    changeset = Reservation.changeset(%Reservation{}, attrs)
    assert {:error, changeset} = Equiplent.Repo.insert(changeset)
    assert changeset.errors[:status] == {gettext("Invalid status"), []}
  end

  test "reservation begins_at must be before ends_at" do
    attrs = %{begins_at: %{day: 19, hour: 14, min: 0, month: 4, sec: 0, year: 2010},
              ends_at: %{day: 18, hour: 14, min: 0, month: 4, sec: 0, year: 2010},
              item_id: insert(:item).id,
              user_id: insert(:user).id,
              status: "Pending"
            }
    changeset = Reservation.changeset(%Reservation{}, attrs)
    assert {:error, changeset} = Equiplent.Repo.insert(changeset)
    assert changeset.errors[:begins_at] == {gettext("Must be before reservation end date"), []}
  end
end
