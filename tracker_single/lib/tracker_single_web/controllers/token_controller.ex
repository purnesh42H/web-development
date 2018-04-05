defmodule TrackerSingleWeb.TokenController do
  use TrackerSingleWeb, :controller
  alias TrackerSingle.Users.User

  action_fallback TrackerSingleWeb.FallbackController

  def create(conn, %{"name" => name, "pass" => pass}) do
    with {:ok, %User{} = user} <- TrackerSingle.Users.get_and_auth_user(name, pass) do
      token = Phoenix.Token.sign(conn, "auth token", user.id)
      conn
      |> put_status(:created)
      |> render("token.json", user: user, token: token)
    end
  end
  
  def create(conn, %{}) do
      conn
      |> put_status(:created)
      |> render("token.json")
  end
end
