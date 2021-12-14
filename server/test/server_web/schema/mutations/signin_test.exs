defmodule AppWeb.Schema.Mutation.SigninTest do
  use AppWeb.ConnCase, async: true

  @query"""
  mutation SignIn($inputs: SignInInputs!) {
    signIn(inputs: $inputs) {
      data {
        token
        user {
          createdAt
          email
          firstName
          id
          lastName
          modifiedAt
          username
        }
      }
      errors {
        field
        message
      }
    }
  }
  """
  test "siging in" do
    attrs = %{
      email: "bob@gmail.com",
      first_name: "Bob",
      last_name: "Taylor",
      password: "hello-World123**",
      username: "bTaylor101"
    }

    assert {:ok, user} = App.Accounts.create_user(attrs)

    assert user.username == attrs.username

    inputs = %{
      "password" => attrs.password,
      "username" => attrs.username
    }

    conn = post(build_conn(), "/api", %{
      query: @query,
      variables: %{ inputs: inputs }
    })

    assert %{"data" => %{
      "signIn" => %{
        "data" => session,
        "errors" => errors
      }
    }} = json_response(conn, 200)

    assert %{
      "token" => token,
    } = session

    assert errors == nil
    assert session["user"]["username"] == attrs.username
    {:ok, %{id: id}} = AppWeb.AuthToken.verify(token)
    assert to_string(id) == session["user"]["id"]
  end
end
