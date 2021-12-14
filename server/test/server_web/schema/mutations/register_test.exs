defmodule AppWeb.Schema.Mutation.RegisterTest do
  use AppWeb.ConnCase, async: true

  @query"""
  mutation RegisterNewUser($inputs: RegistrationInputs!) {
    register(inputs: $inputs) {
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
  test "registering new user" do
    inputs = %{
      email: "bob@gmail.com",
      first_name: "Bob",
      last_name: "Taylor",
      password: "hello-World123**",
      username: "bt101"
    }
    conn = post(build_conn(), "/api", %{
      query: @query,
      variables: %{ inputs: inputs }
    })

    assert %{"data" => %{
      "register" => session
    }} = json_response(conn, 200)

    assert session["errors"] == nil
    assert session["data"]["user"]["username"] == inputs.username
  end
end
