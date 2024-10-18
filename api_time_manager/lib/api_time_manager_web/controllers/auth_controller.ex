defmodule ApiTimeManagerWeb.AuthController do
  use ApiTimeManagerWeb, :controller

  # alias ApiTimeManager.Auth
  alias ApiTimeManager.Accounts.Auth

  action_fallback ApiTimeManagerWeb.FallbackController

  # ! Reprendre le register
  def register(conn, %{"user" => user_params}) do
    case Auth.register_user(user_params) do
      {:ok, user} ->
        # token = Auth.generate_token(user)
        conn
        |> put_status(:created)
        |> render(:register, %{user: user})
        # |> render(:show, %{user: user, token: token})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:error, changeset: changeset)
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    case Auth.authenticate_user(email, password) do
      {:ok, user} ->
        token = Auth.generate_token(user)
        conn
        |> put_status(:ok)
        # |> render("login.json", %{user: user, token: token})
        |> render(:show, %{user: user, token: token})

      {:error, :invalid_credentials} ->
        conn
        |> put_status(:unauthorized)
        |> render(:error, message: "Invalid credentials")
    end
  end
end
