defmodule TimeManager.ClockingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Clocking` context.
  """

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        clock_in: ~U[2024-10-07 13:55:00Z],
        clock_out: ~U[2024-10-07 13:55:00Z]
      })
      |> TimeManager.Clocking.create_clock()

    clock
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        clock_in: ~U[2024-10-07 14:07:00Z],
        clock_out: ~U[2024-10-07 14:07:00Z]
      })
      |> TimeManager.Clocking.create_clock()

    clock
  end
end
