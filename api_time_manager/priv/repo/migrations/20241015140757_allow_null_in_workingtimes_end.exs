defmodule ApiTimeManager.Repo.Migrations.AllowNullInWorkingtimesEnd do
  use Ecto.Migration

  def change do
    alter table(:workingtimes) do
      modify :start, :naive_datetime, null: true
      modify :end, :naive_datetime, null: true
    end
  end
end