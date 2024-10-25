defmodule ApiTimeManager.Repo.Migrations.AddTeamIdToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :team_id, references(:teams, on_delete: :nothing) # Ajoute la clé étrangère vers teams
    end
  end
end
