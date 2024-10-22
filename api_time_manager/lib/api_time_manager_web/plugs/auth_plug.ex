defmodule ApiTimeManagerWeb.Plugs.AuthPlug do
  import Plug.Conn
  import Phoenix.Controller

  alias ApiTimeManager.Guardian

  def init(opts), do: opts

  def call(conn, roles) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
    {:ok, claims} <- verify_token(token),
      true <- has_required_role?(claims["roles"], roles) do
        # IO.inspect(claims["sub"])
        assign(conn, :current_user_id, claims["sub"])
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Unauthorized"})
        |> halt()
    end
  end

  defp verify_token(token) do
    case Guardian.decode_and_verify(token) do
      # {:ok, claims} -> {:ok, claims}
      {:ok, claims} ->
        _roles = Map.get(claims, "roles", [])
        {:ok, claims}
      {:error, _reason} -> {:error, :invalid_token}
    end
  end

  defp has_required_role?(user_roles, required_roles) do
    Enum.any?(required_roles, &(&1 in user_roles))
  end

  defp has_required_role?(_, _), do: false
end
