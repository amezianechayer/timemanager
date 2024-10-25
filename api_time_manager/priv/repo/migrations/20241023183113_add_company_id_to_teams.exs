defmodule ApiTimeManager.Repo.Migrations.AddCompanyIdToTeams do
  use Ecto.Migration

  def change do
    alter table(:teams) do
      add :company_id, references(:compagnies) # si vous avez une table 'companies'
    end
  end
end
