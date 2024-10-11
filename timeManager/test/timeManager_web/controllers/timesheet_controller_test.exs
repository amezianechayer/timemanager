defmodule TimeManagerWeb.TimesheetControllerTest do
  use TimeManagerWeb.ConnCase

  import TimeManager.WorkFixtures

  @create_attrs %{start_time: ~U[2024-10-07 13:55:00Z], end_time: ~U[2024-10-07 13:55:00Z]}
  @update_attrs %{start_time: ~U[2024-10-08 13:55:00Z], end_time: ~U[2024-10-08 13:55:00Z]}
  @invalid_attrs %{start_time: nil, end_time: nil}

  describe "index" do
    test "lists all workingtimes", %{conn: conn} do
      conn = get(conn, ~p"/workingtimes")
      assert html_response(conn, 200) =~ "Listing Workingtimes"
    end
  end

  describe "new timesheet" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/workingtimes/new")
      assert html_response(conn, 200) =~ "New Timesheet"
    end
  end

  describe "create timesheet" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/workingtimes", timesheet: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/workingtimes/#{id}"

      conn = get(conn, ~p"/workingtimes/#{id}")
      assert html_response(conn, 200) =~ "Timesheet #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/workingtimes", timesheet: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Timesheet"
    end
  end

  describe "edit timesheet" do
    setup [:create_timesheet]

    test "renders form for editing chosen timesheet", %{conn: conn, timesheet: timesheet} do
      conn = get(conn, ~p"/workingtimes/#{timesheet}/edit")
      assert html_response(conn, 200) =~ "Edit Timesheet"
    end
  end

  describe "update timesheet" do
    setup [:create_timesheet]

    test "redirects when data is valid", %{conn: conn, timesheet: timesheet} do
      conn = put(conn, ~p"/workingtimes/#{timesheet}", timesheet: @update_attrs)
      assert redirected_to(conn) == ~p"/workingtimes/#{timesheet}"

      conn = get(conn, ~p"/workingtimes/#{timesheet}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, timesheet: timesheet} do
      conn = put(conn, ~p"/workingtimes/#{timesheet}", timesheet: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Timesheet"
    end
  end

  describe "delete timesheet" do
    setup [:create_timesheet]

    test "deletes chosen timesheet", %{conn: conn, timesheet: timesheet} do
      conn = delete(conn, ~p"/workingtimes/#{timesheet}")
      assert redirected_to(conn) == ~p"/workingtimes"

      assert_error_sent 404, fn ->
        get(conn, ~p"/workingtimes/#{timesheet}")
      end
    end
  end

  defp create_timesheet(_) do
    timesheet = timesheet_fixture()
    %{timesheet: timesheet}
  end
end
