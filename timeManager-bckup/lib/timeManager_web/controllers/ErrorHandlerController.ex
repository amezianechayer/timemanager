defmodule TimeManagerWeb.ErrorHandlerController do
  use TimeManagerWeb, :controller
  def call(conn, {:error, %Ecto.Changeset{} = changest}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(TimeManagerWeb.ChangesetView)
    |> render("error.json", changest: changest)
  end
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ServerWeb.ErrorView)
    |> render(:"404")
  end
end
