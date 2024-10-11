defmodule TimeManager.WorkTest do
  use TimeManager.DataCase

  alias TimeManager.Work

  describe "workingtimes" do
    alias TimeManager.Work.Timesheet

    import TimeManager.WorkFixtures

    @invalid_attrs %{start_time: nil, end_time: nil}

    test "list_workingtimes/0 returns all workingtimes" do
      timesheet = timesheet_fixture()
      assert Work.list_workingtimes() == [timesheet]
    end

    test "get_timesheet!/1 returns the timesheet with given id" do
      timesheet = timesheet_fixture()
      assert Work.get_timesheet!(timesheet.id) == timesheet
    end

    test "create_timesheet/1 with valid data creates a timesheet" do
      valid_attrs = %{start_time: ~U[2024-10-07 13:55:00Z], end_time: ~U[2024-10-07 13:55:00Z]}

      assert {:ok, %Timesheet{} = timesheet} = Work.create_timesheet(valid_attrs)
      assert timesheet.start_time == ~U[2024-10-07 13:55:00Z]
      assert timesheet.end_time == ~U[2024-10-07 13:55:00Z]
    end

    test "create_timesheet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Work.create_timesheet(@invalid_attrs)
    end

    test "update_timesheet/2 with valid data updates the timesheet" do
      timesheet = timesheet_fixture()
      update_attrs = %{start_time: ~U[2024-10-08 13:55:00Z], end_time: ~U[2024-10-08 13:55:00Z]}

      assert {:ok, %Timesheet{} = timesheet} = Work.update_timesheet(timesheet, update_attrs)
      assert timesheet.start_time == ~U[2024-10-08 13:55:00Z]
      assert timesheet.end_time == ~U[2024-10-08 13:55:00Z]
    end

    test "update_timesheet/2 with invalid data returns error changeset" do
      timesheet = timesheet_fixture()
      assert {:error, %Ecto.Changeset{}} = Work.update_timesheet(timesheet, @invalid_attrs)
      assert timesheet == Work.get_timesheet!(timesheet.id)
    end

    test "delete_timesheet/1 deletes the timesheet" do
      timesheet = timesheet_fixture()
      assert {:ok, %Timesheet{}} = Work.delete_timesheet(timesheet)
      assert_raise Ecto.NoResultsError, fn -> Work.get_timesheet!(timesheet.id) end
    end

    test "change_timesheet/1 returns a timesheet changeset" do
      timesheet = timesheet_fixture()
      assert %Ecto.Changeset{} = Work.change_timesheet(timesheet)
    end
  end
end
