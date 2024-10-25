defmodule ApiTimeManager.Clocks.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field :status, :boolean, default: false
    field :time, :string
    belongs_to :user, ApiTimeManager.Accounts.User
    field :inserted_at, :utc_datetime
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :user_id, :inserted_at])
    |> validate_required([:time, :status, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
