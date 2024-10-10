defmodule ApiTimeManagerWeb.ClockController do
  use ApiTimeManagerWeb, :controller

  alias ApiTimeManager.Clocks
  alias ApiTimeManager.Clocks.Clock

  action_fallback ApiTimeManagerWeb.FallbackController

  def index(conn, _params) do
    clocks = Clocks.list_clocks()
    render(conn, :index, clocks: clocks)
  end

  def show_by_user(conn, %{"userID" => user_id}) do
    clocks = Clocks.get_clocks_by_user(user_id)
    updated_clocks = Enum.map(clocks, fn clock -> Map.put(clock, :user_id, user_id) end)
    render(conn, :index, clocks: updated_clocks)
  end

  def create_for_user(conn, %{"userID" => user_id, "clock" => clock_params}) do
    clock_params = Map.put(clock_params, "user_id", user_id)
    with {:ok, %Clock{} = clock} <- Clocks.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/clocks/#{user_id}")
      |> render(:show, clock: clock)
    end
  end

  # def create(conn, %{"clock" => clock_params}) do
  #   with {:ok, %Clock{} = clock} <- Clocks.create_clock(clock_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", ~p"/api/clocks/#{clock}")
  #     |> render(:show, clock: clock)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   clock = Clocks.get_clock!(id)
  #   render(conn, :show, clock: clock)
  # end

  # def update(conn, %{"id" => id, "clock" => clock_params}) do
  #   clock = Clocks.get_clock!(id)

  #   with {:ok, %Clock{} = clock} <- Clocks.update_clock(clock, clock_params) do
  #     render(conn, :show, clock: clock)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   clock = Clocks.get_clock!(id)

  #   with {:ok, %Clock{}} <- Clocks.delete_clock(clock) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
