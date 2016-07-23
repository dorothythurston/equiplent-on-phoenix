defmodule Equiplent.Item do
  use Equiplent.Web, :model
  import Equiplent.Gettext

  schema "items" do
    field :name, :string
    belongs_to :user, Equiplent.User

    timestamps
  end

  @required_fields ~w(name user_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> foreign_key_constraint(:user_id)
    |> validate_required([:name], message: gettext("Name is required"))
  end
end
