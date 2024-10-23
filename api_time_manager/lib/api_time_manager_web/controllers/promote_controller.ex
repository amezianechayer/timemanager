defmodule ApiTimeManagerWeb.PromoteController do
  use ApiTimeManagerWeb, :controller

  alias ApiTimeManager.Accounts

  action_fallback ApiTimeManagerWeb.FallbackController

  # def promote_user_to_manager(conn, %{"userID" => user_id}) do
  #   user = Accounts.get_user!(user_id)

  #   with {:ok, %User{} = updated_user} <- Accounts.promote_user(2) do
  #     render(conn, :promote, user: updated_user)
  #   end
  # end

  def promote_user_to_manager(conn, %{"userID" => user_id}) do
    case Accounts.promote_user(user_id) do
      {:ok, _result} ->
        json(conn, %{status: :success, message: "User promoted to manager successfully."})

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{status: :error, message: reason})
    end
  end

  def demote_manager_to_user(conn, %{"userID" => user_id}) do
    case Accounts.demote_user(user_id) do
      {:ok, _result} ->
        json(conn, %{status: :success, message: "Manager demoted to user successfully."})

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{status: :error, message: reason})
    end
  end
end
