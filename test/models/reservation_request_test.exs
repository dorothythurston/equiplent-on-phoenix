defmodule Equiplent.ReservationRequestTest do
  use Equiplent.ModelCase
  import Equiplent.Factory

  alias Equiplent.ReservationRequest

  test "changeset with valid attributes" do
    user = insert(:user)
    item = insert(:item)
    valid_attrs = %{requested_start_date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010},
                    requested_end_date: %{day: 18, hour: 14, min: 0, month: 4, sec: 0, year: 2010},
                    status: "pending approval",
                    user_id: user.id,
                    item_id: item.id
                  }
    changeset = ReservationRequest.changeset(%ReservationRequest{}, valid_attrs)
    assert changeset.valid?
  end

  test "changeset with non existent user is invalid" do
    non_existant_user = %{user_id: 1}
    item = insert(:item)
    attrs = %{requested_start_date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010},
              requested_end_date: %{day: 18, hour: 14, min: 0, month: 4, sec: 0, year: 2010},
              status: "pending approval",
              item_id: item.id,
            }
    attrs = Map.merge(attrs, non_existant_user)
    changeset = ReservationRequest.changeset(%ReservationRequest{}, attrs)
    assert {:error, changeset} = Equiplent.Repo.insert(changeset)
    assert changeset.errors[:user_id] == {"does not exist", []}
  end

  test "changeset with non existent item is invalid" do
    non_existant_item = %{item_id: 1}
    user = insert(:user)
    attrs = %{requested_start_date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010},
              requested_end_date: %{day: 18, hour: 14, min: 0, month: 4, sec: 0, year: 2010},
              status: "pending approval",
              user_id: user.id
            }
    attrs = Map.merge(attrs, non_existant_item)
    changeset = ReservationRequest.changeset(%ReservationRequest{}, attrs)
    assert {:error, changeset} = Equiplent.Repo.insert(changeset)
    assert changeset.errors[:item_id] == {"does not exist", []}
  end

  test "changeset with non existent status is invalid" do
    attrs = %{requested_start_date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010},
              requested_end_date: %{day: 18, hour: 14, min: 0, month: 4, sec: 0, year: 2010},
              item_id: insert(:item).id,
              user_id: insert(:user).id
            }
    attrs = Map.merge(attrs, %{status: "bats"})
    changeset = ReservationRequest.changeset(%ReservationRequest{}, attrs)
    assert {:error, changeset} = Equiplent.Repo.insert(changeset)
    assert changeset.errors[:status] == {"is invalid", []}
  end
end
