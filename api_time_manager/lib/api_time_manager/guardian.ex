defmodule ApiTimeManager.Guardian do
  use Guardian, otp_app: :api_time_manager

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    user = ApiTimeManager.Accounts.get_user!(id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end

  def authenticate(email, password) do
    case ApiTimeManager.Accounts.get_user_by_email(email) do
      nil ->
        {:error, :invalid_credentials}

      resource ->
        case validate_password(password, resource.hash_password) do
          true -> create_token(resource)
          false -> {:error, :invalid_credentials}
        end
    end
  end

  def validate_password(password, hash_password) do
    Bcrypt.verify_pass(password, hash_password)
  end

  defp create_token(account) do
    {:ok, token, _full_claims} =
      encode_and_sign(account)

    {:ok, account, token}
  end
end
