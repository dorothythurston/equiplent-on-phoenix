defmodule Equiplent.UserTest do
  use Equiplent.ModelCase

  alias Equiplent.User
  import Equiplent.Factory

  @valid_attrs %{email: "some@email.com", password: "some password", password_confirmation: "some password"}
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
    assert changeset.errors[:email] == { gettext("email has already been taken"), []}
  end

  test "changeset is invalid if email does not match email format" do
    changeset = User.changeset(%User{}, %{email: "notanemail"})

    assert {:error, changeset} = Equiplent.Repo.insert(changeset)
    assert changeset.errors[:email] == { gettext("email has invalid format"), []}
  end

  test "changeset is invalid if password does not match password_confirmation" do
    invalid_attrs = Map.merge(@valid_attrs, %{password_confirmation: "not that password"})
    changeset = User.changeset(%User{}, invalid_attrs)

    assert {:error, changeset} = Equiplent.Repo.insert(changeset)
    assert changeset.errors[:password_confirmation] == { gettext("passwords do not match"), []}
  end
end
