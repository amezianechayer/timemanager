# defmodule ApiTimeManagerWeb.PromoteController do
#   use ApiTimeManagerWeb, :controller

#   alias ApiTimeManager.Accounts
#   alias ApiTimeManager.Accounts.User

#   action_fallback ApiTimeManagerWeb.FallbackController

#   def promote_user(conn, %{"userID" => user_id}) do
#     user_id
#     |> Accounts.get_user!()
#     |> promote_to_manager(conn)
#   end

#   defp promote_to_manager(%User{} = user, conn) do
#     case Accounts.promote_user(user) do
#       {:ok, updated_user} ->
#         conn
#         |> put_status(:ok)
#         |> json(%{message: "User promoted successfully", user: updated_user})

#       {:error, reason} ->
#         conn
#         |> put_status(:unprocessable_entity)
#         |> json(%{error: "Failed to promote user", reason: reason})
#     end
#   end
# end
