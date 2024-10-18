defmodule ApiTimeManagerWeb.AuthJSON do
  @doc """
  Renders user data and token on successful registration
  """
  def register(%{user: user}) do
    %{
      status: :success,
      data: %{
        user: user_json(user)
        # token: token
      }
    }
  end

  @doc """
  Renders user data and token on successful login
  """
  def login(%{user: user, token: token}) do
    %{
      status: :success,
      data: %{
        user: user_json(user),
        token: token
      }
    }
  end



  @doc """
  Renders error messages
  """
  def error(%{changeset: changeset}) do
    %{
      status: :error,
      errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
    }
  end

  def error(%{message: message}) do
    %{
      status: :error,
      message: message
    }
  end

  defp user_json(user) do
    %{
      id: user.id,
      email: user.email,
      roles: Enum.map(user.roles, & &1.name),
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end

  # defp translate_error({msg, opts}) do
  #   if count = opts[:count] do
  #     Gettext.dngettext(ApiTimeManager.Gettext, "errors", msg, msg, count, opts)
  #   else
  #     Gettext.dgettext(ApiTimeManager.Gettext, "errors", msg, opts)
  #   end
  # end
  defp translate_error({msg, opts}) do
    # You can make use of gettext to translate error messages by
    # uncommenting and adjusting the following code:

    # if count = opts[:count] do
    #   Gettext.dngettext(ApiTimeManagerWeb.Gettext, "errors", msg, msg, count, opts)
    # else
    #   Gettext.dgettext(ApiTimeManagerWeb.Gettext, "errors", msg, opts)
    # end

    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", fn _ -> to_string(value) end)
    end)
  end
end
