defmodule TimeManagerWeb.ClockController do
  use TimeManagerWeb, :controller

  alias TimeManager.Account
  alias TimeManager.Account.Clock
  # alias TimeManager.Comptes.User


  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    clocks = Account.list_clocks()
    render(conn, :index, clocks: clocks)
  end

  def create(conn, %{"userID" => id}) do
    IO.inspect(id)
    with {:ok, %Clock{} = clock} <- Account.create_clock(%{"userID" => id}) do
      IO.inspect(clock)
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/clocks/#{id}")
      |> render(:show, clock: clock)
    end
  end

  def show(conn, %{"id" => id}) do
    clock = Account.get_clock!(id)
    render(conn, :show, clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Account.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Account.update_clock(clock, clock_params) do
      render(conn, :show, clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Account.get_clock!(id)

    with {:ok, %Clock{}} <- Account.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
