defmodule TimeManagerWeb.ClockController do
  use TimeManagerWeb, :controller

  alias TimeManager.Clocking
  alias TimeManager.Clocking.Clock

  def index(conn, _params) do
    clocks = Clocking.list_clocks()
    render(conn, :index, clocks: clocks)
  end

  def new(conn, _params) do
    changeset = Clocking.change_clock(%Clock{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"clock" => clock_params}) do
    case Clocking.create_clock(clock_params) do
      {:ok, clock} ->
        conn
        |> put_flash(:info, "Clock created successfully.")
        |> redirect(to: ~p"/clocks/#{clock}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    clock = Clocking.get_clock!(id)
    render(conn, :show, clock: clock)
  end

  def edit(conn, %{"id" => id}) do
    clock = Clocking.get_clock!(id)
    changeset = Clocking.change_clock(clock)
    render(conn, :edit, clock: clock, changeset: changeset)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Clocking.get_clock!(id)

    case Clocking.update_clock(clock, clock_params) do
      {:ok, clock} ->
        conn
        |> put_flash(:info, "Clock updated successfully.")
        |> redirect(to: ~p"/api/clock/#{clock}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, clock: clock, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Clocking.get_clock!(id)
    {:ok, _clock} = Clocking.delete_clock(clock)

    conn
    |> put_flash(:info, "Clock deleted successfully.")
    |> redirect(to: ~p"/clocks")
  end
end
