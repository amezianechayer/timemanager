defmodule ApiTimeManager.Compagnies do
  @moduledoc """
  The Compagnies context.
  """

  import Ecto.Query, warn: false
  alias ApiTimeManager.Repo

  alias ApiTimeManager.Compagnies.Compagny

  @doc """
  Returns the list of compagnies.

  ## Examples

      iex> list_compagnies()
      [%Compagny{}, ...]

  """
  def list_compagnies do
    Repo.all(Compagny)
  end

  @doc """
  Gets a single compagny.

  Raises `Ecto.NoResultsError` if the Compagny does not exist.

  ## Examples

      iex> get_compagny!(123)
      %Compagny{}

      iex> get_compagny!(456)
      ** (Ecto.NoResultsError)

  """
  def get_compagny!(id), do: Repo.get!(Compagny, id)

  @doc """
  Creates a compagny.

  ## Examples

      iex> create_compagny(%{field: value})
      {:ok, %Compagny{}}

      iex> create_compagny(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_compagny(attrs \\ %{}) do
    %Compagny{}
    |> Compagny.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a compagny.

  ## Examples

      iex> update_compagny(compagny, %{field: new_value})
      {:ok, %Compagny{}}

      iex> update_compagny(compagny, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_compagny(%Compagny{} = compagny, attrs) do
    compagny
    |> Compagny.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a compagny.

  ## Examples

      iex> delete_compagny(compagny)
      {:ok, %Compagny{}}

      iex> delete_compagny(compagny)
      {:error, %Ecto.Changeset{}}

  """
  def delete_compagny(%Compagny{} = compagny) do
    Repo.delete(compagny)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking compagny changes.

  ## Examples

      iex> change_compagny(compagny)
      %Ecto.Changeset{data: %Compagny{}}

  """
  def change_compagny(%Compagny{} = compagny, attrs \\ %{}) do
    Compagny.changeset(compagny, attrs)
  end
end
