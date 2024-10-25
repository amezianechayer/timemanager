defmodule ApiTimeManager.Repo.Migrations.CreateCompagnies do
  use Ecto.Migration

  def change do
    create table(:compagnies) do
      add :name, :string
      add :description, :text
      add :teams_id, references(:teams, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:compagnies, [:teams_id])
  end
end
