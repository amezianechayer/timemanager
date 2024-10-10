defmodule ApiTimeManager.ClocksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ApiTimeManager.Clocks` context.
  """

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2024-10-08 20:39:00]
      })
      |> ApiTimeManager.Clocks.create_clock()

    clock
  end
end
