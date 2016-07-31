defmodule UserCanApproveReservationTest do
  use Equiplent.FeatureCase
  import Equiplent.Factory

  test "owner can approve item reservation" do
    user = insert(:user)
    item = insert(:item, user: user)
    reservation = insert(:reservation, item: item)
    user_navigate_to "/reservations/#{reservation.id}", as: user

    click_on gettext("Approve Reservation")

    assert visible_page_text =~ gettext("Successfully approved reservation request")
  end

  test "owner cannot approve reservation when a reservation for that time period exists" do
    user = insert(:user)
    start_date = Ecto.DateTime.from_erl(Equiplent.Reservation.start_of_hour())
    end_date = Ecto.DateTime.from_erl(Equiplent.Reservation.end_of_hour())
    item = insert(:item, user: user)
    insert(:reservation, item: item, begins_at: start_date, ends_at: end_date, status: "Approved")
    new_reservation = insert(:reservation, item: item, begins_at: start_date, ends_at: end_date)
    user_navigate_to "/reservations/#{new_reservation.id}", as: user

    click_on gettext("Approve Reservation")

    assert visible_page_text =~ gettext("Could not approve reservation request")
  end
end
