defmodule ApiTimeManagerWeb.Plugs.AuthPlug do
  import Plug.Conn
  import Phoenix.Controller

  alias ApiTimeManager.Guardian

  def init(opts), do: opts

  def call(conn, roles) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        with {:ok, claims} <- verify_token(token),
             roles_claims = Map.get(claims, "roles", []),
             user_id = Map.get(claims, "sub"),
             true <- has_required_role?(roles_claims, roles) do

          conn
          |> assign(:current_user_id, user_id)
          |> assign(:current_user_role, roles_claims)
        else
          _ ->
            unauthorized_response(conn)
        end

      _ ->
        unauthorized_response(conn)
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

  defp unauthorized_response(conn) do
    conn
    |> put_status(:unauthorized)
    |> json(%{error: "Unauthorized"})
    |> halt()
  end

  defp has_required_role?(user_roles, required_roles) do
    Enum.any?(required_roles, &(&1 in user_roles))
  end

  defp has_required_role?(_, _), do: false
end
