defmodule AppWeb.Resolvers.Accounts do
  alias App.Accounts
  alias AppWeb.AuthToken, as: Token

  def sign_in(_, %{inputs: inputs}, _) do
    case Accounts.authenticate(inputs) do
      {:error, changeset} ->
        {:error, changeset}
      {:ok, user} ->
        token = Token.sign(user)
        {:ok, %{data: %{user: user, token: token}}}
    end
  end

  def register(_, %{inputs: inputs}, _) do
    case Accounts.create_user(inputs) do
      {:error, changeset} ->
        {:error, changeset}
      {:ok, user} ->
        token = Token.sign(user)
        {:ok, %{data: %{user: user, token: token}}}
    end
  end

  def me(_, _, %{context: %{current_user: user}}) do
    {:ok, user}
  end

  def me(_,_,_) do
    {:ok, nil}
  end
end
