defmodule ApiTimeManagerWeb.WorkingtimeController do
  use ApiTimeManagerWeb, :controller

  alias ApiTimeManager.TimeManagement
  alias ApiTimeManager.TimeManagement.Workingtime

  action_fallback ApiTimeManagerWeb.FallbackController

  def index(conn, _params) do
    workingtimes = TimeManagement.list_workingtimes()
    render(conn, :index, workingtimes: workingtimes)
  end

  def show(conn, %{"id" => id}) do
    workingtime = TimeManagement.get_workingtime!(id)
    render(conn, :show, workingtime: workingtime)
  end

  def delete(conn, %{"id" => id}) do
    workingtime = TimeManagement.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- TimeManagement.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end

  def create_for_authenticated_user(conn, %{"workingtime" => workingtime_params}) do
    user_id = conn.assigns[:current_user_id]
    workingtime_params = Map.put(workingtime_params, "user_id", String.to_integer(user_id))
    with {:ok, %Workingtime{} = workingtime} <- TimeManagement.create_workingtime(workingtime_params) do
      conn
      |> put_status(:created)
        # |> put_resp_header("location", ~p"/api/workingtimes/#{workingtime.user_id}")
      |> render(:show, workingtime: workingtime)
    end
  end

  def create_for_user(conn, %{"userID" => user_id, "workingtime" => workingtime_params}) do
    workingtime_params = Map.put(workingtime_params, "user_id", String.to_integer(user_id))
    with {:ok, %Workingtime{} = workingtime} <- TimeManagement.create_workingtime(workingtime_params) do
      conn
      |> put_status(:created)
        # |> put_resp_header("location", ~p"/api/workingtimes/#{workingtime.id}")
      |> render(:show, workingtime: workingtime)
    end
  end

  def update_for_authenticated_user(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = TimeManagement.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- TimeManagement.update_workingtime(workingtime, workingtime_params) do
      render(conn, :show, workingtime: workingtime)
    end
  end

  def user_get_working_times(conn, _params) do
    user_id = conn.assigns[:current_user_id]
    case TimeManagement.list_workingtimes_for_user(user_id) do
      [] ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "No working times found for user"})

      workingtimes ->
        render(conn, :index, workingtimes: workingtimes)
    end
  end

  def admin_get_working_times(conn, %{"userID" => user_id}) do
    user_id = String.to_integer(user_id)
    IO.inspect(user_id)
    case TimeManagement.list_workingtimes_for_user(user_id) do
      [] ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "No working times found for user"})

      workingtimes ->
        render(conn, :index, workingtimes: workingtimes)
    end
  end

  def admin_get_working_time(conn, %{"userID" => user_id, "id" => workingtime_id}) do
    user_id = String.to_integer(user_id)
    workingtime_id = String.to_integer(workingtime_id)
    case TimeManagement.get_workingtime_for_user(user_id, workingtime_id) do
      [] ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "No working times found for user"})

      workingtimes when is_list(workingtimes) ->
        render(conn, :index, workingtimes: workingtimes)

      workingtime ->
        render(conn, :show, workingtime: workingtime)
    end
  end
end

# def create(conn, %{"workingtime" => workingtime_params}) do
#   with {:ok, %Workingtime{} = workingtime} <- TimeManagement.create_workingtime(workingtime_params) do
#     conn
#     |> put_status(:created)
#     |> put_resp_header("location", ~p"/api/workingtimes/#{workingtime}")
#     |> render(:show, workingtime: workingtime)
#   end
# end