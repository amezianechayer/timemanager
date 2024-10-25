defmodule ApiTimeManagerWeb.CompagnyController do
  use ApiTimeManagerWeb, :controller

  alias ApiTimeManager.Compagnies
  alias ApiTimeManager.Compagnies.Compagny

  action_fallback ApiTimeManagerWeb.FallbackController

  def index(conn, _params) do
    compagnies = Compagnies.list_compagnies()
    render(conn, :index, compagnies: compagnies)
  end

  def create(conn, %{"compagny" => compagny_params}) do
    with {:ok, %Compagny{} = compagny} <- Compagnies.create_compagny(compagny_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/compagnies/#{compagny}")
      |> render(:show, compagny: compagny)
    end
  end

  def show(conn, %{"id" => id}) do
    compagny = Compagnies.get_compagny!(id)
    render(conn, :show, compagny: compagny)
  end

  def update(conn, %{"id" => id, "compagny" => compagny_params}) do
    compagny = Compagnies.get_compagny!(id)

    with {:ok, %Compagny{} = compagny} <- Compagnies.update_compagny(compagny, compagny_params) do
      render(conn, :show, compagny: compagny)
    end
  end

  def delete(conn, %{"id" => id}) do
    compagny = Compagnies.get_compagny!(id)

    with {:ok, %Compagny{}} <- Compagnies.delete_compagny(compagny) do
      send_resp(conn, :no_content, "")
    end
  end
end
