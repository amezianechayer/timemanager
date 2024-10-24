defmodule ApiTimeManagerWeb.UserJSON do
  alias ApiTimeManager.Accounts.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a list of users for a specific team.
  """
  def index_by_team(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user, token: token}) do
    %{data: data(user), token: token}
  end

  @doc """
  Renders a single user without a token.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  @doc """
  Renders an error.
  """
  def error(%{error: error}) do
    %{error: error}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      team_id: user.team_id  # Ajoutez le team_id ici
      # Suppression du hash_password pour la sécurité
      # hash_password: user.hash_password
    }
  end
end
