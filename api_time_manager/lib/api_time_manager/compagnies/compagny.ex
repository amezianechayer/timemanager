defmodule ApiTimeManager.Compagnies.Compagny do
  use Ecto.Schema
  import Ecto.Changeset

  schema "compagnies" do
    field :name, :string
    field :description, :string

    # Relation avec les équipes (teams)
    has_many :teams, ApiTimeManager.Teams.Team, foreign_key: :company_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(compagny, attrs) do
    compagny
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
    |> cast_assoc(:teams)  # Permet de caster les associations (facultatif selon le besoin)
  end
end
