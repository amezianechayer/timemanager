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
    |> validate_required([:email,:username, :hash_password])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:hash_password, min: 6)
    |> put_password_hash()
  end

  defp put_password_hash(
    %Ecto.Changeset{valid?: true, changes: %{hash_password: hash_password}} = changeset) do
    change(changeset, hash_password: Bcrypt.hash_pwd_salt(hash_password))
  end

  defp put_password_hash(changeset), do: changeset
end
