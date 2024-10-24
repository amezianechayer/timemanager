defmodule ApiTimeManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias ApiTimeManager.Repo

  @derive {Jason.Encoder, only: [:id, :username, :email, :team_id]}  # Dérive l'encodeur pour ces champs

  schema "users" do
    field :username, :string
    field :email, :string
    field :hash_password, :string
    belongs_to :team, ApiTimeManager.Accounts.Team  # Changer cela pour pointer vers le bon module

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :hash_password, :team_id])
    |> validate_required([:username, :email, :hash_password])
    |> unique_constraint(:email)
    |> validate_length(:hash_password, min: 6)
  end

  def get_user(id) do
    Repo.get(__MODULE__, id)
  end

  def assign_team(%__MODULE__{} = user, team_id) do
    user
    |> Ecto.Changeset.change(team_id: team_id)
    |> Repo.update()
  end

  def list_users_by_team(team_id) do
    from(u in __MODULE__, where: u.team_id == ^team_id)
    |> Repo.all()
  end
end
