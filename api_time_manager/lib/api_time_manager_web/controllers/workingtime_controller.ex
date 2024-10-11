defmodule ApiTimeManagerWeb.WorkingtimeController do
  use ApiTimeManagerWeb, :controller

  alias ApiTimeManager.TimeManagement
  alias ApiTimeManager.TimeManagement.Workingtime

  action_fallback ApiTimeManagerWeb.FallbackController

  def create_for_user(conn, %{"userID" => user_id, "workingtime" => workingtime_params}) do
    workingtime_params = Map.put(workingtime_params, "user_id", String.to_integer(user_id))
    with {:ok, %Workingtime{} = workingtime} <- TimeManagement.create_workingtime(workingtime_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/workingtimes/#{workingtime.id}")
      |> render(:show, workingtime: workingtime)
    end
  end

  def get_working_time_for_user(conn, %{"userID" => user_id, "id" => id}) do
    case TimeManagement.get_workingtime_for_user(user_id, id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Workingtime not found for user"})

      workingtime ->
        render(conn, "show.json", workingtime: workingtime)
    end
  end

  def index(conn, _params) do
    workingtimes = TimeManagement.list_workingtimes()
    render(conn, :index, workingtimes: workingtimes)
  end

  def create(conn, %{"workingtime" => workingtime_params}) do
    with {:ok, %Workingtime{} = workingtime} <- TimeManagement.create_workingtime(workingtime_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/workingtimes/#{workingtime}")
      |> render(:show, workingtime: workingtime)
    end
  end

  def show(conn, %{"id" => id}) do
    workingtime = TimeManagement.get_workingtime!(id)
    render(conn, :show, workingtime: workingtime)
  end


  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = TimeManagement.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- TimeManagement.update_workingtime(workingtime, workingtime_params) do
      render(conn, :show, workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = TimeManagement.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- TimeManagement.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end
