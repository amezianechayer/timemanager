defmodule TimeManager.Clocking.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field :clock_in, :utc_datetime
    field :clock_out, :utc_datetime
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:clock_in, :clock_out])
    |> validate_required([:clock_in, :clock_out])
  end
end
