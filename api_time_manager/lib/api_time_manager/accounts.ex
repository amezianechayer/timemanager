defmodule ApiTimeManager.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias ApiTimeManager.Repo
  alias ApiTimeManager.Accounts.{User, Role, UsersRoles}

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User) |> Repo.preload(:roles)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id) |> Repo.preload(:roles)

  @doc """
  Creates a user.

  ## Examples
      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def list_users_filtered(nil, nil) do
    Repo.all(User) |> Repo.preload(:roles)
  end

  def list_users_filtered(email, nil) do
    Repo.all(from u in User, where: u.email == ^email) |> Repo.preload(:roles)
  end

  def list_users_filtered(nil, username) do
    Repo.all(from u in User, where: u.username == ^username) |> Repo.preload(:roles)
  end

  def list_users_filtered(email, username) do
    Repo.all(from u in User, where: u.email == ^email and u.username == ^username) |> Repo.preload(:roles)
  end

  def promote_user(user_id) do
    user = Repo.get!(User, user_id) |> Repo.preload(:roles)
    role_user = Repo.get_by!(Role, name: "user")

    if user.roles && role_user.id in Enum.map(user.roles, & &1.id) do
      role_manager = Repo.get_by!(Role, name: "manager")

      Ecto.Multi.new()
      |> Ecto.Multi.delete_all(:delete_old_role,
            from(ur in "users_roles",
            where: ur.user_id == ^user.id and ur.role_id == ^role_user.id))
      |> Ecto.Multi.insert(:insert_new_role,
            %UsersRoles{
              user_id: user.id,
              role_id: role_manager.id
            }
            |> UsersRoles.changeset(%{}))
      |> Repo.transaction()
    else
      {:error, "User does not have the 'user' role"}
    end
  end

  def demote_user(user_id) do
    user = Repo.get!(User, user_id) |> Repo.preload(:roles)
    role_manager = Repo.get_by!(Role, name: "manager")

    if user.roles && role_manager.id in Enum.map(user.roles, & &1.id) do
      role_user = Repo.get_by!(Role, name: "user")

      Ecto.Multi.new()
      |> Ecto.Multi.delete_all(:delete_old_role,
            from(ur in "users_roles",
            where: ur.user_id == ^user.id and ur.role_id == ^role_manager.id))
      |> Ecto.Multi.insert(:insert_new_role,
            %UsersRoles{
              user_id: user.id,
              role_id: role_user.id
            }
            |> UsersRoles.changeset(%{}))
      |> Repo.transaction()
    else
      {:error, "User does not have the 'manager' role"}
    end
  end

end
