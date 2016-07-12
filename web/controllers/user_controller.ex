defmodule Equiplent.UserController do
  use Equiplent.Web, :controller

  alias Equiplent.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, :new, changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Successfully signed up!")
        |> redirect(to: dashboard_path(conn, :show))
      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
