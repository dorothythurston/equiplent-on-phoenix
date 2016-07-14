defmodule UserSignoutTest do
  use Equiplent.FeatureCase
  import Equiplent.Factory

  test "user can sign out" do
    user = create(:user)
    navigate_to "/", as: user
    click_on gettext("Sign Out")

    assert visible_page_text  =~ gettext("You have been logged out")
  end
end
