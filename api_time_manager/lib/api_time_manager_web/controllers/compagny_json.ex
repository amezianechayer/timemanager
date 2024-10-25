defmodule ApiTimeManagerWeb.CompagnyJSON do
  alias ApiTimeManager.Compagnies.Compagny

  @doc """
  Renders a list of compagnies.
  """
  def index(%{compagnies: compagnies}) do
    %{data: for(compagny <- compagnies, do: data(compagny))}
  end

  @doc """
  Renders a single compagny.
  """
  def show(%{compagny: compagny}) do
    %{data: data(compagny)}
  end

  defp data(%Compagny{} = compagny) do
    %{
      id: compagny.id,
      name: compagny.name,
      description: compagny.description
    }
  end
end
