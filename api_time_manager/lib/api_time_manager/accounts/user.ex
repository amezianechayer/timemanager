defmodule ApiTimeManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string
    has_many :clocks, ApiTimeManager.Clocks.Clock
<<<<<<< HEAD
    has_many :working_times, ApiTimeManager.WorkingTimes.WorkingTime
=======
    has_many :workingtimes, ApiTimeManager.TimeManagement.Workingtime
>>>>>>> ed97b3001893390fab2e6cb118e581f5cc07943c

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username])
    |> validate_required([:email, :username])
  end
end
