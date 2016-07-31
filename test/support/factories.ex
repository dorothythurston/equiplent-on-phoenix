defmodule Equiplent.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: Equiplent.Repo

  def user_factory do
    %Equiplent.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      password_digest: "password"
    }
  end

  def item_factory do
    %Equiplent.Item{
      name: "some name",
      user: build(:user),
    }
  end

  def reservation_factory do
    %Equiplent.Reservation{
      user: build(:user),
      item: build(:item),
      begins_at: Ecto.DateTime.from_erl(Equiplent.Reservation.start_of_hour),
      ends_at: Ecto.DateTime.from_erl(Equiplent.Reservation.end_of_hour)
    }
  end
end
