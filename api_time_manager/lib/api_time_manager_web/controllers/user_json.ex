defmodule ApiTimeManagerWeb.UserJSON do
  alias ApiTimeManager.Accounts.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user, token: token}) do
    %{data: data(user), token: token}
  end

  @doc """

  # Renders a list of users.
  # """
  # def index(%{users: users}) do
  #  %{data: for(user <- users, do: data(user))}
  # end

  # @doc """
  # Renders a single user.
  # """

  # SUPPRESION DU TOKEN POUR LA ROUTE GET /api/users/:id
  # def show(%{user: user}) do
  #   %{data: data(user)}
  # end
  # SUPPRESION DU TOKEN POUR LA ROUTE GET /api/users/:id

  # @doc """
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
    }
  end
end
