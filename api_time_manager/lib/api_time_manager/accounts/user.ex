defmodule ApiTimeManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string, null: false
    field :username, :string, null: false
    has_many :clocks, ApiTimeManager.Clocks.Clock

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username])
    |> validate_required([:email, :username])
  end
end
