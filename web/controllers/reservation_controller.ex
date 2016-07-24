defmodule Equiplent.ReservationController do
  use Equiplent.Web, :controller
  alias Equiplent.Reservation
  alias Equiplent.ReservationRequest

  def show(conn, %{"id" => id}) do
    reservation = Repo.get!(Reservation, id)
    render conn, :show, reservation: reservation
  end


  def create(conn, %{"reservation_request_id"=> reservation_request_id}) do
    approved_request = Repo.get(ReservationRequest, reservation_request_id)
    reservation = build_assoc(approved_request, :reservation)
    changeset = Reservation.changeset(reservation, reservation_params(approved_request))

    case Repo.insert(changeset) do
      {:ok, reservation} ->
      Repo.update!(Ecto.Changeset.change approved_request, status: "approved")
        conn
        |> put_flash(:info, gettext("Successfully approved reservation"))
        |> redirect(to: reservation_path(conn, :show, reservation))
      {:error, changeset} ->
        conn
        |> put_flash(:info, gettext("Error approving reservation"))
    end
  end

  defp reservation_params(request) do
    %{user_id: request.user_id,
      item_id: request.item_id,
      begins_at: request.requested_start_date,
      ends_at: request.requested_end_date
    }
  end
end
