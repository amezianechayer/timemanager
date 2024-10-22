defmodule ApiTimeManagerWeb.AuthController do
  use ApiTimeManagerWeb, :controller

  alias ApiTimeManager.Accounts.Auth
  alias ApiTimeManager.Guardian

  action_fallback ApiTimeManagerWeb.FallbackController

  def register(conn, %{"user" => user_params}) do

    case Auth.register_user(user_params) do
      {:ok, user} ->
        # if uncomment this line, also uncomment line 10 of \lib\api_time_manager_web\controllers\auth_json.ex
        # token = Auth.generate_token(user)
        conn
        |> put_status(:created)
        |> render(:register, %{user: user})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:error, changeset: changeset)
    end
  end

  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Auth.authenticate_user(email, password) do
      {:ok, user} ->
        user_roles = user.roles |> Enum.map(& &1.name)
        claims = %{roles: user_roles}
        {:ok, token, _claims} = Guardian.encode_and_sign(user, claims)
        conn
        |> put_status(:ok)
        |> render(:login, %{user: user, token: token})

      {:error, :invalid_credentials} ->
        conn
        |> put_status(:unauthorized)
        |> render(:error, message: "Invalid credentials")
    end
  end
end
