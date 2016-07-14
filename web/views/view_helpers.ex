defmodule Equiplent.ViewHelpers do
  def logged_in?(conn) do
    !!Plug.Conn.get_session(conn, :current_user_id)
  end
end
