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
      hash_password: user.hash_password
    }
  end
end
