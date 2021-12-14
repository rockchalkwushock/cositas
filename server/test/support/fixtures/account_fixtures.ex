defmodule App.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Accounts` context.
  """

  @doc """
  Generate a unique user email.
  """
  def unique_user_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a unique user username.
  """
  def unique_user_username, do: "some username#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "tim@gmail.com",
        first_name: "Tim",
        last_name: "Taylor",
        password: "hello-World123**",
        username: "timTayTayTay"
      })
      |> App.Accounts.create_user()

    user
  end
end
