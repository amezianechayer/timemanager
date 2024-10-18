defmodule ApiTimeManagerWeb.UserController do
  use ApiTimeManagerWeb, :controller

  alias ApiTimeManager.Accounts
  alias ApiTimeManager.Accounts.User
  # alias ApiTimeManager.Guardian

  action_fallback ApiTimeManagerWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, :index, users: users)
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

  # def create(conn, user_params) do
  #   with {:ok, %User{} = user} <- Accounts.create_user(user_params),
  #        {:ok, token, _full_claims} <- ApiTimeManager.Guardian.encode_and_sign(user) do
  #     conn
  #     |> put_status(:created)
  #     |> render(:show, user: user, token: token)
  #   end
  # end

  ## Old create controller
  # def create(conn, %{"user" => user_params}) do
  #   with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", ~p"/api/users/#{user}")
  #     |> render(:show, user: user)
  #   end
  # end
end
