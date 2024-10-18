defmodule ApiTimeManager.Accounts.Auth do
  @moduledoc """
  The Authentication context.
  This module handles all authentication-related operations including user registration,
  authentication, and token generation.
  """

  import Ecto.Query, warn: false

  alias ApiTimeManager.Repo
  alias ApiTimeManager.Accounts.{User, Role}

  @doc """
  Registers a new user with the given attributes.

  ## Parameters
    * attrs - Map containing user attributes:
      * email - String, required
      * password - String, required
      * username - String, optional

  ## Returns
    * {:ok, user} - Returns the created user with default "user" role
    * {:error, changeset} - Returns an error changeset if validation fails

  ## Examples
      iex> register_user(%{email: "user@example.com", password: "password123"})
      {:ok, %User{}}

      iex> register_user(%{email: "invalid"})
      {:error, %Ecto.Changeset{}}
  """
  def register_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, user} ->
        default_role = Repo.get_by!(Role, name: "user")
        Repo.insert_all("users_roles", [%{
          user_id: user.id,
          # role_id: 1,
          role_id: default_role.id,
          inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
          updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
        }])
        user = Repo.preload(user, :roles)

        {:ok, user}
      error -> error
    end
  end

  @doc """
  Authenticates a user using email and password.

  ## Parameters
    * email - String representing user's email
    * password - String representing user's password

  ## Returns
    * {:ok, user} - Returns the authenticated user if credentials are valid
    * {:error, :invalid_credentials} - Returns error if credentials are invalid

  ## Examples
      iex> authenticate_user("user@example.com", "correctpassword")
      {:ok, %User{}}

      iex> authenticate_user("user@example.com", "wrongpassword")
      {:error, :invalid_credentials}
  """
  def authenticate_user(email, password) do
    user = Repo.get_by(User, email: email)
    |> Repo.preload(:roles)

    case user do
      nil ->
        Bcrypt.no_user_verify()
        {:error, :invalid_credentials}
      user ->
        if Bcrypt.verify_pass(password, user.hash_password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end

  @doc """
  Generates an authentication token for a user.

  ## Parameters
    * user - User struct with preloaded roles

  ## Returns
    * String - JWT token containing user ID and roles

  ## Examples
      iex> user = %User{id: 1, roles: [%Role{name: "user"}]}
      iex> generate_token(user)
      "eyJhbGciOiJIUzI1NiIs..."

  Note: Make sure the user struct has roles preloaded before calling this function.
  """
  def generate_token(user) do
    roles = Enum.map(user.roles, & &1.name)
    user = Repo.preload(user, :roles)

    Phoenix.Token.sign(
      ApiTimeManager.Endpoint,  # Note: Vous devriez changer ceci pour ApiTimeManagerWeb.Endpoint
      "user auth",
      %{user_id: user.id, roles: roles}
    )
  end
end
