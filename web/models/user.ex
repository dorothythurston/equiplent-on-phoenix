defmodule Equiplent.User do
  use Equiplent.Web, :model
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]
  alias Equiplent.Password
  import Equiplent.Gettext

  schema "users" do
    field :email, :string
    field :password_digest, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    has_many :items, Equiplent.Item

    timestamps
  end

  @required_fields ~w(email password password_confirmation)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:email, name: :users_email_index, message: gettext("email has already been taken"))
    |> validate_format(:email, ~r/(\w+)@([\w.]+)/, message: gettext("email has invalid format"))
    |> validate_length(:password, min: 1, message: gettext("password must be longer"))
    |> validate_length(:password_confirmation, min: 1, message: gettext("password must be longer"))
    |> validate_confirmation(:password, message: gettext("passwords do not match"))
    |> hash_password
  end

  defp hash_password(changeset) do
    Password.encrypt(changeset)
  end
end
