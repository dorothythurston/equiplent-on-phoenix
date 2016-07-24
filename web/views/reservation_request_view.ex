defmodule Equiplent.ReservationRequestView do
  use Equiplent.Web, :view

  def approved?(request) do
    request.status == "approved"
  end
end
