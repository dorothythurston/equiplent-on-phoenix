defmodule AddUsersTest do
  use Equiplent.FeatureCase

  test "user sign up" do
    navigate_to("/signup")

    email = "email@email.com"
    fill_in("user[email]", email)
    fill_in("user[password]", "password")
    fill_in("user[password_confirmation]", "password")
    submit

    assert visible_page_text  =~ gettext("Successfully signed up!")
    assert visible_page_text  =~ email
  end
end
