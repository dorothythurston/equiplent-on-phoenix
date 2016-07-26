defmodule Equiplent.ReservationController do
  use Equiplent.Web, :controller

  alias Equiplent.Reservation
  alias Equiplent.Item
  import Equiplent.Gettext

  def new(conn, %{"item_id" => item_id}) do
    item = Repo.get!(Item, item_id)
    changeset = Reservation.changeset(%Reservation{})
    render conn, :new, changeset: changeset, item: item
  end

  def create(conn, %{"reservation" => reservation_params, "item_id" => item_id}) do
    reservation_params = Map.put(reservation_params, "item_id", item_id)
    new_reservation = build_assoc(conn.assigns.current_user, :reservations)
    changeset = Reservation.changeset(new_reservation, reservation_params)

    case Repo.insert(changeset) do
      {:ok, reservation} ->
        conn
        |> put_flash(:info, gettext("Successfully submitted reservation request"))
        |> redirect(to: reservation_path(conn, :show, reservation))
      {:error, changeset} ->
        item = Repo.get!(Item, item_id)
        render(conn, :new, changeset: changeset, item: item)
    end
  end

  def show(conn, %{"id" => id}) do
    reservation = Repo.get!(Reservation, id)
    render conn, :show, reservation: reservation
  end
end
