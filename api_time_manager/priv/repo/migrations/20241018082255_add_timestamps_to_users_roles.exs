defmodule ApiTimeManager.Repo.Migrations.AddTimestampsToUsersRoles do
  use Ecto.Migration

  def change do
    alter table(:users_roles) do
      add :inserted_at, :naive_datetime, null: false, default: fragment("now()")
      add :updated_at, :naive_datetime, null: false, default: fragment("now()")
    end
  end
end
