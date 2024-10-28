defmodule ApiTimeManagerWeb.UserJSON do
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
    %{
      status: :success,
      data: data(user),
      token: token
    }
  end

  @doc """
  Renders a single user without a token.
  """
  def show(%{user: user}) do
    %{
      status: :success,
      data: data(user)
    }
  end

  @doc """
  Renders an error.
  """
  def error(%{error: error}) do
    %{error: error}
  end

  # Fonction privée pour structurer les données de l'utilisateur
  defp data(user) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      roles: Enum.map(user.roles, & &1.name),
      team_id: user.team_id  # Ajoutez le team_id ici
    }
  end
end
