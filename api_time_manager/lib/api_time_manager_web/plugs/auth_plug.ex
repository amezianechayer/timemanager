defmodule ApiTimeManagerWeb.Plugs.AuthPlug do
  import Plug.Conn
  import Phoenix.Controller

  def init(opts), do: opts

  def call(conn, roles) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, claims} <- verify_token(token),
         true <- has_required_role?(claims["roles"], roles) do
      assign(conn, :current_user_id, claims["user_id"])
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Unauthorized"})
        |> halt()
    end
  end

  defp verify_token(token) do
    Phoenix.Token.verify(ApiTimeManagerWeb.Endpoint, "user auth", token, max_age: 86400)

  end

  defp has_required_role?(user_roles, required_roles) do
    Enum.any?(required_roles, &(&1 in user_roles))
  end

  # defp has_required_role?(_, _), do: false

end
