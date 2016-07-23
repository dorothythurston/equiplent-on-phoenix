defmodule Equiplent.ReservationRequestController do
  use Equiplent.Web, :controller

  alias Equiplent.ReservationRequest
  alias Equiplent.Item
  import Equiplent.Gettext

  def new(conn, %{"item_id" => item_id}) do
    item = Repo.get!(Item, item_id)
    changeset = ReservationRequest.changeset(%ReservationRequest{})
    render conn, :new, changeset: changeset, item: item
  end

  def create(conn, %{"reservation_request" => reservation_request_params, "item_id" => item_id}) do
    reservation_request_params = Map.put(reservation_request_params, "item_id", item_id)
    new_reservation_request = build_assoc(conn.assigns.current_user, :reservation_requests)
    changeset = ReservationRequest.changeset(new_reservation_request, reservation_request_params)

    case Repo.insert(changeset) do
      {:ok, reservation_request} ->
        conn
        |> put_flash(:info, gettext("Successfully submitted reservation request"))
        |> redirect(to: reservation_request_path(conn, :show, reservation_request))
      {:error, changeset} ->
        item = Repo.get!(Item, item_id)
        render(conn, :new, changeset: changeset, item: item)
    end
  end

  def show(conn, %{"id" => id}) do
    reservation_request = Repo.get!(ReservationRequest, id)
    render conn, :show, reservation_request: reservation_request
  end
end
