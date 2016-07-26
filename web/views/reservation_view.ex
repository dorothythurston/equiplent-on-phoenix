defmodule Equiplent.ReservationView do
  use Equiplent.Web, :view

  def current_date do
    :calendar.universal_time()
  end

  def set_minute_value({date, {hour, minute, second}}, value) do
    {date, {hour, value, second}}
  end

  def start_of_hour do
    set_minute_value(current_date, 1)
  end

  def end_of_hour do
    set_minute_value(current_date, 59)
  end
end
