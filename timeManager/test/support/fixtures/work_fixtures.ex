defmodule TimeManager.WorkFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Work` context.
  """

  @doc """
  Generate a timesheet.
  """
  def timesheet_fixture(attrs \\ %{}) do
    {:ok, timesheet} =
      attrs
      |> Enum.into(%{
        end_time: ~U[2024-10-07 13:55:00Z],
        start_time: ~U[2024-10-07 13:55:00Z]
      })
      |> TimeManager.Work.create_timesheet()

    timesheet
  end
end
