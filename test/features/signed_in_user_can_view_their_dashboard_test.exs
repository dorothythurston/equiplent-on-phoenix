defmodule ViewDashboardTest do
  use Equiplent.FeatureCase
  import Equiplent.Factory

  test "user can view their dashboard" do
    user = insert(:user)
    user_navigate_to "/", as: user

    assert visible_page_text =~ gettext("Welcome")
  end
end
