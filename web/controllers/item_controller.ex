defmodule Equiplent.ItemController do
  use Equiplent.Web, :controller

  alias Equiplent.Item
  import Equiplent.Gettext

  def new(conn, _params) do
    changeset = Item.changeset(%Item{})
    render conn, :new, changeset: changeset
  end

  def create(conn, %{"item" => item_params}) do
    new_item = build_assoc(conn.assigns.current_user, :items)
    changeset = Item.changeset(new_item, item_params)

    case Repo.insert(changeset) do
      {:ok, item} ->
        conn
        |> put_flash(:info, gettext("Successfully saved"))
        |> redirect(to: item_path(conn, :show, item))
      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    item = Repo.get!(Item, id)
    render conn, :show, item: item
  end
end
