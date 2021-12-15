defmodule App.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Accounts` context.
  """
  alias Faker

  @doc """
  Generate a unique user email.
  """
  def unique_user_email, do: Faker.Internet.email()

  @doc """
  Generate a unique user username.
  String.slice/2 is used because of validation constraint
  on `username`, must be less than 18 characters.
  """
  def unique_user_username, do: Faker.Internet.user_name() |> String.slice(0..16)

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: unique_user_email(),
        first_name: Faker.Person.first_name(),
        last_name: Faker.Person.last_name(),
        password: "hello-World123**",
        username: unique_user_username()
      })
      |> App.Accounts.create_user()

    user
  end
end
