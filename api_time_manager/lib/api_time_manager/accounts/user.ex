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

    has_many :clocks, ApiTimeManager.Clocks.Clock
    has_many :working_times, ApiTimeManager.WorkingTimes.WorkingTime
    has_many :workingtimes, ApiTimeManager.TimeManagement.Workingtime
    many_to_many :roles, ApiTimeManager.Accounts.Role, join_through: "users_roles"
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


    |> cast(attrs, [:email, :username, :hash_password, :team_id])
    |> validate_required([:email, :username, :hash_password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:username, min: 3, max: 20, message: "Must be between 3 and 20 characters")
    |> unique_constraint(:email)
    |> validate_length(:hash_password, min: 6, message: "Must be at least 6 characters long")
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{hash_password: hash_password}} = changeset) do
    change(changeset, hash_password: Bcrypt.hash_pwd_salt(hash_password))
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
