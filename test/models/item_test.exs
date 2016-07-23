defmodule Equiplent.ItemTest do
  use Equiplent.ModelCase

  alias Equiplent.Item
  import Equiplent.Factory

  test "changeset with valid attributes" do
    user = insert(:user)
    valid_attrs = %{ name: "some content", user_id: user.id }
    changeset = Item.changeset(%Item{}, valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Item.changeset(%Item{}, %{})
    refute changeset.valid?
  end

  test "changeset with non existent user is invalid" do
    non_existant_user = %{user_id: 1}
    attrs = Map.merge(%{name: "some content"}, non_existant_user)
    changeset = Item.changeset(%Item{}, attrs)
    assert {:error, changeset} = Equiplent.Repo.insert(changeset)
    assert changeset.errors[:user_id] == {"does not exist", []}
  end
end
