defmodule TimeManager.AccountTest do
  use TimeManager.DataCase

  alias TimeManager.Account

  describe "clocks" do
    alias TimeManager.Account.Clock

    import TimeManager.AccountFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Account.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Account.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~U[2024-10-07 12:30:00Z]}

      assert {:ok, %Clock{} = clock} = Account.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~U[2024-10-07 12:30:00Z]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~U[2024-10-08 12:30:00Z]}

      assert {:ok, %Clock{} = clock} = Account.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~U[2024-10-08 12:30:00Z]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_clock(clock, @invalid_attrs)
      assert clock == Account.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Account.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Account.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Account.change_clock(clock)
    end
  end
end
