defmodule ApiTimeManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :hash_password, :text

      timestamps(type: :utc_datetime)
    end

    drop_if_exists index(:users, [:email])
    create unique_index(:users, [:email])
  end
end