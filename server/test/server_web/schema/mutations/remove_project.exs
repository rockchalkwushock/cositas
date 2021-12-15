defmodule AppWeb.Schema.Mutation.RemoveProjectTest do
  use AppWeb.ConnCase, async: true
  alias Faker
  import App.AccountsFixtures

  @query"""
  mutation RemoveProject($inputs: RemoveProjectInputs!) {
    removeProject(inputs: $inputs) {
      data {
        id
      }
      errors {
        field
        message
      }
    }
  }
  """
  test "removing a project" do
    user = user_fixture()

    inputs = %{
      end_date: to_string(~U[2022-12-31 23:59:00.000000Z]),
      start_date: to_string(~U[2021-12-14 23:59:00.000000Z]),
      title: "My New Project"
    }

    conn = build_conn() |> auth_user(user)

    conn = post conn, "/api",
      query: @query,
      variables: %{ inputs: inputs }

    assert %{
      "data" => %{
        "removeProject" => %{
          "data" => project,
          "errors" => errors
        }
      }
    } = json_response(conn, 200)

    assert errors == nil
    assert project["title"] == inputs.title
  end
end
