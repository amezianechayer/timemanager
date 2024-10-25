defmodule ApiTimeManager.Teams.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string
    belongs_to :company, ApiTimeManager.Companies.Company

    timestamps()
  end

  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :company_id])
    |> validate_required([:name, :company_id])
  end
end
