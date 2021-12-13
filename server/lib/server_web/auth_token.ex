defmodule AppWeb.AuthToken do
  alias Phoenix.Token

  @user_salt "hello world"

   @doc """
  Encodes the given `user` id and signs it, returning a token
  clients can use as identification when using the API.
  """
  def sign(user) do
    Token.sign(AppWeb.Endpoint, @user_salt, %{id: user.id})
  end

  @doc """
  Decodes the original data from the given `token` and
  verifies its integrity.
  """
  def verify(token) do
    Token.verify(AppWeb.Endpoint, @user_salt, token, [
      max_age: 365 * 24 * 3600
    ])
  end
end
