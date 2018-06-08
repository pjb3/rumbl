defmodule RumblWeb.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  def init(opts), do: opts

  def call(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: RumblWeb.Router.Helpers.page_path(conn, :index))
      |> halt()
    end
  end
end
