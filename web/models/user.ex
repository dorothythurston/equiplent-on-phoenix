defmodule Equiplent.User do
  use Equiplent.Web, :model

  schema "users" do
    field :email, :string
    field :password_digest, :string

    timestamps
  end

  @required_fields ~w(email password_digest)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:email, name: :users_email_index)
    |> validate_format(:email, ~r/(\w+)@([\w.]+)/)
  end
end
