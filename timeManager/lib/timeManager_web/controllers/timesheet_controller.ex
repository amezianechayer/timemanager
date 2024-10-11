defmodule TimeManagerWeb.TimesheetController do
  use TimeManagerWeb, :controller

  alias TimeManager.Work
  alias TimeManager.Work.Timesheet

  def index(conn, _params) do
    workingtimes = Work.list_workingtimes()
    render(conn, :index, workingtimes: workingtimes)
  end

  def new(conn, _params) do
    changeset = Work.change_timesheet(%Timesheet{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"timesheet" => timesheet_params}) do
    case Work.create_timesheet(timesheet_params) do
      {:ok, timesheet} ->
        conn
        |> put_flash(:info, "Timesheet created successfully.")
        |> redirect(to: ~p"/api/workingtimes/#{timesheet}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    timesheet = Work.get_timesheet!(id)
    render(conn, :show, timesheet: timesheet)
  end

  def edit(conn, %{"id" => id}) do
    timesheet = Work.get_timesheet!(id)
    changeset = Work.change_timesheet(timesheet)
    render(conn, :edit, timesheet: timesheet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "timesheet" => timesheet_params}) do
    timesheet = Work.get_timesheet!(id)

    case Work.update_timesheet(timesheet, timesheet_params) do
      {:ok, timesheet} ->
        conn
        |> put_flash(:info, "Timesheet updated successfully.")
        |> redirect(to: ~p"/workingtimes/#{timesheet}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, timesheet: timesheet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    timesheet = Work.get_timesheet!(id)
    {:ok, _timesheet} = Work.delete_timesheet(timesheet)

    conn
    |> put_flash(:info, "Timesheet deleted successfully.")
    |> redirect(to: ~p"/workingtimes")
  end
end
