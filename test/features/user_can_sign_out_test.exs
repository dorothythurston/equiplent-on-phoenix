defmodule UserSignoutTest do
  use Equiplent.FeatureCase
  import Equiplent.Factory

  test "user can sign out" do
    user = insert(:user)
    user_navigate_to "/", as: user
    IO.inspect visible_page_text
    click_on gettext("Sign Out")

    assert visible_page_text  =~ gettext("You have been logged out")
  end
end
