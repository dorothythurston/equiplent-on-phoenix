defmodule AddUsersTest do
  use Equiplent.FeatureCase

  test "user sign up" do
    navigate_to("/signup")

    fill_in("user[email]", "email@email.com")
    fill_in("user[password]", "password")
    fill_in("user[password_confirmation]", "password")
    submit

    assert visible_page_text  =~ "Successfully signed up!"
  end
end
