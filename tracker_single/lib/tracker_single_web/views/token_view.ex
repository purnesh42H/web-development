
defmodule TrackerSingleWeb.TokenView do
  use TrackerSingleWeb, :view
  
  def render("token.json", %{user: user, token: token}) do
    %{
      user_id: user.id,
      token: token,
    }
  end
  
  def render("token.json", %{}) do
    nil
  end
end
