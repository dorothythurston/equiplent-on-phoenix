defmodule Equiplent.PageController do
  use Equiplent.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
