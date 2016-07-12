defmodule Equiplent.Password do
  import Ecto.Changeset, only: [put_change: 3, get_change: 2]
  import Comeonin.Bcrypt, only: [hashpwsalt: 1, checkpw: 2]

  @doc """
    Generates a password for the user changeset and stores it to the changeset as password_digest.
  """

  def encrypt(changeset) do
    if password = get_change(changeset, :password) do
      if Mix.env == :test do
        changeset
        |> put_change(:password_digest, password)
      else
        changeset
        |> put_change(:password_digest, hashpwsalt(password))
      end
    else
      changeset
    end
  end

  @doc """
    Checks password against password_digest.
  """
  def authenticate(password, password_digest) do
    if Mix.env == :test do
      password == password_digest
    else
      checkpw(password, password_digest)
    end
  end
end
