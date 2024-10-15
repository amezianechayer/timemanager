defmodule ApiTimeManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string
    field :hash_password, :string
    has_many :clocks, ApiTimeManager.Clocks.Clock
    has_many :workingtimes, ApiTimeManager.TimeManagement.Workingtime

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :hash_password])
    |> validate_required([:email, :username, :hash_password])
    |> validate_format(:email, ~r/@/, message: "must be a valid email format")
    |> validate_length(:username, min: 3, max: 20, message: "must be between 3 and 20 characters")
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> validate_length(:hash_password, min: 6, message: "must be at least 6 characters long")
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{hash_password: hash_password}} = changeset) do
    change(changeset, hash_password: Bcrypt.hash_pwd_salt(hash_password))
  end

  defp put_password_hash(changeset), do: changeset
end
