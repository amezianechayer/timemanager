defmodule ApiTimeManager.CompagniesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ApiTimeManager.Compagnies` context.
  """

  @doc """
  Generate a compagny.
  """
  def compagny_fixture(attrs \\ %{}) do
    {:ok, compagny} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> ApiTimeManager.Compagnies.create_compagny()

    compagny
  end
end
