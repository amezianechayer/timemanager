defmodule ApiTimeManagerWeb.UserJSON do
  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{
      status: :success,
      data: for(user <- users, do: data(user))
    }
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{
      status: :success,
      data: data(user)}
  end

  @doc """
  Renders an error.
  """
  def error(%{error: error}) do
    %{error: error}
  end


  # defp data(%User{} = user) do
  defp data(user) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      roles: Enum.map(user.roles, & &1.name)
    }
  end
end
