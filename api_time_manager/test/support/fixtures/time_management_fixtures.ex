defmodule ApiTimeManager.TimeManagementFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ApiTimeManager.TimeManagement` context.
  """

  @doc """
  Generate a workingtime.
  """
  def workingtime_fixture(attrs \\ %{}) do
    {:ok, workingtime} =
      attrs
      |> Enum.into(%{
        end: ~N[2024-10-09 12:55:00],
        start: ~N[2024-10-09 12:55:00]
      })
      |> ApiTimeManager.TimeManagement.create_workingtime()

    workingtime
  end
end
