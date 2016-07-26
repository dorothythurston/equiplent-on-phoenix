defmodule UserCanRequestReservationTest do
  use Equiplent.FeatureCase
  import Equiplent.Factory

  test "user can request an item reservation" do
    user = insert(:user)
    item = insert(:item)
    user_navigate_to "/items/#{item.id}", as: user

    click_on gettext("Reserve Item")
    submit

    assert visible_page_text =~ gettext("Successfully submitted reservation request")
  end
end
