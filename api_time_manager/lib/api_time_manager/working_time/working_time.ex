defmodule ApiTimeManager.WorkingTimes.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset
  alias ApiTimeManager.Account.User

  schema "workingtimes" do
    field :end, :utc_datetime
    field :start, :utc_datetime
    belongs_to :user, User
    timestamps()
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:start, :end])
    |> validate_required([:start, :end])
  end
end
