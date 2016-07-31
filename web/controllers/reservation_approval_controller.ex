defmodule Equiplent.ReservationApprovalController do
  use Equiplent.Web, :controller

  alias Equiplent.Reservation
  alias Equiplent.Item
  import Equiplent.Gettext

  def create(conn, %{"reservation_id" => reservation_id}) do
    reservation = Repo.get!(Reservation, reservation_id)
    changeset = Reservation.approval_changeset(reservation)

    case Repo.update(changeset) do
      {:ok, reservation} ->
        conn
        |> put_flash(:info, gettext("Successfully approved reservation request"))
        |> redirect(to: reservation_path(conn, :show, reservation))
      {:error, changeset} ->
        conn
        |> put_flash(:info, gettext("There was an error approving the reservation request"))
        |> redirect(to: reservation_path(conn, :show, reservation))
    end
  end
end
