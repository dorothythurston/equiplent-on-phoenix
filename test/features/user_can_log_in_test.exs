defmodule NewSessionTest do
  use Equiplent.FeatureCase
  import Equiplent.Factory

  test "user logs in" do
    user = insert(:user)
    navigate_to("/login")
    fill_in("user[email]", user.email)
    fill_in("user[password]", user.password_digest)
    submit

    assert visible_page_text  =~ gettext("Welcome!")
  end

  test "user logs in with bad password" do
    user = insert(:user)
    navigate_to("/login")
    fill_in("user[email]", user.email)
    fill_in("user[password]", "bad password")
    submit

    assert visible_page_text  =~ gettext("Username or password are incorrect.")
  end

  test "user logs in with non existing user" do
    navigate_to("/login")
    fill_in("user[email]", "i@dontexist.com")
    fill_in("user[password]", "bad password")
    submit

    assert visible_page_text  =~ gettext("Could not find a user with that username.")
  end
end
