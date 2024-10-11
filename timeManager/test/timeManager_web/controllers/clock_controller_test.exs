defmodule TimeManagerWeb.ClockControllerTest do
  use TimeManagerWeb.ConnCase

  import TimeManager.ClockingFixtures

  @create_attrs %{clock_in: ~U[2024-10-07 13:55:00Z], clock_out: ~U[2024-10-07 13:55:00Z]}
  @update_attrs %{clock_in: ~U[2024-10-08 13:55:00Z], clock_out: ~U[2024-10-08 13:55:00Z]}
  @invalid_attrs %{clock_in: nil, clock_out: nil}

  describe "index" do
    test "lists all clocks", %{conn: conn} do
      conn = get(conn, ~p"/clocks")
      assert html_response(conn, 200) =~ "Listing Clocks"
    end
  end

  describe "new clock" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/clocks/new")
      assert html_response(conn, 200) =~ "New Clock"
    end
  end

  describe "create clock" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/clocks", clock: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/clocks/#{id}"

      conn = get(conn, ~p"/clocks/#{id}")
      assert html_response(conn, 200) =~ "Clock #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/clocks", clock: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Clock"
    end
  end

  describe "edit clock" do
    setup [:create_clock]

    test "renders form for editing chosen clock", %{conn: conn, clock: clock} do
      conn = get(conn, ~p"/clocks/#{clock}/edit")
      assert html_response(conn, 200) =~ "Edit Clock"
    end
  end

  describe "update clock" do
    setup [:create_clock]

    test "redirects when data is valid", %{conn: conn, clock: clock} do
      conn = put(conn, ~p"/clocks/#{clock}", clock: @update_attrs)
      assert redirected_to(conn) == ~p"/clocks/#{clock}"

      conn = get(conn, ~p"/clocks/#{clock}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, clock: clock} do
      conn = put(conn, ~p"/clocks/#{clock}", clock: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Clock"
    end
  end

  describe "delete clock" do
    setup [:create_clock]

    test "deletes chosen clock", %{conn: conn, clock: clock} do
      conn = delete(conn, ~p"/clocks/#{clock}")
      assert redirected_to(conn) == ~p"/clocks"

      assert_error_sent 404, fn ->
        get(conn, ~p"/clocks/#{clock}")
      end
    end
  end

  defp create_clock(_) do
    clock = clock_fixture()
    %{clock: clock}
  end
end
