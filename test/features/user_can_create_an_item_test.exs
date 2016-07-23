defmodule UserCanCreateItemTest do
  use Equiplent.FeatureCase
  import Equiplent.Factory

  test "user can create an item" do
    user = insert(:user)
    item_name = "Camera"
    user_navigate_to "/", as: user

    click_on gettext("Add Item")
    fill_in("item[name]", item_name)
    submit

    assert visible_page_text =~ item_name
  end
end
