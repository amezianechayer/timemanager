defmodule ApiTimeManagerWeb.UserController do
  use ApiTimeManagerWeb, :controller

  alias ApiTimeManager.Accounts
  alias ApiTimeManager.Accounts.User
  # alias ApiTimeManager.Guardian

  action_fallback ApiTimeManagerWeb.FallbackController

  # def create(conn, user_params) do
  #   with {:ok, %User{} = user} <- Accounts.create_user(user_params),
  #        {:ok, token, _full_claims} <- ApiTimeManager.Guardian.encode_and_sign(user) do
  #     conn
  #     |> put_status(:created)
  #     |> render(:show, user: user, token: token)
  #   end
  # end


  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, :index, users: users)
  end

  ## Old create controller
  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    end
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

  # def sign_in(conn, %{"user" => %{"email" => email, "password" => hash_password}}) do
  #   case ApiTimeManager.Guardian.authenticate(email, hash_password) do
  #     {:ok, user, token} ->
  #       conn
  #       |> put_status(:ok)
  #       |> render(:show, user: user, token: token)
  #     {:error, _reason} ->
  #       conn
  #       |> put_status(:unauthorized)
  #       |> render(:show, error: "invalid credentials")
  #   end
  # end

  # def sign_in(conn, %{"email" => email, "password" => hash_password}) do
  #   case Accounts.authenticate_user(email, hash_password) do
  #     {:ok, user} ->
  #       {:ok, token, _claims} = Guardian.encode_and_sign(user)
  #       json(conn, %{token: token, user: user})

  #     {:error, :unauthorized} ->
  #       conn
  #       |> put_status(:unauthorized)
  #       |> json(%{error: "Invalid credentials"})
  #   end
  # end
end
