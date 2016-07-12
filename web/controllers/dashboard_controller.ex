defmodule Equiplent.DashboardController do
  use Equiplent.Web, :controller

  def show(conn, _params) do
    render conn, "show.html"
  end
end
