defmodule Equiplent.UserController do
  use Equiplent.Web, :controller

  alias Equiplent.User
  import Equiplent.Gettext

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, :new, changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, gettext("Successfully signed up!"))
        |> put_session(:current_user_id, user.id)
        |> redirect(to: dashboard_path(conn, :show))
      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
