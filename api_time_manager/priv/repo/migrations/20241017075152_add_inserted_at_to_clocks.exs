defmodule ApiTimeManager.Repo.Migrations.AddInsertedAtToClocks do
  use Ecto.Migration

  def change do
    alter table(:clocks) do
      add :inserted_at, :utc_datetime, default: fragment("now()"), null: false
    end
  end
end
