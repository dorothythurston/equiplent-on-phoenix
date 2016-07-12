defmodule Equiplent.UserTest do
  use Equiplent.ModelCase

  alias Equiplent.User
  import Equiplent.Factory

  @valid_attrs %{email: "some@email.com", password_digest: "some password"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset is invalid if email is used already (case sensitive)" do
    user = insert(:user)
    upcased_email = String.upcase(user.email)
    invalid_attrs = Map.merge(@valid_attrs, %{email: upcased_email})
    changeset = User.changeset(%User{}, invalid_attrs)

    assert {:error, changeset} = Equiplent.Repo.insert(changeset)
    assert changeset.errors[:email] == {"has already been taken", []}
  end

  test "changeset is invalid if email does not match email format" do
    changeset = User.changeset(%User{}, %{email: "notanemail"})

    assert {:error, changeset} = Equiplent.Repo.insert(changeset)
    assert changeset.errors[:email] == {"has invalid format", []}
  end
end
