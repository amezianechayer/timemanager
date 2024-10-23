defmodule ApiTimeManager.Accounts.UsersRoles do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users_roles" do
    field :user_id, :id
    field :role_id, :id
  end

  @doc false
  def changeset(users_roles, attrs) do
    users_roles
    |> cast(attrs, [:user_id, :role_id])
    |> validate_required([:user_id, :role_id])
  end
end
