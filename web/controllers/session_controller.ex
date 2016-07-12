defmodule Equiplent.SessionController do
  use Equiplent.Web, :controller
  alias Equiplent.User
  alias Equiplent.Password

  plug :scrub_params, "user" when action in [:create]

  def new(conn, _params) do
    render conn, changeset: User.changeset(%User{})
  end

  def create(conn, %{"user" => user_params}) do
    Repo.get_by(User, email: user_params["email"])
      |> sign_in(user_params["password"], conn)
  end

  defp sign_in(user, password, conn) when is_nil(user) do
    conn
      |> put_flash(:error, 'Could not find a user with that username.')
      |> render("new.html", changeset: User.changeset(%User{}))
  end

  defp sign_in(user, password, conn) when is_map(user) do
    if Password.authenticate(password, user.password_digest) do
      conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, 'Welcome!')
        |> redirect(to: dashboard_path(conn, :show))
    else
      conn
        |> put_flash(:error, 'Username or password are incorrect.')
        |> render("new.html", changeset: User.changeset(%User{}))
    end
  end
end
