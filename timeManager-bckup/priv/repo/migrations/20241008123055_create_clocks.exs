defmodule TimeManager.Repo.Migrations.CreateClocks do
  use Ecto.Migration

  def change do
    create table(:clocks) do
      add :status, :boolean, default: false
      add :time, :utc_datetime
      add :user_id, references(:users, on_delete: :delete_all)
    end

    create index(:clocks, [:user_id])
  end
end
