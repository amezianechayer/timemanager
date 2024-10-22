defmodule ApiTimeManagerWeb.UserController do
  use ApiTimeManagerWeb, :controller

  alias ApiTimeManager.Accounts
  alias ApiTimeManager.Accounts.User

  action_fallback ApiTimeManagerWeb.FallbackController

  def index(conn, _params) do
    users_roles = conn.assigns[:current_user_role]
    users = Accounts.list_users()
    render(conn, :index, users: users, current_user_role: users_roles)
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_current_user(conn, _params) do
    user_id = conn.assigns[:current_user_id]
    user = Accounts.get_user!(user_id)
    render(conn, :show, user: user)
  end

  def update_current_user(conn, %{"user" => user_params}) do
    user_id = conn.assigns[:current_user_id]
    user = Accounts.get_user!(user_id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete_current_user(conn, _params) do
    user_id = conn.assigns[:current_user_id]
    user = Accounts.get_user!(user_id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
