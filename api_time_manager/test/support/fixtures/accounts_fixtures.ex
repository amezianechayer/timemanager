defmodule ApiTimeManager.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ApiTimeManager.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        username: "some username"
      })
      |> ApiTimeManager.Accounts.create_user()

    user
  end
end
