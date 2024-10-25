defmodule ApiTimeManager.CompagniesTest do
  use ApiTimeManager.DataCase

  alias ApiTimeManager.Compagnies

  describe "compagnies" do
    alias ApiTimeManager.Compagnies.Compagny

    import ApiTimeManager.CompagniesFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_compagnies/0 returns all compagnies" do
      compagny = compagny_fixture()
      assert Compagnies.list_compagnies() == [compagny]
    end

    test "get_compagny!/1 returns the compagny with given id" do
      compagny = compagny_fixture()
      assert Compagnies.get_compagny!(compagny.id) == compagny
    end

    test "create_compagny/1 with valid data creates a compagny" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %Compagny{} = compagny} = Compagnies.create_compagny(valid_attrs)
      assert compagny.name == "some name"
      assert compagny.description == "some description"
    end

    test "create_compagny/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Compagnies.create_compagny(@invalid_attrs)
    end

    test "update_compagny/2 with valid data updates the compagny" do
      compagny = compagny_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %Compagny{} = compagny} = Compagnies.update_compagny(compagny, update_attrs)
      assert compagny.name == "some updated name"
      assert compagny.description == "some updated description"
    end

    test "update_compagny/2 with invalid data returns error changeset" do
      compagny = compagny_fixture()
      assert {:error, %Ecto.Changeset{}} = Compagnies.update_compagny(compagny, @invalid_attrs)
      assert compagny == Compagnies.get_compagny!(compagny.id)
    end

    test "delete_compagny/1 deletes the compagny" do
      compagny = compagny_fixture()
      assert {:ok, %Compagny{}} = Compagnies.delete_compagny(compagny)
      assert_raise Ecto.NoResultsError, fn -> Compagnies.get_compagny!(compagny.id) end
    end

    test "change_compagny/1 returns a compagny changeset" do
      compagny = compagny_fixture()
      assert %Ecto.Changeset{} = Compagnies.change_compagny(compagny)
    end
  end
end
