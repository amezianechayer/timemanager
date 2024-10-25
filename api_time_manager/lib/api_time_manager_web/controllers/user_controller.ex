defmodule ApiTimeManagerWeb.UserController do
  use ApiTimeManagerWeb, :controller
  alias ApiTimeManager.Repo
  alias ApiTimeManager.Accounts
  alias ApiTimeManager.Accounts.User

  action_fallback ApiTimeManagerWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    user_params = Map.put_new(user_params, "team_id", nil)

    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token, _full_claims} <- ApiTimeManager.Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render(:show, user: user, token: token)
    end
  end

  def index_by_team(conn, %{"team_id" => team_id}) do

    users = ApiTimeManager.Accounts.User.list_users_by_team(team_id)  # Assurez-vous d'utiliser le bon module


    users = ApiTimeManager.Accounts.User.list_users_by_team(team_id) 

    render(conn, "index.json", users: users)
  end

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, :index, users: users)
  end

  def assign_user_to_team(conn, %{"team_id" => team_id, "user_id" => user_id}) do
    team_id = String.to_integer(team_id)

    case User.get_user(user_id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "User not found"})
      user ->
        case User.assign_team(user, team_id) do
          {:ok, updated_user} ->
            updated_user = Repo.preload(updated_user, :team)  # Précharge l'association `team`
            json(conn, updated_user)
          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{error: changeset})
        end
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


  def fetch_users(conn, params) do
    email = Map.get(params, "email")
    username = Map.get(params, "username")

    users = Accounts.list_users_filtered(email, username)
    render(conn, :index, users: users)
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
  # end

end
