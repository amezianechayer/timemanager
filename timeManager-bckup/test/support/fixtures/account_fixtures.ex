defmodule TimeManager.AccountFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Account` context.
  """

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~U[2024-10-07 12:30:00Z]
      })
      |> TimeManager.Account.create_clock()

    clock
  end
end
