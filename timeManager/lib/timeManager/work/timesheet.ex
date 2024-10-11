defmodule TimeManager.Work.Timesheet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field :start_time, :utc_datetime
    field :end_time, :utc_datetime
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(timesheet, attrs) do
    timesheet
    |> cast(attrs, [:start_time, :end_time])
    |> validate_required([:start_time, :end_time])
  end
end
