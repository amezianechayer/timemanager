defmodule ApiTimeManagerWeb.CompagnyControllerTest do
  use ApiTimeManagerWeb.ConnCase

  import ApiTimeManager.CompagniesFixtures

  alias ApiTimeManager.Compagnies.Compagny

  @create_attrs %{
    name: "some name",
    description: "some description"
  }
  @update_attrs %{
    name: "some updated name",
    description: "some updated description"
  }
  @invalid_attrs %{name: nil, description: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all compagnies", %{conn: conn} do
      conn = get(conn, ~p"/api/compagnies")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create compagny" do
    test "renders compagny when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/compagnies", compagny: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/compagnies/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some description",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/compagnies", compagny: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update compagny" do
    setup [:create_compagny]

    test "renders compagny when data is valid", %{conn: conn, compagny: %Compagny{id: id} = compagny} do
      conn = put(conn, ~p"/api/compagnies/#{compagny}", compagny: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/compagnies/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, compagny: compagny} do
      conn = put(conn, ~p"/api/compagnies/#{compagny}", compagny: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete compagny" do
    setup [:create_compagny]

    test "deletes chosen compagny", %{conn: conn, compagny: compagny} do
      conn = delete(conn, ~p"/api/compagnies/#{compagny}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/compagnies/#{compagny}")
      end
    end
  end

  defp create_compagny(_) do
    compagny = compagny_fixture()
    %{compagny: compagny}
  end
end
